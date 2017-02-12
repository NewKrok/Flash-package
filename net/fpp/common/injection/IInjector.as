/**
 * Created by newkrok on 09/10/16.
 */
package net.fpp.common.injection
{
	public interface IInjector
	{
		function mapToValue( requestClass:Class, value:Object, requestId:String = '' ):void;

		function getValue( requestClass:Class, requestId:String = '' ):Object;

		function removeMapToValue( requestClass:Class, requestId:String = '' ):void;

		function removeMapFromValue( value:Object ):void;

		function mapToSingleton( requestClass:Class, classReference:Class, requestId:String = '' ):void;

		function getSingleton( requestClass:Class, requestId:String = '' ):Object;

		function removeMapToSingleton( requestClass:Class, requestId:String = '' ):void;

		function removeMapFromSingleton( value:Object ):void;

		function mapToClass( requestClass:Class, classReference:Class, requestId:String = '' ):void;

		function getClass( requestClass:Class, requestId:String = '' ):Class;

		function removeMapToClass( requestClass:Class, requestId:String = '' ):void;

		function inject( injectionContainer:Object ):void;

		function dispose():void;
	}
}