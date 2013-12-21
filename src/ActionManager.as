package{
	import flash.display.MovieClip;
	import flash.events.*;
	public class ActionManager extends MovieClip{
		private var activeAction:String;
		public function ActionManager(){
			//setUp();
		}
		
		public function setUp():void{
			enableUpdateLoop();
		}
		
		public function destroy():void{
			disableUpdateLoop();
		}
		
		public function setActiveAction(newAction:String):void{
			//trace(newAction);
			Main.getActionIndicator_mouse().setActiveState(newAction);
		}
		
		private function disableUpdateLoop():void{
			removeEventListener(Event.ENTER_FRAME, updateLoop);
		}
		
		private function enableUpdateLoop():void{
			addEventListener(Event.ENTER_FRAME, updateLoop);
		}
		
		private function updateLoop(e:Event):void{
			
		}
		
		public function testFunc():void{
			trace("testFunc");
		}
		
	}
}