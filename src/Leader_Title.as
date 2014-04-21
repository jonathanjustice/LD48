package{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.*;
	import customEvents.*;
	public class Leader_Title extends default_screen{
		private var screenLerpX:Number=.07;
		private var screenLerpY:Number=.07;
		//fire
		private var currency_1:int=0;
		//squish
		private var currency_2:int=0;
		//coin
		private var currency_3:int=0;
		private var currencyArray:Array;
		private var buildRequirements:BuildRequirements = new BuildRequirements();
		public function Leader_Title(){
			arrangeScreen();
			setUp();
			trace(buildRequirements);
		}
		
		public function addCurrency(event:CurrencyEvent):void {
			switch(event.result){
				case "currency_COIN":
					currency_1 += event.C_amount;
					break;
				case "currency_FIRE":
					currency_2 += event.C_amount;;
					break;
				case "currency_SQUISH":
					currency_3 += event.C_amount;;
					break;
			}
			currencyArray = [currency_1,currency_2,currency_3,0];
			buildRequirements.setBuildStatus(currencyArray);
			var buildPercent:Number = buildRequirements.getCurrentTotalStatus();
			Main.getStage().dispatchEvent(new ScreenEvent("BUILD_PROGRESS","Statue_base","",buildPercent));
		}
		
		public function deductCurrency(event:CurrencyEvent):void {
			switch(event.result){
				case "currency_COIN":
					currency_1 -= event.C_amount;
					break;
				case "currency_FIRE":
					currency_2 -= event.C_amount;
					break;
				case "currency_SQUISH":
					currency_3 -= event.C_amount;
					break;
			}
			currencyArray = [currency_1,currency_2,currency_3,0];
			buildRequirements.setBuildStatus(currencyArray);
		}
		
		public function updateLoop(e:Event):void{
			updateResources();
		}
		
		public function updateResources():void{
			var current_txt_currency_1:Number = Number(txt_currency_1.text);
			var current_txt_currency_2:Number = Number(txt_currency_2.text);
			var current_txt_currency_3:Number = Number(txt_currency_3.text);
			if(current_txt_currency_1 < currency_1){
				current_txt_currency_1 += 1;
			}
			if(current_txt_currency_2 < currency_2){
				current_txt_currency_2 += 1;
			}
			if(current_txt_currency_3 < currency_3){
				current_txt_currency_3 += 1;
			}
			if(current_txt_currency_1 > currency_1){
				current_txt_currency_1 -= 1;
			}
			if(current_txt_currency_2 > currency_2){
				current_txt_currency_2 -= 1;
			}
			if(current_txt_currency_3 > currency_3){
				current_txt_currency_3 -= 1;
			}
			txt_currency_1.text = String(current_txt_currency_1);
			txt_currency_2.text = String(current_txt_currency_2);
			txt_currency_3.text = String(current_txt_currency_3);
			
			
			/*
			txt_currency_1.text = String(currency_1);
			txt_currency_2.text = String(currency_2);
			txt_currency_3.text = String(currency_3);*/
		}
		
		public function getCurrency_1():int{
			return currency_1;
		}
		
		public function getCurrency_2():int{
			return currency_2;
		}
		
		public function getCurrency_3():int{
			return currency_3;
		}
		
		private function arrangeScreen():void{
			currencyArray = new Array();
			this.y = -250;
			stop();
			setMultiplier(screenLerpX,screenLerpY);
			this.mouseEnabled=false;
			this.mouseChildren=false;
			Main.theStage.addEventListener(CurrencyEvent.CURRENCY_ADD, addCurrency);
			Main.theStage.addEventListener(CurrencyEvent.CURRENCY_DEDUCT, deductCurrency);
			updateResources();
			
			Main.getStage().dispatchEvent(new CurrencyEvent("CURRENCY_ADD","currency_1",32));
			Main.getStage().dispatchEvent(new CurrencyEvent("CURRENCY_DEDUCT","currency_1",19));
			Main.getStage().dispatchEvent(new CurrencyEvent("CURRENCY_ADD","currency_2",232));
			Main.getStage().dispatchEvent(new CurrencyEvent("CURRENCY_ADD","currency_3",32333));
			updateScreenLocation();
			stopAllButtonsFromAnimating();
			this.addEventListener(Event.ENTER_FRAME, updateLoop);
		}
		
		public function updateScreenLocation():void{
			//desiredX = Main.theStage.stageWidth - (Main.theStage.stageWidth-Main.originalStageX)/2;
			desiredY = 0;
			
		}
	}
}