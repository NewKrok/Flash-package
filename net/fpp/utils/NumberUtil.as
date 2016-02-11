/**
 * Created by newkrok on 11/02/16.
 */
package net.fpp.utils
{
	public class NumberUtil
	{
		public static function formatNumber( number:Number, spacer:String = ' ' ):String
		{
			const fission:int = 3;

			var resultNumber:String = number.toString();
			var resultRemainder:String = '';
			var dotIndex:int = resultNumber.indexOf( '.' );

			if ( dotIndex != -1 )
			{
				resultRemainder = resultNumber.substr ( dotIndex, resultNumber.length );
				resultNumber = resultNumber.substr( 0, dotIndex );
			}
			
			if ( resultNumber.length <= fission )
			{
				return resultNumber + resultRemainder;
			}

			var spacerCount:int = Math.floor( resultNumber.length / fission );
			var spacerIndex:int = resultNumber.length - fission;

			for ( var i:int = 0; i < spacerCount; i++ )
			{
				resultNumber = resultNumber.substring( 0, spacerIndex ) + spacer + resultNumber.substring( spacerIndex, resultNumber.length );
				spacerIndex -= fission;
			}

			return resultNumber + resultRemainder;
		}
	}
}