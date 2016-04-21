package net.fpp.starling.module
{
	import net.fpp.starling.events.IEventDispatcher;

	public interface IModule extends IEventDispatcher
	{
		function getView():AModuleView;

		function registerService( service:AService ):void

		function dispose():void;
	}
}