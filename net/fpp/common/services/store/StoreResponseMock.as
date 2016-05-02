/**
 * Created by newkrok on 04/11/15.
 */
package net.fpp.common.services.store
{
	public class StoreResponseMock implements IStoreResponse
	{
		private var _products:Vector.<MockStoreProduct>;
		private var _invalidProductIdentifier:Vector.<String>;
		private var _storageUpToDate:Boolean;

		public function StoreResponseMock( products:Vector.<MockStoreProduct>, invalidIdentifier:Vector.<String>, storageUpToDate:Boolean )
		{
			this._products = products;
			this._invalidProductIdentifier = invalidIdentifier;
			this._storageUpToDate = storageUpToDate;
		}

		public function get products():Vector.<MockStoreProduct>
		{
			return this._products;
		}

		public function get invalidIdentifiers():Vector.<String>
		{
			return this._invalidProductIdentifier;
		}

		public function get storageUpToDate():Boolean
		{
			return this._storageUpToDate;
		}
	}
}