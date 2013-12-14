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
		
		public function setActiveAction(newAction:String):void{
			trace(newAction);
			switch (newAction){
				case "null":
					trace("Action passed was null");
					break;
				case "NONE":
					trace("Action passed was none");
					break;
				case "FIRE":
					trace("Action passed was FIRE");
					Main.getActionIndicator_mouse().setActiveState(newAction);
					break;
				case "METEOR":
					trace("Action passed was METEOR");
					Main.getActionIndicator_mouse().setActiveState(newAction);
					break;
				case "LOVE":
					trace("Action passed was LOVE");
					Main.getActionIndicator_mouse().setActiveState(newAction);
					break;
				case "LIFT":
					trace("Action passed was LIFT");
					Main.getActionIndicator_mouse().setActiveState(newAction);
					break;
			}
		}
		
		private function disableUpdateLoop():void{
			removeEventListener(Event.ENTER_FRAME, updateLoop);
		}
		
		private function enableUpdateLoop():void{
			addEventListener(Event.ENTER_FRAME, updateLoop);
		}
		
		private function updateLoop(e:Event):void{
			/*for(var i:int=0;i<followers.length;i++){
				//trace(i);
				followers[i].updateLoop();
			}*/
		}
		
		public function testFunc():void{
			trace("testFunc");
		}
		/*
		public function spawnNewFollower():void{
			for(var i:int=0;i<maxFollowers;i++){
				var follower:Follower = new Follower();
				followers.push(follower);
				follower.y+=(i*1.5);
				follower.scaleY = 1 + (i*.05);
				follower.scaleX = 1 + (i*.05);
				Main.theStage.addChild(follower);
			}
		}*/
	}
}