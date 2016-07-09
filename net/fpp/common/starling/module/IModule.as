﻿package net.fpp.common.starling.module
{
	import net.fpp.common.starling.events.IEventDispatcher;

	public interface IModule extends IEventDispatcher
	{
		function getView():AModuleView;

		function onRegistered():void;

		function dispose():void;
	}
}