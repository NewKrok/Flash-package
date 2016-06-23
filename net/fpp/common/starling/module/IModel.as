package net.fpp.common.starling.module
{
	import net.fpp.common.starling.events.IEventDispatcher;

	public interface IModel extends IEventDispatcher
	{
		function dispose():void;
	}
}