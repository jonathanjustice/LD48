package {
	import flash.events.MouseEvent;
	import flash.events.*;
	import flash.display.Sprite;
	public class Screen_Dynamic_Blocker extends Sprite{
		public var blocker:Sprite = new Sprite();
		
		public function Screen_Dynamic_Blocker(){
			createBlocker();
		}
		
		private function createBlocker():void{
			//var 
			addChild(blocker);
			//blocker.graphics.lineStyle(3,0x000000);
			blocker.graphics.beginFill(0x000000);
			blocker.graphics.drawRect(0,0,1000,1000);
			blocker.graphics.endFill();
			blocker.alpha=.5;
			//blocker.x = stage.stageWidth/2-blocker.width/2;
			//blocker.y = stage.stageHeight/2-blocker.height/2;
		}
		
		//update the size of the bitmatmap when someone resizes the screen
		//not actually implemented yet
		public function update_dynamic_blocker_because_the_screen_was_resized():void{
			blocker.graphics.clear();
			//blocker.graphics.lineStyle(3,0xffffff);
			blocker.graphics.beginFill(0xffffff);
			blocker.graphics.drawRect(0,0,500,500);
			blocker.graphics.endFill();
			blocker.alpha=.5;
			//blocker.x = stage.stageWidth/2-blocker.width/2;
			//blocker.y = stage.stageHeight/2-blocker.height/2;
			
		}
	}
}