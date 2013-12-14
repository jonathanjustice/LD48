package{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.*;
	public class ActionIndicator_mouse extends default_screen{
		private var activeState:String;
		public function ActionIndicator_mouse(){
			setUp();
			stop();
			arrangeScreen();
		}
		
		public override function setUp():void {
			//addDynamicBlocker();
			//addClickHandler();
			//addOverHandler();
			//addDownHandler();
			//addUpHandler();
			//addOutHandler();
			//mouseEnabledHandler();
			addScreenToUIContainer();
		}
		
		public function getActiveState():String{
			return activeState;
		}
		
		public function setActiveState(newState:String):void{
			trace(newState);
			activeState = newState;
			gotoAndStop(newState);
			switch (newState){
				case "null":
					trace("newState passed was null");
					break;
				case "NONE":
					trace("newState passed was none");
					break;
				case "FIRE":
					trace("newState passed was FIRE");
					break;
				case "METEOR":
					trace("newState passed was METEOR");
					break;
				case "LOVE":
					trace("newState passed was LOVE");
					break;
				case "LIFT":
					trace("newState passed was LIFT");
					break;
			}
		}
		
		private function arrangeScreen():void{
			//trace("arrange");
			updateScreenLocation();
			stopAllButtonsFromAnimating();
			setMultiplier(.25);
			this.mouseEnabled=false;
			this.mouseChildren=false;
		}
		
		public function setMouseCoordinates(newX:Number,newY:Number):void{
			desiredX = newX;
			desiredY = newY;
		}
		
		public function updateScreenLocation():void{
			
		}
		
		
	}
}