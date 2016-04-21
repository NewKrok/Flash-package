/**
 * Created by newkrok on 20/03/16.
 */
package net.fpp.starling.events
{
	import starling.events.Event;

	public interface IEventDispatcher
	{
		function addEventListener( type:String, listener:Function ):void;
		function removeEventListener( type:String, listener:Function ):void;
		function dispatchEvent( event:Event ):void;
		function dispatchEventWith( type:String, bubbles:Boolean = false, data:Object = null ):void;
	}
}