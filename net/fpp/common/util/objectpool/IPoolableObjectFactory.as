/**
 * Created by newkrok on 09/07/16.
 */
package net.fpp.common.util.objectpool
{
	public interface IPoolableObjectFactory
	{
		function createObject():IPoolableObject;
	}
}