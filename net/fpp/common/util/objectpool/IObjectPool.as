/**
 * Created by newkrok on 09/07/16.
 */
package net.fpp.common.util.objectpool
{
	public interface IObjectPool
	{
		function getObject():IPoolableObject;

		function releaseObject( value:IPoolableObject ):void;

		function dispose():void;
	}
}