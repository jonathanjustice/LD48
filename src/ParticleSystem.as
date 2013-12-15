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
		private var lifeTime:int=300;
		private var timeExisted:int=0;
		private var isSpawningEnabled=true;
		public function ParticleSystem(follower:MovieClip){
			myFollower = follower;
		}
		
		public function playMode(newMode:String):void{
			particleMode = newMode;
			enableParticles();
		}
		
		public function enableParticles():void{
			this.addEventListener(Event.ENTER_FRAME, spawnParticles);
			isSpawningEnabled = true;
		}
		
		public function disableParticles():void{
			this.removeEventListener(Event.ENTER_FRAME, spawnParticles);
		}
		
		public function disableSpawning():void{
			isSpawningEnabled=false;
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
			if(timeExisted > lifeTime){
				//disableSpawning();
			}
			if(spawnDelayCounter >= spawnDelay){
				spawnDelayCounter=0;
				var index:int = myFollower.parent.getChildIndex(myFollower);
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
						Main.getStage().addChildAt(p_F,index);
						fireParticles.push(p_F);
						break;
					case "COIN":
						for (var b:int=0;b<3;b++){
							var p_C:P_C = new P_C();
							p_C.defineSpawnPoint(myFollower.getLocation(),myFollower.getVelocity(),myFollower.getScale());
							Main.getStage().addChildAt(p_C,index);
							fireParticles.push(p_C);
						}
						for (var a:int=0;a<25;a++){
							var p_B:P_B = new P_B();
							p_B.defineSpawnPoint(myFollower.getLocation(),myFollower.getVelocity(),myFollower.getScale());
							Main.getStage().addChildAt(p_B,index);
							fireParticles.push(p_B);
						}
						
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
			//if(isSpawningEnabled){
			//timeExisted++;
			spawnDelayCounter++;
			//}
		}
	}
}