/**
 * Created by newkrok on 24/04/16.
 */
package net.fpp.common.starling.module
{
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;

	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;

	public class AApplicationContext extends Sprite implements IApplicationContext
	{
		private var _modules:Vector.<IModule> = new <IModule>[];
		private var _updatableModules:Vector.<IUpdatableModule> = new <IUpdatableModule>[];

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

			var length:int = this._updatableModules.length;

			for( var i:int = 0; i < length; i++ )
			{
				var updatableModule:IUpdatableModule = this._updatableModules[ i ];

				if( this._updateCounter % updatableModule.getUpdateFrequency() == 0 )
				{
					updatableModule.onUpdate();
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

			if( module is IUpdatableModule )
			{
				this._updatableModules.push( module as IUpdatableModule );
			}

			this.collectDependencies( module );

			module.onInited();

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

					break;
				}
			}

			if( module is IUpdatableModule )
			{
				length = this._updatableModules.length;

				for( i = 0; i < length; i++ )
				{
					bModule = this._updatableModules[ i ];

					if( module == bModule )
					{
						this._updatableModules.splice( i, 1 );

						break;
					}
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

		private function collectDependencies( injectionContainer:IInjectionContainer ):void
		{
			var dependencies:Vector.<Class> = injectionContainer.getDependencies();
			var length:int = dependencies ? dependencies.length : 0;

			if ( length > 0 )
			{
				var classVariables:XMLList = describeType( injectionContainer ).child( 'variable' );

				for( var i:int = 0; i < length; i++ )
				{
					var classType:Class = dependencies[ i ];
					var injectionName:String = this.getInjectionName( classVariables, classType );
					var dependency:Object = this.getDependencyByClassType( classType );

					try
					{
						if( dependency )
						{
							injectionContainer[ injectionName ] = dependency;
						}
						else
						{
							throw new Error( 'The class ' + getQualifiedClassName( classType ) + ' is missing.' );
						}
					}
					catch( e:Error )
					{
						throw new Error( 'Automatic dependency injection error at ' + getQualifiedClassName( classType ) + ' as ' + injectionName + ' to ' + injectionContainer + '.' );
					}
				}
			}
		}

		private function getInjectionName( classVariables:XMLList, classType:Class ):String
		{
			var length:int = classVariables.length();

			for( var i:int = 0; i < length; i++ )
			{
				if ( classVariables[i].@type == getQualifiedClassName( classType ) )
				{
					return classVariables[i].@name;
				}
			}

			return '';
		}

		private function getDependencyByClassType( classType:Class ):Object
		{
			if( classType == IApplicationContext )
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

			this._updatableModules.length = 0;
			this._updatableModules = null;
		}
	}
}