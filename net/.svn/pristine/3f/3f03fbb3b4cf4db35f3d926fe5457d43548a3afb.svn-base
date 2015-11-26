package net.fpp.static
{
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import net.fpp.services.ad.IFPPAdService;
	
	public class Navigate
	{
		
		private static const URL_HOME:String = 'http://flashplusplus.net/';
		
		private static var _fppAdService:IFPPAdService;
		
		// Note: If you use fppadservice the navigate system use that, because the ad service can decorate home URL with Google Analytics campaign params.
		public static function setFPPAdService( $value:IFPPAdService ):void
		{
			_fppAdService = $value;
		}
		
		// Note: This function can use the FPP Ad Service. It needed, because that service can decorate the URL with Google Analytics campaign params.
		// If the ad service doesn't initalized, the navigator use the default home URL.
		public static function toHome( ):void
		{
			if ( _fppAdService )
			{
				_fppAdService.goToHome( );
			}
			else
			{
				navigateToURL( new URLRequest ( URL_HOME ) );
			}
		}
		
	}
	
}