/**
 * Created by newkrok on 09/10/16.
 */
package net.fpp.common.test.injection.helper
{
	public class TestInjectionContainerC
	{
		[Inject(id='testA')]
		public var testInjectionA:ITestInjectClassA;

		[Inject(id='testB')]
		public var testInjectionB:ITestInjectClassA;
	}
}