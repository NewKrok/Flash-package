package net.fpp.starling.module
{	
	import starling.display.DisplayObject;
	import starling.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public interface IModule
	{
		function getView():DisplayObject;
		
		function dispose():void;
	}
}