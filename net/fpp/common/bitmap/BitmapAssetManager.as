/**
 * Created by newkrok on 22/02/16.
 */
package net.fpp.common.bitmap
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

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

				this.addBitmapData( key, bitmapData );
			}
		}

		public function loadFromStarlingAtlas( atlasImageBitmap:Class, atlasStarlingDescription:Class ):void
		{
			var defaultBitmapData:BitmapData = ( new atlasImageBitmap as Bitmap ).bitmapData;

			var descriptionXML:XMLList = new XMLList( new atlasStarlingDescription() )
			var description:Object = this.convertStarlingDescriptionXMLToObject( descriptionXML );

			this.createAssets( defaultBitmapData, description );

			defaultBitmapData.dispose();
			defaultBitmapData = null;
		}

		private function convertStarlingDescriptionXMLToObject( sourceXML:XMLList ):Object
		{
			var result:Object = {};
			result.frames = [];

			for( var i:int = 0; i < sourceXML.SubTexture.length(); i++ )
			{
				var assetObject:Object = {};

				assetObject.spriteSourceSize = {};
				assetObject.spriteSourceSize.w = sourceXML.SubTexture[ i ].@width;
				assetObject.spriteSourceSize.h = sourceXML.SubTexture[ i ].@height;

				assetObject.frame = {};
				assetObject.frame.x = sourceXML.SubTexture[ i ].@x;
				assetObject.frame.y = sourceXML.SubTexture[ i ].@y;
				assetObject.frame.w = sourceXML.SubTexture[ i ].@width;
				assetObject.frame.h = sourceXML.SubTexture[ i ].@height;

				result.frames[ sourceXML.SubTexture[ i ].@name ] = assetObject;
			}

			return result;
		}

		public function addBitmap( id:String, bitmap:Bitmap ):void
		{
			this.addBitmapData( id, bitmap.bitmapData );
		}

		public function addBitmapData( id:String, bitmapData:BitmapData ):void
		{
			var assetVO:BitmapAssetVO = new BitmapAssetVO();
			assetVO.key = id;
			assetVO.bitmapData = bitmapData;

			this._assets.push( assetVO );
		}

		public function getBitmapData( key:String ):BitmapData
		{
			var length:int = this._assets.length;
			const movieClipNameFix:String = '0000';

			for( var i:int = 0; i < length; i++ )
			{
				var assetKey:String = this._assets[ i ].key;

				if( assetKey.substr( assetKey.length - movieClipNameFix.length ) == movieClipNameFix )
				{
					assetKey = assetKey.substr( 0, assetKey.length - movieClipNameFix.length )
				}

				if( assetKey == key )
				{
					if( this._scaleFactor == 1 )
					{
						return this._assets[ i ].bitmapData.clone();
					}
					else
					{
						var scaledBitmapData:BitmapData = new BitmapData( this._assets[ i ].bitmapData.width / this._scaleFactor, this._assets[ i ].bitmapData.height / this._scaleFactor, true, 0x60 );

						var transformMatrix:Matrix = new Matrix;
						transformMatrix.scale( 1 / this._scaleFactor, 1 / this._scaleFactor );

						scaledBitmapData.draw( this._assets[ i ].bitmapData, transformMatrix );

						return scaledBitmapData;
					}
				}
			}

			throw new Error( 'Unregistered key: ' + key );

			return null;
		}

		public function getBitmap( key:String, smoothing:Boolean = true ):Bitmap
		{
			try
			{
				return new Bitmap( this.getBitmapData( key ), 'auto', smoothing );
			}
			catch( e:Error )
			{
				throw new Error( 'Unregistered key: ' + key );
			}

			return null;
		}

		public function disposeLoadedAssets():void
		{
			var length:int = this._assets.length;

			for( var i:int = 0; i < length; i++ )
			{
				this._assets[ i ].bitmapData.dispose();
				this._assets[ i ].bitmapData = null;
				this._assets[ i ] = null;
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