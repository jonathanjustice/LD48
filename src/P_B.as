package{
	import flash.display.MovieClip
	import flash.geom.Point;
	public class P_B extends Particle{
		private var scaleMultiplier:Number=1.08;
		public function P_B(){
			
		}
		
		public override function setRotationValue():void{
			rotationValue = addSomeRandom();
		}
		
		public override function setGravity():void{
			gravity=-0.5;
			gravityIncrement=+.03;
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