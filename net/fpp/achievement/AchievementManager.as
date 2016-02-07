package net.fpp.achievement
{
	import flash.events.EventDispatcher;
	import flash.net.SharedObject;
	
	import net.fpp.achievement.events.AchievementEvent;
	
	public class AchievementManager extends EventDispatcher
	{
		protected var _achievementVOs:	Vector.<AchievementVO> = new Vector.<AchievementVO>;
		
		protected var _savedObject: 	SharedObject;
		
		protected var _namespace:		String;
		
		public function AchievementManager( namespace:String ):void
		{
			_namespace = namespace;
		}
		
		public function registerAchievement( achievementVO:AchievementVO ):void
		{
			var isThisAchievementIDAlreadyUsed:Boolean = false;
			try
			{
				getAchievementVO( achievementVO.id );
				isThisAchievementIDAlreadyUsed = true;
			} catch ( e:Error ) {}
			
			if ( !isThisAchievementIDAlreadyUsed )
			{
				_achievementVOs.push( achievementVO );
			}
			else
			{
				throw new Error( 'This achievement ID is already used: ' + achievementVO.id );
			}
		}
		
		public function unregisterAchievement( achievementID:uint ):void
		{
			var length:uint = this._achievementVOs.length;
			
			for ( var i:uint = 0; i < length; i++ )
			{
				if ( this._achievementVOs[i].id == achievementID )
				{
					this._achievementVOs.splice( i, 1 );
					return;
				}
			}
			
			throw new Error( 'Missing achievement data: ' + achievementID );
		}
		
		public function loadInformations( ):void
		{
			if ( _achievementVOs.length == 0 )
			{
				throw new Error( 'Missing registered achievements.' );
			}
			
			_savedObject = SharedObject.getLocal( _namespace + '_FPP_ACHIEVEMENT_DATA' );
			
			if ( _savedObject.data.content == undefined )
			{
				/*
					Saved data pattern
						[ ACHIEVEMENT_ID
						  IS_EARNED
						  CURRENT_VALUE ]
				*/
				_savedObject.data.content = [];
				_savedObject.flush( );
			}
			
			var innerLength:uint = _achievementVOs.length;
			var length:uint = _savedObject.data.content.length;
			
			for ( var i:uint = 0; i < length; i++ )
			{
				for ( var j:uint = 0; j < innerLength; j++ )
				{
					if ( _savedObject.data.content[i][0] == _achievementVOs[j].id )
					{
						_achievementVOs[j].isEarned 		= _savedObject.data.content[i][1];
						_achievementVOs[j].currentValue 	= _savedObject.data.content[i][2];
					}
				}
			}
		}
		
		public function getAchievementVO( achievementID:uint ):AchievementVO
		{
			var length:uint = _achievementVOs.length;
			
			for ( var i:uint = 0; i < length; i++ )
			{
				if ( _achievementVOs[i].id == achievementID )
				{
					return _achievementVOs[i];
				}
			}
			
			throw new Error( 'Missing achievement data: ' + achievementID );
		}
		
		public function isAchievementRegistered( achievementID:uint ):Boolean
		{
			var length:uint = _achievementVOs.length;
			
			for ( var i:uint = 0; i < length; i++ )
			{
				if ( _achievementVOs[i].id == achievementID )
				{
					return true;
				}
			}
			
			return false;
		}
		
		public function increaseAchievementCurrentValue( achievementID:uint, increaseValue:Number = 1 ):void
		{
			if ( isAchievementRegistered( achievementID ) )
			{
				var achievementVO:AchievementVO = getAchievementVO( achievementID );
				if ( !achievementVO.isEarned )
				{
					var newCurrentValue:Number = achievementVO.currentValue + increaseValue;
					setAchievementCurrentValue( achievementID, newCurrentValue );
				}
			}
		}
		
		public function setAchievementCurrentValue( achievementID:uint, currentValue:Number ):void
		{
			if ( isAchievementRegistered( achievementID ) )
			{
				var achievementVO:AchievementVO = getAchievementVO( achievementID );

				if ( !achievementVO.isEarned )
				{
					achievementVO.currentValue = currentValue;
					achievementVO.isEarned = achievementVO.currentValue >= achievementVO.requiredValue;
					
					if ( achievementVO.isEarned )
					{
						dispatchEvent( new AchievementEvent( AchievementEvent.ACHIEVEMENT_UNLOCKED, achievementVO.clone( ) ) );
					}
				}
			}
		}
		
		public function save( ):void
		{
			var length:uint = _achievementVOs.length;
			
			for ( var i:uint = 0; i < length; i++ )
			{
				_savedObject.data.content[i] = [
					_achievementVOs[i].id,
					_achievementVOs[i].isEarned,
					_achievementVOs[i].currentValue
				];
			}
			
			_savedObject.flush( );
		}
		
		public function getSavedAchievementInfoLog( ):String
		{
			var log:String = 'Saved achievements data:';
			
			var length:int = _savedObject.data.content.length;
			if ( length == 0 )
			{
				log += '\nempty';
				return log;
			}
			
			for ( var i:int = 0; i < length; i++ )
			{
				var id:int = _savedObject.data.content[i][0];
				var isEarned:Boolean = _savedObject.data.content[i][1];
				var currentValue:Number = _savedObject.data.content[i][2];
				var requiredValue = getAchievementVO( id ).requiredValue;
				
				log += '\nAchievement ID: ' + id + ' | Is earned: ' + isEarned + ' | Current value: ' + currentValue + ' | Required value: ' + requiredValue;
			}
			
			return log;
		}
		
		public function getLocalAchievementInfoLog( ):String
		{
			var log:String = 'Local achievements data:';
			
			var length:int = _achievementVOs.length;
			if ( length == 0 )
			{
				log += '\nempty';
				return log;
			}
			
			for ( var i:int = 0; i < length; i++ )
			{
				var id:int = _achievementVOs[i].id;
				var isEarned:Boolean = _achievementVOs[i].isEarned;
				var currentValue:Number = _achievementVOs[i].currentValue;
				var requiredValue = _achievementVOs[i].requiredValue;
				
				log += '\nAchievement ID: ' + id + ' | Is earned: ' + isEarned + ' | Current value: ' + currentValue + ' | Required value: ' + requiredValue;
			}
			
			return log;
		}
		
		public function getAchievementVOs():Vector.<AchievementVO>
		{
			return this._achievementVOs;
		}
	}
}