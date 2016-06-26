/**
 * Created by newkrok on 26/06/16.
 */
package net.fpp.common.starling.display
{
	import starling.display.DisplayObject;

	public class HUIBox extends UIBox
	{
		public static const VERTICAL_ALIGN_TOP:String = 'top';
		public static const VERTICAL_ALIGN_MIDDLE:String = 'middle';
		public static const VERTICAL_ALIGN_BOTTOM:String = 'bottom';

		private var _verticalAlign:String = VERTICAL_ALIGN_TOP;

		public function HUIBox()
		{
			this.orderType = UIBox.HORIZONTAL_ORDER;
		}

		public function get verticalAlign():String
		{
			return _verticalAlign;
		}

		public function set verticalAlign( value:String ):void
		{
			_verticalAlign = value;
		}

		override protected function orderByHorizontal():void
		{
			super.orderByHorizontal();
			
			this.setVerticalAlignTop();
			
			switch( this._verticalAlign )
			{
				case VERTICAL_ALIGN_MIDDLE:
					this.setVerticalAlignMiddle();
					break;

				case VERTICAL_ALIGN_BOTTOM:
					this.setVerticalAlignBottom();
					break;
			}
		}
		
		private function setVerticalAlignTop():void
		{
			for( var i:int = 0; i < this.numChildren; i++ )
			{
				var child:DisplayObject = this.getChildAt( i );
				child.y = 0;
			}
		}
		
		private function setVerticalAlignMiddle():void
		{
			for( var i:int = 0; i < this.numChildren; i++ )
			{
				var child:DisplayObject = this.getChildAt( i );
				child.y = this.height / 2 - child.height / 2;
			}
		}
		
		private function setVerticalAlignBottom():void
		{
			for( var i:int = 0; i < this.numChildren; i++ )
			{
				var child:DisplayObject = this.getChildAt( i );
				child.y = this.height - child.height;
			}
		}
	}
}