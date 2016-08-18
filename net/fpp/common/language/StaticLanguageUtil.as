/**
 * Created by newkrok on 18/08/16.
 */
package net.fpp.common.language
{
	public class StaticLanguageUtil
	{
		private static var _languageUtil:LanguageUtil;

		public function StaticLanguageUtil()
		{
			throw new Error( 'This is a Singleton class!' );
		}

		public static function get instance():LanguageUtil
		{
			if( !_languageUtil )
			{
				_languageUtil = new LanguageUtil();
			}

			return _languageUtil;
		}
	}
}