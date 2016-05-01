/**
 * Created by newkrok on 21/04/16.
 */
package net.fpp.util.jsonbitmapatlas
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import net.fpp.util.jsonbitmapatlas.vo.BitmapDataVO;

	public class JSONBitmapAtlas
	{
		public function getBitmapDataVOs( bitmap:Bitmap, atlasDescription:String ):Vector.<BitmapDataVO>
		{
			var terrainTextureList:Vector.<BitmapDataVO> = new Vector.<BitmapDataVO>;

			var defaultBitmapData:BitmapData = bitmap.bitmapData.clone();
			var description:Object = JSON.parse( atlasDescription );

			for( var key:String in description.frames )
			{
				var terrainTextureVO:BitmapDataVO = new BitmapDataVO();
				terrainTextureVO.id = key;

				var bitmapData:BitmapData = new BitmapData(
						description.frames[ key ].spriteSourceSize.w,
						description.frames[ key ].spriteSourceSize.h
				);

				var textureRectangleData:Object = description.frames[ key ].frame as Object;

				bitmapData.copyPixels(
						defaultBitmapData,
						new Rectangle(
								textureRectangleData.x,
								textureRectangleData.y,
								textureRectangleData.w,
								textureRectangleData.h
						),
						new Point()
				);

				terrainTextureVO.bitmapData = bitmapData;

				terrainTextureList.push( terrainTextureVO );
			}

			defaultBitmapData.dispose();
			defaultBitmapData = null;

			return terrainTextureList;
		}
	}
}