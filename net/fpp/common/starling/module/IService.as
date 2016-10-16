/**
 * Created by newkrok on 16/10/16.
 */
package net.fpp.common.starling.module
{
	import net.fpp.common.starling.events.IEventDispatcher;

	public interface IService extends IEventDispatcher
	{
		function onInited():void;

		function dispose():void;
	}
}