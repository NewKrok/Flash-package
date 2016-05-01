/**
 * Created by newkrok on 24/04/16.
 */
package net.fpp.starling.module
{
	import org.swiftsuspenders.Injector;

	import starling.display.Sprite;

	public class AApplicationContext extends Sprite
	{
		public var injector:Injector = new Injector();

		private var _modules:Vector.<AModule> = new <AModule>[];

		public function createModule( moduleClass:Class ):AModule
		{
			var module:AModule = new moduleClass;

			this._modules.push( module );

			this.injector.injectInto( module );

			return module;
		}
	}
}