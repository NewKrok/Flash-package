package net.fpp.starling.module
{	
	import starling.display.DisplayObject;
	import starling.events.EventDispatcher;
	
	import net.fpp.starling.module.events.ModuleEvent;
	
	public class AModule extends EventDispatcher
	{
		protected var _model:AModel;
		
		protected var _view:AModuleView;
		
		public function AModule():void
		{
			if( this._view && this._model )
			{
				this._view.setModel( this._model );
			}
		}
		
		public function getView():AModuleView
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