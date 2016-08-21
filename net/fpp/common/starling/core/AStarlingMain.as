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
		protected var _isIPad:Boolean;

		protected var _aspectRatio:String = CAspectRatio.LANDSCAPE;

		public function AStarlingMain()
		{
			this.addEventListener( flash.events.Event.ADDED_TO_STAGE, this.onAddedToStageHandler );
		}

		private function onAddedToStageHandler( e:flash.events.Event ):void
		{
			this.stage.addEventListener( flash.events.Event.RESIZE, this.onResize );
			
			this._isIOS = SystemUtil.platform == "IOS";

			this.setStage();

			this.onInit();
		}
		
		private function onResize( e:flash.events.Event ):void
		{
			if ( this._starlingObject )
			{
				this._starlingObject.viewPort = this.calculateViewPort();
			}
		}

		private function setStage():void
		{
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP;
		}

		protected function createStarling( mainClass:Class ):void
		{
			this._mainClass = mainClass;

			this.initStarling( this.calculateViewPort() );
		}
		
		private function calculateViewPort():Rectangle
		{
			this.calculateBaseStageSize();
			
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
		
		private function calculateBaseStageSize():void
		{
			if ( CAspectRatio.LANDSCAPE )
			{
				this._isIPad = ( this.stage.fullScreenHeight == 768 || this.stage.fullScreenHeight == 1536 ) ? true : false;
				
				if ( this._isIPad )
				{
					this.StageWidth = 1024 / 2;
					this.StageHeight = 768 / 2;	
				}
				else
				{
					if ( this._isIOS )
					{
						this.StageWidth = this.stage.fullScreenWidth / this.stage.fullScreenHeight != 480 / 320 ? 568 : 480;
					}
					else
					{
						this.StageWidth = this.stage.stageWidth / this.stage.stageHeight != 480 / 320 ? 568 : 480
					}
					this.StageHeight = 320;
				}
			}
			else
			{
				this._isIPad = ( this.stage.fullScreenWidth == 768 || this.stage.fullScreenWidth == 1536 ) ? true : false;
				
				if ( this._isIPad )
				{
					this.StageWidth = 768 / 2;
					this.StageHeight = 1024 / 2;	
				}
				else
				{
					if ( this._isIOS )
					{
						this.StageHeight = this.stage.fullScreenHeight / this.stage.fullScreenWidth != 480 / 320 ? 568 : 480;
					}
					else
					{
						this.StageHeight = this.stage.stageHeight / this.stage.stageWidth != 480 / 320 ? 568 : 480
					}
					this.StageWidth = 320;
				}
			}
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
            var screenSize:Rectangle = new Rectangle( 0, 0, this.stage.stageWidth, this.stage.stageHeight );

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