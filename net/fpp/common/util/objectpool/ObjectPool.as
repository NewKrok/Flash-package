/**
 * Created by newkrok on 09/07/16.
 */
package net.fpp.common.util.objectpool
{
	public class ObjectPool implements IObjectPool
	{
		private var _objectPoolFactory:IPoolableObjectFactory;

		private var _availableObjects:Vector.<IPoolableObject>;

		private var _usedObjectIndexes:Array;

		private var _increaseCount:uint;

		private var _isDynamicPool:Boolean;

		public function ObjectPool( objectPoolSettingVO:ObjectPoolSettingVO )
		{
			this._objectPoolFactory = objectPoolSettingVO.objectPoolFactory;
			this._isDynamicPool = objectPoolSettingVO.isDynamicPool;
			this._increaseCount = objectPoolSettingVO.increaseCount;

			this._usedObjectIndexes = [];

			if( this._isDynamicPool )
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

			for( var i:int = 0; i < poolSize; i++ )
			{
				this._availableObjects.push( this.createPoolableObject() );
			}
		}

		private function increaseDynamicPool( count:uint ):void
		{
			for( var i:int = 0; i < count; i++ )
			{
				this._availableObjects.push( this.createPoolableObject() );
			}
		}

		private function createPoolWithFixedSize( poolSize:uint ):void
		{
			this._availableObjects = new Vector.<IPoolableObject>( poolSize );

			for( var i:int = 0; i < poolSize; i++ )
			{
				this._availableObjects[ i ] = this.createPoolableObject();
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
			if( this.getUsedObjectCount() < this.getPoolSize() )
			{
				return this.getAvailableObject();
			}
			else if( this._isDynamicPool )
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

		private function getAvailableObject():IPoolableObject
		{
			var length:int = this._availableObjects.length;

			for( var i:int = 0; i < length; i++ )
			{
				if( this.isFreeIndex( i ) )
				{
					this._usedObjectIndexes.push( i );

					return this._availableObjects[ i ];
				}
			}

			return null;
		}

		private function isFreeIndex( index:int ):Boolean
		{
			var length:int = this._usedObjectIndexes.length;

			for( var i:int = 0; i < length; i++ )
			{
				if( this._usedObjectIndexes[ i ] == index )
				{
					return false;
				}
			}

			return true;
		}

		public function releaseObject( poolableObject:IPoolableObject ):void
		{
			var length:int = this._availableObjects.length;

			for( var i:int = 0; i < length; i++ )
			{
				if( this._availableObjects[ i ] == poolableObject )
				{
					poolableObject.reset();

					this._usedObjectIndexes.splice( this._usedObjectIndexes.indexOf( i ), 1 );

					return;
				}
			}

			throw new Error( 'Unknown releaseble pool object.' );
		}

		public function dispose():void
		{
			if( this._availableObjects )
			{
				var length:int = this._availableObjects.length;

				for( var i:int = 0; i < length; i++ )
				{
					this._availableObjects[ i ].reset();
					this._availableObjects[ i ].dispose();
					this._availableObjects[ i ] = null;
				}

				this._availableObjects.length = 0;
				this._availableObjects = null;
			}

			this._usedObjectIndexes = null;
		}

		public function getPoolSize():int
		{
			return this._availableObjects ? this._availableObjects.length : 0;
		}

		public function getUsedObjectCount():int
		{
			return this._usedObjectIndexes ? this._usedObjectIndexes.length : 0;
		}
	}
}