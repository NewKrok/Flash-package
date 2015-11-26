/**
 * Created by newkrok on 08/11/15.
 */
package net.fpp.starling.log
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;

	import net.fpp.starling.log.events.LogViewEvent;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class LogView extends Sprite
	{
		private var _background:Image;
		private var _contentText:TextField;

		private var _isInited:Boolean;

		public function LogView()
		{
			this.addEventListener( Event.ADDED_TO_STAGE, this.onInit );
		}

		private function onInit():void
		{
			this.buildView();
			this.hide();

			this._isInited = true;
			this.dispatchEvent( new LogViewEvent( LogViewEvent.INITED ) );

			this.removeEventListener( Event.ADDED_TO_STAGE, this.onInit );

			this.addEventListener( TouchEvent.TOUCH, this.onTouch );
		}

		private function buildView():void
		{
			this._background = Image.fromBitmap( new Bitmap( new BitmapData( this.stage.stageWidth * 2, this.stage.stageHeight * 2, false, 0 ) ), false, 2 );
			this.addChild( this._background );
			this._background.alpha = .7;

			this._contentText = new TextField( this.stage.stageWidth - 10, this.stage.stageHeight - 10, '' );
			this.addChild( this._contentText );
			this._contentText.x = this.stage.stageWidth / 2 - _contentText.width / 2;
			this._contentText.y = this.stage.stageHeight / 2 - _contentText.height / 2;
			this._contentText.vAlign = VAlign.TOP;
			this._contentText.hAlign = HAlign.LEFT;
			this._contentText.color = 0xFFFFFF;
			this._contentText.fontSize = 10;
		}

		public function add( ...args:Array ):void
		{
			var entry:String = '';
			var length:int = args.length;

			for ( var i:int = 0; i < length; i++ )
			{
				entry += args[i] + ' ';
			}

			this._contentText.text = entry + '\n' + this._contentText.text;
		}

		private function onTouch( e:TouchEvent ):void
		{
			if ( e.getTouch( this ).phase == TouchPhase.BEGAN )
			{
				this.hide();
			}
		}

		public function show():void
		{
			if ( this.parent.getChildIndex( this ) != this.parent.numChildren )
			{
				this.parent.addChild( this );
			}

			this.visible = true;
		}

		public function hide():void
		{
			this.visible = false;
		}

		public function get isInited():Boolean
		{
			return this._isInited;
		}
	}
}