/**
 * Created by newkrok on 11/07/16.
 */
package net.fpp.common.test.util.objectpool
{
	import flexunit.framework.TestCase;

	import net.fpp.common.test.util.objectpool.helper.ObjectPoolTestFactory;
	import net.fpp.common.test.util.objectpool.helper.ObjectPoolTestPoolableObject;
	import net.fpp.common.util.objectpool.IObjectPool;
	import net.fpp.common.util.objectpool.IPoolableObject;
	import net.fpp.common.util.objectpool.ObjectPool;
	import net.fpp.common.util.objectpool.ObjectPoolSettingVO;

	[RunWith("org.flexunit.runners.Parameterized")]
	public class ObjectPoolTest extends TestCase
	{
		public static var objectPoolCreationDataProvider:Array = [
			[ true ],
			[ false ]
		];

		public static var objectPoolUsageDataProvider:Array = [
			[ true, 1 ],
			[ true, 10 ],
			[ true, 100 ],
			[ false, 1 ],
			[ false, 10 ],
			[ false, 100 ]
		];

		private var _objectPool:IObjectPool;

		[Before]
		override public function setUp():void
		{
		}

		[After]
		override public function tearDown():void
		{
			this._objectPool.dispose();
			this._objectPool = null;
		}

		[Test(dataProvider='objectPoolCreationDataProvider')]
		public function testObjectPoolCreateAndDestroy( isDynamicObject:Boolean ):void
		{
			var objectPoolSettingVO:ObjectPoolSettingVO = getObjectPoolSettingVO( isDynamicObject );

			this._objectPool = new ObjectPool( objectPoolSettingVO );

			assertEquals( this._objectPool.getPoolSize(), objectPoolSettingVO.poolSize );

			this._objectPool.dispose();

			assertEquals( this._objectPool.getPoolSize(), 0 );
		}

		[Test(dataProvider='objectPoolUsageDataProvider')]
		public function testObjectPoolGetAndReleaseObject( isDynamicObject:Boolean, countOfObjects ):void
		{
			var objectPoolSettingVO:ObjectPoolSettingVO = getObjectPoolSettingVO( isDynamicObject );

			this._objectPool = new ObjectPool( objectPoolSettingVO );

			var usedObjects:Vector.<IPoolableObject> = new <IPoolableObject>[];

			if( isDynamicObject || ( !isDynamicObject && countOfObjects <= objectPoolSettingVO.poolSize ) )
			{
				for( var i:int = 0; i < countOfObjects; i++ )
				{
					var object:Object = this._objectPool.getObject();
					usedObjects.push( object );

					assertTrue( object is ObjectPoolTestPoolableObject );
					assertEquals( this._objectPool.getUsedObjectCount(), usedObjects.length );
				}

				for( i = 0; i < countOfObjects; i++ )
				{
					this._objectPool.releaseObject( usedObjects[ i ] );
					usedObjects[ i ] = null;

					assertEquals( this._objectPool.getUsedObjectCount(), usedObjects.length - ( i + 1 ) );
				}
			}
			else
			{
				try
				{
					for( i = 0; i < countOfObjects; i++ )
					{
						object = this._objectPool.getObject();
						usedObjects.push( object );

						assertTrue( object is ObjectPoolTestPoolableObject );
						assertEquals( this._objectPool.getUsedObjectCount(), usedObjects.length );
					}

					assertTrue( false );
				}
				catch( e:Error )
				{
					assertTrue( true );
				}
			}

			usedObjects.length = 0;
		}

		private function getObjectPoolSettingVO( isDynamicPool:Boolean, poolSize:int = 10 ):ObjectPoolSettingVO
		{
			var objectPoolSettingVO:ObjectPoolSettingVO = new ObjectPoolSettingVO();
			objectPoolSettingVO.isDynamicPool = isDynamicPool;
			objectPoolSettingVO.poolSize = 10;
			objectPoolSettingVO.increaseCount = 10;
			objectPoolSettingVO.objectPoolFactory = new ObjectPoolTestFactory;

			return objectPoolSettingVO;
		}
	}
}