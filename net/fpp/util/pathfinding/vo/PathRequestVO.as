/**
 * Created by newkrok on 13/03/16.
 */
package net.fpp.util.pathfinding.vo
{
	import net.fpp.geom.SimplePoint;

	public class PathRequestVO
	{
		public var startPosition:SimplePoint;
		public var endPosition:SimplePoint;
		public var mapNodes:Vector.<Vector.<PathNodeVO>>;
	}
}