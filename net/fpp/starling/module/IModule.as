package net.fpp.starling.module
{
	public interface IModule
	{
		function getView():AModuleView;
		
		function dispose():void;
	}
}