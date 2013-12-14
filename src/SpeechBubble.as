package{
	import flash.display.MovieClip;
	import flash.events.*;
	public class SpeechBubble extends MovieClip{
		private var bubbleText:String = "";
		private var typeCounter:int=0;
		private var typeCounterMax:int=5;
		private var typeIncrement:int=0;
		private var lettersArray:Array = new Array();
		private var myFollower:MovieClip;
		public function SpeechBubble(follower:MovieClip,dialog:String="threeve"){
			trace("speechbubble");
			myFollower = follower;
			defineText(dialog);
		}
		
		public function updateLoop():void{
			this.x = myFollower.x;
			this.y = myFollower.y;
		}
		
		public function defineText(newString:String):void{
			//trace(newString);
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
					this.removeEventListener(Event.ENTER_FRAME, typeText);
				}
			}
			typeCounter++;
			}
		}
	}
}