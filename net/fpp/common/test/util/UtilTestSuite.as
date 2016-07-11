/**
 * Created by newkrok on 11/07/16.
 */
package net.fpp.common.test.util
{
	import flexunit.framework.TestSuite;

	import net.fpp.common.test.util.objectpool.ObjectPoolTest;

	public class UtilTestSuite extends TestSuite
	{
		public function UtilTestSuite()
		{
			this.addTestSuite( ObjectPoolTest );
		}
	}
}