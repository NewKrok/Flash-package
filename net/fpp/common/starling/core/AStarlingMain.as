/**
 * Created by newkrok on 18/04/16.
 */
package net.fpp.common.starling.core
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;

	import net.fpp.common.starling.constant.CAspectRatio;

	import starling.core.Starling;
	import starling.events.Event;

	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	import starling.utils.SystemUtil;

	public class AStarlingMain extends Sprite
	{
		private var StageWidth:int;
        private var StageHeight:int;

		protected var _starlingObject:*;
		protected var _mainClass:Class;

		protected var _isIOS:Boolean;

		protected var _aspectRatio:String = CAspectRatio.LANDSCAPE;

		public function AStarlingMain()
		{
			this.addEventListener( flash.events.Event.ADDED_TO_STAGE, this.onAddedToStageHandler );
		}

		private function onAddedToStageHandler( e:flash.events.Event ):void
		{
			this._isIOS = SystemUtil.platform == "IOS";

			this.setStage();

			this.onInit();
		}

		private function setStage():void
		{
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP;
		}

		protected function createStarling( mainClass:Class ):void
		{
			this._mainClass = mainClass;

			this.StageWidth = this._aspectRatio == CAspectRatio.LANDSCAPE ? 480 : 320;
			this.StageHeight = this._aspectRatio == CAspectRatio.LANDSCAPE ? 320 : 480;

			this.initStarling( this.calculateViewPort() );
		}

		private function calculateViewPort():Rectangle
		{
			if( this._isIOS )
			{
				return this.getMobileViewPort();
			}
			else
			{
				return this.getPCViewPort();
			}

			return new Rectangle();
		}

		private function getMobileViewPort():Rectangle
		{
			var stageSize:Rectangle = new Rectangle( 0, 0, StageWidth, StageHeight );
            var screenSize:Rectangle = new Rectangle( 0, 0, this.stage.fullScreenWidth, this.stage.fullScreenHeight );

			return RectangleUtil.fit( stageSize, screenSize, ScaleMode.SHOW_ALL, this._isIOS );
		}

		private function getPCViewPort():Rectangle
		{
			var stageSize:Rectangle = new Rectangle( 0, 0, StageWidth, StageHeight );
            var screenSize:Rectangle = new Rectangle( 0, 0, this.stage.stageWidth, this.stage.stageWidth );

			return RectangleUtil.fit( stageSize, screenSize, ScaleMode.SHOW_ALL, this._isIOS );
		}

		private function initStarling( viewPort:Rectangle ):void
		{
			this._starlingObject = new Starling( this._mainClass, stage, viewPort );
			this._starlingObject.stage.stageWidth = StageWidth;
			this._starlingObject.stage.stageHeight = StageHeight;

			this._starlingObject.addEventListener( starling.events.Event.ROOT_CREATED, this.starlingRootCreated );
		}

		private function starlingRootCreated( e:starling.events.Event ):void
		{
			var mainClass:* = this._starlingObject.root;
			mainClass.start();

			this._starlingObject.start();
		}

		protected function onInit():void
		{
		}
	}
}