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
			removeAllListeners();
			
			
			//Main.getStage().dispatchEvent(new ScreenEvent("SCREEN_CLOSE","EditMenu"));
		}
		
		public override function doSpecial():void{
			//do stuff in descendent classes
			//trace(Math.abs(desiredY-this.y));
			if(Math.abs(desiredY-this.y) < 1 && lerpMode == "ENTER"){
				pauseLerping();
				//trace("NOW");
				addAllListeners();
			}
		}
		
		public function openScreen(event:ScreenEvent):void {
			if(this.getScreenID() == "[object "+event.screenID+"]"){
				//trace(this,"screen opened");
				resumeLerping();
				switchLerpMode("ENTER");
				showScaffolding();
			}
		}
		
		
		public function closeScreen(event:ScreenEvent):void {
			if(this.getScreenID() == "[object "+event.screenID+"]"){
				resumeLerping();
				//trace(this,"screen closed");
				switchLerpMode("EXIT");
				removeAllListeners();
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
		
		public function showScaffolding():void{
			Main.getStage().dispatchEvent(new ScreenEvent("PREVIEW_BUILD","Statue_base","scaffolding"));
		}
		
		public override function outHandler(event:MouseEvent):void {
			//trace(event.target.name);
			if (event.target.name.indexOf("hitbox") != -1) {
				event.target.parent.gotoAndStop("up");
				showScaffolding();
			}
		}
		
		
		public override function overHandler(event:MouseEvent):void {
			//trace(event.target.name);
			if (event.target.name.indexOf("hitbox") != -1) {
				event.target.parent.gotoAndStop("over");
				switch (event.target.name) {
					case "hitbox_1":
					//trace("1");
						Main.getStage().dispatchEvent(new ScreenEvent("PREVIEW_BUILD","Statue_base","wood"));
						break;
					case "hitbox_2":
						Main.getStage().dispatchEvent(new ScreenEvent("PREVIEW_BUILD","Statue_base","bone"));
						break;
					case "hitbox_3":
						Main.getStage().dispatchEvent(new ScreenEvent("PREVIEW_BUILD","Statue_base","steel"));
						break;
					case "hitbox_4":
						Main.getStage().dispatchEvent(new ScreenEvent("PREVIEW_BUILD","Statue_base","gold"));
						break;
					case "hitbox_5":
						Main.getStage().dispatchEvent(new ScreenEvent("PREVIEW_BUILD","Statue_base","ice"));
						break;
					case "hitbox_6":
						Main.getStage().dispatchEvent(new ScreenEvent("PREVIEW_BUILD","Statue_base","flesh"));
						break;
				}
			}
		}
		/*
		public override function upHandler(event:MouseEvent):void {
			//trace(event.target.name);
			if (event.target.name.indexOf("hitbox") != -1) {
				event.target.parent.gotoAndStop("up");
			}
			
		}*/
		
		//should do feedback on each click
		public override function clickHandler(event:MouseEvent):void {
			//trace(event.target.name);
			switch (event.target.name) {
				case "hitbox_1":
					Main.getStage().dispatchEvent(new ScreenEvent("SCREEN_CLOSE","EditMenu"));
					Main.getStage().dispatchEvent(new ScreenEvent("BUILD_START","Statue_base","wood"));
					//trace("1");
					break;
				case "hitbox_2":
					Main.getStage().dispatchEvent(new ScreenEvent("SCREEN_CLOSE","EditMenu"));
					Main.getStage().dispatchEvent(new ScreenEvent("BUILD_START","Statue_base","bone"));
					//trace("2");
					break;
				case "hitbox_3":
					Main.getStage().dispatchEvent(new ScreenEvent("SCREEN_CLOSE","EditMenu"));
					Main.getStage().dispatchEvent(new ScreenEvent("BUILD_START","Statue_base","steel"));
					//trace("3");
					break;
				case "hitbox_4":
					Main.getStage().dispatchEvent(new ScreenEvent("SCREEN_CLOSE","EditMenu"));
					Main.getStage().dispatchEvent(new ScreenEvent("BUILD_START","Statue_base","gold"));
					//trace("4");
					break;
				case "hitbox_5":
					Main.getStage().dispatchEvent(new ScreenEvent("SCREEN_CLOSE","EditMenu"));
					Main.getStage().dispatchEvent(new ScreenEvent("BUILD_START","Statue_base","ice"));
					//trace("5");
					break;
				case "hitbox_6":
					Main.getStage().dispatchEvent(new ScreenEvent("SCREEN_CLOSE","EditMenu"));
					Main.getStage().dispatchEvent(new ScreenEvent("BUILD_START","Statue_base","flesh"));
					//trace("6");
					break;
			}
			
		}
		
		public override function stageClickHandler(event:MouseEvent):void{
			//click anything else
			if (event.target.name.indexOf("hitbox") != -1) {
				trace(event.target.name);
			}else{
				Main.getStage().dispatchEvent(new ScreenEvent("SCREEN_CLOSE","EditMenu"));
				Main.getStage().dispatchEvent(new ScreenEvent("BUILD_ABORT","Statue_base"));
			}
		}
		
		public function beginBuildingStatuePart():void{
			
		}
	}
}