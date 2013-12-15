package{
	import flash.display.MovieClip;
	import flash.geom.Point;
	public class Particle extends MovieClip{
		public  var timeExisted:int=0;
		public var lifeTime:int=44;
		public var velocity:Point = new Point();
		private var friction:Number = 0.95;
		public var gravity:Number=0;
		public var gravityIncrement:Number=.05;
		private var markedForDeletion:Boolean=false;
		public var scale:Number=0;
		public var rotationValue:Number=0;
		public var isActive:Boolean=true;
		public var initialSpawnVel:Point=new Point();
		public function Particle(){
			
		}
		
		public function setLifeTime():void{
			//lifeTime = 44;
		}
		
		public function setIsActive(newState:Boolean):void{
			isActive = newState;
		}
		
		public function defineSpawnPoint(spawnLocation:Point,spawnVelocity:Point,spawnScale:Number):void{
			initialSpawnVel = spawnVelocity;
			setLifeTime();
			setRotationValue();
			setGravity();
			addSomeRandom();
			scale = spawnScale;
			this.scaleX = spawnScale;
			this.scaleY = spawnScale;
			this.x+=(4.5*spawnScale)+spawnLocation.x + addSomeRandom();
			this.y+=(10*spawnScale)+spawnLocation.y + addSomeRandom();
			if(this is P_B){
				this.y-= 35*spawnScale;
			}
			velocity.x = spawnVelocity.x/25 + addSomeRandom();
			velocity.y = spawnVelocity.y/25 + addSomeRandom();
			
			/*
			
			trace(parent);
			//var index:int = parent.getChildIndex(parent);
			Main.theStage.addChildAt(this,0);
			*/
		}
		
		public function addSomeRandom():Number{
			var randomValue:Number= 5-(Math.random()*10);
			return randomValue;
		}
		
		public function setGravity():void{
			//child classes do this
		}
		
		public function setRotationValue():void{
			//child classes do this
		}
		
		public function updateLoop():void{
			if(isActive){
				this.rotation+=rotationValue;
				gravity+=gravityIncrement;
				velocity.y+=gravity;
				//trace("particle" );
				this.x+=velocity.x*friction*scale;
				this.y+=velocity.y*friction*scale;
				doSpecial();
				timeExisted++;
				if(timeExisted > lifeTime){
					//trace("timeExisted > lifeTime");
					//trace("actual lifeTime:",lifeTime);
					markForDeletion();
				}
			}else if(!isActive){
				doSpecialInactiveStuff();
			}
		}
		
		public function doSpecialInactiveStuff():void{
			//child classes do this
		}
		
		public function doSpecial():void{
			//child classes do this
		}
		
		public function markForDeletion():void{
			//trace("markForDeletion()");
			markedForDeletion = true;
		}
		
		public function getMarkedForDeletion():Boolean{
			return markedForDeletion;
		}
	}
}
