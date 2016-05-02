package net.fpp.common.starling
{
	
	import flash.system.Capabilities;
	
	import starling.utils.AssetManager;
	
	public class StaticAssetManager
	{
		
		private static var _scaleFactor:Number;
		
		private static var _assetManager:AssetManager;
		
		public function StaticAssetManager( )
		{
			throw new Error( 'This is a Singleton class!' );
		}
		
		public static function get instance( ):AssetManager
		{
			if ( isNaN( _scaleFactor ) )
			{
				throw new Error( 'Missing scale factor setting.' );
			}
			
			if ( !_assetManager )
			{
				_assetManager = new AssetManager( _scaleFactor );
				_assetManager.verbose = Capabilities.isDebugger;
			}
			
			return _assetManager;
		}
		
		public static function set scaleFactor( value:Number ):void
		{
			if ( isNaN( _scaleFactor ) )
			{
				_scaleFactor = value;
			}
			else
			{
				throw new Error( 'The scale factor already set up.' );
			}
		}
		
	}
	
}