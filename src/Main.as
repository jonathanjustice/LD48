package {
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.*;
	import flash.events.MouseEvent;
	public class Main extends MovieClip{
		public static var dialogs:Dialogs;
		public static var followerManager:FollowerManager;
		public static var actionManager;ActionManager;
		public static var actionIndicator_mouse:ActionIndicator_mouse;
		public static var theStage:Object;
		private var actionMenu:ActionMenu;
		private var stageNode:StageNode;
		public static var originalStageX:int=800;
		public function Main() {
			if (stage) init();
            else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		//once the stage exists, launch the game
        private function init(e:Event = null):void {
			theStage = this.stage;
            removeEventListener(Event.ADDED_TO_STAGE, init);
			setUp();
        }
		
		private function setUp():void{
			dialogs = new Dialogs();
			actionMenu = new ActionMenu();
			actionIndicator_mouse = new ActionIndicator_mouse();
			actionManager = new ActionManager();
			followerManager = new FollowerManager();
			stageNode = new StageNode();
			stageNode.visible=false;
			stage.addChild(stageNode);
			followerManager.setUp();
			this.addEventListener(Event.ENTER_FRAME, updateScreenLocations);
		}
		
		private function updateScreenLocations(e:Event):void{
			//trace("stage.width",stage.width);
			//trace("stage.stageWidth",stage.stageWidth);
			actionMenu.updateScreenLocation();
			actionMenu.lerpToPosition();
			actionIndicator_mouse.setMouseCoordinates(stage.mouseX,stage.mouseY);
			actionIndicator_mouse.lerpToPosition();
		}
		
		public static function getDialogs():Dialogs{
			return dialogs;
		}
		
		public static function getActionManager():ActionManager{
			return actionManager;
		}
		
		public static function getFollowerManager():FollowerManager{
			return followerManager;
		}
		
		public static function getActionIndicator_mouse():ActionIndicator_mouse{
			return actionIndicator_mouse;
		}
		
		public static function requestMouseCoordinates(follower:MovieClip):void{
			follower.setMouseCoordinates(theStage.mouseX,theStage.mouseY);
		}
		
		/*
		public function getStage():Object{
			return theStage;
		}*/
	}
}
	