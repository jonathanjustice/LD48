package{
	import flash.display.MovieClip;
	public class Follower extends MovieClip{
		private var walkTarget:int=0;
		private var maxWalkSpeed:int=5;
		private var minWalkSpeed:int=-5;
		private var minDistanceBetweenOldAndNewTargets:int=35;
		private var maxDistanceBetweenOldAndNewTargets:int=400;
		private var walking:Boolean=false;
		private var pauseTime:int=0;
		private var maxPauseTime:int=900;
		private var minPauseTime:int=90;
		private var lerpMin:Number=.01;
		private var lerpMax:Number=.9;
		private var multiplier:Number=0;
		public function Follower(){
			
			setUp();
		}
		
		private function setUp():void{
			this.x = Math.round(Math.random()* 800);
			this.y = 450;
			selectNewLerpMultiplier();
			pauseWalking();
		}
		
		private function anim_eyes(animLabel:String):void{
			this.eyes.gotoAndStop(animLabel);
		}
		
		private function selectNewLerpMultiplier():void{
			multiplier = lerpMin + Math.random()* lerpMax;
		}
		
		private function selectNewWalkTarget():void{
			var newTarget = Math.abs(Math.random()* 800);
		if(newTarget > walkTarget){
				anim_eyes("right");
			}
			if(newTarget < walkTarget){
				anim_eyes("left");
			}
			if(Math.abs(newTarget-walkTarget) < minDistanceBetweenOldAndNewTargets || Math.abs(newTarget-walkTarget) > maxDistanceBetweenOldAndNewTargets){
				selectNewWalkTarget();
			}else{
				
				walkTarget = Math.abs(Math.random()* 800);
			}
		}
		
		private function selectNewPauseTime():void{
			pauseTime = minPauseTime + Math.abs(Math.random()* maxPauseTime);
		}
		
		private function resumeWalking():void{
			selectNewLerpMultiplier();
			selectNewWalkTarget();
			walking = true;
		}
		
		private function pauseWalking():void{
			//trace("pauseeWalking");
			selectNewPauseTime();
			walking = false;
			anim_eyes("center")
		}
		
		public function updateLoop():void{
			
			if(walking == false){
				pauseTime--;
				if(pauseTime > 0){
				}else if(pauseTime==0){
					resumeWalking();
				}
			}
			
			if(walking){
				//trace("walking");
				var lerpAmount:Number =  (walkTarget-this.x)*multiplier;
				if(this.x == walkTarget){
					pauseWalking();
				}
				if(lerpAmount < minWalkSpeed){
					lerpAmount = minWalkSpeed;
				}
				if(lerpAmount > maxWalkSpeed){
					lerpAmount = maxWalkSpeed;
				}
				if(lerpAmount==0){
					if(walkTarget < this.x){
					lerpAmount =-.25;
					}
					if(walkTarget > this.x){
						lerpAmount =.25;
					}
				}
				this.x += lerpAmount;
				if(Math.abs(walkTarget-this.x) < 10){
					pauseWalking();
				}
				
			}
		}
	}
}