/**
 * Created by newkrok on 04/11/15.
 */
package net.fpp.services.store.events
{
	import flash.events.Event;

	import net.fpp.services.store.IStoreResponse;

	public class StoreManagerEvent extends Event implements IStoreManagerEvent
	{
		public static const PRODUCT_PURCHASED:String = "PRODUCT_PURCHASED";
		public static const PRODUCT_IDENTIFIER_VALIDATION_COMPLETE:String = "PRODUCT_IDENTIFIER_VALIDATION_COMPLETE";
		public static const PRODUCT_PURCHASING:String = "PRODUCT_PURCHASING";
		public static const PRODUCT_PURCHASING_FAILED:String = "PRODUCT_PURCHASING_FAILED";
		public static const PRODUCT_PURCHASE_RESTORED:String = "PRODUCT_PURCHASE_RESTORED";

		private var _productIdentifier:String;
		private var _response:IStoreResponse;

		public function StoreManagerEvent( type:String, productIdentifier:String, response:IStoreResponse = null, bubbles:Boolean = false, cancelable:Boolean = false )
		{
			this._productIdentifier = productIdentifier;
			this._response = response;
			super( type );
		}

		override public function clone():Event
		{
			return new StoreManagerEvent( type, this._productIdentifier );
		}

		public function get productIdentifier():String
		{
			return this._productIdentifier;
		}

		public function get response():IStoreResponse
		{
			return this._response;
		}
	}
}