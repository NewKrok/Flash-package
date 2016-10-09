/**
 * Created by newkrok on 09/10/16.
 */
package net.fpp.common.test.injection.helper
{
	public class TestInjectionContainerB
	{
		[Inject]
		public var testInjectionA:ITestInjectClassA;

		[Inject]
		public var testInjectionB:ITestInjectClassB;
	}
}