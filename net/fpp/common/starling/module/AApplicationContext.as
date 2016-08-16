/**
 * Created by newkrok on 24/04/16.
 */
package net.fpp.common.starling.module
{
	import org.swiftsuspenders.Injector;

	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;

	public class AApplicationContext extends Sprite implements IApplicationContext
	{
		public var injector:Injector = new Injector();

		private var _modules:Vector.<IModule> = new <IModule>[];

		private var _handlers:Vector.<IHandler> = new <IHandler>[];

		private var _updateCounter:int = 0;

		public function startUpdateHandling():void
		{
			this.addEventListener( EnterFrameEvent.ENTER_FRAME, this.onEnterFrameHandler );
		}

		public function stopUpdateHandling():void
		{
			this.removeEventListener( EnterFrameEvent.ENTER_FRAME, this.onEnterFrameHandler );
		}

		private function onEnterFrameHandler():void
		{
			this.updateModules();
			this.onUpdate();
		}

		private function updateModules():void
		{
			this._updateCounter++;

			var length:int = this._modules.length;

			for( var i:int = 0; i < length; i++ )
			{
				var module:IModule = this._modules[ i ];

				if( module is IUpdatableModule )
				{
					var updatableModule:IUpdatableModule = module as IUpdatableModule;

					if( this._updateCounter % updatableModule.getUpdateFrequency() == 0 )
					{
						updatableModule.onUpdate();
					}
				}
			}
		}

		protected function onUpdate():void
		{
		}

		public function createModule( moduleClass:Class, args:Array = null ):IModule
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

			return this.registerModule( module );
		}

		public function registerModule( module:IModule ):IModule
		{
			this._modules.push( module );

			this.injector.injectInto( module );

			module.onRegistered();

			return module;
		}

		public function unregisterModule( module:IModule ):void
		{
			var length:int = this._modules.length;

			for( var i:int = 0; i < length; i++ )
			{
				var bModule:IModule = this._modules[ i ];

				if( module == bModule )
				{
					this._modules.splice( i, 1 );

					return;
				}
			}
		}

		private function getModuleByClassType( classType:Class ):IModule
		{
			var length:int = this._modules.length;

			for( var i:int = 0; i < length; i++ )
			{
				var module:IModule = this._modules[ i ];

				if( module is classType )
				{
					return module;
				}
			}

			return null;
		}

		public function registerHandler( handler:IHandler ):void
		{
			this._handlers.push( handler );

			this.collectDependencies( handler );

			handler.onInited();
		}

		private function collectDependencies( handler:IHandler ):void
		{
			var dependencies:Vector.<Class> = handler.getDependencies();
			var length:int = dependencies.length;

			for( var i:int = 0; i < length; i++ )
			{
				var classType:Class = dependencies[ i ];

				try
				{
					handler[ this.getInjectionName( classType ) ] = this.getDependencyByClassType( classType );
				}
				catch( e:Error )
				{
					throw new Error( 'Automatic dependency injection error at ' + classType.toString() + ' as ' + this.getInjectionName( classType ) + ' to ' + handler + '. Maybe there is a misspelled variable name or is it a not public variable.' );
				}
			}
		}

		private function getInjectionName( classType:Class ):String
		{
			var classInString:String = classType.toString();
			classInString = classInString.replace( '[class I', '' );
			classInString = classInString.replace( ']', '' );
			classInString = classInString.charAt( 0 ).toLowerCase() + classInString.substr( 1 );

			return classInString;
		}

		private function getDependencyByClassType( classType:Class ):Object
		{
			if ( classType == IApplicationContext )
			{
				return this;
			}
			else
			{
				return this.getModuleByClassType( classType );
			}
		}

		override public function dispose():void
		{
			this.stopUpdateHandling();

			this.disposeHandlers();
			this.disposeModules();

			this.injector = null;
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
			var length:int = this._modules.length;

			for( var i:int = 0; i < length; i++ )
			{
				var module:IModule = this._modules[ i ];

				module.dispose();
				module = null;
			}

			this._modules.length = 0;
			this._modules = null;
		}
	}
}