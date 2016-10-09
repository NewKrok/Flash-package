/**
 * Created by newkrok on 16/08/16.
 */
package net.fpp.common.starling.module
{
	public interface IApplicationContext
	{
		function get passedTime():Number;

		function get now():Number;

		function startUpdateHandling():void;

		function stopUpdateHandling():void;

		function createModule( id:String, moduleClass:Class, moduleInterface:Class, args:Array = null ):IModule

		function registerModule( id:String, module:IModule, moduleInterface:Class ):IModule;

		function unregisterModule( module:IModule ):void;

		function registerHandler( handler:IHandler ):void;

		function dispose():void;
	}
}