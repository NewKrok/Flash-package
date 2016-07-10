/**
 * Created by newkrok on 13/03/16.
 */
package net.fpp.common.util.pathfinding.astar
{
	import net.fpp.common.geom.SimplePoint;
	import net.fpp.common.util.pathfinding.astar.vo.AStarNodeVO;
	import net.fpp.common.util.pathfinding.astar.vo.AStarPathRequestVO;
	import net.fpp.common.util.pathfinding.vo.PathVO;

	public class AStarUtil
	{
		private static var width:int;
		private static var height:int;

		private static var start:AStarNodeVO;
		private static var goal:AStarNodeVO;

		private static var map:Vector.<Vector.<AStarNodeVO>>;

		public static var open:Vector.<AStarNodeVO>;

		public static var closed:Vector.<AStarNodeVO>;

		private static const COST_ORTHOGONAL:Number = 1;
		private static const COST_DIAGONAL:Number = Math.SQRT2;

		public static function getPath( pathRequestVO:AStarPathRequestVO ):PathVO
		{
			map = pathRequestVO.mapNodes;

			width = map.length;
			height = map[ 0 ].length;

			start = map[ pathRequestVO.startPosition.x ][ pathRequestVO.startPosition.y ];
			goal = map[ pathRequestVO.endPosition.x ][ pathRequestVO.endPosition.y ];

			open = new Vector.<AStarNodeVO>;
			closed = new Vector.<AStarNodeVO>;

			var node:AStarNodeVO = start;
			node.g = 0;
			node.h = euclidian( node );
			node.f = node.g + node.h;

			while( node != goal )
			{
				var startX:int = Math.max( 0, node.x - 1 );
				var endX:int = Math.min( width - 1, node.x + 1 );
				var startY:int = Math.max( 0, node.y - 1 );
				var endY:int = Math.min( height, node.y + 1 );

				var i:int, j:int;
				var test:AStarNodeVO;
				for( i = startX; i <= endX; i++ )
				{
					for( j = startY; j <= endY; j++ )
					{
						test = map[ i ][ j ];

						if( test == node || !test.isWalkable )
						{
							continue;
						}

						var cost:Number = COST_ORTHOGONAL;
						if( !((node.x == test.x) || (node.y == test.y)) )
						{
							cost = COST_DIAGONAL;
						}
						var g:Number = node.g + cost;
						var h:Number = euclidian( test );
						var f:Number = g + h;

						if( isOpen( test ) || isClosed( test ) )
						{
							if( test.f > f )
							{
								test.f = f;
								test.g = g;
								test.h = h;
								test.parent = node;
							}
						}
						else
						{
							test.f = f;
							test.g = g;
							test.h = h;
							test.parent = node;
							open.push( test );
						}
					}
				}
				closed.push( node );
				if( open.length == 0 )
				{
					trace( "no path found" );
					return null;
				}

				open.sort( sortVector );
				node = open.shift() as AStarNodeVO;
			}

			var solution:Vector.<SimplePoint> = new Vector.<SimplePoint>();
			solution.push( new SimplePoint( node.x, node.y ) );

			while( node.parent && node.parent != start )
			{
				node = node.parent;
				solution.push( new SimplePoint( node.x, node.y ) );
			}

			var path:PathVO = new PathVO();
			path.path = solution.reverse();

			return path;
		}

		private static function sortVector( x:AStarNodeVO, y:AStarNodeVO ):int
		{
			return (x.f >= y.f) ? 1 : -1;
		}

		private static function euclidian( node:AStarNodeVO ):Number
		{
			var dx:Number = node.x - goal.x;
			var dy:Number = node.y - goal.y;
			return Math.sqrt( dx * dx + dy * dy ) * COST_ORTHOGONAL;
		}

		private static function isClosed( node:AStarNodeVO ):Boolean
		{
			var i:int, len:int = closed.length;
			for( i = 0; i < len; i++ )
			{
				if( closed[ i ] == node )
				{
					return true;
				}
			}
			return false;
		}

		private static function isOpen( node:AStarNodeVO ):Boolean
		{
			var i:int, len:int = open.length;
			for( i = 0; i < len; i++ )
			{
				if( open[ i ] == node )
				{
					return true;
				}
			}
			return false;

		}
	}
}