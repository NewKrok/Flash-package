/**
 * Created by newkrok on 13/03/16.
 */
package net.fpp.common.util.pathfinding.vo
{
	public class PathNodeVO
	{
		public var h:Number;
		public var g:Number;
		public var f:Number;
		public var parent:PathNodeVO;

		public var x:Number;
		public var y:Number;

		public var isWalkable:Boolean = true;

		public function PathNodeVO( x:Number, y:Number, isWalkable:Boolean = true )
		{
			this.x = x;
			this.y = y;
			this.isWalkable = isWalkable;
		}
	}
}