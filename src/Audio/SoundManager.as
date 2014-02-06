package Audio{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.SoundMixer;
	import flash.net.URLRequest; 
	import customEvents.SoundEvent;
	//import JSON;
	import customEvents.*;
	public class SoundManager extends MovieClip{
		
		public static var soundObjects:Array = new Array();
		
		private var START_SCREEN_SONG:String = "sound/START_SCREEN_SONG.mp3";
		private var SONG_BG_1:String = "sound/SONG_BG_1.mp3";
		private var SONG_BG_2:String = "sound/SONG_BG_2.mp3";
		private var CUTSCENE_SONG_1:String = "sound/CUTSCENE_SONG_1.mp3";
		private var CUTSCENE_SONG_2:String = "sound/CUTSCENE_SONG_2.mp3";
		private var SONG_INVINCIBLE:String = "sound/SONG_INVINCIBLE.mp3";
		private var SONG_GAMEOVER:String = "sound/SONG_GAMEOVER.mp3";
		private var SONG_GAMEWON:String = "sound/SONG_GAMEWON.mp3";
		private var SONG_LEVEL_COMPLETE:String = "sound/SONG_LEVEL_COMPLETE.mp3";
		
		private var METEOR_IMPACT:explosion_002 = new explosion_002();
		private var METEOR_FALL:meteorFall_001 = new meteorFall_001();
		private var FOLLOWER_SQUISH:squish_002 = new squish_002();
		
		public var theStage;
		//sdfsdfsdf
		
		
		
		
		//file paths for sound
		//EVENT FORMAT FOR CALLING SONG EVENT:
		//Main.theStage.dispatchEvent(new SoundEvent("SOUND_START","SOUNDNAME"));
		//imports needed for firing custom events
		//import utilities.customEvents.*;
		
		private var filePath;
		private static var _instance:SoundManager;
		
		public function SoundManager(newStage){
			theStage = newStage;
			//trace(theStage);
			//createNewSoundObject(filePath);
			get_sounds_from_JsonParser();
			//trace("filePath",filePath);
			//stop_a_sound_channel(filePath);
			addSoundListeners();
		}
		
		private static function get_sounds_from_JsonParser():void {
			//trace(Main.game);
			//trace(Main.game.getJsonParser());
			//JSON_sounds = Main.game.getJsonParser().getData_mp3();
			//trace("JSON_sounds", JSON_sounds.sounds[0].name);
			//trace("JSON_sounds",JSON_sounds.sounds.mp3_guileTheme);
		}
		
		private function addSoundListeners():void {
			Main.theStage.addEventListener(SoundEvent.SOUND_START, startSound);
		}
	
		public function startSound(event:SoundEvent):void {
			var myResult:String = event.result;
			//trace(myResult);
			switch(event.result) {
				case "START_SCREEN_SONG":
					filePath = START_SCREEN_SONG;
					break;
				case "METEOR_FALL":
					filePath = METEOR_FALL;
					break;
				case "METEOR_IMPACT":
					filePath = METEOR_IMPACT;
					break;
				case "FOLLOWER_SQUISH":
					filePath = FOLLOWER_SQUISH;
					break;
				
				
				
			}
			createNewSoundObject(filePath,myResult);
		}
		
		public function createNewSoundObject(file_path,soundID):void {
			var newSoundObject:SoundObject = new SoundObject(filePath,soundID);
			soundObjects.push(newSoundObject);
		}
		
		public function stop_a_sound_channel(channel_to_stop:String):void {
			for each(var soundObject:SoundObject in soundObjects) {
				if (soundObject.name == channel_to_stop) {
					soundObject.stopSound();
				}				
			}
		}
		
		public function stopAllSounds():void{
			for each(var soundObject:SoundObject in soundObjects) {
				soundObject.stopSound();				
			}
		}
		
		public static function destroySoundObject(soundObject:SoundObject):void {
			var index:int = soundObjects.lastIndexOf(soundObject);
			//trace("index", index);
			soundObjects.splice(index, 1);
			soundObject = null;
			//trace(soundObjects);
		}
	}
}
