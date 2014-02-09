package{
	import flash.display.MovieClip
	import flash.geom.Point;
	public class P_HEART extends Particle{
		private var scaleMultiplier:Number=1.005
		private var speed:Number=2;
		private var waveHeight:Number = 20;
		private var waveLength:Number = 8;
		private var yStartPosition:Number=0;
		private var xStartPosition:Number=0;
		//private var lifeTime:int=500;
		public function P_HEART(){
			//trace("i exist, somwerhe?");
		}
		
		public override function defineSpawnPoint(spawnLocation:Point,spawnVelocity:Point,spawnScale:Number):void{
			//trace("x",this.x);
			//trace("y",this.y);
			lifeTime = 150;
			initialSpawnVel = spawnVelocity;
			setLifeTime();
			setRotationValue();
			setGravity();
			addSomeRandom();
			scale = Math.abs(spawnScale);
			this.scaleX = scale *.5;
			this.scaleY = scale *.5;
			this.x+=(4.5*scale)+spawnLocation.x ;
			xStartPosition = this.x;
			yStartPosition = spawnLocation.y*scaleMultiplier;
			this.y+=(10*scale)+spawnLocation.y + addSomeRandom();
			//defineSpecialCaseStats();
			waveHeight += addSomeRandom()*5;
			waveLength += addSomeRandom()*5;
			speed += addSomeRandom()*5;
			this.mouseEnabled=false;
			this.mouseChildren=false;
			
		}
		
		public override function doSpecial():void{
			//collisionTime++;
			//lerp();
			floatAround();
			//checkForImpact();
			this.scaleX*=scaleMultiplier;
			this.scaleY*=scaleMultiplier;
			//scaleMultiplier-=.0021;
		}
		
		public override function updateLoop():void{
			if(isActive){
				doSpecial();
				timeExisted++;
				if(timeExisted > lifeTime){
					markForDeletion();
				}
			}else if(!isActive){
				doSpecialInactiveStuff();
			}
		}
		
		
		private function floatAround():void{
			this.y -= speed;
			//this.x = (Math.sin(this.y / waveLength) * waveHeight) + yStartPosition;
			// this.y -= speed;
      	 	 this.x = (Math.sin(this.y*scaleMultiplier / waveLength) * waveHeight) + xStartPosition;
			
		}
		
		public override function setGravity():void{
			gravity=0.1;
			gravityIncrement=-.01;
			//this.alpha=.5;
		}
		
		public override function addSomeRandom():Number{
			var randomValue:Number= .25-(Math.random()*.5);
			return randomValue;
		}
	}
}