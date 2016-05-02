/**
 * Created by newkrok on 06/11/15.
 */
package net.fpp.common.services.store.events
{
	import net.fpp.common.services.store.IStoreResponse;

	public interface IStoreManagerEvent
	{
		function get productIdentifier():String;

		function get response():IStoreResponse;
	}
}