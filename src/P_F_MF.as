package{
	import flash.display.MovieClip
	import flash.geom.Point;
	public class P_F_MF extends Particle{
		private var scaleMultiplier:Number=1.08;
		private var groundPlane:Number=0;
		public function P_F_MF(){
			
		}
		
		public function setGroundPlane(newGroundPlane:Number):void{
			groundPlane = newGroundPlane;
		}
		
		public function fireMode(newMode:String):void{
			if(newMode == "trail"){
				lifeTime = 45;
				gravity=0.3;
				gravityIncrement=-.015;
				this.x+=  addSomeFrontRandom();
				this.y+=  (scale*(addSomeFrontRandom()*10))-15;
				velocity.x = velocity.x/2;
				velocity.y = velocity.y/2;
				this.scaleX +=addSomeFrontRandom();
				this.scaleY = this.scaleX;
			}
			if(newMode == "ball"){
				lifeTime = 25;
				gravity=0.2;
				gravityIncrement=-.005;
				//this.x+=(4.5*scale)+this.x + addSomeRearRandom();
				this.y+= 20*scale;
				velocity.x = velocity.x*1.2;
				velocity.y = initialSpawnVel.y +addSomeFrontRandom()+1;
				this.scaleX +=addSomeFrontRandom();
				this.scaleY = this.scaleX;
			}
		}
		
		
		
		public override function setGravity():void{
			gravity=0.4;
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