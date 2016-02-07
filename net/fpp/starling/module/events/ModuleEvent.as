/**
 * Created by newkrok on 09/01/16.
 */
package net.fpp.starling.module.events
{
	import starling.events.Event;

	public class ModuleEvent extends Event
	{
		public static const DISPOSE_REQUEST:String = "ModuleEvent.DISPOSE_REQUEST";
		public static const MODULE_VIEW_INITED:String = "ModuleEvent.MODULE_VIEW_INITED";

		public function ModuleEvent( type:String ):void
		{
			super( type );
		}
	}
}