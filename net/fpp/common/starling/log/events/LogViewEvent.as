/**
 * Created by newkrok on 08/11/15.
 */
package net.fpp.common.starling.log.events
{
	import starling.events.Event;

	public class LogViewEvent extends Event
	{
		public static const INITED:String = "LogViewEvent.INITED";

		public function LogViewEvent( type:String ):void
		{
			super( type );
		}
	}
}