/**
 * Created by newkrok on 26/06/16.
 */
package net.fpp.common.starling.display
{
	import starling.display.DisplayObject;

	public class VUIBox extends UIBox
	{
		public static const HORIZONTAL_ALIGN_LEFT:String = 'left';
		public static const HORIZONTAL_ALIGN_CENTER:String = 'center';
		public static const HORIZONTAL_ALIGN_RIGHT:String = 'right';

		private var _horizontalAlign:String = HORIZONTAL_ALIGN_LEFT;

		public function VUIBox()
		{
			this.orderType = UIBox.VERTICAL_ORDER;
		}

		public function get horizontalAlign():String
		{
			return _horizontalAlign;
		}

		public function set horizontalAlign( value:String ):void
		{
			_horizontalAlign = value;
		}

		override protected function orderByVertical():void
		{
			super.orderByVertical();
			
			this.setHorizontalAlignLeft();
			
			switch( this._horizontalAlign )
			{
				case HORIZONTAL_ALIGN_CENTER:
					this.setHorizontalAlignCenter();
					break;

				case HORIZONTAL_ALIGN_RIGHT:
					this.setHorizontalAlignRight();
					break;
			}
		}
			
		private function setHorizontalAlignLeft():void
		{
			for( var i:int = 0; i < this.numChildren; i++ )
			{
				var child:DisplayObject = this.getChildAt( i );
				child.x = 0;
			}
		}
		
		private function setHorizontalAlignCenter():void
		{
			for( var i:int = 0; i < this.numChildren; i++ )
			{
				var child:DisplayObject = this.getChildAt( i );
				child.x = this.width / 2 - child.width / 2;
			}
		}
		
		private function setHorizontalAlignRight():void
		{
			for( var i:int = 0; i < this.numChildren; i++ )
			{
				var child:DisplayObject = this.getChildAt( i );
				child.x = this.width - child.width;
			}
		}
	}
}