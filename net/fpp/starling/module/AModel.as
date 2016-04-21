package net.fpp.starling.module
{
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	import starling.events.EventDispatcher;
	
	public class AModel extends EventDispatcher
	{
		private var _services:Dictionary = new Dictionary();

		public function registerService( service:AService ):void
		{
			this._services[Class( getDefinitionByName( getQualifiedClassName( service ) ) )] = service;
		}

		public function getService( className:Class ):AService
		{
			return this._services[className] as AService;
		}
	}
}