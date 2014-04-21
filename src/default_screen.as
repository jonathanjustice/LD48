package {
	import flash.events.MouseEvent;
	import flash.events.*;
	import flash.display.MovieClip;
	import Screen_Dynamic_Blocker;
	
	public class default_screen extends MovieClip{
		private var blocker:Screen_Dynamic_Blocker;
		private var myScreen:MovieClip;//or replace with swf eventually
		private var actorGraphic:MovieClip;
		private var animationState:String = "idle"
		private var hasBlocker:Boolean = false;
		public var desiredX:int=0;
		public var desiredY:int=0;
		private var multiplierX:Number=.1;
		private var multiplierY:Number=.1;
		private var lerping:Boolean=true;
		private var screenID:String="";
		
		public function Screen_Default(){
			setUp();
			defineScreenID();
			getScreenID();
			trace("default screen");
		}
		
		public function defineScreenID():void{
			screenID = String(this);
		}
		
		public function getScreenID():String{
			return screenID;
			//trace("screenID",screenID);
		}
		
		public function setMultiplier(newAmountX:Number,newAmountY:Number):void{
			multiplierX = newAmountX;
			multiplierY = newAmountY;
		}
		
		public function lerpToPosition():void{
			if(lerping){
				var lerpAmountX:Number = (desiredX-this.x)*multiplierX;
				this.x += lerpAmountX;
				var lerpAmountY:Number = (desiredY-this.y)*multiplierY;
				this.y += lerpAmountY;
			}
			if(Math.abs(desiredX-this.x) > 0){
				resumeLerping();
			}
			doSpecial();
		}
		
		public function doSpecial():void{
			//do stuff in descendent classes
			
		}
		
		public function resumeLerping():void{
			lerping = true;
		}
		
		public function pauseLerping():void{
			lerping = false;
		}
		
		public function stopAllButtonsFromAnimating():void {
			//trace("stopAllButtonsFromAnimating");
			for (var i:int = 0; i < this.numChildren; i++) {
				if (this.getChildAt(i) is MovieClip) {	
					if (this.getChildAt(i).name.indexOf("btn_") != -1) {
						dumbButtonStoppingWorkaround(this.getChildAt(i) as MovieClip);
					}
				}
			}
		}
		
		public function stopAllStatuePartsFromAnimating():void {
			//trace("stopAllButtonsFromAnimating");
			for (var i:int = 0; i < this.numChildren; i++) {
				if (this.getChildAt(i) is MovieClip) {	
					if (this.getChildAt(i).name.indexOf("statue_") != -1) {
						dumbButtonStoppingWorkaround(this.getChildAt(i) as MovieClip);
					}
				}
			}
		}
		
		private function dumbButtonStoppingWorkaround(movieClip:MovieClip):void{
			movieClip.stop();
		}
			
			
			public function removeAllListeners():void{
				removeClickHandler();
				removeStageClickHandler();
				removeOverHandler();
				removeDownHandler();
				removeUpHandler();
				removeOutHandler();
			}
			
			public function addAllListeners():void{
				addClickHandler();
				addStageClickHandler();
				addOverHandler();
				addDownHandler();
				addUpHandler();
				addOutHandler();
			}
		
		public function setUp():void {
			//addDynamicBlocker();
			mouseEnabledHandler();
			addAllListeners();
			addScreenToUIContainer();
		}
		
		//CLICKING ON THIS SCREEN
		public function addClickHandler():void{
			this.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		public function removeClickHandler():void{
			this.removeEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		public function clickHandler(event:MouseEvent):void{
			//defined in other classes
		}
		
		//CLICKING ON STAGE
		public function addStageClickHandler():void{
			Main.theStage.addEventListener(MouseEvent.CLICK, stageClickHandler);
		}
		
		public function stageClickHandler(event:MouseEvent):void{
			//defined in other classes
		}
		
		public function removeStageClickHandler():void{
			Main.theStage.removeEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		//MOUSING DOWN
		public function addDownHandler():void{
			this.addEventListener(MouseEvent.MOUSE_DOWN, downHandler);
		}
		
		public function removeDownHandler():void{
			this.removeEventListener(MouseEvent.MOUSE_DOWN, downHandler);
		}
		
		public function downHandler(event:MouseEvent):void {
			//trace(event.target.name);
			if (event.target.name.indexOf("hitbox") != -1) {
				event.target.parent.gotoAndStop("clicked");
			}
		}
		
		//MOUSING UP
		public function addUpHandler():void{
			this.addEventListener(MouseEvent.MOUSE_UP, upHandler);
		}
		
		public function removeUpHandler():void{
			this.removeEventListener(MouseEvent.MOUSE_UP, upHandler);
		}
		
		public function upHandler(event:MouseEvent):void {
			//trace(event.target.name);
			if (event.target.name.indexOf("hitbox") != -1) {
				event.target.parent.gotoAndStop("up");
			}
		}
		
		//MOUSEING OVER
		public function addOverHandler():void{
			this.addEventListener(MouseEvent.MOUSE_OVER, overHandler);
		}
		
		public function removeOverHandler():void{
			this.removeEventListener(MouseEvent.MOUSE_OVER, overHandler);
		}
		
		public function overHandler(event:MouseEvent):void {
			//trace(event.target.name);
			if (event.target.name.indexOf("hitbox") != -1) {
				event.target.parent.gotoAndStop("over");
			}
		}
		
		public function mouseEnabledHandler():void{
			
		}
		
		//MOUSING OUT
		public function addOutHandler():void{
			this.addEventListener(MouseEvent.MOUSE_OUT, outHandler);
		}
		
		public function removeOutHandler():void{
			this.removeEventListener(MouseEvent.MOUSE_OUT, outHandler);
		}
		
		public function outHandler(event:MouseEvent):void {
			//trace(event.target.name);
			if (event.target.name.indexOf("hitbox") != -1) {
				event.target.parent.gotoAndStop("up");
			}
		}
		
		private function addDynamicBlocker():void{
			blocker = new Screen_Dynamic_Blocker;
			this.addChild(blocker)
			hasBlocker = true;
		}
		
		private function removeDynamicBlocker():void{
			
			if (hasBlocker) {
				this.removeChild(blocker);
			}
		}
		
		private function updateDynamicBlocker():void{
			blocker.update_dynamic_blocker_because_the_screen_was_resized();
		}
		
		/*public function addScreenToGame(){
			//utilities.Engine.Game.gameContainer.addChild(this);
			utilities.Engine.UIManager.uiContainer.addChild(this);
			
		}
		*/
		public function addScreenToUIContainer():void{
			Main.theStage.addChild(this);
		}
		
		public function setDesiredLerpPoint(newX:Number,newY:Number):void{
			desiredX = newX;
			desiredY = newY;
		}
		
		public function setMouseCoordinates(newX:Number,newY:Number):void{
			desiredX = newX;
			desiredY = newY;
		}
		
		//removing the screen
		public function removeThisScreen():void{
			removeAllListeners();
			removeDynamicBlocker();
			Main.theStage.removeChild(this);
		}
	}
}