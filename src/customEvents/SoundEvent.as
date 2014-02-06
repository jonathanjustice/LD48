package customEvents {
import flash.events.Event;
	public class SoundEvent extends Event {
		public static const SOUND_START:String = "SOUND_START";
		public static const SOUND_STOP:String = "SOUND_STOP";
		public static const SOUND_FADE_OUT:String = "SOUND_FADE_OUT";
		public static const SOUND_FADE_OUT_DISPATCHER_ONLY:String = "SOUND_FADE_OUT_DISPATCHER_ONLY";
		
		// this is the object you want to pass through your event.
		public var result:String;
		public var dispatcherID:int;
		
		
		public function SoundEvent(type:String,result:String,dispatcherID:int=999,bubbles:Boolean=true) {
			super(type, bubbles, cancelable);
			this.result = result;
			this.dispatcherID = dispatcherID;
		}
		/*
		public override function clone():Event {
			return new SoundEvent(type, result, bubbles, cancelable);
		}*/
	}
}
