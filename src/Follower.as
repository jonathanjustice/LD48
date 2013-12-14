package{
	import flash.events.MouseEvent;
	import flash.events.*;
	import flash.display.MovieClip;
	public class Follower extends default_screen{
		private var walkTarget:int=0;
		private var minDistanceBetweenOldAndNewTargets:int=35;
		private var maxDistanceBetweenOldAndNewTargets:int=400;
		private var walking:Boolean=false;
		private var pauseTime:int=0;
		private var maxPauseTime:int=900;
		private var minPauseTime:int=90;
		private var lerpMin:Number=.001;
		private var lerpMax:Number=.01;
		private var multiplier:Number=0;
		public function Follower(){
			
			setUp();
			initialSetup();
			
		}
		
		private function initialSetup():void{
			this.x = Math.round(Math.random()* 780);
			this.y = 450;
			maxWalkSpeed = 2;
			minWalkSpeed = -2;
			selectNewLerpMultiplier();
			pauseWalking();
		}
		
		public override function clickHandler(event:MouseEvent):void {
			trace(event.target.name);
			switch (event.target.name) {
				case "hitbox":
					trace("clicked follower");
					setActiveState(Main.getActionIndicator_mouse().getActiveState());
					break;
			}
		}
		
		public function setActiveState(newState:String):void{
			trace(newState);
			switch (newState){
				case "null":
					trace("newState passed was null");
					break;
				case "NONE":
					trace("newState passed was none");
					break;
				case "FIRE":
					trace("newState passed was FIRE");
					break;
				case "METEOR":
					trace("newState passed was METEOR");
					break;
				case "LOVE":
					trace("newState passed was LOVE");
					break;
				case "LIFT":
					trace("newState passed was LIFT");
					break;
			}
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
				var lerpAmount:Number =  (walkTarget-this.x)*multiplier;
				if(this.x == walkTarget){
					pauseWalking();
				}
				this.x += lerpAmount;
				if(Math.abs(walkTarget-this.x) < 1){
					pauseWalking();
				}
				
			}
		}
	}
}