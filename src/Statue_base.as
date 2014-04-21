package{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.*;
	import customEvents.*;
	public class Statue_base extends StatuePart{
		private var screenLerpX:Number=.07;
		private var screenLerpY:Number=.07;
		private var feetBuildPercent:int = 0;
		public function Statue_base(){
			setUp();
			arrangeScreen();
			defineScreenID();
		}
		
		public override function arrangeScreen():void{
			Main.theStage.addEventListener(ScreenEvent.PREVIEW_BUILD, previewBuild);
			Main.theStage.addEventListener(ScreenEvent.BUILD_START, buildStart);
			Main.theStage.addEventListener(ScreenEvent.BUILD_ABORT, buildAbort);
			Main.theStage.addEventListener(ScreenEvent.BUILD_PROGRESS, buildProgress);
			this.y = 460;
			this.x = 350;
			stop();
			updateScreenLocation();
			stopAllButtonsFromAnimating();
			stopAllStatuePartsFromAnimating();
			setMultiplier(screenLerpX,screenLerpY);
			this.statue_feet.mouseEnabled=false;
			this.statue_feet.mouseChildren=false;
			statue_feet.mask_build.gotoAndStop(1);
			statue_feet.scaffolding.visible=false;
		}
		
		public function showEditButton():void{
			this.btn_edit.visible=true;
		}
		
		public function hideEditButton():void{
			this.btn_edit.visible=false;
			
		}
		
		public function buildAbort(event:ScreenEvent):void {
			if(this.getScreenID() == "[object "+event.screenID+"]"){
				this.statue_feet.gotoAndStop(event.buildID);
				statue_feet.mask_build.gotoAndStop(1);
				statue_feet.scaffolding.visible=false;
				showEditButton();
			}
		}
		
		public function buildStart(event:ScreenEvent):void {
			if(this.getScreenID() == "[object "+event.screenID+"]"){
				this.statue_feet.gotoAndStop(event.buildID);
				statue_feet.mask_build.gotoAndStop(1);
				statue_feet.scaffolding.visible=true;
				showEditButton();
			}
		}
		
		public function buildProgress(event:ScreenEvent):void {
			if(this.getScreenID() == "[object "+event.screenID+"]"){
				//event.buildProgressAmount
				this.statue_feet.gotoAndStop(event.buildID);
				statue_feet.mask_build.gotoAndPlay(event.buildProgressAmount);
				statue_feet.scaffolding.visible=true;
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
				statue_feet.scaffolding.visible=true;
				statue_feet.mask_build.gotoAndStop(101);
			}
		}
		
		
		//should do feedback on each click
		public override function clickHandler(event:MouseEvent):void {
			//trace(event.target.name);
			switch (event.target.name) {
				case "hitbox_EDIT":
					//trace("EDIT");
					Main.getStage().dispatchEvent(new ScreenEvent("SCREEN_OPEN","EditMenu"));
					hideEditButton();
					break;
			}
		}
	}
}