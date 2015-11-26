/**
 * Created by newkrok on 08/11/15.
 */
package net.fpp.starling.log
{
	import net.fpp.starling.log.events.LogViewEvent;

	import starling.display.DisplayObjectContainer;

	public class LogModule
	{
		private static var _logger:LogView;
		private static var _queue:Vector.<Array> = new <Array>[];

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
				add.apply( null, _queue[0] );

				_queue[0].shift();
			}
		}

		public static function add( ...args:Array ):void
		{
			if ( _logger.isInited )
			{
				_logger.add.apply( null, args );
				_logger.show();
			}
			else
			{
				addLogToQueue( args );
			}
		}

		private static function addLogToQueue( value:Array ):void
		{
			_queue.push( value );
		}
	}
}