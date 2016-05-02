/**
 * Created by newkrok on 04/11/15.
 */
package net.fpp.common.services.store
{
	public class StaticStoreManager
	{
		private static var _manager:Object;

		public static function init( manager:Object ):void
		{
			_manager = manager;
		}

		public static function addEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void
		{
			try
			{
				_manager.addEventListener( type, listener, useCapture, priority, useWeakReference );
			}
			catch( e:Error )
			{
				throw new Error( "StoreManager Error: can't call the addEventListener function." );
			}
		}

		public static function removeEventListener( type:String, listener:Function, useCapture:Boolean = false ):void
		{
			try
			{
				_manager.removeEventListener( type, listener, useCapture );
			}
			catch( e:Error )
			{
				throw new Error( "StoreManager Error: can't call the removeEventListener function." );
			}
		}

		public static function purchaseNonConsumableProduct( id:String ):void
		{
			try
			{
				_manager.purchaseNonConsumableProduct( id );
			}
			catch( e:Error )
			{
				throw new Error( "StoreManager Error: can't call the purchaseNonConsumableProduct function." );
			}
		}

		public static function purchaseConsumableProduct( identifier, count:uint ):void
		{
			try
			{
				_manager.purchaseConsumableProduct( identifier, count );
			}
			catch( e:Error )
			{
				throw new Error( "StoreManager Error: can't call the purchaseConsumableProduct function." );
			}
		}

		public static function validateProductIdentifiers( identifiers:Vector.<String>, appIdentifier:String ):void
		{
			try
			{
				_manager.validateProductIdentifiers( identifiers, appIdentifier );
			}
			catch( e:Error )
			{
				throw new Error( "StoreManager Error: can't call the validateProductIdentifiers function." );
			}
		}

		public static function restoreTransactions():void
		{
			try
			{
				_manager.restoreTransactions();
			}
			catch( e:Error )
			{
				throw new Error( "StoreManager Error: can't call the restoreTransactions function." );
			}
		}

		public static function getInstance():Object
		{
			return _manager;
		}
	}
}