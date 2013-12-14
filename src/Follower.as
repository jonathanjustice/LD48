package{
	import flash.events.MouseEvent;
	import flash.events.*;
	import flash.display.MovieClip;
	import flash.geom.Point;
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
		private var multiplier_lift_X:Number=.1;
		private var multiplier_lift_Y:Number=.1;
		private var behaviorState:String="";
		private var maxWalkSpeed:int = 2;
		private var minWalkSpeed:int = -2;
		private var currentGravity:Number=0;
		private var originalGravity:Number=0;
		private var gravityIncrement:Number=.038;
		private var friction:Number=.97;
		private var maxGravity:Number=15;
		private var groundPlane:Number=0;
		private var velocity:Point = new Point(0,0);
		private var previousPosition:Point = new Point(0,0);
		private var screenBounds:Number = 0;
		public function Follower(){
			setUp();
			initialSetup();
			triggerNewSpeechBubble();
		}
		
		private function triggerNewSpeechBubble():void{
			Main.getFollowerManager().createNewSpeechBubble(this);
		}
		
		public function setGroundPlane(newValue:Number):void{
			groundPlane = newValue;
		}
		
		private function initialSetup():void{
			setBehaviorState("WALK");
			this.x = Math.round(Math.random()* 780);
			this.y = 450;
			
			selectNewLerpMultiplier(behaviorState);
			pauseWalking();
		}
		
		public function addReleaseHandler():void{
			Main.theStage.addEventListener(MouseEvent.MOUSE_UP, releaseHandler);
		}
		
		public function releaseHandler(event:MouseEvent):void{
			Main.theStage.removeEventListener(MouseEvent.MOUSE_UP, releaseHandler);
			setBehaviorState("FALL");
			this.stop();
		}
		
		public override function outHandler(event:MouseEvent):void {
			//trace(event.target.name);
			if (event.target.name.indexOf("hitbox") != -1) {
				//event.target.parent.gotoAndStop("up");
			}
		}
		
		public override function upHandler(event:MouseEvent):void {
			//trace(event.target.name);
			if (event.target.name.indexOf("hitbox") != -1) {
				//event.target.parent.gotoAndStop("up");
			}
		}
		
		public override function overHandler(event:MouseEvent):void {
			//trace(event.target.name);
			if (event.target.name.indexOf("hitbox") != -1) {
				//event.target.parent.gotoAndStop("over");
			}
		}
		
		public override function downHandler(event:MouseEvent):void {
			//trace(event.target.name);
			switch (event.target.name) {
				case "hitbox":
					//trace("clicked follower");
					setBehaviorState(Main.getActionIndicator_mouse().getActiveState());
					break;
			}
		}
		
		public function setBehaviorState(newState:String):void{
			//trace(newState);
			behaviorState = newState;
			switch (newState){
				case "null":
					//trace("newState passed was null");
					break;
				case "NONE":
					//trace("newState passed was none");
					break;
				case "FIRE":
					//trace("newState passed was FIRE");
					break;
				case "METEOR":
					//trace("newState passed was METEOR");
					break;
				case "LOVE":
					//trace("newState passed was LOVE");
					break;
				case "LIFT":
					//trace("newState passed was LIFT");
					anim_lifted();
					addReleaseHandler();
					break;
				case "FALL":
					//trace("newState passed was FALL");
					anim_falling();
					addReleaseHandler();
					break;
				case "WALK":
					//trace("newState passed was WALK");
					anim_walk();
					break;
			}
		}
		
		private function anim_eyes(animLabel:String):void{
			this.eyes.gotoAndStop(animLabel);
		}
		
		private function anim_lifted():void{
			//trace("play lifted");
			this.gotoAndPlay("lifted");
		}
		
		private function anim_walk():void{
			this.gotoAndStop("walk");
		}
		
		private function anim_falling():void{
			//this.gotoAndStop("falling");
		}
		
		private function selectNewLerpMultiplier(currentBehaviorState:String):void{
			switch (currentBehaviorState){
				case "null":
					//trace("newState passed was null");
					break;
				case "NONE":
					//trace("newState passed was none");
					break;
				case "FIRE":
					//trace("newState passed was FIRE");
					
					break;
				case "METEOR":
					//trace("newState passed was METEOR");
					break;
				case "LOVE":
					//trace("newState passed was LOVE");
					break;
				case "LIFT":
					//trace("newState passed was LIFT");
					setMultiplier(multiplier_lift_X,multiplier_lift_Y);
					break;
				case "WALK":
					//trace("newState passed was WALK");
					multiplier = lerpMin + Math.random()* lerpMax;
					setMultiplier(multiplier,0);
					break;
			}
			
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
			selectNewLerpMultiplier(behaviorState);
			selectNewWalkTarget();
			walking = true;
		}
		
		private function pauseWalking():void{
			selectNewPauseTime();
			walking = false;
			anim_eyes("center")
		}
		
		public function updateLoop():void{
			
			if(behaviorState == "WALK"){
				walk();
			}
			if(behaviorState == "FIRE"){
				onFire();
			}
			if(behaviorState == "LIFT"){
				lift();
			}
			if(behaviorState == "LOVE"){
				love();
			}
			if(behaviorState == "FALL"){
				setScreenBounds();
				fall();
			}
			calculateVelocity();
			calculatePreviousPositions();
		}
		
		private function calculatePreviousPositions():void{
			previousPosition.x = this.x;
			previousPosition.y = this.y;
			//trace("prev",previousPosition);
		}
		
		private function calculateVelocity():void{
			velocity.x = this.x-previousPosition.x;
			velocity.y = this.y-previousPosition.y;
			//trace("vel",velocity);
		}
		
		private function setScreenBounds():void{
				screenBounds = Main.theStage.stageWidth - (Main.theStage.stageWidth-Main.originalStageX)/2;
		}
		
		private function fall():void{
			
			if(this.y < groundPlane){
				if(this.x > screenBounds){
					velocity.x*=-1;
				}
				if(this.x < 0){
					velocity.x*=-1;
				}
				this.x += velocity.x * friction;
				this.y += velocity.y + currentGravity;
				increaseGravity();
			}else{
				this.y = groundPlane;
				resetGravity();
				setBehaviorState("WALK");
			}
		}
		
		private function resetGravity():void{
			currentGravity = originalGravity;
		}
		
		private function increaseGravity():void{
			currentGravity += gravityIncrement;
		}
		
		private function onFire():void{
			
		}
		
		public function lift():void{
			selectNewLerpMultiplier("LIFT")
			Main.requestMouseCoordinates(this);
			lerpToPosition();
			//anim_lifted();
		}
		
		private function love():void{
			
		}
		
		private function walk():void{
			//anim_walk();
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