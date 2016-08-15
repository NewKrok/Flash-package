/**
 * Created by newkrok on 15/08/16.
 */
package net.fpp.common.starling.module
{
	public interface IHandler
	{
		function getDependencies():Vector.<Class>

		function onInited():void;

		function dispose():void;
	}
}