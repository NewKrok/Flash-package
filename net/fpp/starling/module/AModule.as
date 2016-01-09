package net.fpp.starling.module
{	
	import starling.display.DisplayObject;
	import starling.events.EventDispatcher;
	
	import net.fpp.starling.module.events.ModuleEvent;
	
	public class AModule extends EventDispatcher
	{
		protected var _view:DisplayObject;
		
		public function AModule():void
		{
		}
		
		public function getView():DisplayObject
		{
			return this._view;
		}
		
		public function dispose():void
		{
			if ( this._view )
			{
				this._view.removeFromParent( true );
				this._view = null;
			}
		}
		
		protected function disposeRequest():void
		{
			this.dispatchEvent( new ModuleEvent( ModuleEvent.DISPOSE_REQUEST ) );
		}
	}
}