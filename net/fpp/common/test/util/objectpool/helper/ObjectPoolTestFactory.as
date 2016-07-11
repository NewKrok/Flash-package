/**
 * Created by newkrok on 11/07/16.
 */
package net.fpp.common.test.util.objectpool.helper
{
	import net.fpp.common.util.objectpool.IPoolableObject;
	import net.fpp.common.util.objectpool.IPoolableObjectFactory;

	public class ObjectPoolTestFactory implements IPoolableObjectFactory
	{
		public function createObject():IPoolableObject
		{
			return new ObjectPoolTestPoolableObject;
		}
	}
}