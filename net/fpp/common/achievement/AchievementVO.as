package net.fpp.common.achievement {
	
	public class AchievementVO {

		private var _name:			String;
		private var _description:	String;
		public var currentValue:	Number = 0;
		private var _requiredValue:	Number = 0;
		
		private var _id:			uint = 0;
		
		public var isEarned:		Boolean = false;
		
		public function AchievementVO( id:uint, required:Number, name:String = '', description:String = '' ):void
		{		
			_id = id;
			_name = name;
			_requiredValue = required;
			_description = description;
		}
		
		public function get id( ):uint
		{
			return _id;
		}
		
		public function get requiredValue( ):Number
		{
			return _requiredValue;
		}
		
		public function get name( ):String
		{
			return _name;
		}
		
		public function get description( ):String
		{
			return _description;
		}

		public function get progress( ):uint
		{
			return Math.min( Math.floor( currentValue / requiredValue * 100 ), 100 );
		}
		
		public function clone( ):AchievementVO
		{
			var clonedAchievementVO:AchievementVO = new AchievementVO( _id, _requiredValue, _name, _description );
			clonedAchievementVO.currentValue = currentValue;
			clonedAchievementVO.isEarned = isEarned;
			
			return clonedAchievementVO
		}
		
	}
	
}