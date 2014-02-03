package{
	import flash.display.MovieClip
	import flash.geom.Point;
	public class P_BULL_DUST extends Particle{
		private var scaleMultiplier:Number=1.08;
		private var groundPlane:Number=0;
		private var runningDirection:String="";
		public function P_BULL_DUST(){
			
		}
		
		public function setRunningDirection(newDir:String):void{
			runningDirection = newDir;
		}
		
		public override function defineSpawnPoint(spawnLocation:Point,spawnVelocity:Point,spawnScale:Number):void{
			scale = Math.abs(spawnScale);
			setLifeTime();
			setRotationValue();
			this.x+=spawnLocation.x;
			//this.x+=(4.5*scale)+spawnLocation.x + addSomeRandom();
			this.y+=(4.5*scale)+spawnLocation.y + addSomeRandom();
			if(runningDirection == "LEFT"){
				this.x += 40*scale;
			}else{
				this.x -= 40*scale;
			}
			
			
			//addSomeRandom();
			this.scaleX = scale;
			this.scaleY = scale;
			//this.x+=  addSomeFrontRandom();
			//this.y+=  (scale*(addSomeFrontRandom()*10))-15;
			velocity.x = (velocity.x/10)-.1;
			velocity.y = (velocity.y/2);
			this.scaleX +=addSomeFrontRandom();
			this.scaleY = this.scaleX;
			setGravity();
			
		}
		
		public function setGroundPlane(newGroundPlane:Number):void{
			groundPlane = newGroundPlane;
		}
		
		public override function setGravity():void{
			gravity=-0.1;
			gravityIncrement=-.01;
			//this.alpha=.5;
		}
		
		public function addSomeRearRandom():Number{
			var randomValue:Number= 0-(Math.random()*55);
			return randomValue;
		}
		
		public function addSomeFrontRandom():Number{
			var randomValue:Number= 3-(Math.random()*6);
			return randomValue;
		}
		
		public override function addSomeRandom():Number{
			var randomValue:Number= 2-(Math.random()*4);
			return randomValue;
		}
		
		public override function doSpecial():void{
			
			if(this.y > groundPlane){
				
				velocity.y *=-.9;
				//velocity.x*=1.1;
			}
			this.scaleX*=scaleMultiplier;
			this.scaleY*=scaleMultiplier;
			scaleMultiplier-=.003;
		}
	}
}