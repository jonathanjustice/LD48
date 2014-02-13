package {
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.*;
	import flash.events.MouseEvent;
	import flash.display.*;
	import flash.ui.Mouse;
	import Audio.SoundManager;
	import Audio.SoundObject;
	public class Main extends MovieClip{
		public static var dialogs:Dialogs;
		public static var theStage:TheStage;
		public static var followerManager:FollowerManager;
		public static var actionManager:ActionManager;
		public static var screenFlash_FULL:screenFlash_Full;
		public static var actionIndicator_mouse:ActionIndicator_mouse;
		public static var uiContainter:Object;
		private var actionMenu:ActionMenu;
		private var editMenu:EditMenu;
		private var leader_Title:Leader_Title;
		private var stageNode:StageNode;
		public static var originalStageX:int=800;
		private var bg_art:BG_art = new BG_art;
		private var soundManager:SoundManager;
		
		
		
		
		public function Main() {
			if (stage) init();
            else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		//once the stage exists, launch the game
        private function init(e:Event = null):void {
            removeEventListener(Event.ADDED_TO_STAGE, init);
			//stage.scaleMode = StageScaleMode.NO_SCALE;
			
			//stage.scaleMode = StageScaleMode.NO_SCALE;
			
			stage.scaleMode = StageScaleMode.EXACT_FIT;
			//stage.displayState = StageDisplayState.FULL_SCREEN;
			setUp();
        }
		//Main.theStage.dispatchEvent(new SoundEvent("SOUND_START","ENEMY_PICKED_UP"));
		private function setUp():void{
			
			screenFlash_FULL = new screenFlash_Full();
			theStage = new TheStage(screenFlash_FULL);
			soundManager = new SoundManager(theStage);
			leader_Title = new Leader_Title();
			uiContainter = stage;
			theStage.addChildAt(bg_art,0);
			stage.addChildAt(theStage,1);
			theStage.hitbox.visible=false;
			stage.addChildAt(leader_Title,2);
			stage.addChild(screenFlash_FULL);
			Mouse.hide();
			addKeyboardInput();
			dialogs = new Dialogs();
			actionMenu = new ActionMenu();
			
			actionIndicator_mouse = new ActionIndicator_mouse();
			actionManager = new ActionManager();
			followerManager = new FollowerManager();
			followerManager.setUp();
			editMenu = new EditMenu();
			this.addEventListener(Event.ENTER_FRAME, updateScreenLocations);
		}
		
		private function addKeyboardInput():void{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, restartGame);
		}
		
		private function removeKeyboardInput():void{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, restartGame);
		}
		
		private function restartGame(event:KeyboardEvent):void{
			trace(event.keyCode);
			if(event.keyCode == 32 || event.keyCode == 82){
				trace("game should restart here");
				
				//cleareverything
				Mouse.hide();
				removeKeyboardInput();
				stage.removeChild(leader_Title);
				leader_Title = null;
				
				stage.removeChild(bg_art);
				bg_art = null;
				dialogs = null;
				dialogs = new Dialogs();
				actionMenu.removeThisScreen();
				actionMenu = null;
				
				actionIndicator_mouse.removeThisScreen();
				actionIndicator_mouse = null;
				actionManager.destroy();
				actionManager = null;
				followerManager.destroy();
				followerManager = null;
				this.removeEventListener(Event.ENTER_FRAME, updateScreenLocations);
			}
		}
		
		private function updateScreenLocations(e:Event):void{
			//trace("stage.width",stage.width);
			//trace("stage.stageWidth",stage.stageWidth);
			actionMenu.updateScreenLocation();
			uiContainter.setChildIndex(actionIndicator_mouse, parent.numChildren-1)
			actionMenu.lerpToPosition();
			editMenu.lerpToPosition();
			theStage.updateScreenLocation();
			actionIndicator_mouse.setMouseCoordinates(stage.mouseX,stage.mouseY);
			actionIndicator_mouse.lerpToPosition();
			leader_Title.lerpToPosition();
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
		
		public static function getScreenFlash():screenFlash_Full{
			return screenFlash_FULL;
		}
		
		public static function getStage():Object{
			return theStage;
		}
		
		public static function getNewStage():Object{
			return uiContainter;
		}
	}
}
	