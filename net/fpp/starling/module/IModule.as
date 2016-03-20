package net.fpp.starling.module
{
	import net.fpp.starling.events.IEventDispatcher;

	public interface IModule extends IEventDispatcher
	{
		function getView():AModuleView;
		
		function dispose():void;
	}
}