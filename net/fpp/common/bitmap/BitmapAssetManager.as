/**
 * Created by newkrok on 22/02/16.
 */
package net.fpp.common.bitmap
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Matrix;

	public class BitmapAssetManager
	{
		private var _scaleFactor:Number;
		
		private var _assets:Vector.<BitmapAssetVO> = new Vector.<BitmapAssetVO>;
		
		public function BitmapAssetManager( scaleFactor:Number = 1 ):void
		{
			this._scaleFactor = scaleFactor;
		}
		
		public function loadFromJSONAtlas( atlasImageBitmap:Class, atlasJSONDescription:Class ):void
		{
			var defaultBitmapData:BitmapData = ( new atlasImageBitmap as Bitmap ).bitmapData;

			var jsonData:String = new String( new atlasJSONDescription() );
			var description:Object = JSON.parse( jsonData );
			
			this.createAssets( defaultBitmapData, description );
			
			defaultBitmapData.dispose();
			defaultBitmapData = null;
		}
		
		private function createAssets( defaultBitmapData:BitmapData, description:Object ):void
		{
			for( var key:String in description.frames )
			{
				var assetVO:BitmapAssetVO = new BitmapAssetVO();
				assetVO.key = key;
				
				var bitmapData:BitmapData = new BitmapData(
						description.frames[ key ].spriteSourceSize.w,
						description.frames[ key ].spriteSourceSize.h
				);

				bitmapData.copyPixels(
						defaultBitmapData,
						new Rectangle(
								description.frames[ key ].frame.x,
								description.frames[ key ].frame.y,
								description.frames[ key ].frame.w,
								description.frames[ key ].frame.h
						),
						new Point()
				);

				assetVO.bitmapData = bitmapData;

				this._assets.push( assetVO );
			}
		}

		public function getBitmapData( key:String ):BitmapData
		{
			var length:int = this._assets.length;

			for ( var i:int = 0; i < length; i++ )
			{
				if ( this._assets[i].key == key )
				{
					if ( this._scaleFactor == 1 )
					{
						return this._assets[i].bitmapData.clone();
					}
					else
					{
						var scaledBitmapData:BitmapData = new BitmapData( this._assets[i].bitmapData.width / this._scaleFactor, this._assets[i].bitmapData.height / this._scaleFactor, true, 0x60 );
						
						var	transformMatrix:Matrix = new Matrix;
						transformMatrix.scale( 1 / this._scaleFactor, 1 / this._scaleFactor );
						
						scaledBitmapData.draw( this._assets[i].bitmapData, transformMatrix );
						
						return scaledBitmapData;
					}
				}
			}

			throw new Error( 'Unregistered key: ' + key );
			
			return null;
		}
		
		public function getBitmap( key:String ):Bitmap
		{
			try{
				return new Bitmap( this.getBitmapData( key ) );
			}
			catch ( e:Error )
			{
				throw new Error( 'Unregistered key: ' + key );
			}
			
			return null;
		}
		
		public function disposeLoadedAssets():void
		{
			var length:int = this._assets.length;

			for ( var i:int = 0; i < length; i++ )
			{
				this._assets[i].bitmapData.dispose();
				this._assets[i].bitmapData = null;
				this._assets[i] = null;
			}
			
			this._assets.length = 0;
		}
		
		public function dispose():void
		{
			this.disposeLoadedAssets();
			
			this._assets = null;
		}
	}
}