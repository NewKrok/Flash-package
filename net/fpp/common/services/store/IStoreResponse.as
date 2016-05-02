/**
 * Created by newkrok on 04/11/15.
 */
package net.fpp.common.services.store
{
	public interface IStoreResponse
	{
		function get products():Vector.<IStoreProduct>;

		function get invalidIdentifiers():Vector.<String>;

		function get storageUpToDate():Boolean;
	}
}