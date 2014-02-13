package customEvents {
import flash.events.Event;
	public class CurrencyEvent extends Event {
		public static const CURRENCY_ADD:String = "CURRENCY_ADD";
		public static const CURRENCY_DEDUCT:String = "CURRENCY_DEDUCT";
		
		// this is the object you want to pass through your event.
		public var result:String;
		public var C_amount:int;
		
		public function CurrencyEvent(type:String,result:String,C_amount:int=0,bubbles:Boolean=true) {
			super(type, bubbles, cancelable);
			this.result = result;
			this.C_amount = C_amount;
		}
	}
}
