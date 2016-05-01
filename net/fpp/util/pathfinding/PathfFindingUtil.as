/**
 * Created by newkrok on 13/03/16.
 */
package net.fpp.util.pathfinding
{
	import net.fpp.geom.SimplePoint;
	import net.fpp.util.pathfinding.vo.PathNodeVO;
	import net.fpp.util.pathfinding.vo.PathRequestVO;
	import net.fpp.util.pathfinding.vo.PathVO;

	public class PathfFindingUtil
	{
		private static var _startPathNode:PathNodeVO;
		private static var _endPathNode:PathNodeVO;
		private static var _mapNodes:Vector.<Vector.<PathNodeVO>>;

		private static var _openedPathNodes:Vector.<PathNodeVO>;
		private static var _closedPathNodes:Vector.<PathNodeVO>;

		private static const _straightCost:Number = 1.0;

		public static function getPath( pathRequestVO:PathRequestVO ):PathVO
		{
			_startPathNode = getNodeByPosition( pathRequestVO.mapNodes, pathRequestVO.startPosition );
			_endPathNode = getNodeByPosition( pathRequestVO.mapNodes, pathRequestVO.endPosition );
			_mapNodes = pathRequestVO.mapNodes;

			_openedPathNodes = new <PathNodeVO>[];
			_closedPathNodes = new <PathNodeVO>[];

			_startPathNode.g = 0;
			_startPathNode.h = diagonalHeuristic( _startPathNode );
			_startPathNode.f = _startPathNode.g + _startPathNode.h;

			var pathVO:PathVO = new PathVO();
			pathVO.path = calculatePath();
			pathVO.path.push( pathRequestVO.endPosition );

			return pathVO;
		}

		private static function getNodeByPosition( map:Vector.<Vector.<PathNodeVO>>, position:SimplePoint ):PathNodeVO
		{
			var xIndex:int = Math.floor( position.x );
			var yIndex:int = Math.floor( position.y );

			return map[ xIndex ][ yIndex ];
		}

		private static function diagonalHeuristic( pathNodeVO:PathNodeVO ):Number
		{
			var dx:Number = pathNodeVO.x - _endPathNode.x;
			var dy:Number = pathNodeVO.y - _endPathNode.y;
			var distance:Number = Math.abs( dx + dy );

			var A_axis:Number = ( Math.abs( dx - dy ) - distance ) / 2;
			if( A_axis > 0 )
			{
				distance += A_axis;
			}

			return distance * _straightCost;
		}

		private static function calculatePath():Vector.<SimplePoint>
		{
			var pathNodeVO:PathNodeVO = _startPathNode;
			while( pathNodeVO != _endPathNode )
			{
				var startX:int = Math.max( 0, pathNodeVO.x - 1 );
				var endX:int = Math.min( _mapNodes.length - 1, pathNodeVO.x + 1 );
				var startY:int = Math.max( 0, pathNodeVO.y - 1 );
				var endY:int = Math.min( _mapNodes[ 0 ].length - 1, pathNodeVO.y + 1 );

				for( var i:int = startX; i <= endX; i++ )
				{
					for( var j:int = startY; j <= endY; j++ )
					{
						var test:PathNodeVO = _mapNodes[ i ][ j ];
						if( ( i - pathNodeVO.x ) * ( j - pathNodeVO.y ) > 0 )
						{
							continue;
						}
						if( test == pathNodeVO || !test.isWalkable )
						{
							continue;
						}

						var cost:Number = _straightCost;
						var g:Number = pathNodeVO.g + cost;
						var h:Number = diagonalHeuristic( test );
						var f:Number = g + h;

						if( isOpenPathNode( test ) || isClosedPathNode( test ) )
						{
							if( test.f > f )
							{
								test.f = f;
								test.g = g;
								test.h = h;
								test.parent = pathNodeVO;
							}
						}
						else
						{
							test.f = f;
							test.g = g;
							test.h = h;
							test.parent = pathNodeVO;
							_openedPathNodes.push( test );
						}
					}
				}
				_closedPathNodes.push( pathNodeVO );

				if( _openedPathNodes.length == 0 )
				{
					return new <SimplePoint>[];
				}
				_openedPathNodes.sort( sortNodes );
				pathNodeVO = _openedPathNodes.shift() as PathNodeVO;
			}

			return pathToPointVector( buildPath() );
		}

		private static function sortNodes( pathNodeVOA:PathNodeVO, pathNodeVOB:PathNodeVO ):int
		{

			return pathNodeVOA.f > pathNodeVOB.f ? 1 : pathNodeVOA.f == pathNodeVOB.f ? 0 : -1;
		}

		private static function pathToPointVector( path:Vector.<PathNodeVO> ):Vector.<SimplePoint>
		{
			var result:Vector.<SimplePoint> = new <SimplePoint>[];

			for( var i:int = 1; i < path.length - 1; i++ )
			{
				result.push( new SimplePoint( path[ i ].x, path[ i ].y ) );
			}

			return result;
		}

		private static function buildPath():Vector.<PathNodeVO>
		{
			var pathNodeVO:PathNodeVO = _endPathNode;

			var path:Vector.<PathNodeVO> = new <PathNodeVO>[];
			path.push( pathNodeVO );

			while( pathNodeVO != _startPathNode )
			{
				pathNodeVO = pathNodeVO.parent;
				path.unshift( pathNodeVO );
			}

			return path;
		}

		private static function isOpenPathNode( pathNodeVO:PathNodeVO ):Boolean
		{

			for each ( var selectedNode:PathNodeVO in _openedPathNodes )
			{
				if( selectedNode == pathNodeVO )
				{
					return true;
				}
			}

			return false;
		}

		private static function isClosedPathNode( pathNodeVO:PathNodeVO ):Boolean
		{
			for each ( var selectedNode:PathNodeVO in _closedPathNodes )
			{
				if( selectedNode == pathNodeVO )
				{
					return true;
				}
			}

			return false;
		}
	}
}