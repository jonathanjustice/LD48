package{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.*;
	import flash.geom.Point;
	public class TheStage extends default_screen{
		private var screenLerpX:Number=.37;
		private var screenLerpY:Number=.37;
		
		private var shakeTimer:int=0;
		private var maxShakeTime=30;
		private var originalMaxShakeTime:int=30;
		private var shakeCount:int=0;
		private var isShaking:Boolean=false;
		private var shakeMode:String="NONE";
		private var previousShakeMode:String="NONE";
		private var shakeRandomNess:Point = new Point();
		private var screenFlash;
		
		
		public function TheStage(newScreenFlash){
			screenFlash = newScreenFlash;
			trace("TheStage",this);
			//trace(Main.theStage.width);
			setUp();
			arrangeScreen();
			resetScreenFlash();
			setMultiplier(screenLerpX,screenLerpY);
			resetShakeRandomNess();
			resetShake();
		}
		
		public function resetScreenFlash():void{
			Main.getScreenFlash().visible=false;
		}
		
		public function setScreenFlash(newAlpha:Number):void{
			Main.getScreenFlash().alpha = newAlpha;
				Main.getScreenFlash().visible = true;
		}
		
		public function updateScreenFlash():void{
			//trace("screenFlash",screenFlash );
			if(screenFlash.alpha > 0){
				screenFlash.alpha -= .05;
			}else{
				screenFlash.visible = false;
				screenFlash.alpha = 0;
			}
		}
		
		private function arrangeScreen():void{
			//trace("arrange");
			updateScreenLocation();
			stopAllButtonsFromAnimating();
		}
		
		public function updateScreenLocation():void{
			//desiredX = Main.theStage.width - (Main.theStage.width-Main.originalStageX);
			//desiredY = 0;
			screenShake();
			lerpToPosition();
			updateScreenFlash();
		}
		
		private function resetShakeRandomNess():void{
			shakeRandomNess.x=20;
			shakeRandomNess.y=10;
		}
		
		private function resetShake():void{
			maxShakeTime = originalMaxShakeTime;
			setMultiplier(.37,.37);
			desiredX = 0;
			desiredY = 0;
		}
		
		public function setScreenShake(newState:Boolean,newMode:String="NONE"):void{
			//trace("setScreenShake",shakeMode);
			isShaking = newState;
			previousShakeMode = shakeMode;
			shakeMode = newMode;
			switch(shakeMode){
				case "NONE":
				
					shakeTimer=0;
					isShaking = false;
					resetShake();
					break;
				case "BULL_CHARGE":
					shakeTimer=0;
					maxShakeTime = 9999;
					shakeRandomNess.x=10;
					shakeRandomNess.y=5;
					break;
				case "BULL_IMPACT":
					maxShakeTime=30;
					shakeRandomNess.x=50;
					shakeRandomNess.y=25;
					break;
				case "METEOR_FALL":
				
					break;
				case "METEOR_IMPACT":
					shakeTimer=0;
					maxShakeTime = 10;
					this.y+=25;
					shakeRandomNess.x=20;
					shakeRandomNess.y=10;
					setScreenFlash(1);
					break;
				case "COIN":
					//trace("SQUISH");
					shakeTimer=0;
					maxShakeTime = 10;
					this.y-=10;
					shakeRandomNess.x=20;
					shakeRandomNess.y=10;
					break;
			}
		}
		
		public function screenShake():void{
			//trace("screenShake");
			if(isShaking == true){
				shakeTimer++
				desiredX = Math.random()*shakeRandomNess.x - shakeRandomNess.y;
				desiredY = Math.random()*shakeRandomNess.x - shakeRandomNess.y;
			}
			if(shakeTimer >= maxShakeTime){
				screenShakeComplete();
			}
		}
		
		public function screenShakeComplete():void{
			//trace("screenShakeComplete",shakeMode);
			switch(shakeMode){
				case "NONE":
					//sdfjsd;fjsd
					break;
				case "BULL_IMPACT":
					setScreenShake(true,"BULL_CHARGE");
					break;
				case "METEOR_FALL":
					//sdfsdfsdfsdf
					break;
				case "METEOR_IMPACT":
					//sdfsdfsdfsdf
					setScreenShake(false,"NONE");
					break;
				case "COIN":
					//sdfsdfsdfsdf
					setScreenShake(false,"NONE");
					break;
			}
		}
		
		public override function setUp():void {
			//addDynamicBlocker();
			//addClickHandler();
			//addOverHandler();
			//addDownHandler();
			//addUpHandler();
			//addOutHandler();
			//mouseEnabledHandler();
			//addScreenToUIContainer();
		}
	}
}