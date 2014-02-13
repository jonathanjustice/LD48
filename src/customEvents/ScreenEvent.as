package customEvents {
import flash.events.Event;
	public class ScreenEvent extends Event {
		public static const SCREEN_OPEN:String = "SCREEN_OPEN";
		public static const SCREEN_CLOSE:String = "SCREEN_CLOSE";
		
		// this is the object you want to pass through your event.
		public var screenID:String;
		
		public function ScreenEvent(type:String,screenID:String="",bubbles:Boolean=true) {
			super(type, bubbles, cancelable);
			this.screenID = screenID;
		}
	}
}
