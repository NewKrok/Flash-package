/**
 * Created by newkrok on 13/03/16.
 */
package net.fpp.common.util.pathfinding.astar.vo
{
	public class AStarNodeVO
	{
		public var h:Number;
		public var g:Number;
		public var f:Number;
		public var parent:AStarNodeVO;

		public var x:Number;
		public var y:Number;

		public var isWalkable:Boolean = true;

		public function AStarNodeVO( x:Number, y:Number, isWalkable:Boolean = true )
		{
			this.x = x;
			this.y = y;
			this.isWalkable = isWalkable;
		}
	}
}