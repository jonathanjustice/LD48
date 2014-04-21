package customEvents {
import flash.events.Event;
	public class ScreenEvent extends Event {
		public static const SCREEN_OPEN:String = "SCREEN_OPEN";
		public static const SCREEN_CLOSE:String = "SCREEN_CLOSE";
		public static const BUILD_START:String = "BUILD_START";
		public static const BUILD_ABORT:String = "BUILD_ABORT";
		public static const PREVIEW_BUILD:String = "PREVIEW_BUILD";
		public static const BUILD_PROGRESS:String = "BUILD_PROGRESS";
		
		// this is the object you want to pass through your event.
		public var screenID:String;
		public var buildID:String;
		public var buildProgressAmount:int;
		
		public function ScreenEvent(type:String,screenID:String="",buildID:String="",buildProgressAmount:int=0,bubbles:Boolean=true) {
			super(type, bubbles, cancelable);
			this.screenID = screenID;
			this.buildID = buildID;
			this.buildProgressAmount = buildProgressAmount;
		}
	}
}
