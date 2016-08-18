/**
 * Created by newkrok on 18/08/16.
 */
package net.fpp.common.language
{
	import flash.utils.Dictionary;

	import net.fpp.common.language.constant.CLanguage;

	public class LanguageUtil
	{
		private var languageManifest:Dictionary = new Dictionary();

		private var _selectedLanguage:String = CLanguage.LANG_EN;

		public function setLanguageDataFromObjectVector( data:Vector.<Object> ):void
		{
			var length:int = data.length;

			for( var i:int = 0; i < length; i++ )
			{
				var languageEntry:LanguageEntry = new LanguageEntry();
				for( var key:String in data[ i ] )
				{
					if ( key != 'id' )
					{
						languageEntry[ key ] = data[ i ][ key ];
					}
				}

				this.languageManifest[ data[ i ].id ] = languageEntry;
			}
		}

		public function getLanguage( textId:String ):String
		{
			if( this.languageManifest.hasOwnProperty( textId ) )
			{
				var text:String = this.languageManifest[ textId ][ this._selectedLanguage ];

				if( text )
				{
					return text;
				}
			}

			return textId;

		}

		public function setSelectedLanguage( value:String ):void
		{
			this._selectedLanguage = value;
		}
	}
}