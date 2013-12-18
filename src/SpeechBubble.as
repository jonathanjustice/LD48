package{
	import flash.display.MovieClip;
	import flash.events.*;
	public class SpeechBubble extends MovieClip{
		private var bubbleText:String = "";
		private var typeCounter:int=0;
		private var typeCounterMax:int=1;
		private var typeIncrement:int=0;
		private var lettersArray:Array = new Array();
		private var myFollower:MovieClip;
		private var timeExisted:int=0;
		private var lifeTime:int=400;
		
		private var markedForDeletion:Boolean=false;
		public function SpeechBubble(follower:MovieClip,dialog:String="threeve"){
			//trace("speechbubble");
			myFollower = follower;
			defineText(dialog);
			this.mouseEnabled=false;
			this.mouseChildren=false;
		}
		
		public function getFollower():MovieClip{
			return myFollower;
		}
		
		public function updateLoop():void{
			
			this.x = myFollower.x;
			this.y = myFollower.y;
		}
		
		public function defineText(newString:String):void{
			//trace("newString:",newString);
			//trace("newString.length:",newString.length);
			//bubbleText = newString;
			for(var i:int=0;i< newString.length;i++){
				lettersArray.push(newString.charAt(i));
			}
			this.addEventListener(Event.ENTER_FRAME, typeText);
		}
		
		private function typeText(event:Event):void{
			if(this.currentLabel == "speechActive"){
				if(typeCounter > typeCounterMax){
					if(typeIncrement < lettersArray.length){
						//trace("typing");
						bubbleText +=  lettersArray[typeIncrement];
						//trace(bubbleText);
						bubble_txt.text = bubbleText;
						typeCounter=0;
						typeIncrement++;
					}else{
						//this.removeEventListener(Event.ENTER_FRAME, typeText);
					}
				}
				timeExisted++;
				typeCounter++;
				if(timeExisted>lifeTime){
					//trace("beyond lifetime");
					this.scaleX-=.05;
					this.scaleY-=.05;
					if(this.scaleX < .05){
						//trace("too small");
						this.removeEventListener(Event.ENTER_FRAME, typeText);	
						markForDeletion();
					}
				}
			}
		}
		
		public function setTimeExistedToMaxLifeTime():void{
			timeExisted = lifeTime;
		}
		
		public function markForDeletion():void{
			markedForDeletion = true;
		}
		
		public function getMarkedForDeletion():Boolean{
			return markedForDeletion;
		}
	}
}