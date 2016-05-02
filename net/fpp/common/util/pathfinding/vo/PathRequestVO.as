/**
 * Created by newkrok on 13/03/16.
 */
package net.fpp.common.util.pathfinding.vo
{
	import net.fpp.common.geom.SimplePoint;

	public class PathRequestVO
	{
		public var startPosition:SimplePoint;
		public var endPosition:SimplePoint;
		public var mapNodes:Vector.<Vector.<PathNodeVO>>;
	}
}