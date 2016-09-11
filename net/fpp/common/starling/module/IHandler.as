/**
 * Created by newkrok on 15/08/16.
 */
package net.fpp.common.starling.module
{
	public interface IHandler extends IInjectionContainer
	{
		function onInited():void;

		function dispose():void;
	}
}