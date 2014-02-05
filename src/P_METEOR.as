package{
	import flash.display.MovieClip
	import flash.geom.Point;
	public class P_METEOR extends Particle{
		private var scaleMultiplier:Number=1.08;
		private var desiredX:Number=0;
		private var desiredY:Number=0;
		private var multiplierX:Number=.015;
		private var collisionTime:int=0;
		private var particleSystem:ParticleSystem;
		//private var velocity:Point=new Point();
		private var previousPosition:Point=new Point();
		private var myFollower:MovieClip=new MovieClip();
		public function P_METEOR(){
			meteor_dirt.visible=false;
			meteor_top.visible=true;
			meteor_bottom.visible=true;
			disabledMouseInteraction();
		}
		
		private function disabledMouseInteraction():void{
			this.mouseEnabled=false;
			this.mouseChildren=false;
			meteor_dirt.mouseEnabled=false;
			meteor_top.mouseEnabled=false;
			meteor_bottom.mouseEnabled=false;
			meteor_dirt.mouseChildren=false;
			meteor_top.mouseChildren=false;
			meteor_bottom.mouseChildren=false;
		}
		
		public override function doSpecial():void{
			collisionTime++;
			lerp();
			
			checkForImpact();
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
		
		public function getScale():Number{
			return this.scaleX;
		}
		
		public function setFollower(newFollower:MovieClip):void{
			myFollower = newFollower;
		}
		
		public override function defineSpawnPoint(spawnLocation:Point,spawnVelocity:Point,spawnScale:Number):void{
			
			setLifeTime();
			desiredX = spawnLocation.x;
			desiredY = spawnLocation.y;
			setRotationValue();
			
			addSomeRandom();
			scale = Math.abs(spawnScale);
			this.scaleX = scale;
			this.scaleY = scale;
			this.x+=(4.5*scale)+spawnLocation.x + addSomeRandom()*125;
			this.y+= ((10*scale)+spawnLocation.y )-700 + addSomeRandom();
			setGravity();
			//this.y=5;
			//velocity.x = spawnVelocity.x/25 + addSomeRandom();
			//velocity.y = Math.abs(spawnVelocity.y/25 + addSomeRandom());
			//trace("override");
			particleSystem = new ParticleSystem(this);
			particleSystem.playMode("METEOR_FALL");
			//Main.getStage().setScreenShake(true,"METEOR_FALL");
			
			
		}
		
		private function checkForImpact():void{
			if(this.y > desiredY){
				meteor_dirt.visible=true;
				meteor_top.visible=true;
				meteor_bottom.visible=false;
				setIsActive(false);
				this.y=desiredY+10*scale;
				//trace("this.y",this.y);
				this.particleSystem.playMode("NONE");
				timeExisted=950;
				myFollower.setBehaviorState("SQUISHED");
				Main.getFollowerManager().tossAllFollowers(this);
				disabledMouseInteraction();
				Main.getStage().setScreenShake(true,"METEOR_IMPACT");
			}
		}
		
		public override function doSpecialInactiveStuff():void{
			timeExisted++;
			if(timeExisted > lifeTime){
				particleSystem.abortAll();
			}
		}
		
		private function lerp():void{
			var lerpAmountX:Number = (desiredX-this.x)*multiplierX;
			this.x += lerpAmountX;
			//trace("lerpAmountX",lerpAmountX);
			//trace("desiredX",desiredX);
			//trace("this.x",this.x);
		}
		
		public override function setGravity():void{
			gravity=0.1*scale;
			gravityIncrement=.001*scale;
			multiplierX = .055
			//this.alpha=.5;
		}
		
		public override function setLifeTime():void{
			lifeTime = 1000;
		}
		
		public override function addSomeRandom():Number{
			var randomValue:Number= 2.5-(Math.random()*5);
			return randomValue;
		}
		
		
	}
}