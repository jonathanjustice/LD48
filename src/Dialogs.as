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
		
		
		private var lift_worship:Array = new Array();
		private var lift_happy:Array = new Array();
		private var lift_indifferent:Array = new Array();
		private var lift_upset:Array = new Array();
		private var lift_angry:Array = new Array();
		private var lift_furious:Array = new Array();
		private var lift_dying:Array = new Array();
		private var lift_crazy:Array = new Array();
		
		private var fire_worship:Array = new Array();
		private var fire_happy:Array = new Array();
		private var fire_indifferent:Array = new Array();
		private var fire_upset:Array = new Array();
		private var fire_angry:Array = new Array();
		private var fire_furious:Array = new Array();
		private var fire_dying:Array = new Array();
		private var fire_crazy:Array = new Array();
		
		private var coin_worship:Array = new Array();
		private var coin_happy:Array = new Array();
		private var coin_indifferent:Array = new Array();
		private var coin_upset:Array = new Array();
		private var coin_angry:Array = new Array();
		private var coin_furious:Array = new Array();
		private var coin_dying:Array = new Array();
		private var coin_crazy:Array = new Array();
		
		private var meteor_worship:Array = new Array();
		private var meteor_happy:Array = new Array();
		private var meteor_indifferent:Array = new Array();
		private var meteor_upset:Array = new Array();
		private var meteor_angry:Array = new Array();
		private var meteor_furious:Array = new Array();
		private var meteor_dying:Array = new Array();
		private var meteor_crazy:Array = new Array();
		
		
		private var C_FIRE_COIN_worship:Array = new Array();
		private var BULL_worship:Array = new Array();
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
			lift_worship = ["I am chosen!",
							"Leader has chosen me.",
							"Leader carries me to the heavens.",
							"Leader gives me the power to fly!",
							"Those below me do not give worship as I do.",
							"Flight is the gift of Leader.",
							"Carry me to the heavens oh great Leader.",
							"Praise Leader, I never wish to touch the ground.",
							"The winds of the Leader lift me high."
							]
			fire_worship = ["Leader's love burns me.",
							"Leader blesses me with fire.",
							"The flames are Leader's love!",
							"Leader gives me fire!",
							"I brun with Leader's love",
							"I am Leader's torch!",
							"I am Leader's light!",
							"I am bestowed with fire. Leader chooses me."
							]
			coin_worship = ["I fill the Leader's coffers!",
							"Leader values me!",
							"Leader says I'm worth it.",
							"My happiness is Leader's true wealth.",
							"Leader says money buys happiness.",
							"Leader blesses me with gold!",
							"Leader makes my heaven golden.",
							"Leader paves the streets with gold!",
							]
			meteor_worship = ["Leader gives me the sky!",
							"Leader brings the sky to me!",
							"Leader makes the heavens reach to me.",
							"A star is Leader's gift to me.",
							"Leader's glowing love approaches!",
							"I see Leader!",
							"Leader is coming for me!",
							"A gift of love from Leader",
							]
			C_FIRE_COIN_worship = ["asdasdasdasd",
							"asdasdasdasd!",
							"asdasdasd.",
							"Aasdasdasdasde.",
							"Leasdasdasdasdoaches!",
							"Iasdasdasdader!",
							"Leadasdasdasdme!",
							"Aasdasdasdader",
							]
			BULL_worship = ["asdasdasdasd",
							"asdasdasdasd!",
							"asdasdasd.",
							"Aasdasdasdasde.",
							"Leasdasdasdasdoaches!",
							"Iasdasdasdader!",
							"Leadasdasdasdme!",
							"Aasdasdasdader",
							]
			
		}
		
		public function selectDialog(arrayName:String):String{
			var activeArray:Array = new Array();
			switch(arrayName){
				case "C_FIRE_COIN_worship":
					activeArray = C_FIRE_COIN_worship;
					break;
				case "BULL_worship":
					activeArray = BULL_worship;
					break;
				
				
				
				case "WALK_worship":
					activeArray = walk_worship;
					break;
				case "WALK_happy":
					activeArray = walk_happy;
					break;
				case "WALK_indifferent":
					activeArray = walk_indifferent;
					break;
				case "WALK_upset":
					activeArray = walk_upset;
					break;
				case "WALK_angry":
					activeArray = walk_angry;
					break;
				case "WALK_furious":
					activeArray = walk_furious;
					break;
				case "WALK_dying":
					activeArray = walk_dying;
					break;
				case "WALK_crazy":
					activeArray = walk_crazy;
					break;
					
				case "LIFT_worship":
					activeArray = lift_worship;
					break;
				case "LIFT_happy":
					activeArray = lift_happy;
					break;
				case "LIFT_indifferent":
					activeArray = lift_indifferent;
					break;
				case "LIFT_upset":
					activeArray = lift_upset;
					break;
				case "LIFT_angry":
					activeArray = lift_angry;
					break;
				case "LIFT_furious":
					activeArray = lift_furious;
					break;
				case "LIFT_dying":
					activeArray = lift_dying;
					break;
				case "LIFT_crazy":
					activeArray = lift_crazy;
					break;
				
				case "FIRE_worship":
					activeArray = fire_worship;
					break;
				case "FIRE_happy":
					activeArray = fire_happy;
					break;
				case "FIRE_indifferent":
					activeArray = fire_indifferent;
					break;
				case "FIRE_upset":
					activeArray = fire_upset;
					break;
				case "FIRE_angry":
					activeArray = fire_angry;
					break;
				case "FIRE_furious":
					activeArray = fire_furious;
					break;
				case "FIRE_dying":
					activeArray = fire_dying;
					break;
				case "FIRE_crazy":
					activeArray = fire_crazy;
					break;
					
				case "COIN_worship":
					activeArray = coin_worship;
					break;
				case "COIN_happy":
					activeArray = coin_happy;
					break;
				case "COIN_indifferent":
					activeArray = coin_indifferent;
					break;
				case "COIN_upset":
					activeArray = coin_upset;
					break;
				case "COIN_angry":
					activeArray = coin_angry;
					break;
				case "COIN_furious":
					activeArray = coin_furious;
					break;
				case "COIN_dying":
					activeArray = coin_dying;
					break;
				case "COIN_crazy":
					activeArray = coin_crazy;
					break;
					
				case "METEOR_worship":
					activeArray = meteor_worship;
					break;
				case "METEOR_happy":
					activeArray = meteor_happy;
					break;
				case "METEOR_indifferent":
					activeArray = meteor_indifferent;
					break;
				case "METEOR_upset":
					activeArray = meteor_upset;
					break;
				case "METEOR_angry":
					activeArray = meteor_angry;
					break;
				case "METEOR_furious":
					activeArray = meteor_furious;
					break;
				case "METEOR_dying":
					activeArray = meteor_dying;
					break;
				case "METEOR_crazy":
					activeArray = meteor_crazy;
					break;
			}
			
			var dialogIndex:Number = Math.floor(Math.random()*activeArray.length);
			//trace("activeArray:",activeArray);
			//trace(dialogIndex);
			return activeArray[dialogIndex];
		}
	}
}
		