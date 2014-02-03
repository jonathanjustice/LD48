﻿package{
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
		private var beingTossed:Boolean=false;
		private var pauseTime:int=0;
		private var maxPauseTime:int=9;
		private var minPauseTime:int=9;
		private var lerpMin:Number=.001;
		private var lerpMax:Number=.01;
		private var multiplier:Number=0;
		private var multiplier_fire:Number=.05;
		private var multiplier_squishedWalk:Number=.00001;
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
		private var maxYVelocity:int=-30;
		private var isDead:Boolean=false;
		private var isCrispy:Boolean=false;
		private var isSquished:Boolean=false;
		private var isOnFire:Boolean=false;
		private var is_C_FIRE_COIN:Boolean = false;
		private var targetRotation:Number=0;
		private var rocketVelocity:Point=new Point(0,-.5);
		private var rocketSpeed:int=5;
		private var isBeingTossed:Boolean=false;
		public function Follower(){
			setUp();
			initialSetup();
		}
		
		public function abortInput():void{
			removeOutHandler();
			removeOverHandler();
			removeClickHandler();
			removeDownHandler();
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
			//trace("mood:",mood);
			dialog = Main.getDialogs().selectDialog(mood);
			//trace("dialog:",dialog);
		}
		
		public function allowSpeechBubble():void{
			isSpeechAllowed = true;
		}
		
		private function triggerNewSpeechBubble():void{
			if(isSpeechAllowed){
				if(Math.random()*10<5){
					activeBubbles += 1;
					calculateMood();
					Main.getFollowerManager().createNewSpeechBubble(this,dialog);
					isSpeechAllowed=false;
				}
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
			this.eyes.burnMask.alpha=0;
			this.eyes.burnMask.mouseEnabled=false;
			this.eyes.burnMask.mouseChildren=false;
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
			switch (event.target.name) {
				case "hitbox":
					setBehaviorState(Main.getActionIndicator_mouse().getActiveState());
					break;
			}
		}
		
		private function randomlyFlipRightOrLeft():void{
			var chanceToFlipLeftOrRight_2:Number = Math.random() * 10;
			if (chanceToFlipLeftOrRight_2 < 5) {
				this.scaleX *= -1;
			}
		}
		
		private function EXPLODED_handler():void{
			anim_exploded();
			particleSystem.playMode(behaviorState);
			setToDead();
		}
		
		private function SQUISHED_handler():void{
			setToDead();
			anim_squished();
			isSquished = true;
		}
		
		private function FIRE_handler():void{
			if(isCrispy == true){
				behaviorState = "CRISPY";
				this.eyes.burnMask.alpha=1;
			}else if (isDead == false) {
				randomlyFlipRightOrLeft();
				this.eyes.burnMask.alpha=0;
				anim_fire();
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
				isOnFire=true;
				selectNewWalkTarget();
				enableInput();
			}else if(isSquished == true){
			}else{
				trace("else");
			}
		}
		
		private function CRISPY_handler():void{
			setToDead();
			running=false;
			walking=false;
			isOnFire=false;
			isCrispy=true;
			anim_crispy();
			particleSystem.playMode(behaviorState);
		}
		
		private function COIN_handler():void{
			if(isDead==true || is_C_FIRE_COIN == true){
				//trace("dead DON'T DO ANYTHING");
			}else if(isDead == false){
				do_stuff_to_active_followers_inside_the_click_radius_excluding_this("HOP");
				setToDead();
				running=false;
				walking=false;
				if(isOnFire && is_C_FIRE_COIN==false){
					setBehaviorState("C_FIRE_COIN");
				}else {
					Main.getFollowerManager().abortCurrentBubble(this);
					isSpeechAllowed=true;
					triggerNewSpeechBubble();
					anim_coin();
					isSquished = true;
				}
			}
		}
		
		private function C_FIRE_COIN_handler():void{
			this.y-=10;
			setToDead();
			is_C_FIRE_COIN = true;
			this.gotoAndStop("fire");
			particleSystem.playMode("FIRE");
			selectNewTargetRotation();
			running=false;
			walking=false;
			isOnFire=false;
			isCrispy=true;
			triggerNewSpeechBubble();
			disableInput();
		}
		
		private function METEOR_handler():void{
			if(isDead == false){
				setToDead();
				anim_meteorLook();
				isSpeechAllowed=true;
				triggerNewSpeechBubble();
				do_stuff_to_active_followers_inside_the_click_radius_excluding_this("LOOK_UPWARDS");
				Main.getFollowerManager().createNewMeteor(this);
			}
		}
		
		
		private function BULL_handler():void{
			if(isDead == false){
				isSpeechAllowed=true;
				triggerNewSpeechBubble();
				Main.getFollowerManager().createNewBull(this);
				if(isOnFire == true){
					var preBullAlpha:Number=this.eyes.burnMask.alpha;
					setBehaviorState("FIRE");
					this.eyes.burnMask.alpha=preBullAlpha;
					running=true;
				}else{
					setBehaviorState("WALK");
					walking=true;
				}
			}
		}
		
		private function HOP_handler():void{
			anim_hop();
		}
		
		private function LOVE_handler():void{
			if(isDead==true){
				if(isCrispy == true){//if crispy dead
					setBehaviorState("LOVE_CRISPY");
				}else if(isSquished){
					setBehaviorState("SQUISHED_WALK");
				}
			}else if(isDead == false){
				 if(!isCrispy && isOnFire){//if on fire and not crispy yet
					this.eyes.gotoAndPlay("center");
					walking=true;
					isOnFire=false;
					this.eyes.burnMask.alpha=0;
					this.eyes.burnMask.visible=false;
					setBehaviorState("NONE");
					setBehaviorState("WALK");
				 }else{
					//not dead
					setBehaviorState("WALK");
					triggerNewSpeechBubble();
				 }
			}
			isSpeechAllowed=true;
			triggerNewSpeechBubble();
		}
		
		private function SQUISHED_WALK_handler():void{
			anim_ressurecting();
			this.eyes.visible=false;
			running=false;
			walking=true;
			minDistanceBetweenOldAndNewTargets = minDistanceBetweenOldAndNewTargets_walk;
			maxDistanceBetweenOldAndNewTargets = maxDistanceBetweenOldAndNewTargets_walk;
		}
		
		private function LIFT_handler():void{
			if(isDead == false){
				anim_lifted();
				addReleaseHandler();
				Main.getFollowerManager().abortCurrentBubble(this);
				isSpeechAllowed=true;
				triggerNewSpeechBubble();
			}
		}
		
		private function FALL_handler():void{
			disableInput();
			anim_falling();
		}
		
		private function WALK_handler():void{
			if(isDead == false){
				enableInput();
				running=false;
				minDistanceBetweenOldAndNewTargets = minDistanceBetweenOldAndNewTargets_walk;
				maxDistanceBetweenOldAndNewTargets = maxDistanceBetweenOldAndNewTargets_walk;
				anim_walk();
			}
		}
		
		private function LOOK_UPWARDS_handler():void{
			this.eyes.gotoAndPlay("meteor");
				enableInput();
		}
		
		
		
		public function setBehaviorState(newState:String):void{
			//trace("setBehaviorState",newState);
			behaviorState = newState;
			switch (newState){
				case "null":
					break;
				case "NONE":
					particleSystem.playMode(behaviorState);
					break;
				case "EXPLODED":
					EXPLODED_handler();
					break;
				case "SQUISHED":
					SQUISHED_handler();
					break;
				case "FIRE":
					FIRE_handler();
					break;
				case "CRISPY":
					CRISPY_handler();
					break;
				case "COIN":
					COIN_handler();
					break;
				case "C_FIRE_COIN":
					C_FIRE_COIN_handler();
					break;
				case "METEOR":
					METEOR_handler();
					break;
				case "BULL":
					BULL_handler();
					break;
				case "LOOK_UPWARDS":
					LOOK_UPWARDS_handler();
					break;
				case "HOP":
					HOP_handler();
					break;
				case "LOVE":
					LOVE_handler();
					break;
				case "SQUISHED_WALK":
					SQUISHED_WALK_handler();
					break;
				case "LIFT":
					LIFT_handler();
					break;
				case "FALL":
					FALL_handler();
					break;
				case "WALK":
					WALK_handler();
					break;
			}
		}
		
		private function do_stuff_to_active_followers_inside_the_click_radius_excluding_this(newState:String):void{
			var followers:Array = Main.getFollowerManager().checkForClickRadius();
			for each( var follower:Follower in followers){
				if(follower != this){
					if(follower.behaviorState != "SQUISHED" && 
						follower.behaviorState != "COIN" && 
						follower.behaviorState != "C_FIRE_COIN" && 
						follower.behaviorState != "EXPLODED" && 
						follower.behaviorState != "NONE" && 
						follower.behaviorState != "CRISPY"){
						follower.setBehaviorState(newState);
					}
				}
			}
		}
		
		private function disableInput():void{
			this.eyes.burnMask.mouseEnabled=false;
			this.eyes.burnMask.mouseChildren=false;
			this.mouseEnabled=false;
			this.mouseChildren=false;
		}
		
		private function enableInput():void{
			this.eyes.burnMask.mouseEnabled=true;
			this.eyes.burnMask.mouseChildren=true;
			this.mouseEnabled=true;
			this.mouseChildren=true;
		}
		
		private function setToDead():void{
			isDead = true;
			//abortInput();
			this.eyes.burnMask.mouseEnabled=false;
			this.eyes.burnMask.mouseChildren=false;
			//this.mouseEnabled=false;
			//this.mouseChildren=false;
		}
		
		private function anim_meteorLook():void{
			this.gotoAndPlay("meteor");
			this.eyes.gotoAndPlay("meteor");
			setToDead();
		}
		
		private function anim_hop():void{
			this.gotoAndStop("hop");
			this.eyes.gotoAndPlay("coinLook");
			var animOffset:int = Math.random()*8;
			animOffset+=this.currentFrame;
			this.gotoAndPlay(animOffset);
			
			//setToDead();
		}
		
		private function anim_eyes(animLabel:String):void{
			
			try {
				this.eyes.gotoAndStop(animLabel);
			}
			catch(error:Error){
				//don't report error 
			}
						
			
		}
		
		private function anim_ressurected():void{
			this.gotoAndPlay("ressurected");
		}
		
		private function anim_ressurecting():void{
			this.gotoAndPlay("ressurecting");
		}
		
		private function anim_lifted():void{
			this.gotoAndPlay("lifted");
		}
		
		private function anim_squished():void{
			this.gotoAndPlay("squished");
		}
		
		private function anim_exploded():void{
			this.gotoAndPlay("exploded");
		}
		
		private function anim_coin():void{
			this.gotoAndPlay("coin");
		}
		
		private function anim_fire():void{
			this.gotoAndPlay("fire");
		}
		
		private function anim_crispy():void{
			this.gotoAndPlay("crispy");
		}
		
		private function anim_walk():void{
			this.gotoAndStop("walk");
		}
		
		private function anim_falling():void{
			
		}
		
		private function selectNewLerpMultiplier(currentBehaviorState:String):void{
			switch (currentBehaviorState){
				case "null":
					break;
				case "NONE":
					break;
				case "FIRE":
					setMultiplier(multiplier_fire,multiplier_fire);
					break;
				case "COIN":
					break;
				case "METEOR":
					break;
				case "LOVE":
					break;
				case "LIFT":
					setMultiplier(multiplier_lift_X,multiplier_lift_Y);
					break;
				case "WALK":
					multiplier = lerpMin + Math.random()* lerpMax;
					setMultiplier(multiplier,0);
					break;
				case "SQUISHED_WALK":
					setMultiplier(multiplier_squishedWalk,multiplier_squishedWalk);
					break;
			}
			
		}
		
		private function selectNewTargetRotation():void{
			targetRotation = 45 - (Math.random()*90);
			 
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
			anim_eyes("center");
		}
		
		public function updateLoop():void{
			if(behaviorState == "LOVE_SQUISHED"){
				//walk();
			}
			if(behaviorState == "SQUISHED_WALK"){
				onSquishedWalk();
			}
			if(behaviorState == "LOVE_CRISPY"){
				//walk();
			}
			
			if(behaviorState == "LOVE_FIRE"){
				walk();
			}
			if(behaviorState == "WALK"){
				walk();
			}
			if(behaviorState == "C_FIRE_COIN"){
				onFire_Coin();
			}
			if(behaviorState == "FIRE"){
				onFire();
			}
			if(behaviorState == "LIFT"){
				if(isDead == false){
					lift();
				}
			}
			if(behaviorState == "LOVE"){
				love();
			}
			if(behaviorState == "FALL"){
				setScreenBounds();
				fall();
			}
			if(behaviorState == "COIN"){
				//setScreenBounds();
				onCoin();
			}
			if(behaviorState == "METEOR"){
				//setScreenBounds();
				//fall();
			}
			if(behaviorState == "SQUISHED"){
				//setScreenBounds();
					
				onSquished();
			}
			if(behaviorState == "HOP"){
				//setScreenBounds();
				onHop();
			}
			calculateVelocity();
			calculatePreviousPositions();
			calculateShadows();
			
		}
		
		private function calculateShadows():void{
			if(isDead == false){
				this.shadow.alpha = ((this.y/2)/groundPlane*2)
				this.shadow.y = ((19.85*getScale())+groundPlane-this.y)/getScale();
				this.shadow.x = ((groundPlane-this.y)/getScale())/5;
				if(this.y > groundPlane){
					this.shadow.alpha = 1;
					this.shadow.y = 19.85;
					this.shadow.x = 0;
				}
			}else{
				this.shadow.alpha = 0;
				this.shadow.y = 19.85;
				this.shadow.x = 0;
			}
		}
		
		private function chanceToSpeak():void{
			var chance = Math.round(Math.random()*100000);
			if(chance > 99995){
				triggerNewSpeechBubble();
			}
		}
		
		private function calculatePreviousPositions():void{
			previousPosition.x = this.x;
			previousPosition.y = this.y;
		}
		
		private function calculateVelocity():void{
			velocity.x = this.x-previousPosition.x;
			velocity.y = this.y-previousPosition.y;
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
			screenBounds = Main.theStage.width - (Main.theStage.width-Main.originalStageX)/2;
		}
		
		public function startBounce():void{
			
		}
		
		//if the guy isn't dead, then allow him to be thrown
		public function startToss(tossValue:Number,tossMode:String="none"):void{
			var preBullAlpha:Number=this.eyes.burnMask.alpha;
			if(behaviorState != "SQUISHED" 
			   && behaviorState != "COIN" 
			   && behaviorState != "EXPLODED" 
			   && behaviorState != "FALL" 
			   && behaviorState != "NONE"
			   && isBeingTossed == false){
				this.y-=2;
				isBeingTossed=true;
				switch(tossMode){
					case "bull":
						var bullModifier:Number = Math.random()*150 -75;
						velocity.y = -.3*Math.abs((200+bullModifier)/tossValue);
						velocity.x = bullModifier/10;
						break;
					case"none":
						velocity.y = -.3*Math.abs(800/tossValue);
						velocity.x = -tossValue/50;
						if(behaviorState != "CRISPY"){
							var setOnFireChance:Number = Math.random()*10;
							if(setOnFireChance>9.5){
								setBehaviorState("FIRE");
							}
						}
						break;
				}
				setBehaviorState("FALL");
			}
			this.eyes.burnMask.alpha=preBullAlpha;
		}
		
		private function onHop():void{
			if(this.eyes.currentLabel == "coinLook_end"){
				setBehaviorState("WALK");
			}
		}
		private function fall():void{
				this.x += velocity.x * friction;
				this.y += velocity.y + currentGravity;
				increaseGravity();
			if(velocity.y < maxYVelocity){
				velocity.y = maxYVelocity;
			}
			if(this.y < groundPlane){
				//this.alpha=.5;
				
				if(this.x > screenBounds){
					velocity.x*=-1;
				}
				if(this.x < 0){
					velocity.x*=-1;
				}
				
			}else{
				var preBullAlpha:Number=this.eyes.burnMask.alpha;
				this.y = groundPlane;
				resetGravity();
				isBeingTossed=false;
				//this.alpha=1;
				if(velocity.y >= 30){
					setBehaviorState("SQUISHED");
					setToDead();
					enableInput();
					Main.getStage().setScreenShake(true,"COIN");
				}else if(running){
					setBehaviorState("FIRE");
					enableInput();
				}else if(walking){
					setBehaviorState("WALK");
					enableInput();
					selectNewWalkTarget();
					resumeWalking();
				}else if(isCrispy){
					enableInput();
					setBehaviorState("CRISPY");
					this.gotoAndStop("crispy_end");
				}else{
					enableInput();
					setBehaviorState("WALK");
					selectNewWalkTarget();
					resumeWalking();
				}
				
			this.eyes.burnMask.alpha=preBullAlpha;
			}
		}
		
		private function resetGravity():void{
			currentGravity = originalGravity;
		}
		
		private function increaseGravity():void{
			currentGravity += gravityIncrement;
		}
		
		private function onCoin():void{
			if(this.currentLabel == "coinPop"){
				particleSystem.playMode(behaviorState);
			}
			if(this.currentLabel == "coinEnd"){
				Main.getStage().setScreenShake(true,"COIN");
				setBehaviorState("EXPLODED");
			}
		}
		
		private function onSquished():void{
			isSquished = true;
			particleSystem.playMode(behaviorState);
			if(this.currentLabel != "squished_end"){
				particleSystem.playMode("SQUISHED");
			}
			if(this.currentLabel == "squished_end"){
				particleSystem.playMode(behaviorState);
				setBehaviorState("NONE");
			}
		}
		
		private function onFire_Coin():void{
			try {
				if(this.eyes.burnMask.alpha < 1){
					this.eyes.burnMask.alpha+=.005;
				}
			}
			catch(error:Error){
			}
			chanceToSpeak();
			if(is_C_FIRE_COIN){
				setToDead();
				
				if(this.rotation < targetRotation){
					this.rotation+=.5;
				}if(this.rotation > targetRotation){
					this.rotation-=.5;
				}
				
				rocketVelocity.x += ((Math.cos(rotation-.001 / (180 * Math.PI))))*.5;
       			rocketVelocity.y -= (1-Math.sin(rotation-.001 / (180 * Math.PI)))/25;
				this.x+=rocketVelocity.x;
				this.y+=rocketVelocity.y;
				if(Math.abs(targetRotation-this.rotation) < 5){
					selectNewTargetRotation();
				}
				
				if(this.y<200){
					particleSystem.playMode(behaviorState);
				}
				if(this.y<-100){
					setBehaviorState("NONE");
					particleSystem.playMode(behaviorState);
				}
				
			}
		}
		
		private function onSquishedWalk():void{
			
			//trace("onWalk");
			chanceToSpeak();
			if(walking == false){
				pauseTime--;
				if(pauseTime > 0){
				}else if(pauseTime==0){
					resumeWalking();
				}
			}
			
			if(walking){
				var lerpAmount:Number =  (walkTarget-this.x)*multiplier;
				
				this.x += lerpAmount;
				if(Math.abs(walkTarget-this.x) < 50){
					pauseWalking();
				}
			}
		}
		
		private function onFire():void{
			try {
				if(this.eyes.burnMask.alpha < 1){
					this.eyes.burnMask.alpha+=.005;
				}
			}
			catch(error:Error){
			}
			chanceToSpeak();
			var lerpAmount:Number =  (walkTarget-this.x)*multiplier_fire;
			this.x += lerpAmount;
			if(Math.abs(walkTarget-this.x) < 1){
				selectNewWalkTarget();
			}
			if(fireTime > maxFireTime){
				setBehaviorState("CRISPY");
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
			//trace("onWalk");
			chanceToSpeak();
			anim_walk();
			if(walking == false){
				pauseTime--;
				if(pauseTime > 0){
				}else if(pauseTime==0){
					resumeWalking();
				}
			}
			
			if(walking){
				var lerpAmount:Number =  (walkTarget-this.x)*multiplier;
				
				this.x += lerpAmount;
				if(Math.abs(walkTarget-this.x) < 50){
					pauseWalking();
				}
			}
		}
	}
}