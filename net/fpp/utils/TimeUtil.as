/**
 * Created by newkrok on 11/02/16.
 */
package net.fpp.utils
{
	public class TimeUtil
	{
		public static const TIME_FORMAT_HH_MM_SS_MS:String = 'hh:mm:ss.ms';
		public static const TIME_FORMAT_HH_MM_SS:String = 'hh:mm:ss';
		public static const TIME_FORMAT_HH_MM:String = 'hh:ss';
		public static const TIME_FORMAT_MM_SS_MS:String = 'mm:ss.ms';
		public static const TIME_FORMAT_MM_SS:String = 'mm:ss';

		public static function timeStampToFormattedTime( timeStamp:Number, timeFormat:String = TimeUtil.TIME_FORMAT_HH_MM_SS ):String
		{
			var showHour:Boolean = timeFormat.indexOf( 'hh' ) != -1;
			var showMinute:Boolean = timeFormat.indexOf( 'mm' ) != -1;
			var showSecond:Boolean = timeFormat.indexOf( 'ss' ) != -1;
			var showMilliSecond:Boolean = timeFormat.indexOf( 'ms' ) != -1;

			var hour:String = "";
			if( showHour )
			{
				hour = TimeUtil.getHourFromTimeStamp( timeStamp ).toString();
				if( hour.length == 1 )
				{
					hour = '0' + hour;
				}
			}

			var minute:String = "";
			if( showMinute )
			{
				minute = TimeUtil.getMinuteFromTimeStamp( timeStamp ).toString();
				if( minute.length == 1 )
				{
					minute = '0' + minute;
				}
			}

			var second:String = "";
			if( showSecond )
			{
				second = TimeUtil.getSecondFromTimeStamp( timeStamp ).toString();
				if( second.length == 1 )
				{
					second = '0' + second;
				}
			}

			var millisecond:String = "";
			if( showMilliSecond )
			{
				millisecond = TimeUtil.getMilliSecondFromTimeStamp( timeStamp ).toString();
				if( millisecond.length == 1 )
				{
					millisecond = '00' + millisecond;
				}
				else if( millisecond.length == 2 )
				{
					millisecond = '0' + millisecond;
				}
			}

			var result:String = timeFormat;

			if ( showHour )
			{
				result = result.replace( new RegExp( 'hh', '|g' ), hour );
			}

			if ( showMinute )
			{
				result = result.replace( new RegExp( 'mm', '|g' ), minute );
			}
			
			if ( showSecond )
			{
				result = result.replace( new RegExp( 'ss', '|g' ), second );
			}

			if ( showMilliSecond )
			{
				result = result.replace( new RegExp( 'ms', '|g' ), millisecond );
			}

			return result;
		}

		public static function getHourFromTimeStamp( timeStamp:Number ):int
		{
			return Math.floor( ( Math.floor( timeStamp / 1000 / 60 ) / 60 ) % 24 );
		}

		public static function getMinuteFromTimeStamp( timeStamp:Number ):int
		{
			return Math.floor( Math.floor( timeStamp / 1000 / 60 ) % 60 );
		}

		public static function getSecondFromTimeStamp( timeStamp:Number ):int
		{
			return Math.floor( timeStamp / 1000 % 60 );
		}

		public static function getMilliSecondFromTimeStamp( timeStamp:Number ):int
		{
			return Math.floor( timeStamp % 1000 );
		}
	}
}