﻿/**
 * Created by newkrok on 24/04/16.
 */
package net.fpp.common.starling.module
{
	import org.swiftsuspenders.Injector;

	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;

	public class AApplicationContext extends Sprite
	{
		public var injector:Injector = new Injector();

		private var _modules:Vector.<AModule> = new <AModule>[];

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
			var length:int = this._modules.length;

			for( var i:int = 0; i < length; i++ )
			{
				var module:AModule = this._modules[ i ];

				if( module is IUpdatableModule )
				{
					( module as IUpdatableModule ).update();
				}
			}
		}

		protected function onUpdate():void
		{
		}

		public function createModule( moduleClass:Class ):AModule
		{
			var module:AModule = new moduleClass;

			this._modules.push( module );

			this.injector.injectInto( module );

			return module;
		}

		override public function dispose():void
		{
			this.stopUpdateHandling();

			var length:int = this._modules.length;

			for( var i:int = 0; i < length; i++ )
			{
				var module:AModule = this._modules[ i ];

				module.dispose();

				module = null;
			}

			this._modules.length = 0;
			this._modules = null;

			this.injector = null;
		}
	}
}