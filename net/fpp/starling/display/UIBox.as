package net.fpp.starling.display
{	
	import starling.display.Sprite;
	import starling.display.DisplayObject;
	
	public class UIBox extends Sprite
	{
		public static var HORIZONTAL_ORDER:String = 'UIBox.HORIZONTAL_ORDER';
		public static var VERTICAL_ORDER:String = 'UIBox.VERTICAL_ORDER';
		
		private var _orderType:String = UIBox.VERTICAL_ORDER;
		private var _gap:Number = 0;
		
		public function UIBox():void
		{
		}
		
		override public function addChild( child:DisplayObject ):DisplayObject
		{
			super.addChild( child );
			
			this.orderElements();
			
			return child;
		}
		
		public function set orderType( value:String ):void
		{
			this._orderType = value;
			
			this.orderElements();
		}
		
		public function get orderType():String
		{
			return this._orderType;
		}
		
		public function set gap( value:Number ):void
		{
			this._gap = value;
			
			this.orderElements();
		}
		
		public function get gap():Number
		{
			return this._gap;
		}
		
		private function orderElements():void
		{
			if( this._orderType == HORIZONTAL_ORDER )
			{
				this.orderByHorizontal();
			}
			else if( this._orderType == VERTICAL_ORDER )
			{
				this.orderByVertical();
			}
		}
		
		protected function orderByHorizontal():void
		{
			var nextChildPosition:Number = 0;
			
			for( var i:int = 0; i < this.numChildren; i++ )
			{
				var child:DisplayObject = this.getChildAt( i );
				
				child.x = nextChildPosition;
				
				nextChildPosition += child.width + gap;
			}
		}
		
		protected function orderByVertical():void
		{
			var nextChildPosition:Number = 0;
			
			for( var i:int = 0; i < this.numChildren; i++ )
			{
				var child:DisplayObject = this.getChildAt( i );
				
				child.y = nextChildPosition;
				
				nextChildPosition += child.height + gap;
			}
		}
	}
}