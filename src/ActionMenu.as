package{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.*;
	public class ActionMenu extends default_screen{
		private var screenLerpX:Number=.07;
		private var screenLerpY:Number=.07;
		public function ActionMenu(){
			this.x = Main.theStage.stageWidth+this.width+250;
			setUp();
			stop();
			arrangeScreen();
			setMultiplier(screenLerpX,screenLerpY);
		}
		
		private function arrangeScreen():void{
			//trace("arrange");
			updateScreenLocation();
			stopAllButtonsFromAnimating();
		}
		
		public function updateScreenLocation():void{
			desiredX = Main.theStage.stageWidth - (Main.theStage.stageWidth-Main.originalStageX)/2;
			desiredY = 0;
		}
		
		public override function clickHandler(event:MouseEvent):void {
			//trace(event.target.name);
			switch (event.target.name) {
				case "hitbox_FIRE":
					Main.getActionManager().setActiveAction("FIRE");
					break;
				case "hitbox_METEOR":
					Main.getActionManager().setActiveAction("METEOR");
					break;
				case "hitbox_LOVE":
					Main.getActionManager().setActiveAction("LOVE");
					break;
				case "hitbox_LIFT":
					Main.getActionManager().setActiveAction("LIFT");
					break;
				case "hitbox_COIN":
					Main.getActionManager().setActiveAction("COIN");
					break;
			}
		}
	}
}