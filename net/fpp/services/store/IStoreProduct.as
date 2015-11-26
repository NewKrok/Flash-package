/**
 * Created by newkrok on 04/11/15.
 */
package net.fpp.services.store
{
	public interface IStoreProduct
	{
		function get productionIdentifier():String;

		function get localizedDescription():String;

		function get localizedTitle():String;

		function get price():Number;

		function get purchased():Boolean;

	}
}