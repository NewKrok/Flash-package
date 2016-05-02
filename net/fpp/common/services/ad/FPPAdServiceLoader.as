package net.fpp.common.services.ad {
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	import net.fpp.common.services.ad.events.FPPAdServiceEvent;
	
	public class FPPAdServiceLoader extends EventDispatcher {
		
		private const SERVICE_URL:		String = 'http://flashplusplus.net/api/fppadservice/fppadservice.swf';
		
		private var fppAdService:		IFPPAdService;
		private var fppAdServiceLoader:	URLLoader;
		private var binaryLoader:		Loader;
		
		private var isLoading:			Boolean;
		
		public function FPPAdServiceLoader( ):void
		{	
		}

		public function load( ):void
		{
			if ( isLoading )
				return;
			
			isLoading = true;
			fppAdServiceLoader = new URLLoader( );
			fppAdServiceLoader.addEventListener( Event.COMPLETE, loadedFPPAdService );
			fppAdServiceLoader.addEventListener( IOErrorEvent.IO_ERROR, failedFPPAdService );
			fppAdServiceLoader.dataFormat = URLLoaderDataFormat.BINARY;
			fppAdServiceLoader.load( new URLRequest( SERVICE_URL ) );
		}
		
		private function failedFPPAdService( event:IOErrorEvent ):void
		{
			removeFPPAdServiceListeners( );
			dispatchEvent( new FPPAdServiceEvent( FPPAdServiceEvent.FAILED, fppAdService ) );
		}
		
		private function loadedFPPAdService( event:Event ):void
		{
			binaryLoader = new Loader;
			binaryLoader.contentLoaderInfo.addEventListener( Event.COMPLETE, binaryConvertionSuccess );
			binaryLoader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, binaryConvertionFailed );
			binaryLoader.loadBytes( fppAdServiceLoader.data );
		}
		
		private function binaryConvertionSuccess( event:Event ):void
		{
			fppAdService = event.currentTarget.content as IFPPAdService;
				
			removeFPPAdServiceListeners( );
			dispatchEvent( new FPPAdServiceEvent( FPPAdServiceEvent.LOADED, fppAdService ) );
		}
		
		private function binaryConvertionFailed( event:IOErrorEvent ):void
		{
			removeFPPAdServiceListeners( );
			dispatchEvent( new FPPAdServiceEvent( FPPAdServiceEvent.FAILED, fppAdService ) );
		}
		
		private function removeFPPAdServiceListeners( ):void
		{
			isLoading = false;
			if ( fppAdServiceLoader )
			{
				fppAdServiceLoader.removeEventListener( Event.COMPLETE, loadedFPPAdService );
				fppAdServiceLoader.removeEventListener( IOErrorEvent.IO_ERROR, failedFPPAdService );
			}
			if ( binaryLoader )
			{
				binaryLoader.contentLoaderInfo.addEventListener( Event.COMPLETE, binaryConvertionSuccess );
				binaryLoader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, binaryConvertionFailed );
			}
		}
		
	}
	
}