package{
	public class Dialogs{
		private var walk_worship:Array = new Array();
		private var walk_happy:Array = new Array();
		private var walk_indifferent:Array = new Array();
		private var walk_upset:Array = new Array();
		private var walk_angry:Array = new Array();
		private var walk_furious:Array = new Array();
		private var walk_dying:Array = new Array();
		private var walk_crazy:Array = new Array();
		public function Dialogs(){
			defineDialogs();
		}
		
		private function defineDialogs():void{
			walk_worship = ["I sure do love our almighty leader.",
							"I can't belive Leader allows me in his presence.",
							"I wish that I could devote all my time to Leader.",
							"Leader hears and answers my prayers.",
							"My life is for bringing glory to Leader.",
							"Today is the best day of my life. I will see Leader.",
							"Today is the day. I will be touched by Leader.",
							"Praise Leader.",
							"I can feel Leader in my heart."
							
							]
		}
		
		public function selectDialog(arrayName:String):String{
			var activeArray:Array = new Array();
			switch(arrayName){
				case "walk_worship":
					activeArray = walk_worship;
					break;
				case "walk_happy":
					activeArray = walk_happy;
					break;
				case "walk_indifferent":
					activeArray = walk_indifferent;
					break;
				case "walk_upset":
					activeArray = walk_upset;
					break;
				case "walk_angry":
					activeArray = walk_angry;
					break;
				case "walk_furious":
					activeArray = walk_furious;
					break;
				case "walk_dying":
					activeArray = walk_dying;
					break;
				case "walk_crazy":
					activeArray = walk_crazy;
					break;
			}
			
			var dialogIndex:Number = Math.floor(Math.random()*activeArray.length);
			//trace("activeArray:",activeArray);
			//trace(dialogIndex);
			return activeArray[dialogIndex];
		}
	}
}
		