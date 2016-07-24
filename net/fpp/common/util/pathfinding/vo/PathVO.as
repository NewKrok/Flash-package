/**
 * Created by newkrok on 13/03/16.
 */
package net.fpp.common.util.pathfinding.vo
{
	import net.fpp.common.geom.SimplePoint;

	public class PathVO
	{
		public var path:Vector.<SimplePoint>;

		public function PathVO( path:Vector.<SimplePoint> = null )
		{
			this.path = path;
		}
	}
}