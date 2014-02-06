package Audio{
	import flash.display.MovieClip;
	import flash.media.Sound;
	import flash.media.*;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.SoundMixer;
	import flash.events.Event;
	import flash.events.*;
	import flash.net.URLRequest; 
	//import utilities.Saving_And_Loading.mp3Loader;
	import customEvents.*;
	
	public class SoundObject extends MovieClip{
		private var soundID:String="";
		//public var soundFile:Sound = new Sound(new URLRequest("Audio/GuileTheme.mp3"));//if building in Flash IDE, need to specify entire filepath starting at the bin level, or be terrible and it put inside same folder as this class
		private var channel:SoundChannel;
		private var sound;
		//private var soundLoader:mp3Loader = new mp3Loader();
		private var soundVolume:Number = .25;
		private var soundFadeSpeed:Number = .025;
		private var isSoundActive:Boolean = false;
		private var followerID:int = 999;
		private var timesPlayed:int=0;
		
		private var numberOfPlays:int = 1;
		
		public function SoundObject(soundFileLocation,newID:String,newFollowerID:int=999,numTimesToPlay:int=1):void {
			numberOfPlays = numTimesToPlay;
			followerID = newFollowerID;
			soundID = newID;
			//trace("soundID   :::   ",soundID);
			createSound(soundFileLocation);
			//requestSounds();
			//trace("newID",newID,"numTimesToPlay",numTimesToPlay);
		}
		
		public function getIsSoundActive():Boolean {
			return isSoundActive;
		}
		
		public function endSoundWithFadeOut(event:SoundEvent):void {
			var myResult:String = event.result;
			//trace(myResult);
			//trace("soundID   -----   ",soundID);
			//trace("***********SOUND FADE OUT");
			//trace("***********isSoundActive",isSoundActive);
			if (isSoundActive == true) {
				if (myResult == soundID || myResult == "ALL") {
					addEventListener(Event.ENTER_FRAME, fadeSoundOunt);	
				}
			}
		}
		
		public function endSoundWithFadeOut_ForEventDispatcherOnly(event:SoundEvent):void {
			//trace("endSoundWithFadeOut_ForEventDispatcherOnly");
			var myResult:String = event.result;
			var dispatcherID:int = event.dispatcherID;
			//trace(myResult);
			//trace("soundID   -----   ",soundID);
			//trace("***********SOUND FADE OUT");
			//trace("***********isSoundActive",isSoundActive);
			if (isSoundActive == true) {
				if(followerID == dispatcherID){
					if (myResult == soundID || myResult == "ALL") {
						addEventListener(Event.ENTER_FRAME, fadeSoundOunt);	
					}
				}
			}
		}
		
		public function endSoundWithoutFadeOut(event:SoundEvent):void {
			var myResult:String = event.result;
			//trace(myResult);
			if (isSoundActive == true) {
				if (myResult == soundID || myResult == "ALL") {
					stopSound();
					resetSound();
				}
			}
		}
		
		private function fadeSoundOunt(e:Event):void {
			soundVolume -= soundFadeSpeed;
			var volume_sound_transform:SoundTransform = new SoundTransform(soundVolume, 0);
			//trace("volume_sound_transform", volume_sound_transform);
			//trace("channel.soundTransform", channel.soundTransform);
			//trace("channel",channel)
			//trace("channel.soundTransform = volume_sound_transform;",channel.soundTransform = volume_sound_transform)
            channel.soundTransform = volume_sound_transform;
			if (soundVolume <= 0) {
				removeEventListener(Event.ENTER_FRAME, fadeSoundOunt);
				channel.stop();
				resetSound();
			}
		}
		
		//argument should be the URL eventually
		public function createSound(soundFileLocation):void {
			//soundLoader.beginLoad(this,soundFileLocation);
			//trace("soundFileLocation",soundFileLocation);
			assignSound(soundFileLocation);
			//soundFile.addEventListener(Event.COMPLETE, loadSound);
		}
		
		/*private function loadSound($evt:Event):void{
			soundFile.removeEventListener(Event.COMPLETE, loadSound);
			//playSound(999, .25);
      	}
		*/
		
		public function assignSound(newSound):void {
			//trace("sound", newSound);
			channel = new SoundChannel();
			//trace("channel",channel);
			sound = newSound;
			playSound(.25);
			Main.theStage.addEventListener(SoundEvent.SOUND_STOP, endSoundWithoutFadeOut);
			Main.theStage.addEventListener(SoundEvent.SOUND_FADE_OUT, endSoundWithFadeOut);
			Main.theStage.addEventListener(SoundEvent.SOUND_FADE_OUT_DISPATCHER_ONLY, endSoundWithFadeOut_ForEventDispatcherOnly);
			isSoundActive = true;
			//trace("new SOUND CHANNEL 1");
		}
		
		
		public function playSound(newVolume:Number):void{
			soundVolume = newVolume;
			var volume_sound_transform:SoundTransform = new SoundTransform(soundVolume,numberOfPlays);
            channel.soundTransform = volume_sound_transform;
			channel = sound.play();
			//channel.addEventListener(Event.SOUND_COMPLETE, sound_completed);
    		channel.addEventListener(Event.SOUND_COMPLETE, sound_completed);
			
		}

		public function stopSound():void {
			//trace("soundobject: stopSound");
			if (isSoundActive == true) {
				isSoundActive = false;
				channel.stop();
			}
		}
		
		function sound_completed(e:Event):void{
			timesPlayed++;
			//trace("sound completed");
			if(timesPlayed >= numberOfPlays){
				stopSound();
				channel.removeEventListener(Event.SOUND_COMPLETE, sound_completed);
				resetSound();
			}else{
				channel = sound.play();
				channel.addEventListener(Event.SOUND_COMPLETE, sound_completed);
			}
		}
		
		private function resetSound():void {
			removeEventListener(SoundEvent.SOUND_STOP, endSoundWithoutFadeOut);
			removeEventListener(SoundEvent.SOUND_FADE_OUT, endSoundWithFadeOut);
			removeEventListener(SoundEvent.SOUND_FADE_OUT, endSoundWithFadeOut_ForEventDispatcherOnly);
			
			//I guess shit was somehow being set to null twice then? 
			//whatever, remove this stuff then
			//trace("resetSound");
			//soundID = null;;
			//channel = null;
			//sound = null;
			//soundLoader = null;
			SoundManager.destroySoundObject(this);
		}
	}
}