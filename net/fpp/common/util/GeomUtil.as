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

			if( result < 0 )
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

		public static function atan2( y:Number, x:Number ):Number
		{
			if ( x == 0 && y == 0 )
			{
				return 0;
			}

			if( y > 0 )
			{
				if( x >= 0 )
				{
					return 0.78539816339744830961566084581988 - 0.78539816339744830961566084581988 * (x - y) / (x + y);
				}
				else
				{
					return 2.3561944901923449288469825374596 - 0.78539816339744830961566084581988 * (x + y) / (y - x);
				}
			}
			else
			{
				if( x >= 0 )
				{
					return -0.78539816339744830961566084581988 + 0.78539816339744830961566084581988 * (x + y) / (x - y);
				}
			}

			return -2.3561944901923449288469825374596 - 0.78539816339744830961566084581988 * (x - y) / (y + x);
		}
	}
}