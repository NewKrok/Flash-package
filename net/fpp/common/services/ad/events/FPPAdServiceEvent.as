package net.fpp.common.services.ad.events {
	
	import flash.events.Event;
	
	import net.fpp.common.services.ad.IFPPAdService;

	public class FPPAdServiceEvent extends Event {
		
		public static const LOADED:String = "FPPAdServiceEvent.loaded";
		public static const FAILED:String = "FPPAdServiceEvent.failed";
		
		public var fppAdService:net.fpp.common.services.ad.IFPPAdService;
		
		public function FPPAdServiceEvent( $type:String, $fppAdService:IFPPAdService )
		{	
			fppAdService = $fppAdService;
			super( $type );	
		}
		
		override public function clone( ):Event
		{
			return new FPPAdServiceEvent( type, fppAdService );
		}
		
	}
	
}