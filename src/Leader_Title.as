package{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.*;
	public class Leader_Title extends default_screen{
		private var screenLerpX:Number=.07;
		private var screenLerpY:Number=.07;
		public function Leader_Title(){
			this.y = -250;
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
			//desiredX = Main.theStage.stageWidth - (Main.theStage.stageWidth-Main.originalStageX)/2;
			desiredY = 0;
			
		}
	}
}