package net.fpp.common.services.ad
{
	
	public class FPPAdSizes
	{
		
		public static const SIZE_100x100:		String = '100x100';
		public static const SIZE_300x300:		String = '300x300';
		public static const SIZE_800x80:		String = '800x80';
		public static const SIZE_1000x170:		String = '1000x170';
		
		private static const _sizes:Vector.<String> = new <String>[ SIZE_100x100, SIZE_300x300, SIZE_800x80, SIZE_1000x170 ];
		
		public static function isValidAdSize( $adSize:String ):Boolean
		{
			return _sizes.indexOf( $adSize ) != -1;
		}
		
	}
	
}