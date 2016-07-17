package net.fpp.common.starling.module
{
	public interface IUpdatableModule extends IModule
	{
		function onUpdate():void;
		function getUpdateFrequency():int;
	}
}