package{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.*;
	public class ActionMenu extends default_screen{
		private var screenLerpX:Number=.07;
		private var screenLerpY:Number=.07;
		public function ActionMenu(){
			trace(Main.theStage);
			trace(Main.theStage.width);
			this.x = Main.theStage.width+this.width+250;
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
			desiredX = Main.theStage.width - (Main.theStage.width-Main.originalStageX);
			desiredY = 0;
			
		}
		
		//should do feedback on each click
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
				case "hitbox_BULL":
					Main.getActionManager().setActiveAction("BULL");
					break;
			}
		}
	}
}