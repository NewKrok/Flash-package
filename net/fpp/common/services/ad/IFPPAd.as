package net.fpp.common.services.ad {
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.display.Sprite
	
	public interface IFPPAd {

		function get adID( ):int;
		function FPPAdDataLoaded( $FPPAdData:Object ):void;
		function getNewAd( event:* = null ):void;
		function refresh( event:Event ):void;
		function addEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void;
		function removeEventListener( type:String, listener:Function, useCapture:Boolean = false ):void;
		function dispose( ):void;
		function get width( ):Number;
		function get height( ):Number;
		function get x( ):Number;
		function get y( ):Number;
		function set x( value:Number ):void;
		function set y( value:Number ):void;
			
	}
	
}