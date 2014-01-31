package{
	import flash.display.MovieClip
	import flash.geom.Point;
    import flash.filters.BitmapFilter;
    import flash.filters.BitmapFilterQuality;
    import flash.filters.GlowFilter;
	public class P_BULL extends Particle{
		private var scaleMultiplier:Number=1.08;
		private var desiredX:Number=0;
		private var desiredY:Number=0;
		private var multiplierX:Number=.015;
		private var collisionTime:int=0;
		private var particleSystem:ParticleSystem;
		//private var velocity:Point=new Point();
		private var previousPosition:Point=new Point();
		private var myFollower:MovieClip=new MovieClip();
		public function P_BULL(){
			/*meteor_dirt.visible=false;
			meteor_top.visible=true;
			meteor_bottom.visible=true;*/
			disabledMouseInteraction();
			//                                         (color,alpha,blurX,blurY,strength,quality,innerglow,knockout)
			var glowFilter:GlowFilter = new GlowFilter(0x000000, 1.0, 5.0, 5.0, 40,1,false,false);
			this.filters = [glowFilter];
		}
		
		private function disabledMouseInteraction():void{
			this.mouseEnabled=false;
			this.mouseChildren=false;
			
		}
		
		public override function doSpecial():void{
			collisionTime++;
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
			scale = Math.abs(spawnScale);
			this.scaleX = scale;
			this.scaleY = scale;
			if(Math.random()*10<5){
				this.x = 150;
				desiredX = 950;
				velocity.x=1.5;
				this.scaleX = -scale;
			}else{
				this.x = 650;
				desiredX = -150;
				velocity.x=-1.5;
			}
			velocity.y=0;
			this.y+= 19*scale+spawnLocation.y;
			setLifeTime();
			setRotationValue();
			setGravity();
			particleSystem = new ParticleSystem(this);
			if(velocity.x > 0){
				particleSystem.playMode("BULL_DUST_RIGHT");
			}else{
				particleSystem.playMode("BULL_DUST_LEFT");
			}
			
		}
		
		private function checkForImpact():void{
			if(this.hitTestObject(myFollower)){
				//setIsActive(false);
				//this.particleSystem.playMode("NONE");
				myFollower.startToss(5,"bull");
				//myFollower.setBehaviorState("SQUISHED");
				//Main.getFollowerManager().tossAllFollowers(this);
				//disabledMouseInteraction();
				//trace("bull");
			}
		}
		
		public override function doSpecialInactiveStuff():void{
			
			//trace("timeExisted",timeExisted);
			timeExisted++;
			if(timeExisted > lifeTime){
				//trace("doSpecialInactiveStuff");
				//markForDeletion();
				
				particleSystem.abortAll();
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