package{
	import customEvents.*;
	public class BuildRequirements{
		private var c_build_reqs:Array;
		private var c_build_percent:Array;
		private var c_build_status:Array;
		private var s_feet_reqs:Array;
		private var totalStatus:Number;
		private var buildComplete:Boolean=false;
		public function BuildRequirements(){
			s_feet_reqs = new Array();
			c_build_reqs = new Array();
			c_build_status = new Array();
			c_build_percent = new Array();
			setBuildRequirments();
		}
		
		
		//coin
		//fire
		//squish
		//hearts
		
		public function setBuildStatus(currencyArray:Array){
			c_build_status = currencyArray;
			trace(c_build_status);
			checkForRequirementsMet();
		}
		
		public function setBuildRequirments():void{
			s_feet_reqs = [1000,900,225,0];
		}
		
		public function getCurrentBuildStatus():Array{
			return c_build_status;
		}
		
		public function getCurrentBuildPercent():Array{
			return c_build_percent;
		}
		
		public function getCurrentTotalStatus():Number{
			return totalStatus;
		}
		
		public function checkForRequirementsMet():void{
			totalStatus=0;
			var numerator:Number=0;
			var denomenmator:Number=0;
			var allRequirementsMet:Boolean=true;
			for(var i:int=0;i<c_build_status.length;i++){
				numerator += c_build_status[i];
				denomenmator += s_feet_reqs[i];
				if(c_build_status[i] < s_feet_reqs[i]){
					allRequirementsMet = false;
				}
				totalStatus = numerator / denomenmator;
				totalStatus = Math.round(totalStatus*100);
				c_build_percent[i] = s_feet_reqs[i] / c_build_reqs[i];
			}
			trace(totalStatus);
			if(allRequirementsMet == true){
				buildComplete = true;
			}
		}
		
		
	}
}