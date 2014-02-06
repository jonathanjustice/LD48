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
		
		public function SoundObject(soundFileLocation,newID:String):void {
			
			soundID = newID;
			//trace("soundID   :::   ",soundID);
			createSound(soundFileLocation);
			//requestSounds();
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
			playSound(1, .25);
			Main.theStage.addEventListener(SoundEvent.SOUND_STOP, endSoundWithoutFadeOut);
			Main.theStage.addEventListener(SoundEvent.SOUND_FADE_OUT, endSoundWithFadeOut);
			isSoundActive = true;
			//trace("new SOUND CHANNEL 1");
		}
		
		
		public function playSound(number_of_times_to_play:int,newVolume:Number):void{
			soundVolume = newVolume;
			number_of_times_to_play=1;
			var volume_sound_transform:SoundTransform = new SoundTransform(soundVolume,0);
            channel.soundTransform = volume_sound_transform;
			channel = sound.play();
			channel.addEventListener(Event.SOUND_COMPLETE, sound_completed);
			
		}

		public function stopSound():void {
			//trace("soundobject: stopSound");
			if (isSoundActive == true) {
				isSoundActive = false;
				channel.stop();
			}
		}
		
		private function sound_completed($evt:Event):void{
			//trace("sound completed");
			stopSound();
			//do some logic here
			channel.removeEventListener(Event.SOUND_COMPLETE, sound_completed);
			resetSound();
		}
		
		private function resetSound():void {
			removeEventListener(SoundEvent.SOUND_STOP, endSoundWithoutFadeOut);
			removeEventListener(SoundEvent.SOUND_FADE_OUT, endSoundWithFadeOut);
			
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