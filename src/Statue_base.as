package{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.*;
	import customEvents.*;
	public class Statue_base extends StatuePart{
		private var screenLerpX:Number=.07;
		private var screenLerpY:Number=.07;
		public function Statue_base(){
			setUp();
			arrangeScreen();
			defineScreenID();
		}
		
		public override function arrangeScreen():void{
			Main.theStage.addEventListener(ScreenEvent.PREVIEW_BUILD, previewBuild);
			Main.theStage.addEventListener(ScreenEvent.BUILD_START, buildStart);
			Main.theStage.addEventListener(ScreenEvent.BUILD_ABORT, buildStart);
			//trace("arrange");
			//trace(Main,"base");
			//trace(Main.getStage());
			//trace(Main.getStage().width);
			this.y = 460;
			this.x = 350;
			stop();
			updateScreenLocation();
			stopAllButtonsFromAnimating();
			stopAllStatuePartsFromAnimating();
			setMultiplier(screenLerpX,screenLerpY);
			this.statue_feet.mouseEnabled=false;
			this.statue_feet.mouseChildren=false;
		}
		
		public function showEditButton():void{
			this.btn_edit.visible=true;
		}
		
		public function hideEditButton():void{
			this.btn_edit.visible=false;
			
		}
		
		public function buildAbort(event:ScreenEvent):void {
			if(this.getScreenID() == "[object "+event.screenID+"]"){
				//trace(this,"build started");
				//switchLerpMode("ENTER");
				//trace("event.buildID",event.buildID);
				this.statue_feet.gotoAndStop(event.buildID);
				showEditButton();
			}
		}
		
		public function buildStart(event:ScreenEvent):void {
			if(this.getScreenID() == "[object "+event.screenID+"]"){
				//trace(this,"build started");
				//switchLerpMode("ENTER");
				//trace("event.buildID",event.buildID);
				this.statue_feet.gotoAndStop(event.buildID);
				showEditButton();
			}
		}
		
		public function previewBuild(event:ScreenEvent):void {
			//trace("preview build");
			//trace("event.buildID",event.buildID);
			if(this.getScreenID() == "[object "+event.screenID+"]"){
				//trace(this,"build preview");
				//switchLerpMode("ENTER");
				this.statue_feet.gotoAndStop(event.buildID);
				
			}
		}
		
		
		//should do feedback on each click
		public override function clickHandler(event:MouseEvent):void {
			//trace(event.target.name);
			switch (event.target.name) {
				case "hitbox_EDIT":
					trace("EDIT");
					Main.getStage().dispatchEvent(new ScreenEvent("SCREEN_OPEN","EditMenu"));
					hideEditButton();
					break;
			}
		}
	}
}