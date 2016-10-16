/**
 * Created by newkrok on 16/08/16.
 */
package net.fpp.common.starling.module
{
	public interface IApplicationContext
	{
		function get now():Number;

		function startUpdateHandling():void;

		function stopUpdateHandling():void;

		function createModule( id:String, moduleClass:Class, moduleInterface:Class, args:Array = null ):IModule

		function registerModule( id:String, module:IModule, moduleInterface:Class ):IModule;

		function unregisterModule( module:IModule ):void;

		function disposeModuleByClass( moduleClass:Class ):void;

		function createHandler( handlerClass:Class, args:Array = null ):IHandler;

		function registerHandler( handler:IHandler ):IHandler;

		function unregisterHandler( handler:IHandler ):void;

		function disposeHandlerByClass( handlerClass:Class ):void;

		function createService( id:String, serviceClass:Class, serviceInterface:Class, args:Array = null ):IService

		function registerService( id:String, service:IService, serviceInterface:Class ):IService

		function unregisterService( service:IService ):void;

		function disposeServiceByClass( serviceClass:Class ):void;

		function dispose():void;
	}
}