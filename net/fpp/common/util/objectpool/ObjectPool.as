/**
 * Created by newkrok on 09/07/16.
 */
package net.fpp.common.util.objectpool
{
	public class ObjectPool implements IObjectPool
	{
		private var _objectPoolFactory:IPoolableObjectFactory;

		private var _availableObjects:Vector.<IPoolableObject>;
		private var _usedObjects:Vector.<IPoolableObject>;

		private var _increaseCount:uint;

		private var _isDynamicPool:Boolean;

		public function ObjectPool( objectPoolSettingVO:ObjectPoolSettingVO )
		{
			this._objectPoolFactory = objectPoolSettingVO.objectPoolFactory;
			this._isDynamicPool = objectPoolSettingVO.isDynamicPool;
			this._increaseCount = objectPoolSettingVO.increaseCount;

			if ( objectPoolSettingVO.isDynamicPool )
			{
				this.createDynamicPool( objectPoolSettingVO.poolSize );
			}
			else
			{
				this.createPoolWithFixedSize( objectPoolSettingVO.poolSize );
			}
		}

		private function createDynamicPool( poolSize:uint ):void
		{
			this._availableObjects = new Vector.<IPoolableObject>;
			this._usedObjects = new Vector.<IPoolableObject>;

			for ( var i:int = 0; i < poolSize; i++ )
			{
				this._availableObjects.push( this.createPoolableObject() );
			}
		}

		private function increaseDynamicPool( count:uint ):void
		{
			for ( var i:int = 0; i < count; i++ )
			{
				this._availableObjects.push( this.createPoolableObject() );
			}
		}

		private function createPoolWithFixedSize( poolSize:uint ):void
		{
			this._availableObjects = new Vector.<IPoolableObject>( poolSize );
			this._usedObjects = new Vector.<IPoolableObject>( poolSize );

			for ( var i:int = 0; i < poolSize; i++ )
			{
				this._availableObjects[i] = this.createPoolableObject();
			}
		}

		private function createPoolableObject():IPoolableObject
		{
			var poolObject:IPoolableObject = this._objectPoolFactory.createObject();
			poolObject.init();

			return poolObject;
		}

		public function getObject():IPoolableObject
		{
			if ( this._availableObjects.length > 0 )
			{
				this._usedObjects.push( this._availableObjects[ this._availableObjects.length - 1 ] );
				this._availableObjects.pop();

				return this._usedObjects[ this._usedObjects.length - 1 ];
			}
			else if ( this._isDynamicPool )
			{
				this.increaseDynamicPool( this._increaseCount );

				return this.getObject();
			}
			else
			{
				return null;
				throw new Error( 'Object pool is empty and not dynamic.' );
			}
		}

		public function releaseObject( poolableObject:IPoolableObject ):void
		{
			var length:int = this._usedObjects.length;

			for ( var i:int = 0; i < length; i++ )
			{
				if ( this._usedObjects[i] == poolableObject )
				{
					this._usedObjects.splice( i, 1 );
					this._availableObjects.push( poolableObject );

					poolableObject.reset();

					return;
				}
			}

			throw new Error( 'Unknown releaseble pool object.' );
		}

		public function dispose():void
		{
			var length:int = this._usedObjects.length;

			for ( var i:int = 0; i < length; i++ )
			{
				this._usedObjects[i].reset();
				this._usedObjects[i].dispose();
				this._usedObjects[i] = null;
			}

			this._usedObjects.length = 0;
			this._usedObjects = null;
		}
	}
}