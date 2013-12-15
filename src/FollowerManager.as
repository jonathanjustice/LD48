package{
	import flash.display.MovieClip;
	import flash.events.*;
	public class FollowerManager extends MovieClip{
		private var followers:Array = new Array();
		private var leaderStatues:Array = new Array();
		private var speechBubbles:Array = new Array();
		private var maxFollowers:int=50;
		public function FollowerManager(){
			//setUp();
		}
		
		public function setUp():void{
			spawnNewLeaderStatue();
			spawnNewFollower();
			enableUpdateLoop();
		}
		
		private function disableUpdateLoop():void{
			removeEventListener(Event.ENTER_FRAME, updateLoop);
		}
		
		private function enableUpdateLoop():void{
			addEventListener(Event.ENTER_FRAME, updateLoop);
		}
		
		private function updateLoop(e:Event):void{
			for(var a:int=0;a<followers.length;a++){
				//trace(a);
				followers[a].updateLoop();
			}
			for(var b:int=0;b<speechBubbles.length;b++){
				//trace(b);
				speechBubbles[b].updateLoop();
				if(speechBubbles[b].getMarkedForDeletion() == true){
					speechBubbles[b].getFollower().allowSpeechBubble();
					Main.theStage.removeChild(speechBubbles[b]);
					speechBubbles.splice(b,1);
				}
			}
		}
		
		public function testFunc():void{
			trace("testFunc");
		}
		
		public function createNewSpeechBubble(follower:MovieClip,dialog:String="slam jam"):void{
			var index:int = followers.indexOf(follower);
			var speechBubble = new SpeechBubble(follower,dialog);
			speechBubbles.push(speechBubble);
			speechBubble.x = follower.x;
			speechBubble.y = follower.y;
			Main.theStage.addChild(speechBubble);
			//trace("bubble");
		}
		
		public function spawnNewLeaderStatue():void{
			var leaderStatue = new LeaderStatue();
			leaderStatues.push(leaderStatue);
			leaderStatue.x = 350;
			leaderStatue.y = 468;
			Main.theStage.addChild(leaderStatue);
		}
		
		public function spawnNewFollower():void{
			for(var i:int=0;i<maxFollowers;i++){
				var follower:Follower = new Follower();
				followers.push(follower);
				follower.y+=(i*1.5);
				follower.setGroundPlane(follower.y);
				follower.scaleY = 1 + (i*.05);
				follower.scaleX = 1 + (i*.05);
				Main.theStage.addChild(follower);
			}
		}
		
		
	}
}