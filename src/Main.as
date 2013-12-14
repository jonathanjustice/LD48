package {
	import flash.display.MovieClip;
	import flash.events.*;
	public class Main extends MovieClip{
		private var followerManager:FollowerManager = new FollowerManager();
		public static var theStage:Object;
		public function Main() {
			if (stage) init();
            else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		//once the stage exists, launch the game
        private function init(e:Event = null):void {
			theStage = this.stage;
            removeEventListener(Event.ADDED_TO_STAGE, init);
			setUp();
        }
		
		private function setUp():void{
			followerManager.setUp();
		}
		/*
		public function getStage():Object{
			return theStage;
		}*/
	}
}
	