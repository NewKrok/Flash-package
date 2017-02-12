/**
 * Created by newkrok on 05/02/17.
 */
package net.fpp.common.util
{
	public class ArrayUtil
	{
		public static function getRandomElementFromArray( array:Array ):*
		{
			return array[Math.floor( Math.random() * array.length )];
		}
	}
}