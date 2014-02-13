package{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.*;
	import customEvents.*;
	public class EditMenu extends default_screen{
		private var screenLerpX:Number=.07;
		private var screenLerpY:Number=.07;
		private var lerpMode:String="IDLE";
		public function EditMenu(){
			setUp();
			defineScreenID();
			arrangeScreen();
		}
		
		public function switchLerpMode(newMode:String):void{
			lerpMode = newMode;
			trace("switch to lerpMode:",lerpMode);
			updateLerpPoints();
		}
		
		private function arrangeScreen():void{
			this.x = 300;
			this.y = 1000;
			stop();
			Main.theStage.addEventListener(ScreenEvent.SCREEN_OPEN, openScreen);
			Main.theStage.addEventListener(ScreenEvent.SCREEN_CLOSE, closeScreen);
			setMultiplier(screenLerpX,screenLerpY);
			//trace("arrange");
			updateLerpPoints();
			stopAllButtonsFromAnimating();
			
			
			//Main.getStage().dispatchEvent(new ScreenEvent("SCREEN_CLOSE","EditMenu"));
		}
		
		public function openScreen(event:ScreenEvent):void {
			if(this.getScreenID() == "[object "+event.screenID+"]"){
				trace(this,"screen opened");
				switchLerpMode("ENTER");
			}
		}
		
		public function closeScreen(event:ScreenEvent):void {
			if(this.getScreenID() == "[object "+event.screenID+"]"){
				trace(this,"screen closed");
				switchLerpMode("EXIT");
			}
		}
		
		public function updateLerpPoints():void{
			trace(lerpMode);
			if(lerpMode == "ENTER"){
				setDesiredLerpPoint(300,200);
			}else if(lerpMode == "EXIT"){
				setDesiredLerpPoint(300,1000);
			}else if(lerpMode == "IDLE"){
				setDesiredLerpPoint(300,1000);
			}
			
			
		}
		
		//should do feedback on each click
		public override function clickHandler(event:MouseEvent):void {
			//trace(event.target.name);
			switch (event.target.name) {
				case "hitbox_1":
					
					Main.getStage().dispatchEvent(new ScreenEvent("SCREEN_CLOSE","EditMenu"));
					trace("1");
					break;
				case "hitbox_2":
					trace("2");
					break;
				case "hitbox_3":
					trace("3");
					break;
				case "hitbox_4":
					trace("4");
					break;
				case "hitbox_5":
					trace("5");
					break;
				case "hitbox_6":
					trace("6");
					break;
			}
		}
	}
}