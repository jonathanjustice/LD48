package{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.Point;
	import flash.errors.*;
	public class ParticleSystem extends MovieClip{
		private var particleMode:String = "";
		private var fireParticles:Array = new Array();
		private var loveParticles:Array = new Array();
		private var liftParticles:Array = new Array();
		private var meteorParticles:Array = new Array();
		private var spawnDelay:int=5;
		private var spawnDelay_DEFAULT:int=5;
		private var spawnDelay_LOVE:int=55;
		private var spawnDelayCounter:int=0;
		private var myFollower:MovieClip;
		private var lifeTime:int=300;
		private var timeExisted:int=0;
		private var isSpawningEnabled:Boolean=true;
		private var isActive:Boolean=false;
		public function ParticleSystem(follower:MovieClip){
			myFollower = follower;
		}
		
		public function playMode(newMode:String):void{
			particleMode = newMode;
			if(particleMode == "LOVE"){
				spawnDelay = spawnDelay_LOVE;
			}else{
				spawnDelay = spawnDelay_DEFAULT;
			}
			enableParticles();
		}
		
		public function enableParticles():void{
			this.addEventListener(Event.ENTER_FRAME, spawnParticles);
			isSpawningEnabled = true;
			isActive = true;
		}
		
		public function abortAll():void{
			disableParticles();
			for(var i:int=0;i<fireParticles.length;i++){
				Main.getStage().removeChild(fireParticles[i]);
				fireParticles.splice(i,1);
				i--;
			}
		}
		
		public function disableParticles():void{
			isActive=false;
			isSpawningEnabled = false;
			this.removeEventListener(Event.ENTER_FRAME, spawnParticles);
		}
		
		public function disableSpawning():void{
			isSpawningEnabled=false;
		}
		
		private function spawnParticles(e:Event):void{
			if(isActive == true){
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
					var index:int = 0;
					try{
						index = myFollower.parent.getChildIndex(myFollower);
					}catch(e : Error){
						//if this throws an error, I should kill the particle immediately
						trace("myFollower",myFollower);
						trace("myFollower.parent",myFollower.parent);
						trace("myFollower.parent.getChildIndex(myFollower)",myFollower.parent.getChildIndex(myFollower));
						trace("remember to kill this particle");
						trace("index");
					}
					
					switch(particleMode){
						
						case "null":
							//trace("newState passed was null");
							break;
						case "NONE":
							//trace("newState passed was none");
							break;
						case "LOVE":
							//trace("particleMode love");
							var p_HEART:P_HEART = new P_HEART();
							p_HEART.defineSpawnPoint(myFollower.getLocation(),myFollower.getVelocity(),myFollower.getScale());
							Main.getStage().addChildAt(p_HEART,index);
							fireParticles.push(p_HEART);
							//trace("particleMode love");
							break;
						case "FIRE":
							var p_F:P_F = new P_F();
							p_F.defineSpawnPoint(myFollower.getLocation(),myFollower.getVelocity(),myFollower.getScale());
							Main.getStage().addChildAt(p_F,index);
							fireParticles.push(p_F);
							break;
						case "BULL_DUST_LEFT":
							var p_BULL_DUST:P_BULL_DUST = new P_BULL_DUST();
							p_BULL_DUST.setRunningDirection("LEFT");
							p_BULL_DUST.defineSpawnPoint(myFollower.getLocation(),myFollower.getVelocity(),myFollower.getScale());
							Main.getStage().addChildAt(p_BULL_DUST,index);
							fireParticles.push(p_BULL_DUST);
							break;
						case "BULL_FIRE":
							
							break;
						case "BULL_DUST_RIGHT":
							var p_BULL_DUST_R:P_BULL_DUST = new P_BULL_DUST();
							p_BULL_DUST_R.setRunningDirection("RIGHT");
							p_BULL_DUST_R.defineSpawnPoint(myFollower.getLocation(),myFollower.getVelocity(),myFollower.getScale());
							Main.getStage().addChildAt(p_BULL_DUST_R,index);
							fireParticles.push(p_BULL_DUST_R);
							break;
						case "BULL_DUST_RIGHT_FIRE":
							var p_BULL_DUST_R_F:P_BULL_DUST = new P_BULL_DUST();
							p_BULL_DUST_R_F.setRunningDirection("RIGHT");
							p_BULL_DUST_R_F.defineSpawnPoint(myFollower.getLocation(),myFollower.getVelocity(),myFollower.getScale());
							Main.getStage().addChildAt(p_BULL_DUST_R_F,index);
							fireParticles.push(p_BULL_DUST_R_F);
							
							var p_BULL_FIRE_R:P_F = new P_F();
							p_BULL_FIRE_R.defineSpawnPoint(myFollower.getFireLocation(),myFollower.getVelocity(),myFollower.getScale());
							Main.getStage().addChildAt(p_BULL_FIRE_R,index);
							fireParticles.push(p_BULL_FIRE_R);
						
							
							break;
						case "BULL_DUST_LEFT_FIRE":
							var p_BULL_DUST_L_F:P_BULL_DUST = new P_BULL_DUST();
							p_BULL_DUST_L_F.setRunningDirection("LEFT");
							p_BULL_DUST_L_F.defineSpawnPoint(myFollower.getLocation(),myFollower.getVelocity(),myFollower.getScale());
							Main.getStage().addChildAt(p_BULL_DUST_L_F,index);
							fireParticles.push(p_BULL_DUST_L_F);
							
							var p_BULL_FIRE_L:P_F = new P_F();
							p_BULL_FIRE_L.defineSpawnPoint(myFollower.getFireLocation(),myFollower.getVelocity(),myFollower.getScale());
							Main.getStage().addChildAt(p_BULL_FIRE_L,index);
							fireParticles.push(p_BULL_FIRE_L);
						
							
							break;
							
							
						case "C_FIRE_COIN":
							var tempPoint2:Point=new Point();
								tempPoint2.y = (myFollower.getVelocity().y+myFollower.getScale());
								tempPoint2.x = 30*myFollower.getVelocity().x;
							for (var h:int=0;h<10;h++){
								var p_F_more:P_F = new P_F();
								p_F_more.defineSpawnPoint(myFollower.getLocation(),tempPoint2,myFollower.getScale());
								Main.getStage().addChildAt(p_F_more,index);
								fireParticles.push(p_F_more);
							}
							for (var j:int=0;j<15;j++){
								var p_B_more:P_B = new P_B();
								p_B_more.defineSpawnPoint(myFollower.getLocation(),myFollower.getVelocity(),myFollower.getScale());
								Main.getStage().addChildAt(p_B_more,index);
								fireParticles.push(p_B_more);
							}
							break;
						case "METEOR_FALL":
							for (var d:int=0;d<15;d++){
								var p_F_MF_f:P_F_MF = new P_F_MF();
								p_F_MF_f.defineSpawnPoint(myFollower.getLocation(),myFollower.getVelocity(),myFollower.getScale());
								p_F_MF_f.fireMode("trail");
								p_F_MF_f.setGroundPlane(myFollower.getDesiredY());
								Main.getStage().addChildAt(p_F_MF_f,index);
								fireParticles.push(p_F_MF_f);
							}
							for (var f:int=0;f<15;f++){
								var p_F_MF_r:P_F_MF = new P_F_MF();
								p_F_MF_r.defineSpawnPoint(myFollower.getLocation(),myFollower.getVelocity(),myFollower.getScale());
								p_F_MF_f.setGroundPlane(myFollower.getDesiredY());
								p_F_MF_r.fireMode("ball");
								Main.getStage().addChildAt(p_F_MF_r,index);
								fireParticles.push(p_F_MF_r);
							}
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
							
						case "SQUISHED":
							for (var g:int=0;g<10;g++){
								var p_B_s:P_B = new P_B();
								var tempPoint:Point=new Point();
								tempPoint.y = myFollower.getLocation().y+45*myFollower.getScale();
								tempPoint.x = myFollower.getLocation().x;
								p_B_s.defineSpawnPoint(tempPoint,myFollower.getVelocity(),myFollower.getScale());
								Main.getStage().addChildAt(p_B_s,index);
								fireParticles.push(p_B_s);
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
			}
		}
	}
}