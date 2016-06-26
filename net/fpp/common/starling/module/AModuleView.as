package net.fpp.common.starling.module
{
	public class AModuleView extends AView
	{
		protected var _model:AModel;

		public function setModel( model:AModel ):void
		{
			this._model = model;
		}

		override public function dispose():void
		{
			if( this._model )
			{
				this._model = null;
			}

			super.dispose();
		}
	}
}