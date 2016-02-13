/**
 * Created by newkrok on 08/11/15.
 */
package net.fpp.starling.log.vo
{
	public class LogEntryVO
	{
		private var _creationTime:Number;
		private var _entry:Array;
		
		public function LogEntryVO( creationTime:Number = 0, entry:Array = null )
		{
			this._creationTime = creationTime;
			this._entry = entry;
		}
		
		public function get creationTime():Number
		{
			return this._creationTime;
		}		
		
		public function get entry():Array
		{
			return this._entry;
		}
	}
}