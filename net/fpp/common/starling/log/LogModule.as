/**
 * Created by newkrok on 08/11/15.
 */
package net.fpp.common.starling.log
{
	import net.fpp.common.starling.log.events.LogViewEvent;

	import starling.display.DisplayObjectContainer;
	import net.fpp.common.starling.log.vo.LogEntryVO;

	public class LogModule
	{
		private static var _logger:LogView;
		private static var _queue:Vector.<LogEntryVO> = new <LogEntryVO>[];

		public static function createView( parent:DisplayObjectContainer ):void
		{
			_logger = new LogView();
			_logger.addEventListener( LogViewEvent.INITED, onLoggerViewInited );

			parent.addChild( _logger );
		}

		private static function onLoggerViewInited():void
		{
			var length:int = _queue.length;

			for ( var i:int = 0; i < length; i++ )
			{
				add( _queue[i] );
			}
			
			_queue.length = 0;
		}

		public static function add( ...args:Array ):void
		{
			var logEntryVO:LogEntryVO = new LogEntryVO( new Date().time, args );
			
			if ( _logger && _logger.isInited )
			{
				_logger.add( logEntryVO );
				_logger.show();
			}
			else
			{
				addLogToQueue( logEntryVO );
			}
		}

		private static function addLogToQueue( value:LogEntryVO ):void
		{
			_queue.push( value );
		}
	}
}