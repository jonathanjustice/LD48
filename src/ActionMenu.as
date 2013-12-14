package{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.*;
	public class ActionMenu extends default_screen{
		public function ActionMenu(){
			setUp();
			stop();
			arrangeScreen();
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
			trace(event.target.name);
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
			}
		}
	}
}