package{
	import flash.display.MovieClip
	import flash.geom.Point;
	public class P_C extends Particle{
		private var scaleMultiplier:Number=1.08
		public function P_C(){
			
		}
		
		public override function setRotationValue():void{
			rotationValue = addSomeRandom()/5;
		}
		
		public override function setGravity():void{
			gravity=-0.5;
			gravityIncrement=+.015;
			//this.alpha=.5;
		}
		
		public override function addSomeRandom():Number{
			var randomValue:Number= 3-(Math.random()*6);
			return randomValue;
		}
		
		public override function doSpecial():void{
			this.scaleX*=scaleMultiplier;
			this.scaleY*=scaleMultiplier;
			scaleMultiplier-=.003;
		}
	}
}