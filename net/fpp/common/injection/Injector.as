/**
 * Created by newkrok on 09/10/16.
 */
package net.fpp.common.injection
{
	import avmplus.getQualifiedClassName;

	import flash.utils.Dictionary;
	import flash.utils.describeType;

	public class Injector implements IInjector
	{
		private var _mapToValueRules:Dictionary = new Dictionary();
		private var _mapToSingletonRules:Dictionary = new Dictionary();
		private var _mapToClassRules:Dictionary = new Dictionary();

		public function mapToValue( requestClass:Class, value:Object, requestId:String = '' ):void
		{
			var ruleName:String = getQualifiedClassName( requestClass ) + '#' + requestId;

			this._mapToValueRules[ ruleName ] = value;
		}

		public function removeMapToValue( requestClass:Class, requestId:String = '' ):void
		{
			var ruleName:String = getQualifiedClassName( requestClass ) + '#' + requestId;

			this._mapToValueRules[ ruleName ] = null;
			delete this._mapToValueRules[ ruleName ];
		}

		public function removeMapFromValue( value:Object ):void
		{
			for( var key:String in this._mapToValueRules )
			{
				if( this._mapToValueRules[ key ] == value )
				{
					this._mapToValueRules[ key ] = null;
					delete this._mapToValueRules[ key ];
				}
			}
		}

		public function mapToSingleton( requestClass:Class, classReference:Class, requestId:String = '' ):void
		{
			var ruleName:String = getQualifiedClassName( requestClass ) + '#' + requestId;

			this._mapToSingletonRules[ ruleName ] = new classReference();
		}

		public function removeMapToSingleton( requestClass:Class, requestId:String = '' ):void
		{
			var ruleName:String = getQualifiedClassName( requestClass ) + '#' + requestId;

			this._mapToSingletonRules[ ruleName ] = null;
			delete this._mapToSingletonRules[ ruleName ];
		}

		public function removeMapFromSingleton( value:Object ):void
		{
			for( var key:String in this._mapToSingletonRules )
			{
				if( this._mapToSingletonRules[ key ] == value )
				{
					this._mapToSingletonRules[ key ] = null;
					delete this._mapToSingletonRules[ key ];
				}
			}
		}

		public function mapToClass( requestClass:Class, classReference:Class, requestId:String = '' ):void
		{
			var ruleName:String = getQualifiedClassName( requestClass ) + '#' + requestId;

			this._mapToClassRules[ ruleName ] = classReference;
		}

		public function removeMapToClass( requestClass:Class, requestId:String = '' ):void
		{
			var ruleName:String = getQualifiedClassName( requestClass ) + '#' + requestId;

			this._mapToClassRules[ ruleName ] = null;
			delete this._mapToClassRules[ ruleName ];
		}

		public function inject( injectionContainer:Object ):void
		{
			var classVariables:XMLList = describeType( injectionContainer ).child( 'variable' );

			var length:int = classVariables.length();

			for( var i:int = 0; i < length; i++ )
			{
				var variableInfo:XML = classVariables[ i ];
				var metadata:XMLList = variableInfo.child( 'metadata' );

				if( metadata.@name.toString().indexOf( 'Inject' ) > -1 )
				{
					var injectionVariableName:String = variableInfo.@name;
					var injectionClassType:String = variableInfo.@type;
					var injectionId:String = '';

					for each( var metaChild:XML in metadata )
					{
						if( metaChild.@name == 'Inject' && metaChild.child( 'arg' ).@key == 'id' )
						{
							injectionId = metaChild.child( 'arg' ).@value;
							break;
						}
					}

					injectionContainer[ injectionVariableName ] = this.getDependency( injectionClassType, injectionId );
				}
			}
		}

		private function getDependency( injectionClassType:String, requestId:String = '' ):Object
		{
			var mapToValueRule:Object = this._mapToValueRules[ injectionClassType + '#' + requestId ];
			if( mapToValueRule )
			{
				return mapToValueRule;
			}

			var mapToSingletonRule:Object = this._mapToSingletonRules[ injectionClassType + '#' + requestId ];
			if( mapToSingletonRule )
			{
				return mapToSingletonRule;
			}

			var mapToClassRule:Class = this._mapToClassRules[ injectionClassType + '#' + requestId ];
			if( mapToClassRule )
			{
				return new mapToClassRule();
			}

			return null;
		}

		private function disposeMapToValueRules():void
		{
			for( var key:String in this._mapToValueRules )
			{
				this._mapToValueRules[ key ] = null;
				delete this._mapToValueRules[ key ];
			}
		}

		private function disposeMapToSingletonRules():void
		{
			for( var key:String in this._mapToSingletonRules )
			{
				this._mapToSingletonRules[ key ] = null;
				delete this._mapToSingletonRules[ key ];
			}
		}

		private function disposeMapToClassRules():void
		{
			for( var key:String in this._mapToClassRules )
			{
				this._mapToClassRules[ key ] = null;
				delete this._mapToClassRules[ key ];
			}
		}

		public function dispose():void
		{
			this.disposeMapToValueRules();
			this.disposeMapToSingletonRules();
			this.disposeMapToClassRules();
		}
	}
}