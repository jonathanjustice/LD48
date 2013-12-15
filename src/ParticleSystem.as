package{
	import flash.display.MovieClip;
	import flash.events.*;
	public class ParticleSystem extends MovieClip{
		private var particleMode:String = "";
		private var fireParticles:Array = new Array();
		private var loveParticles:Array = new Array();
		private var liftParticles:Array = new Array();
		private var meteorParticles:Array = new Array();
		private var spawnDelay:int=5;
		private var spawnDelayCounter:int=0;
		private var myFollower:MovieClip;
		public function ParticleSystem(follower:MovieClip){
			myFollower = follower;
		}
		
		public function playMode(newMode:String):void{
			particleMode = newMode;
			enableParticles();
		}
		
		public function enableParticles():void{
			this.addEventListener(Event.ENTER_FRAME, spawnParticles);
		}
		
		public function disableParticles():void{
			this.removeEventListener(Event.ENTER_FRAME, spawnParticles);
		}
		
		private function spawnParticles(e:Event):void{
			for(var i:int=0;i<fireParticles.length;i++){
				fireParticles[i].updateLoop();
				if(fireParticles[i].getMarkedForDeletion()==true){
					Main.theStage.removeChild(fireParticles[i]);
					fireParticles.splice(i,1);
				}
			}
			//trace("particleMode",particleMode);
			if(spawnDelayCounter >= spawnDelay){
				spawnDelayCounter=0;
				switch(particleMode){
					case "null":
						//trace("newState passed was null");
						break;
					case "NONE":
						//trace("newState passed was none");
						break;
					case "FIRE":
						var p_F:P_F = new P_F();
						p_F.defineSpawnPoint(myFollower.getLocation(),myFollower.getVelocity(),myFollower.getScale());
						var index:int = myFollower.parent.getChildIndex(myFollower);
						Main.getStage().addChildAt(p_F,index);
						fireParticles.push(p_F);
						break;
					case "METEOR":
						//trace("newState passed was METEOR");
						break;
					case "LOVE":
						//trace("newState passed was LOVE");
						break;
					case "LIFT":
						//trace("newState passed was LIFT");
						
						break;
					case "FALL":
						//trace("newState passed was FALL");
						
						break;
					case "WALK":
						//trace("newState passed was WALK");
						
						break;
				}
			}
			spawnDelayCounter++;
		}
	}
}