package net.fpp.common.display
{	
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import net.fpp.common.geom.SimplePoint;
	
	public class UIGrid extends Sprite
	{
		private var _col:int = 0;
		private var _verticalGap:Number = 0;
		private var _horizontalGap:Number = 0;
		private var _gridSize:SimplePoint;
		private var _drawedRow:int;
		private var _drawedCol:int;
		private var _borderColor:uint;
		
		private var _isBorderEnabled:Boolean = false;
		
		public function UIGrid( col:uint, gridSize:SimplePoint ):void
		{
			this._col = col;
			this._gridSize = gridSize;
		}
		
		override public function addChild( child:DisplayObject ):DisplayObject
		{
			super.addChild( child );
			
			this.orderElements();
			
			return child;
		}
		
		public function set gap( value:Number ):void
		{
			this._verticalGap = value;
			this._horizontalGap = value;
			
			this.orderElements();
		}
		
		public function set verticalGap( value:Number ):void
		{
			this._verticalGap = value;
			
			this.orderElements();
		}
		
		public function get verticalGap():Number
		{
			return this._verticalGap;
		}
		
		public function set horizontalGap( value:Number ):void
		{
			this._horizontalGap = value;
			
			this.orderElements();
		}
		
		public function get horizontalGap():Number
		{
			return this._horizontalGap;
		}
		
		public function set gridSize( value:SimplePoint ):void
		{
			this._gridSize = value;
			
			this.orderElements();
		}
		
		public function get gridSize():SimplePoint
		{
			return this._gridSize;
		}
		
		private function orderElements():void
		{
			var col:int = 0;
			var row:int = 0;

			for ( var i:int = 0; i < this.numChildren; i++ )
			{
				var child:DisplayObject = this.getChildAt( i );
				
				child.x = this.getColPositionByIndex( col ) + this._gridSize.x / 2 - child.width / 2;
				child.y = this.getRowPositionByIndex( row ) + this._gridSize.y / 2 - child.height / 2;
				
				col++;
				if ( col > this._col )
				{
					col = 0;
					row++;
				}
			}
			
			this._drawedRow = row - ( col == 0 ? 1 : 0 );
			this._drawedCol = col;
			
			this.drawBorder();
		}
		
		private function getRowPositionByIndex( index:uint ):Number
		{
			return index * this._gridSize.y + index * this.verticalGap;
		}
		
		private function getColPositionByIndex( index:uint ):Number
		{
			return index * this._gridSize.x + index * this.horizontalGap;
		}
		
		public function set isBorderEnabled( value:Boolean ):void
		{
			this._isBorderEnabled = value;
			
			this.drawBorder();
		}
		
		public function set borderColor( value:uint ):void
		{
			this._borderColor = value;
			
			this.drawBorder();
		}
		
		private function drawBorder():void
		{
			this.graphics.clear();
			
			var maxWidth:Number = this.getColPositionByIndex( this._col ) + this._gridSize.x;
			var maxHeight:Number = this.getRowPositionByIndex( this._drawedRow ) + this._gridSize.y;
			
			this.graphics.lineStyle( 1, this._borderColor, this._isBorderEnabled ? 1 : 0 );
			this.graphics.drawRect( 0, 0, maxWidth, maxHeight );
			
			this.graphics.lineStyle( 1, this._borderColor, this._isBorderEnabled ? .3 : 0 );
			
			var rowCount:int = this._drawedRow == 0 ? 1 : this._drawedRow;			
			if ( rowCount > 1 && this._drawedCol == 0 )
			{
				rowCount--;
			}
			
			for ( var i:int = 0; i < rowCount; i++ )
			{
				for ( var j:int = 0; j < this._col + 1; j++ )
				{
					this.graphics.drawRect( this.getColPositionByIndex( j ), this.getRowPositionByIndex( i ), this._gridSize.x, this._gridSize.y );
				}
			}
		}
	}
}