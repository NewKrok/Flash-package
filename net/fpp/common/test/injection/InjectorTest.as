/**
 * Created by newkrok on 09/10/16.
 */
package net.fpp.common.test.injection
{
	import flexunit.framework.Assert;
	import flexunit.framework.TestCase;

	import net.fpp.common.injection.IInjector;
	import net.fpp.common.injection.Injector;
	import net.fpp.common.test.injection.helper.ITestInjectClassA;
	import net.fpp.common.test.injection.helper.ITestInjectClassB;
	import net.fpp.common.test.injection.helper.TestInjectClassA;
	import net.fpp.common.test.injection.helper.TestInjectClassB;
	import net.fpp.common.test.injection.helper.TestInjectionContainerA;
	import net.fpp.common.test.injection.helper.TestInjectionContainerB;
	import net.fpp.common.test.injection.helper.TestInjectionContainerC;

	[RunWith("org.flexunit.runners.Parameterized")]
	public class InjectorTest extends TestCase
	{
		private var _injector:IInjector;

		[Before]
		override public function setUp():void
		{
			this._injector = new Injector();
		}

		[After]
		override public function tearDown():void
		{
			if( this._injector )
			{
				this._injector.dispose();
			}

			this._injector = null;
		}

		[Test]
		public function testMapToValueAddAndRemove():void
		{
			var valueObjectA:ITestInjectClassA = new TestInjectClassA();
			var valueObjectB:ITestInjectClassB = new TestInjectClassB();

			var injectionContainerA:TestInjectionContainerA = new TestInjectionContainerA;
			var injectionContainerB:TestInjectionContainerB = new TestInjectionContainerB;

			this._injector.mapToValue( ITestInjectClassA, valueObjectA );
			this._injector.mapToValue( ITestInjectClassB, valueObjectB );

			this._injector.inject( injectionContainerA );
			this._injector.inject( injectionContainerB );

			Assert.assertEquals( injectionContainerA.testInjection, valueObjectA );
			Assert.assertEquals( injectionContainerB.testInjectionA, valueObjectA );
			Assert.assertEquals( injectionContainerB.testInjectionB, valueObjectB );

			this._injector.removeMapFromValue( valueObjectA );
			this._injector.inject( injectionContainerA );
			this._injector.inject( injectionContainerB );

			Assert.assertNull( injectionContainerA.testInjection );
			Assert.assertNull( injectionContainerB.testInjectionA );
			Assert.assertEquals( injectionContainerB.testInjectionB, valueObjectB );

			this._injector.removeMapToValue( ITestInjectClassB );
			this._injector.inject( injectionContainerB );

			Assert.assertNull( injectionContainerB.testInjectionB );
		}

		[Test]
		public function testMapToValueDispose():void
		{
			var valueObjectA:ITestInjectClassA = new TestInjectClassA();
			var valueObjectB:ITestInjectClassB = new TestInjectClassB();

			var injectionContainerA:TestInjectionContainerA = new TestInjectionContainerA;
			var injectionContainerB:TestInjectionContainerB = new TestInjectionContainerB;

			this._injector.mapToValue( ITestInjectClassA, valueObjectA );
			this._injector.mapToValue( ITestInjectClassB, valueObjectB );

			this._injector.inject( injectionContainerA );
			this._injector.inject( injectionContainerB );

			this._injector.dispose();

			this._injector.inject( injectionContainerA );
			this._injector.inject( injectionContainerB );

			Assert.assertNull( injectionContainerA.testInjection );
			Assert.assertNull( injectionContainerB.testInjectionA );
			Assert.assertNull( injectionContainerB.testInjectionB );
		}

		[Test]
		public function testMapToValueWithId():void
		{
			var valueObjectA:ITestInjectClassA = new TestInjectClassA();
			var valueObjectB:ITestInjectClassA = new TestInjectClassA();

			var injectionContainerC:TestInjectionContainerC = new TestInjectionContainerC;

			this._injector.mapToValue( ITestInjectClassA, valueObjectA, 'testA' );
			this._injector.mapToValue( ITestInjectClassA, valueObjectB, 'testB' );

			this._injector.inject( injectionContainerC );

			Assert.assertNotNull( injectionContainerC.testInjectionA );
			Assert.assertNotNull( injectionContainerC.testInjectionB );
			Assert.assertTrue( injectionContainerC.testInjectionA != injectionContainerC.testInjectionB );
		}

		[Test]
		public function testMapToSingletonAddAndRemove():void
		{
			var injectionContainerA:TestInjectionContainerA = new TestInjectionContainerA;
			var injectionContainerB:TestInjectionContainerB = new TestInjectionContainerB;

			this._injector.mapToSingleton( ITestInjectClassA, TestInjectClassA );
			this._injector.mapToSingleton( ITestInjectClassB, TestInjectClassB );

			this._injector.inject( injectionContainerA );
			this._injector.inject( injectionContainerB );

			Assert.assertEquals( injectionContainerA.testInjection, injectionContainerB.testInjectionA );
			Assert.assertTrue( injectionContainerB.testInjectionA != injectionContainerB.testInjectionB );

			this._injector.removeMapFromSingleton( injectionContainerA.testInjection );
			this._injector.inject( injectionContainerA );
			this._injector.inject( injectionContainerB );

			Assert.assertNull( injectionContainerA.testInjection );
			Assert.assertNull( injectionContainerB.testInjectionA );
			Assert.assertNotNull( injectionContainerB.testInjectionB );

			this._injector.removeMapToSingleton( ITestInjectClassB );
			this._injector.inject( injectionContainerB );

			Assert.assertNull( injectionContainerB.testInjectionB );
		}

		[Test]
		public function testMapToSingletonDispose():void
		{
			var injectionContainerA:TestInjectionContainerA = new TestInjectionContainerA;
			var injectionContainerB:TestInjectionContainerB = new TestInjectionContainerB;

			this._injector.mapToSingleton( ITestInjectClassA, TestInjectClassA );
			this._injector.mapToSingleton( ITestInjectClassB, TestInjectClassB );

			this._injector.inject( injectionContainerA );
			this._injector.inject( injectionContainerB );

			this._injector.dispose();

			this._injector.inject( injectionContainerA );
			this._injector.inject( injectionContainerB );

			Assert.assertNull( injectionContainerA.testInjection );
			Assert.assertNull( injectionContainerB.testInjectionA );
			Assert.assertNull( injectionContainerB.testInjectionB );
		}

		[Test]
		public function testMapToClassAddAndRemove():void
		{
			var injectionContainerA:TestInjectionContainerA = new TestInjectionContainerA;
			var injectionContainerB:TestInjectionContainerB = new TestInjectionContainerB;

			this._injector.mapToClass( ITestInjectClassA, TestInjectClassA );
			this._injector.mapToClass( ITestInjectClassB, TestInjectClassB );

			this._injector.inject( injectionContainerA );
			this._injector.inject( injectionContainerB );

			Assert.assertTrue( injectionContainerA.testInjection != injectionContainerB.testInjectionA );
			Assert.assertTrue( injectionContainerB.testInjectionA != injectionContainerB.testInjectionB );

			this._injector.removeMapToClass( ITestInjectClassA );
			this._injector.inject( injectionContainerA );
			this._injector.inject( injectionContainerB );

			Assert.assertNull( injectionContainerA.testInjection );
			Assert.assertNull( injectionContainerB.testInjectionA );
			Assert.assertNotNull( injectionContainerB.testInjectionB );

			this._injector.removeMapToClass( ITestInjectClassB );
			this._injector.inject( injectionContainerB );

			Assert.assertNull( injectionContainerB.testInjectionB );
		}

		[Test]
		public function testMapToClassDispose():void
		{
			var injectionContainerA:TestInjectionContainerA = new TestInjectionContainerA;
			var injectionContainerB:TestInjectionContainerB = new TestInjectionContainerB;

			this._injector.mapToClass( ITestInjectClassA, TestInjectClassA );
			this._injector.mapToClass( ITestInjectClassB, TestInjectClassB );

			this._injector.inject( injectionContainerA );
			this._injector.inject( injectionContainerB );

			this._injector.dispose();

			this._injector.inject( injectionContainerA );
			this._injector.inject( injectionContainerB );

			Assert.assertNull( injectionContainerA.testInjection );
			Assert.assertNull( injectionContainerB.testInjectionA );
			Assert.assertNull( injectionContainerB.testInjectionB );
		}
	}
}