/**
 * Created by newkrok on 13/03/16.
 */
package net.fpp.geom
{
	public class SimplePoint
	{
		public var x:Number;
		public var y:Number;
		
		public function SimplePoint( x:Number = 0, y:Number = 0 )
		{
			this.x = x;
			this.y = y;
		}
		
		public function toString():String
		{
			return '{x:' + this.x + ', y:' + this.y + '}';
		}
	}
}