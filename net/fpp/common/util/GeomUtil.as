/**
 * Created by newkrok on 30/03/16.
 */
package net.fpp.common.util
{
	import net.fpp.common.geom.SimplePoint;
	
	public class GeomUtil
	{
		public static function simplePointDistance( firstPoint:SimplePoint, secondPoint:SimplePoint ):Number
		{
			return Math.sqrt( Math.pow( firstPoint.x - secondPoint.x, 2 ) + Math.pow( firstPoint.y - secondPoint.y, 2 ) );
		}
		
		public static function simplePointAngle( firstPoint:SimplePoint, secondPoint:SimplePoint ):Number
		{
			return Math.atan2( secondPoint.y - firstPoint.y, secondPoint.x - firstPoint.x );
		}

		public static function normalizeAngle( angle:Number ):Number
		{
			var result:Number = angle;

			var circleMaxAngle:Number = Math.PI * 2;

			if ( result < 0 )
			{
				result += circleMaxAngle;
			}

			while( result > circleMaxAngle )
			{
				result -= circleMaxAngle;
			}

			return result;
		}

		public static function isSimplePointEqual( simplePointA:SimplePoint, simplePointB:SimplePoint ):Boolean
		{
			return simplePointA.x == simplePointB.x && simplePointA.y == simplePointB.y;
		}
	}
}