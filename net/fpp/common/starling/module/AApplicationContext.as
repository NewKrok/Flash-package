/**
 * Created by newkrok on 24/04/16.
 */
package net.fpp.common.starling.module
{
	import net.fpp.common.injection.Injector;
	import net.fpp.common.starling.module.vo.UpdatableModuleVO;

	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;

	public class AApplicationContext extends Sprite implements IApplicationContext
	{
		private var _modules:Vector.<IModule> = new <IModule>[];
		private var _updatableModuleVOs:Vector.<UpdatableModuleVO> = new <UpdatableModuleVO>[];

		private var _handlers:Vector.<IHandler> = new <IHandler>[];

		private var _injector:Injector = new Injector();

		private var _passedTime:Number = 0;
		private var _now:Number = 0;
		private var _lastUpdateTime:Number = 0;

		public function AApplicationContext()
		{
			this._injector.mapToValue( IApplicationContext, this );
		}

		public function startUpdateHandling():void
		{
			this._now = new Date().time;

			this._lastUpdateTime = this._now;

			var length:int = this._updatableModuleVOs.length;

			for( var i:int = 0; i < length; i++ )
			{
				this._updatableModuleVOs[ i ].lastUpdateTime = this._now;
			}

			this.addEventListener( EnterFrameEvent.ENTER_FRAME, this.onEnterFrameHandler );
		}

		public function stopUpdateHandling():void
		{
			this.removeEventListener( EnterFrameEvent.ENTER_FRAME, this.onEnterFrameHandler );
		}

		private function onEnterFrameHandler():void
		{
			this._now = new Date().time;
			this._passedTime = this._now - this._lastUpdateTime;
			this._lastUpdateTime = now;

			this.updateModules();
			this.onUpdate();
		}

		private function updateModules():void
		{
			var length:int = this._updatableModuleVOs.length;

			for( var i:int = 0; i < length; i++ )
			{
				var updatableModule:IUpdatableModule = this._updatableModuleVOs[ i ].moduleReference;
				var updateFrequency:int = updatableModule.getUpdateFrequency();

				if( updateFrequency == 0 )
				{
					updatableModule.onUpdate();
					this._updatableModuleVOs[ i ].lastUpdateTime = now;
				}
				else
				{
					var passedTimeAfterLastModuleUpdate:Number = this.now - this._updatableModuleVOs[ i ].lastUpdateTime;
					var updateCounter:int = Math.floor( passedTimeAfterLastModuleUpdate / updateFrequency );

					for( var j:int = 0; j < updateCounter; j++ )
					{
						updatableModule.onUpdate();
					}

					if( updateCounter > 0 )
					{
						this._updatableModuleVOs[ i ].lastUpdateTime = now + updateCounter * updateFrequency;
					}
				}
			}
		}

		protected function onUpdate():void
		{
		}

		public function get now():Number
		{
			return this._now;
		}

		public function get passedTime():Number
		{
			return this._passedTime;
		}

		public function createModule( id:String, moduleClass:Class, moduleInterface:Class, args:Array = null ):IModule
		{
			var module:IModule;

			if( args )
			{
				switch( args.length )
				{
					case 1:
						module = new moduleClass( args[ 0 ] );
						break;

					case 2:
						module = new moduleClass( args[ 0 ], args[ 1 ] );
						break;

					case 3:
						module = new moduleClass( args[ 0 ], args[ 1 ], args[ 2 ] );
						break;

					case 4:
						module = new moduleClass( args[ 0 ], args[ 1 ], args[ 2 ], args[ 3 ] );
						break;

					case 5:
						module = new moduleClass( args[ 0 ], args[ 1 ], args[ 2 ], args[ 3 ], args[ 4 ] );
						break;

					default:
						throw new Error( 'To many constructor params. Try optimize it!' );
						break;
				}
			}
			else
			{
				module = new moduleClass();
			}

			return this.registerModule( id, module, moduleInterface );
		}

		public function registerModule( id:String, module:IModule, moduleInterface:Class ):IModule
		{
			this._modules.push( module );

			if( module is IUpdatableModule )
			{
				this._updatableModuleVOs.push( new UpdatableModuleVO( module as IUpdatableModule ) );
			}

			this._injector.mapToValue( moduleInterface, module, id );
			this._injector.inject( module );

			module.onInited();

			return module;
		}

		public function unregisterModule( module:IModule ):void
		{
			this._injector.removeMapFromValue( module );

			var length:int = this._modules.length;

			for( var i:int = 0; i < length; i++ )
			{
				var bModule:IModule = this._modules[ i ];

				if( module == bModule )
				{
					this._modules.splice( i, 1 );

					break;
				}
			}

			if( module is IUpdatableModule )
			{
				length = this._updatableModuleVOs.length;

				for( i = 0; i < length; i++ )
				{
					bModule = this._updatableModuleVOs[ i ].moduleReference;

					if( module == bModule )
					{
						this._updatableModuleVOs[ i ] = null;
						this._updatableModuleVOs.splice( i, 1 );

						break;
					}
				}
			}
		}

		public function registerHandler( handler:IHandler ):void
		{
			this._handlers.push( handler );

			this._injector.inject( handler );

			handler.onInited();
		}

		protected function get injector():Injector
		{
			return this._injector;
		}

		override public function dispose():void
		{
			this.stopUpdateHandling();

			this.disposeHandlers();
			this.disposeModules();
		}

		private function disposeHandlers():void
		{
			var length:int = this._handlers.length;

			for( var i:int = 0; i < length; i++ )
			{
				var handler:IHandler = this._handlers[ i ];

				handler.dispose();
				handler = null;
			}

			this._handlers.length = 0;
			this._handlers = null;
		}

		private function disposeModules():void
		{
			this._injector.dispose();

			var length:int = this._modules.length;

			for( var i:int = 0; i < length; i++ )
			{
				var module:IModule = this._modules[ i ];

				module.dispose();
				module = null;
			}

			this._modules.length = 0;
			this._modules = null;

			this._updatableModuleVOs.length = 0;
			this._updatableModuleVOs = null;
		}
	}
}