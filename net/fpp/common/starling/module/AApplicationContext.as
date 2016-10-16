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

		protected var _view:Sprite = new Sprite();

		private var _handlers:Vector.<IHandler> = new <IHandler>[];
		private var _services:Vector.<IService> = new <IService>[];

		protected var _injector:Injector = new Injector();

		private var _now:Number;

		public function AApplicationContext()
		{
			this.addChild( this._view );

			this._injector.mapToValue( IApplicationContext, this );
		}

		public function startUpdateHandling():void
		{
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
					this._updatableModuleVOs[ i ].lastUpdateTime = this._now;
				}
				else
				{
					var passedTimeAfterLastModuleUpdate:Number = this._now - this._updatableModuleVOs[ i ].lastUpdateTime;
					var updateCounter:int = Math.floor( passedTimeAfterLastModuleUpdate / updateFrequency );

					for( var j:int = 0; j < updateCounter; j++ )
					{
						updatableModule.onUpdate();
					}

					if( updateCounter > 0 )
					{
						this._updatableModuleVOs[ i ].lastUpdateTime = this._now + updateCounter * updateFrequency;
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

			if( module.getView() )
			{
				this._view.addChild( module.getView() );
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

		public function disposeModuleByClass( moduleClass:Class ):void
		{
			var length:int = this._modules.length;

			for( var i:int = 0; i < length; i++ )
			{
				var module:IModule = this._modules[ i ];

				if( module is moduleClass )
				{
					this._injector.removeMapFromValue( module );

					module.dispose();
					module = null;
					this._modules.splice( i, 1 );

					length--;
					i--;
				}
			}
		}

		public function createHandler( handlerClass:Class, args:Array = null ):IHandler
		{
			var handler:IHandler;

			if( args )
			{
				switch( args.length )
				{
					case 1:
						handler = new handlerClass( args[ 0 ] );
						break;

					case 2:
						handler = new handlerClass( args[ 0 ], args[ 1 ] );
						break;

					case 3:
						handler = new handlerClass( args[ 0 ], args[ 1 ], args[ 2 ] );
						break;

					case 4:
						handler = new handlerClass( args[ 0 ], args[ 1 ], args[ 2 ], args[ 3 ] );
						break;

					case 5:
						handler = new handlerClass( args[ 0 ], args[ 1 ], args[ 2 ], args[ 3 ], args[ 4 ] );
						break;

					default:
						throw new Error( 'To many constructor params. Try optimize it!' );
						break;
				}
			}
			else
			{
				handler = new handlerClass();
			}

			return this.registerHandler( handler );
		}

		public function registerHandler( handler:IHandler ):IHandler
		{
			this._handlers.push( handler );

			this._injector.inject( handler );

			handler.onInited();

			return handler;
		}

		public function unregisterHandler( handler:IHandler ):void
		{
			var length:int = this._handlers.length;

			for( var i:int = 0; i < length; i++ )
			{
				var bHandler:IHandler = this._handlers[ i ];

				if( handler == bHandler )
				{
					this._handlers.splice( i, 1 );

					break;
				}
			}
		}

		public function disposeHandlerByClass( handlerClass:Class ):void
		{
			var length:int = this._handlers.length;

			for( var i:int = 0; i < length; i++ )
			{
				var handler:IHandler = this._handlers[ i ];

				if( handler is handlerClass )
				{
					handler.dispose();
					handler = null;
					this._handlers.splice( i, 1 );

					length--;
					i--;
				}
			}
		}

		public function createService( id:String, serviceClass:Class, serviceInterface:Class, args:Array = null ):IService
		{
			var service:IService;

			if( args )
			{
				switch( args.length )
				{
					case 1:
						service = new serviceClass( args[ 0 ] );
						break;

					case 2:
						service = new serviceClass( args[ 0 ], args[ 1 ] );
						break;

					case 3:
						service = new serviceClass( args[ 0 ], args[ 1 ], args[ 2 ] );
						break;

					case 4:
						service = new serviceClass( args[ 0 ], args[ 1 ], args[ 2 ], args[ 3 ] );
						break;

					case 5:
						service = new serviceClass( args[ 0 ], args[ 1 ], args[ 2 ], args[ 3 ], args[ 4 ] );
						break;

					default:
						throw new Error( 'To many constructor params. Try optimize it!' );
						break;
				}
			}
			else
			{
				service = new serviceClass();
			}

			return this.registerService( id, service, serviceInterface );
		}

		public function registerService( id:String, service:IService, serviceInterface:Class ):IService
		{
			this._services.push( service );

			this._injector.mapToValue( serviceInterface, service, id );

			service.onInited();

			return service;
		}

		public function unregisterService( service:IService ):void
		{
			this._injector.removeMapFromValue( service );

			var length:int = this._services.length;

			for( var i:int = 0; i < length; i++ )
			{
				var bService:IService = this._services[ i ];

				if( service == bService )
				{
					this._services.splice( i, 1 );

					break;
				}
			}
		}

		public function disposeServiceByClass( serviceClass:Class ):void
		{
			var length:int = this._services.length;

			for( var i:int = 0; i < length; i++ )
			{
				var service:IService = this._services[ i ];

				if( service is serviceClass )
				{
					this._injector.removeMapFromValue( service );

					service.dispose();
					service = null;
					this._services.splice( i, 1 );

					length--;
					i--;
				}
			}
		}

		override public function dispose():void
		{
			this.stopUpdateHandling();

			this._injector.dispose();

			this.disposeHandlers();
			this.disposeServices();
			this.disposeModules();

			this._view.removeFromParent( true );
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

		private function disposeServices():void
		{
			var length:int = this._services.length;

			for( var i:int = 0; i < length; i++ )
			{
				var service:IService = this._services[ i ];

				service.dispose();
				service = null;
			}

			this._services.length = 0;
			this._services = null;
		}

		private function disposeModules():void
		{
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