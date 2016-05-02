/**
 * Created by newkrok on 18/04/16.
 */
package net.fpp.common.starling.display
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;

	import net.fpp.common.geom.SimplePoint;

	import net.fpp.common.starling.constant.CAspectRatio;

	import starling.core.Starling;
	import starling.events.Event;

	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;

	public class AStarlingMain extends Sprite
	{
		protected var _starlingObject:*;
		protected var _mainClass:Class;

		protected var _stageSize:SimplePoint;

		protected var _isIOS:Boolean;

		protected var _aspectRatio:String = CAspectRatio.LANDSCAPE;

		public function AStarlingMain()
		{
			this.addEventListener( flash.events.Event.ADDED_TO_STAGE, this.onAddedToStageHandler );
		}

		private function onAddedToStageHandler( e:flash.events.Event ):void
		{
			this._isIOS = Capabilities.manufacturer.indexOf( "iOS" ) != -1;

			this.setStage();

			this.onInit();
		}

		private function setStage():void
		{
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP;

			this._stageSize = new SimplePoint();

			if ( this._aspectRatio == CAspectRatio.LANDSCAPE )
			{
				this._stageSize.x = this._isIOS ? ( ( stage.fullScreenWidth / stage.fullScreenHeight != 480 / 320 ) ? 568 : 480 ) : ( ( stage.stageWidth / stage.stageHeight != 480 / 320 ) ? 568 : 480 );
				this._stageSize.y = 320;
			}
		}

		protected function createStarling( mainClass:Class ):void
		{
			this._mainClass = mainClass;

			this.initStarling( this.calculateViewPort() );
		}

		private function calculateViewPort():Rectangle
		{
			if( this._isIOS )
			{
				if( this._aspectRatio == CAspectRatio.LANDSCAPE )
				{
					return this.getIOSLandscapeViewPort();
				}
			}
			else
			{
				if( this._aspectRatio == CAspectRatio.LANDSCAPE )
				{
					return this.getPCLandscapeViewPort();
				}
			}

			return new Rectangle();
		}

		private function getIOSLandscapeViewPort():Rectangle
		{
			var viewPort:Rectangle = new Rectangle();

			viewPort = RectangleUtil.fit(
					new Rectangle( 0, 0, this._stageSize.x, this._stageSize.y ),
					new Rectangle( 0, 0, this.stage.fullScreenWidth, this.stage.fullScreenHeight ),
					ScaleMode.SHOW_ALL, true
			);

			return viewPort;
		}

		private function getPCLandscapeViewPort():Rectangle
		{
			var viewPort:Rectangle = new Rectangle();

			viewPort = RectangleUtil.fit(
					new Rectangle( 0, 0, this._stageSize.x, this._stageSize.y ),
					new Rectangle( 0, 0, this.stage.stageWidth, this.stage.stageHeight ),
					ScaleMode.SHOW_ALL, true
			);

			return viewPort;
		}

		private function initStarling( viewPort:Rectangle ):void
		{
			this._starlingObject = new Starling( this._mainClass, stage, viewPort );
			this._starlingObject.stage.stageWidth = this._stageSize.x;
			this._starlingObject.stage.stageHeight = this._stageSize.y;

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