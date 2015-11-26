package net.fpp.static
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.ContextMenuEvent;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	public class FPPContextMenu
	{
		
		private static var _main:DisplayObjectContainer;
		
		public static function create( $main:DisplayObjectContainer ):void
		{
			_main = $main;
			
			var myContextMenu:ContextMenu = new ContextMenu ( );
			myContextMenu.hideBuiltInItems( );
			
			var notice:ContextMenuItem = new ContextMenuItem ( "Created by: Flash++" );
			myContextMenu.customItems.push( notice );
			notice = new ContextMenuItem ( "More Games" );
			notice.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, toHomeRequest );
			
			myContextMenu.customItems.push( notice );
			_main.contextMenu = myContextMenu;
		}
		
		private static function toHomeRequest( event:ContextMenuEvent ):void
		{
			Navigate.toHome( );
		}
		
	}
	
}