package customEvents {
import flash.events.Event;
	public class SoundEvent extends Event {
		public static const SOUND_START:String = "SOUND_START";
		public static const SOUND_STOP:String = "SOUND_STOP";
		public static const SOUND_FADE_OUT:String = "SOUND_FADE_OUT";
		
		// this is the object you want to pass through your event.
		public var result:String;
		
		
		public function SoundEvent(type:String,result:String,bubbles:Boolean=true) {
			super(type, bubbles, cancelable);
			this.result = result;
		}
		/*
		public override function clone():Event {
			return new SoundEvent(type, result, bubbles, cancelable);
		}*/
	}
}
