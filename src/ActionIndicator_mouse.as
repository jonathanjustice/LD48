package{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.*;
	public class ActionIndicator_mouse extends default_screen{
		private var activeState:String;
		private var mouseLerpX:Number=.27;
		private var mouseLerpY:Number=.27;
		public function ActionIndicator_mouse(){
			setUp();
			stop();
			arrangeScreen();
			activeState = "LIFT";
			setActiveState(activeState);
			hitbox.visible = false;
		}
		
		public override function addScreenToUIContainer():void{
			//trace(this);
			//trace(Main);
			//trace(Main.theStage);
			Main.getNewStage().addChild(this);
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
			//trace(newState);
			activeState = newState;
			gotoAndStop(newState);
			this.mouseEnabled=false;
			this.mouseChildren=false;
		}
		
		private function arrangeScreen():void{
			//trace("arrange");
			updateScreenLocation();
			stopAllButtonsFromAnimating();
			setMultiplier(mouseLerpX,mouseLerpY);
			this.mouseEnabled=false;
			this.mouseChildren=false;
		}
		
		public function updateScreenLocation():void{
			
		}
		
		
	}
}