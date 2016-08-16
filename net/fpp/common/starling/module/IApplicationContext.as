/**
 * Created by newkrok on 16/08/16.
 */
package net.fpp.common.starling.module
{
	public interface IApplicationContext
	{
		function startUpdateHandling():void;

		function stopUpdateHandling():void;

		function createModule( moduleClass:Class, args:Array = null ):IModule;

		function registerModule( module:IModule ):IModule;

		function unregisterModule( module:IModule ):void;

		function registerHandler( handler:IHandler ):void;

		function dispose():void;
	}
}