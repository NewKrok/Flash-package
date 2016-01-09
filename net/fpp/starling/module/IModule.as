package net.fpp.starling.module
{	
	import starling.display.DisplayObject;
	import starling.events.EventDispatcher;
	
	public interface IModule implements EventDispatcher
	{
		function getView():DisplayObject;
		
		function dispose():void;
		
		function disposeRequest():void;
	}
}