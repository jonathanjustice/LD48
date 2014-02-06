package utilities.customEvents {
import flash.events.Event;
	public class StateMachineEvent extends Event {
		public static const BOOT:String = "boot";
		public static const START_SCREEN:String = "startScreen";
		public static const CONTINUECODE_SCREEN:String = "continueCodeScreen";
		public static const START_LEVEL_LOAD:String = "startLevelLoad";
		public static const LEVEL_CURRENTLY_LOADING:String = "levelCurrentlyLoading";
		public static const LEVEL_FULLY_LOADED:String = "levelFullyLoaded";
		public static const IN_LEVEL:String = "inLevel";
		public static const LEVEL_COMPLETE:String = "levelComplete";
		public static const LEVEL_FAILED:String = "levelFailed";
		public static const GAME_OVER:String = "gameOver";
		public static const GAME_WON:String = "gameWon";
		public static const START_INGAME_CUTSCENE:String = "startInGameCutScene";
		public static const CUTSCENE_CURRENTLY_LOADING_TRIGGER:String = "cutSceneCurrentlyLoading_Trigger";
		public static const START_CUTSCENE_LOAD:String = "startCutSceneLoad";
		public static const CUTSCENE_CURRENTLY_LOADING:String = "cutSceneCurrentlyLoading";
		public static const CUTSCENE_FULLY_LOADED:String = "cutSceneFullyLoaded";
		public static const IN_CUTSCENE:String = "inCutScene";
		public static const CUTSCENE_COMPLETE:String = "cutSceneComplete";
		public static const INLEVEL_CUTSCENE:String = "inLevelCutScene";
		public static const WORLD_MAP:String = "worldMap";
		public static const TEST_EVENT:String = "testEvent";
		public function StateMachineEvent(type:String,bubbles:Boolean=true) {
			super(type);
			trace("type",type);
		}
	}
}
