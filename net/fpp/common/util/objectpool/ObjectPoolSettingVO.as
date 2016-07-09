/**
 * Created by newkrok on 09/07/16.
 */
package net.fpp.common.util.objectpool
{
	public class ObjectPoolSettingVO
	{
		public var objectPoolFactory:IPoolableObjectFactory;

		public var poolSize:uint;

		public var increaseCount:uint;

		public var isDynamicPool:Boolean;
	}
}