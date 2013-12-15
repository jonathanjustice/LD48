package{
	import flash.events.MouseEvent;
	import flash.events.*;
	import flash.display.MovieClip;
	import flash.geom.Point;
	public class Follower extends default_screen{
		private var walkTarget:int=0;
		private var maxFireTime:int=300;
		private var fireTime:int=0;
		private var minDistanceBetweenOldAndNewTargets:int=35;
		private var maxDistanceBetweenOldAndNewTargets:int=400;
		
		private var minDistanceBetweenOldAndNewTargets_walk:int=35;
		private var maxDistanceBetweenOldAndNewTargets_walk:int=400;
		
		private var minDistanceBetweenOldAndNewTargets_fire:int=15;
		private var maxDistanceBetweenOldAndNewTargets_fire:int=50;
		private var walking:Boolean=false;
		private var running:Boolean=false;
		private var pauseTime:int=0;
		private var maxPauseTime:int=900;
		private var minPauseTime:int=90;
		private var lerpMin:Number=.001;
		private var lerpMax:Number=.01;
		private var multiplier:Number=0;
		private var multiplier_fire:Number=.05;
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
		private var happinessAmount:int=100;
		private var happiness:String="worship";
		private var mood:String="";
		private var dialog:String="";
		private var isSpeechAllowed:Boolean=true;
		private var activeBubbles:int=0;
		private var abortCurrentBubble:Boolean=false;
		private var particleSystem:ParticleSystem;
		public function Follower(){
			setUp();
			initialSetup();
		}
		
		
		public function getMood():String{
			return mood;
		}
		
		private function calculateMood():void{
			if(happinessAmount < 10){
				happiness = "_furious";
			}else if (happinessAmount < 25){
				happiness = "_angry";
			}else if (happinessAmount < 50){
				happiness = "_upset";
			}else if (happinessAmount < 60){
				happiness = "_indifferent";
			}else if (happinessAmount < 75){
				happiness = "_happy";
			}else if (happinessAmount <= 100){
				happiness = "_worship";
			}
			mood = behaviorState + happiness;
			dialog = Main.getDialogs().selectDialog(mood);
			//trace("dialog:",dialog);
		}
		
		public function allowSpeechBubble():void{
			isSpeechAllowed = true;
		}
		
		
		
		private function triggerNewSpeechBubble():void{
			if(isSpeechAllowed){
				activeBubbles += 1;
				calculateMood();
				Main.getFollowerManager().createNewSpeechBubble(this,dialog);
				isSpeechAllowed=false;
			}
		}
		
		public function setGroundPlane(newValue:Number):void{
			groundPlane = newValue;
		}
		
		
		
		private function initialSetup():void{
			particleSystem = new ParticleSystem(this);
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
					anim_fire();
					trace("newState passed was FIRE");
					fireTime=0;
					Main.getFollowerManager().abortCurrentBubble(this);
					isSpeechAllowed=true;
					triggerNewSpeechBubble();
					minDistanceBetweenOldAndNewTargets = minDistanceBetweenOldAndNewTargets_fire;
					maxDistanceBetweenOldAndNewTargets = maxDistanceBetweenOldAndNewTargets_fire;
					particleSystem.playMode(behaviorState);
					pauseTime=3;
					running=true;
					walking=false;
					selectNewWalkTarget();
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
					
					Main.getFollowerManager().abortCurrentBubble(this);
					isSpeechAllowed=true;
					triggerNewSpeechBubble();
					break;
				case "FALL":
					//trace("newState passed was FALL");
					anim_falling();
					addReleaseHandler();
					break;
				case "WALK":
					minDistanceBetweenOldAndNewTargets = minDistanceBetweenOldAndNewTargets_walk;
					maxDistanceBetweenOldAndNewTargets = maxDistanceBetweenOldAndNewTargets_walk;
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
		
		private function anim_fire():void{
			//trace("play lifted");
			this.gotoAndPlay("fire");
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
					setMultiplier(multiplier_fire,multiplier_fire);
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
		
		private function chanceToSpeak():void{
			var chance = Math.round(Math.random()*100000);
			//trace(chance);
			if(chance > 99995){
				triggerNewSpeechBubble();
			}
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
		
		public function getVelocity():Point{
			return velocity;
		}
		
		public function getLocation():Point{
			var loc:Point = new Point(this.x,this.y);
			return loc;
		}
		
		public function getScale():Number{
			return this.scaleX;
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
				if(running){
					setBehaviorState("FIRE");
				}
				if(walking){
					setBehaviorState("WALK");
				}
			}
		}
		
		private function resetGravity():void{
			currentGravity = originalGravity;
		}
		
		private function increaseGravity():void{
			currentGravity += gravityIncrement;
		}
		
		private function onFire():void{
			//trace("onfire");
			chanceToSpeak();
			//anim_walk();
			if(running){
				var lerpAmount:Number =  (walkTarget-this.x)*multiplier_fire;
				if(this.x == walkTarget){
					//pauseWalking();
					selectNewWalkTarget();
				}
				this.x += lerpAmount;
				if(Math.abs(walkTarget-this.x) < 1){
					selectNewWalkTarget();
				}
			}
			if(fireTime > maxFireTime){
				setBehaviorState("WALK");
				this.particleSystem.playMode("NONE");
			}
			fireTime++;
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
			chanceToSpeak();
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