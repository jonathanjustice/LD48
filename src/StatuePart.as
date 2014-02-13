package{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.*;
	public class StatuePart extends default_screen{
		private var screenLerpX:Number=.07;
		private var screenLerpY:Number=.07;
		public function StatuePart(){
			arrangeScreen();
			setUp();
			
		}
		
		public function arrangeScreen():void{
			trace(Main,"Part");
			trace(Main.getStage());
			trace(Main.getStage().width);
			this.y = 0;
			this.x = (Main.getStage().width/2) + (this.width/2)
			setUp();
			stop();
			//trace("arrange");
			updateScreenLocation();
			stopAllButtonsFromAnimating();
			setMultiplier(screenLerpX,screenLerpY);
		}
		
		public function updateScreenLocation():void{
			desiredX = Main.getStage().width - (Main.getStage().width-Main.originalStageX);
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