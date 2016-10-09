/**
 * Created by newkrok on 09/10/16.
 */
package net.fpp.common.test.injection.helper
{
	public class TestInjectClassB implements ITestInjectClassB
	{
		private var STATIC_ID:int = 0;

		private var _id:int = STATIC_ID++;

		public function getId():int
		{
			return this._id;
		}
	}
}