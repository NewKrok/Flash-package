﻿package net.fpp.common.achievement.events {		import flash.events.Event;		import net.fpp.common.achievement.AchievementVO;	public class AchievementEvent extends Event {				public static const ACHIEVEMENT_UNLOCKED:	String = "AchievementEvent.ACHIEVEMENT_UNLOCKED";				private var achievementVO:AchievementVO		public function AchievementEvent( type:String, achievementVO:AchievementVO ):void		{			super ( type );		}				override public function clone( ):Event		{			var event:AchievementEvent = new AchievementEvent( type, achievementVO );			return event;		}			}	}