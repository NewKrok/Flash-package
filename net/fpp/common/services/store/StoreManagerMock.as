/**
 * Created by newkrok on 04/11/15.
 */
package net.fpp.common.services.store
{
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import net.fpp.common.services.store.events.StoreManagerEvent;

	public class StoreManagerMock extends EventDispatcher implements IStoreManager
	{
		private var _minimumDelay:Number = 1;
		private var _maximumDelay:Number = 3;

		private var _purchaseNonConsumableProductTimer:Timer;
		private var _purchaseNonConsumableProductWaitingList:Vector.<String> = new <String>[];

		public function purchaseNonConsumableProduct( identifier:String ):void
		{
			this._purchaseNonConsumableProductWaitingList.push( identifier );
			this.checkPurchaseNonConsumableProductWaitingList();
		}

		private function checkPurchaseNonConsumableProductWaitingList():void
		{
			if( !_purchaseNonConsumableProductTimer )
			{
				this._purchaseNonConsumableProductTimer = this.getNewTimer();
				this._purchaseNonConsumableProductTimer.addEventListener( TimerEvent.TIMER, this.completePurchaseNonConsumableProduct );
				this._purchaseNonConsumableProductTimer.start();
			}
		}

		private function completePurchaseNonConsumableProduct( e:TimerEvent ):void
		{
			this._purchaseNonConsumableProductTimer.stop();
			this._purchaseNonConsumableProductTimer = null;

			this.dispatchEvent( new StoreManagerEvent( StoreManagerEvent.PRODUCT_PURCHASED, this._purchaseNonConsumableProductWaitingList[ 0 ] ) );
			this._purchaseNonConsumableProductWaitingList.shift();

			if( this._purchaseNonConsumableProductWaitingList.length > 0 )
			{
				this.checkPurchaseNonConsumableProductWaitingList();
			}
		}

		public function purchaseConsumableProduct( identifier:String, count:uint ):void
		{

		}

		public function validateProductIdentifiers( identifiers:Vector.<String>, appIdentifier:String ):void
		{

		}

		public function restoreTransactions():void
		{

		}

		private function getNewTimer():Timer
		{
			return new Timer( ( Math.random() * ( this._maximumDelay - this._minimumDelay ) + this._minimumDelay ) * 1000 );
		}

		public function setMinimumDelay( value:Number ):void
		{
			this._minimumDelay = value;
		}

		public function setMaximumDelay( value:Number ):void
		{
			this._maximumDelay = value;
		}
	}
}