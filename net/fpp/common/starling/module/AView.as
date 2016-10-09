package net.fpp.common.starling.module
{
	import net.fpp.common.starling.module.event.ModuleEvent;

	import starling.display.Sprite;
	import starling.events.Event;

	public class AView extends Sprite
	{
		public function AView():void
		{
			this.addEventListener( Event.ADDED_TO_STAGE, onAddedToStageHandler );
		}

		private function onAddedToStageHandler( e:Event ):void
		{
			this.removeEventListener( Event.ADDED_TO_STAGE, onAddedToStageHandler );

			this.onInit();

			this.dispatchEvent( new ModuleEvent( ModuleEvent.MODULE_VIEW_INITED ) );
		}

		protected function onInit():void
		{
		}
	}
}