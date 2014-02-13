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
			
			
		}
		
		public override function arrangeScreen():void{
			//trace("arrange");
			//trace(Main,"base");
			//trace(Main.getStage());
			//trace(Main.getStage().width);
			this.y = 460;
			this.x = 350;
			stop();
			updateScreenLocation();
			stopAllButtonsFromAnimating();
			setMultiplier(screenLerpX,screenLerpY);
		}
		
		
		//should do feedback on each click
		public override function clickHandler(event:MouseEvent):void {
			//trace(event.target.name);
			switch (event.target.name) {
				case "hitbox_EDIT":
					trace("EDIT");
					Main.getStage().dispatchEvent(new ScreenEvent("SCREEN_OPEN","EditMenu"));
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