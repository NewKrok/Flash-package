/**
 * Created by newkrok on 22/02/16.
 */
package net.fpp.asset.bitmap
{
	import net.fpp.asset.bitmap.BitmapAssetManager;
	
	public class StaticBitmapAssetManager
	{
		private static var _scaleFactor:Number;
		
		private static var _assetManager:BitmapAssetManager;
		
		public function StaticBitmapAssetManager( )
		{
			throw new Error( 'This is a Singleton class!' );
		}
		
		public static function get instance( ):BitmapAssetManager
		{
			if ( isNaN( _scaleFactor ) )
			{
				throw new Error( 'Missing scale factor setting.' );
			}
			
			if ( !_assetManager )
			{
				_assetManager = new BitmapAssetManager( _scaleFactor );
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