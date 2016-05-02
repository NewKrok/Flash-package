/**
 * Created by newkrok on 04/11/15.
 */
package net.fpp.common.services.store
{
	import flash.events.IEventDispatcher;

	public interface IStoreManager extends IEventDispatcher
	{
		function purchaseNonConsumableProduct( identifier:String ):void

		function purchaseConsumableProduct( identifier:String, count:uint ):void

		function validateProductIdentifiers( identifiers:Vector.<String>, appIdentifier:String ):void

		function restoreTransactions():void
	}
}