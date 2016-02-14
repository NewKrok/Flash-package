package net.fpp.starling.module
{	
	import starling.events.EventDispatcher;
	
	import net.fpp.starling.module.events.ModuleEvent;
	
	public class AModule extends EventDispatcher implements IModule
	{
		protected var _model:AModel;
		
		protected var _view:AModuleView;
		
		public function AModule():void
		{
		}
		
		public function createView( moduleViewClass:Class ):AModuleView
		{
			this._view = new moduleViewClass();
			
			this.setModelToView();
			
			return this._view;
		}		
		
		public function createModel( modelClass:Class ):AModel
		{
			this._model = new modelClass();
			
			this.setModelToView();
			
			return this._model;
		}
		
		private function setModelToView():void
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