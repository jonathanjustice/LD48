package{
	import flash.display.MovieClip
	import flash.geom.Point;
    import flash.filters.BitmapFilter;
    import flash.filters.BitmapFilterQuality;
    import flash.filters.GlowFilter;
	import customEvents.SoundEvent;
	public class P_BULL extends Particle{
		private var scaleMultiplier:Number=1.08;
		private var desiredX:Number=0;
		private var desiredY:Number=0;
		private var multiplierX:Number=.015;
		private var collisionTime:int=0;
		private var particleSystem:ParticleSystem;
		//private var particleSystem2:ParticleSystem;
		//private var velocity:Point=new Point();
		private var previousPosition:Point=new Point();
		private var myFollower:MovieClip=new MovieClip();
		private var bullDirection:String="";
		private var followerID:int=0;
		public function P_BULL(){
			/*meteor_dirt.visible=false;
			meteor_top.visible=true;
			meteor_bottom.visible=true;*/
			disabledMouseInteraction();
			//                                         (color,alpha,blurX,blurY,strength,quality,innerglow,knockout)
			var glowFilter:GlowFilter = new GlowFilter(0x000000, 1.0, 5.0, 5.0, 40,1,false,false);
			this.filters = [glowFilter];
		}
		
		public function assignID(newID):void{
			followerID = newID;
		}
		
		private function disabledMouseInteraction():void{
			this.mouseEnabled=false;
			this.mouseChildren=false;
			
		}
		
		public override function doSpecial():void{
			checkForImpact();
			checkForExitScreen();
		}
		
		public function getDesiredY():Number{
			return desiredY;
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
		
		public function getFireLocation():Point{
			var xDir
			if(bullDirection == "LEFT"){
				xDir = this.x+60;
			}else if(bullDirection == "RIGHT"){
				xDir = this.x-80;
			}
			var loc:Point = new Point(xDir,this.y-30);
			return loc;
		}
		
		public function getScale():Number{
			return this.scaleX;
		}
		
		public function setFollower(newFollower:MovieClip):void{
			myFollower = newFollower;
		}
		
		public override function defineSpawnPoint(spawnLocation:Point,spawnVelocity:Point,spawnScale:Number):void{
			scale = Math.abs(spawnScale);
			this.scaleX = scale;
			this.scaleY = scale;
			if(Math.random()*10<5){
				this.x = -50;
				desiredX = 950;
				velocity.x=1.5;
				this.scaleX = -scale;
			}else{
				this.x = 850;
				desiredX = -150;
				velocity.x=-1.5;
			}
			velocity.y=0;
			this.y+= 19*scale+spawnLocation.y;
			setLifeTime();
			setRotationValue();
			setGravity();
			particleSystem = new ParticleSystem(this);
			//particleSystem2 = new ParticleSystem(this);
			if(velocity.x > 0){
				bullDirection = "RIGHT";
				particleSystem.playMode("BULL_DUST_RIGHT");
			}else{
				bullDirection = "LEFT";
				particleSystem.playMode("BULL_DUST_LEFT");
			}
			Main.getStage().setScreenShake(true,"BULL_CHARGE");
		}
		
		public function setOnFire():void{
			if(velocity.x > 0){
				particleSystem.playMode("BULL_DUST_RIGHT_FIRE");
			}else{
				particleSystem.playMode("BULL_DUST_LEFT_FIRE");
			}
		}
		
		private function checkForExitScreen():void{
			//1300
			//-500
			if(this.x > 1300 || this.x < -500) {
				particleSystem.abortAll();
				Main.getStage().dispatchEvent(new SoundEvent("SOUND_FADE_OUT_DISPATCHER_ONLY","BULL_STAMPEDE",followerID));
				//particleSystem.playMode("NONE");
				Main.getStage().setScreenShake(false,"NONE");
				timeExisted = 9999;
			}
		}
	
		private function checkForImpact():void{
			if(this.hitbox.hitTestObject(myFollower)){
				
				if(myFollower.getBullCollision()==false){
					Main.getStage().dispatchEvent(new SoundEvent("SOUND_START","BULL_BUMP",followerID));
					setOnFire();
					//setIsActive(false);
					//this.particleSystem.playMode("NONE");
					myFollower.startToss(5,"bull");
					Main.getStage().setScreenShake(true,"BULL_IMPACT");
					//myFollower.setBehaviorState("SQUISHED");
					//Main.getFollowerManager().tossAllFollowers(this);
					//disabledMouseInteraction();
					//trace("bull");
				}
				
				myFollower.setBullCollision(true);
			}else{
				myFollower.setBullCollision(false);
			}
		}
		
		public override function doSpecialInactiveStuff():void{
			
			//trace("timeExisted",timeExisted);
			timeExisted++;
			if(timeExisted > lifeTime){
				trace("doSpecialInactiveStuff");
				//markForDeletion();
				
				//particleSystem2.abortAll();
				//particleSystem.abortAll();
			}
		}
		
		public override function setGravity():void{
			gravity=0;
			gravityIncrement=0;
			multiplierX = 0;
			//this.alpha=.5;
		}
		
		public override function setLifeTime():void{
			lifeTime = 1000;
		}
	}
}