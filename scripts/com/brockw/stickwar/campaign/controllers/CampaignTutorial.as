package com.brockw.stickwar.campaign.controllers
{
   import com.brockw.stickwar.GameScreen;
   import com.brockw.stickwar.campaign.*;
   import com.brockw.stickwar.engine.Ai.*;
   import com.brockw.stickwar.engine.Ai.command.*;
   import com.brockw.stickwar.engine.Hill;
   import com.brockw.stickwar.engine.StickWar;
   import com.brockw.stickwar.engine.Team.*;
   import com.brockw.stickwar.engine.multiplayer.moves.*;
   import com.brockw.stickwar.engine.units.*;
   import com.brockw.stickwar.engine.units.elementals.*;
   import flash.events.*;
   
   public class CampaignTutorial extends CampaignController
   {
      
      private static const S_SET_UP:int = -1;
      
      private static const S_BOX_UNITS:int = 0;
      
      private static const S_MOVE_UNITS:int = 1;
      
      private static const S_MOVE_SCREEN:int = 2;
      
      private static const S_ATTACK_UNITS:int = 3;
      
      private static const S_MOVE_TO_BASE:int = 4;
      
      private static const S_SELECT_MINER:int = 5;
      
      private static const S_START_MINING:int = 6;
      
      private static const S_SELECT_SECOND_MINER:int = 7;
      
      private static const S_PRAY:int = 8;
      
      private static const S_BUILD_UNIT:int = 9;
      
      private static const S_SHOW_ENEMY:int = 10;
      
      private static const S_SPEARTON_ATTACKING:int = 11;
      
      private static const S_GARRISON:int = 12;
      
      private static const S_CLICK_ON_ARCHERY_RANGE:int = 13;
      
      private static const S_UPGRADE_CASTLE_ARCHER:int = 14;
      
      private static const S_SEND_IN_SPEARTON:int = 15;
      
      private static const S_HIT_DEFEND:int = 16;
      
      private static const S_KILL_SPEARTON:int = 17;
      
      private static const S_COMBINE:int = 18;
      
      private static const S_GOOD_LUCK:int = 19;
      
      private static const S_GOOD_LUCK_2:int = 21;
      
      private static const S_ALL_DONE:int = 20;
      
      private static const S_TALK_ABOUT_BUILDINGS:int = 22;
      
      private static const S_SELECT_MINER_2:int = 23;
      
      private static const S_PRAY_INFO:int = 23;
      
      private static const S_GOLD_INFO:int = 24;
      
      private static const S_PRESS_ATTACK_WAIT:int = 25;
      
      private static const S_PRESS_ATTACK:int = 26;
      
      private static const S_LAG_WAIT:int = 27;
      
      private static const S_LAG:int = 28;
      
      private static const S_PICK_MINER:int = 29;
       
      
      private var state:int;
      
      private var bruh:Boolean = false;
      
      private var help:Boolean = false;
      
      private var s1:ChromeElement;
      
      private var s2:EarthElement;
      
      private var s3:WaterElement;
      
      private var o1:Cat;
      
      private var m1:ElementalMiner;
      
      private var m2:ElementalMiner;
      
      private var spearton1:Knight;
      
      internal var popBefore:int;
      
      private var counter:int;
      
      private var message:InGameMessage;
      
      private var message2:InGameMessage;
      
      private var message3:InGameMessage;
      
      private var tip:InGameMessage;
      
      private var frames:int;
      
      private var miniMessage:InGameMessage;
      
      private var arrow:tutorialArrow;
      
      private var spawnSpeartonCounter:int;
      
      private var skipTutorialButton:skipTutorial;
      
      private var _gameScreen:GameScreen;
      
      private var hasShownhillTip:Boolean;
      
      private var frameShownHillTip:int;
      
      private var hasShownBuildSwordwrath:Boolean;
      
      private var hasSpawnedSpearton:Boolean;
      
      public function CampaignTutorial(param1:GameScreen)
      {
         super(param1);
         this.hasShownBuildSwordwrath = false;
         this._gameScreen = param1;
         this.state = S_SET_UP;
         this.spawnSpeartonCounter = -1;
         this.skipTutorialButton = new skipTutorial();
         this.frameShownHillTip = 0;
         this.hasShownhillTip = false;
         this.skipTutorialButton.addEventListener(MouseEvent.CLICK,this.skipTutorialClick,false,0,true);
         this.miniMessage = null;
         this.message = null;
         this.hasSpawnedSpearton = false;
      }
      
      private function skipTutorialClick(param1:Event) : void
      {
         this.state = S_ALL_DONE;
         var _loc2_:StickWar = this._gameScreen.game;
         _loc2_.team.enemyTeam.spawnUnitGroup([Unit.U_CHAOS_MINER,Unit.U_CHAOS_MINER,Unit.U_CHAOS_MINER,Unit.U_CHAOS_MINER,Unit.U_CHAOS_MINER,Unit.U_CHAOS_MINER,Unit.U_KNIGHT,Unit.U_KNIGHT,Unit.U_DEAD,Unit.U_DEAD]);
         _loc2_.team.spawnUnitGroup([Unit.U_MINER_ELEMENT,Unit.U_MINER_ELEMENT,Unit.U_MINER_ELEMENT,Unit.U_EARTH_ELEMENT,Unit.U_EARTH_ELEMENT,Unit.U_EARTH_ELEMENT,Unit.U_EARTH_ELEMENT]);
         _loc2_.team.defend(true);
         this.skipTutorialButton.removeEventListener(MouseEvent.CLICK,this.skipTutorialClick);
         this.message.visible = false;
         if(this._gameScreen.contains(this.skipTutorialButton))
         {
            this._gameScreen.removeChild(this.skipTutorialButton);
         }
         if(this._gameScreen.contains(this.arrow))
         {
            this._gameScreen.removeChild(this.arrow);
         }
         this._gameScreen.team.gold = 550;
         this._gameScreen.team.mana = 175;
         this._gameScreen.userInterface.isSlowCamera = false;
         CampaignGameScreen(this._gameScreen).doAiUpdates = true;
         this._gameScreen.userInterface.isGlobalsEnabled = true;
         this._gameScreen.team.tech.isResearchedMap[Tech.CASTLE_ARCHER_1] = 1;
         this._gameScreen.team.enemyTeam.tech.isResearchedMap[Tech.CASTLE_ARCHER_2] = 1;
      }
      
      override public function update(param1:GameScreen) : void
      {
         var _loc2_:Hill = null;
         var _loc3_:StickWar = null;
         var _loc4_:ChromeElement = null;
         var _loc5_:EarthElement = null;
         var _loc6_:ElementalMinerAi = null;
         var _loc7_:Unit = null;
         var _loc8_:UnitMove = null;
         var _loc9_:Unit = null;
         var _loc10_:UnitMove = null;
         var _loc11_:Knight = null;
         var _loc12_:Boolean = false;
         var _loc13_:Boolean = false;
         var _loc14_:WaterElement = null;
         var _loc15_:EarthElement = null;
         super.update(param1);
         if(param1.game.showGameOverAnimation)
         {
            return;
         }
         if(this.message)
         {
            this.message.update();
         }
         if(this.miniMessage)
         {
            this.miniMessage.update();
         }
         if(this.message2 && param1.contains(this.message2))
         {
            this.message2.update();
            if(this.frames++ > 30 * 3)
            {
               param1.removeChild(this.message2);
            }
         }
         if(this.message3 && param1.contains(this.message3))
         {
            this.message3.update();
            if(this.frames++ > 30 * 3)
            {
               param1.removeChild(this.message3);
            }
         }
         if(Boolean(this.tip) && param1.contains(this.tip))
         {
            this.tip.update();
            if(this.frames++ > 30 * 5)
            {
               param1.removeChild(this.tip);
               this.arrow.visible = false;
            }
         }
         if(param1.team.statue.health < param1.team.statue.maxHealth / 2.5)
         {
            if(!this.help)
            {
               this.message3 = new InGameMessage("",param1.game);
               this.message3.x = param1.game.stage.stageWidth / 2;
               this.message3.y = param1.game.stage.stageHeight / 4 - 75;
               this.message3.scaleX *= 1.3;
               this.message3.scaleY *= 1.3;
               param1.addChild(this.message3);
               this.message3.setMessage("We are here to help","Aid",0,"StartMatchmaking");
               this.frames = 0;
               param1.team.spawnUnitGroup([Unit.U_WATER_ELEMENT,Unit.U_MINER_ELEMENT,Unit.U_MINER_ELEMENT,Unit.U_EARTH_ELEMENT,Unit.U_AIR_ELEMENT,Unit.U_FIRE_ELEMENT,Unit.U_WATER_ELEMENT,Unit.U_MINER_ELEMENT,Unit.U_MINER_ELEMENT,Unit.U_EARTH_ELEMENT,Unit.U_AIR_ELEMENT,Unit.U_FIRE_ELEMENT]);
               this.help = true;
            }
         }
         if(this.state == S_ALL_DONE)
         {
            if(!this.bruh)
            {
               _loc4_ = ChromeElement(param1.game.unitFactory.getUnit(Unit.U_CHROME_ELEMENT));
               param1.team.spawn(_loc4_,param1.game);
               _loc4_.vType = "v";
               this.s1 = _loc4_;
               this.message2 = new InGameMessage("",param1.game);
               this.message2.x = param1.game.stage.stageWidth / 2;
               this.message2.y = param1.game.stage.stageHeight / 4 - 75;
               this.message2.scaleX *= 1.3;
               this.message2.scaleY *= 1.3;
               param1.addChild(this.message2);
               this.message2.setMessage("Get out!","V",0,"StartMatchmaking",true);
               this.frames = 0;
               this.bruh = true;
            }
         }
         if(this.arrow != null)
         {
            if(this.arrow.currentFrame == this.arrow.totalFrames)
            {
               this.arrow.gotoAndPlay(1);
            }
            else
            {
               this.arrow.nextFrame();
            }
         }
         param1.userInterface.isSlowCamera = false;
         if(this.state == S_SET_UP)
         {
            CampaignGameScreen(param1).doAiUpdates = false;
            param1.userInterface.isGlobalsEnabled = false;
            param1.team.gold = 0;
            param1.team.mana = 0;
            param1.team.enemyTeam.gold = 0;
            _loc3_ = param1.game;
            _loc14_ = WaterElement(_loc3_.unitFactory.getUnit(Unit.U_WATER_ELEMENT));
            param1.team.spawn(_loc14_,_loc3_);
            _loc14_.px = param1.team.homeX + 2000 * param1.team.direction;
            _loc14_.py = _loc3_.map.height / 3;
            _loc14_.ai.setCommand(_loc3_,new StandCommand(_loc3_));
            param1.team.population += 2;
            param1.team.population += 2;
            this.s3 = _loc14_;
            _loc5_ = EarthElement(_loc3_.unitFactory.getUnit(Unit.U_EARTH_ELEMENT));
            param1.team.spawn(_loc5_,_loc3_);
            _loc5_.px = param1.team.homeX + 2000 * param1.team.direction;
            _loc5_.py = _loc3_.map.height / 3 * 2;
            _loc5_.ai.setCommand(_loc3_,new StandCommand(_loc3_));
            this.s2 = _loc5_;
            this.message = new InGameMessage("",param1.game);
            this.message.x = _loc3_.stage.stageWidth / 2;
            this.message.y = _loc3_.stage.stageHeight / 4 - 75;
            this.message.scaleX *= 1.3;
            this.message.scaleY *= 1.3;
            param1.addChild(this.message);
            this.arrow = new tutorialArrow();
            param1.addChild(this.arrow);
            this.m1 = ElementalMiner(_loc3_.unitFactory.getUnit(Unit.U_MINER_ELEMENT));
            param1.team.spawn(this.m1,_loc3_);
            this.m1.px = param1.team.homeX + 400;
            this.m1.py = _loc3_.map.height / 2;
            this.m1.ai.setCommand(_loc3_,new StandCommand(_loc3_));
            (_loc6_ = this.m1.ai).canAutoMine = false;
            param1.team.population += 2;
         }
         else if(this.state == S_BOX_UNITS)
         {
            param1.game.screenX = 2200;
            param1.userInterface.isSlowCamera = true;
            param1.game.targetScreenX = 2200;
            this.arrow.x = this.s2.x + param1.game.battlefield.x;
            this.arrow.y = this.s2.y - this.s2.pheight * 0.8 + param1.game.battlefield.y;
            this.arrow.x = this.s3.x + param1.game.battlefield.x;
            this.arrow.y = this.s3.y - this.s3.pheight * 0.8 + param1.game.battlefield.y;
            this.message.setMessage("Left click and drag a box over units to select them.","Step #1",0,"ClickMana",true);
            if(!param1.contains(this.skipTutorialButton) && (param1.main.campaign.difficultyLevel != Campaign.D_NORMAL || param1.main.campaign.getCurrentLevel().retries > 0))
            {
               param1.addChild(this.skipTutorialButton);
               this.skipTutorialButton.x = param1.game.map.screenWidth / 2 + 17;
               this.skipTutorialButton.y = this.message.y + this.message.height - 140;
            }
         }
         else if(this.state == S_MOVE_UNITS)
         {
            if(param1.contains(this.skipTutorialButton))
            {
               param1.removeChild(this.skipTutorialButton);
            }
            if(this.s2.selected == false)
            {
               param1.userInterface.selectedUnits.add(this.s2);
               param1.userInterface.selectedUnits.add(this.s3);
               this.s2.selected = true;
               this.s3.selected = true;
            }
            this.message.setMessage("Right click here to move your selected units.","Step #2",0,"ClickMana");
            param1.game.screenX = 2200;
            param1.game.targetScreenX = 2200;
            this.arrow.visible = true;
            this.arrow.x = 2350 + param1.game.battlefield.x;
            this.arrow.y = 100 + param1.game.battlefield.y;
         }
         else if(this.state == S_MOVE_SCREEN)
         {
            this.message.setMessage("Move your mouse here to scroll the screen sideways.","Step #3",0,"ClickMana");
            this.arrow.visible = true;
            if(param1.game.targetScreenX > 2900)
            {
               param1.game.targetScreenX = 2900;
            }
            if(param1.game.targetScreenX < 1800)
            {
               param1.game.targetScreenX = 1800;
            }
            if(param1.game.targetScreenX > 2850)
            {
               this.arrow.visible = false;
            }
            if(this.s2.selected == false)
            {
               param1.userInterface.selectedUnits.add(this.s2);
               this.s2.selected = true;
               param1.userInterface.selectedUnits.add(this.s3);
               this.s3.selected = true;
            }
            this.arrow.x = param1.game.stage.stageWidth - 50;
            this.arrow.y = param1.game.stage.stageHeight / 4;
            this.arrow.rotation = -90;
         }
         else if(this.state == S_ATTACK_UNITS)
         {
            if(this.s2.selected == false)
            {
               param1.userInterface.selectedUnits.add(this.s2);
               this.s2.selected = true;
               param1.userInterface.selectedUnits.add(this.s3);
               this.s3.selected = true;
            }
            for each(_loc7_ in param1.team.units)
            {
               _loc7_.health = _loc7_.maxHealth;
            }
            param1.game.targetScreenX = 2800;
            this.message.setMessage("Right click on this enemy unit to attack.","Step #4",0,"ClickMana",true);
            this.arrow.visible = true;
            this.arrow.x = this.o1.x + param1.game.battlefield.x;
            this.arrow.y = this.o1.y - this.o1.pheight * 0.8 + param1.game.battlefield.y;
            this.arrow.rotation = 0;
         }
         else if(this.state == S_MOVE_TO_BASE)
         {
            if(this.s2.selected == true)
            {
               param1.userInterface.selectedUnits.clear();
               this.s2.selected = false;
               this.s3.selected = false;
            }
            this.message.setMessage("Click down here on the mini map to quickly navigate back to you castle.","Step #5",0,"ClickMana",true);
            this.arrow.visible = true;
            this.arrow.x = param1.game.stage.stageWidth / 2 - 80;
            this.arrow.y = param1.game.stage.stageHeight - 115;
            (_loc8_ = new UnitMove()).owner = param1.game.team.id;
            _loc8_.moveType = UnitCommand.HOLD;
            _loc8_.arg0 = param1.game.team.homeX + 1000;
            _loc8_.arg1 = param1.game.map.height / 2;
            _loc8_.units.push(this.s2.id);
            _loc8_.units.push(this.s3.id);
            _loc8_.execute(param1.game);
         }
         else if(this.state == S_SELECT_MINER)
         {
            if(this.s2.selected == true)
            {
               param1.userInterface.selectedUnits.clear();
               this.s3.selected = false;
               this.s2.selected = false;
            }
            this.message.setMessage("Click on this miner.","Step #6",0,"ClickMana");
            param1.userInterface.isSlowCamera = true;
            param1.game.targetScreenX = param1.team.homeX;
            this.arrow.visible = true;
            this.arrow.x = this.m1.x + param1.game.battlefield.x;
            this.arrow.y = this.m1.y - this.m1.pheight * 0.8 + param1.game.battlefield.y;
            (_loc8_ = new UnitMove()).owner = param1.game.team.id;
            _loc8_.moveType = UnitCommand.MOVE;
            _loc8_.arg0 = param1.game.team.homeX + 1000;
            _loc8_.arg1 = param1.game.map.height / 2;
            _loc8_.units.push(this.s3.id);
            _loc8_.units.push(this.s2.id);
            _loc8_.execute(param1.game);
         }
         else if(this.state == S_PRAY)
         {
            if(this.s2.selected == true)
            {
               param1.userInterface.selectedUnits.clear();
               this.s2.selected = false;
               this.s3.selected = false;
            }
            this.message.setMessage("Right click the statue to begin praying.","Step #7",0,"ClickMana");
            param1.userInterface.isSlowCamera = true;
            param1.game.targetScreenX = param1.team.homeX;
            this.arrow.visible = true;
            this.arrow.x = param1.game.team.statue.x + param1.game.battlefield.x;
            this.arrow.y = param1.game.team.statue.y - param1.game.team.statue.height / 2 + param1.game.battlefield.y;
            param1.userInterface.selectedUnits.add(this.m1);
            this.m1.selected = true;
         }
         else if(this.state == S_PRAY_INFO)
         {
            if(this.s2.selected == true)
            {
               param1.userInterface.selectedUnits.clear();
               this.s2.selected = false;
               this.s3.selected = false;
            }
            this.arrow.visible = false;
            param1.userInterface.isSlowCamera = true;
            param1.game.targetScreenX = param1.team.homeX;
            this.message.setMessage("Praying gathers mana, which is used to build more advanced units, research technologies and use abilities.","",0,"ClickMana");
         }
         else if(this.state == S_START_MINING)
         {
            if(this.s2.selected == true)
            {
               param1.userInterface.selectedUnits.clear();
               this.s3.selected = false;
               this.s2.selected = false;
            }
            this.arrow.visible = true;
            this.message.setMessage("Right click on a gold mine to gather gold.","Step #8",0,"ClickMana",true);
            param1.userInterface.isSlowCamera = true;
            param1.game.targetScreenX = param1.team.homeX;
            this.arrow.x = param1.game.map.gold[3].x + param1.game.battlefield.x;
            this.arrow.y = param1.game.map.gold[3].y - 60 * 0.8 + param1.game.battlefield.y;
            param1.userInterface.selectedUnits.add(this.m1);
            this.m1.selected = true;
         }
         else if(this.state == S_GOLD_INFO)
         {
            if(this.s2.selected == true)
            {
               param1.userInterface.selectedUnits.clear();
               this.s3.selected = false;
               this.s2.selected = false;
            }
            this.message.setMessage("Your gold, mana and population are shown here.","",75,"ClickMana");
            this.arrow.x = 675;
            this.arrow.y = 40;
            this.arrow.visible = true;
         }
         else if(this.state == S_BUILD_UNIT)
         {
            if(this.s2.selected == true)
            {
               param1.userInterface.selectedUnits.clear();
               this.s3.selected = false;
               this.s2.selected = false;
            }
            this.arrow.visible = true;
            if(param1.team.buttonInfoMap[Unit.U_EARTH_ELEMENT][3] != 0)
            {
               this.message.setMessage("Earth is a basic infantry unit. Once finished training, he will appear from the castle gates.","",0,"ClickMana");
               this.arrow.visible = false;
            }
            else if(!this.hasShownBuildSwordwrath)
            {
               this.message.setMessage("Click the icon below to build a Earth unit.","Step #9",0,"ClickMana",true);
               this.arrow.x = 50;
               this.hasShownBuildSwordwrath = true;
               this.arrow.y = param1.game.stage.stageHeight - 150;
               this.arrow.visible = true;
            }
         }
         else if(this.state == S_SHOW_ENEMY)
         {
            if(this.s3.selected == true)
            {
               param1.userInterface.selectedUnits.clear();
               this.s3.selected = false;
               this.s2.selected = false;
            }
            param1.userInterface.isSlowCamera = true;
            param1.game.targetScreenX = this.spearton1.px - param1.game.map.screenWidth / 2;
            param1.game.fogOfWar.isFogOn = false;
            this.message.setMessage("A Knight is attacking!","",0,"ClickMana");
            this.arrow.visible = false;
         }
         else if(this.state == S_SPEARTON_ATTACKING)
         {
            param1.game.fogOfWar.isFogOn = true;
            param1.userInterface.isSlowCamera = true;
            param1.game.targetScreenX = param1.team.forwardUnit.px - param1.game.map.screenWidth / 2;
            param1.userInterface.isGlobalsEnabled = true;
            for each(_loc9_ in param1.team.units)
            {
               _loc9_.selected = false;
            }
            this.message.setMessage("Click here to garrison your units inside the castle.","Step #10",0,"ClickMana",true);
            this.arrow.x = param1.game.stage.stageWidth / 2 - 90;
            this.arrow.y = param1.game.stage.stageHeight - 75;
            this.arrow.visible = true;
            if(param1.game.team.currentAttackState == Team.G_ATTACK)
            {
               param1.game.team.defend(true);
            }
         }
         else if(this.state == S_GARRISON)
         {
            this.message.setMessage("Your units will now run to the safety of your castle walls.","",0,"ClickMana");
            this.arrow.visible = false;
            param1.userInterface.isGlobalsEnabled = false;
            param1.userInterface.isSlowCamera = true;
            param1.game.targetScreenX = param1.team.forwardUnit.px - param1.game.map.screenWidth / 2;
            for each(_loc9_ in param1.team.units)
            {
               _loc9_.selected = false;
            }
         }
         else if(this.state == S_CLICK_ON_ARCHERY_RANGE)
         {
            param1.userInterface.isSlowCamera = true;
            param1.game.targetScreenX = 0;
            this.message.setMessage("Click on the Air Range building.","Step #11",250,"ClickMana");
            param1.team.gold = 400;
            this.arrow.x = 330 + param1.game.battlefield.x;
            this.arrow.y = param1.game.battlefield.y - 200;
            this.arrow.visible = true;
         }
         else if(this.state == S_UPGRADE_CASTLE_ARCHER)
         {
            this.message.y = param1.game.stage.stageHeight / 4 - 75;
            this.message.setMessage("Click the icon below to build a Castle Air.","Step #12",0,"ClickMana",true);
            param1.game.targetScreenX = 0;
            param1.userInterface.selectedUnits.add(Unit(param1.team.buildings["AirBuilding"]));
            Unit(param1.team.buildings["AirBuilding"]).selected = true;
            this.arrow.x = param1.game.stage.stageWidth - 170;
            this.arrow.y = param1.game.stage.stageHeight - 150;
            this.arrow.visible = true;
         }
         else if(this.state == S_TALK_ABOUT_BUILDINGS)
         {
            this.message.setMessage("Each building contains different technologies and upgrades which must be researched to enable them.","",0,"ClickMana");
         }
         else if(this.state == S_SEND_IN_SPEARTON)
         {
            param1.userInterface.isGlobalsEnabled = true;
            param1.userInterface.isSlowCamera = true;
            param1.game.targetScreenX = this.spearton1.px - param1.game.map.screenWidth / 2;
            (_loc10_ = new UnitMove()).moveType = UnitCommand.ATTACK_MOVE;
            _loc10_.units.push(this.spearton1);
            _loc10_.owner = param1.team.id;
            _loc10_.arg0 = param1.team.homeX;
            _loc10_.arg1 = param1.team.game.map.height / 2;
            _loc10_.execute(param1.team.game);
            this.message.setMessage("Hit the defend button below to send out your units, then press Backspace and right click on this enemy unit to kill him.","Step #13",0,"ClickMana",true);
            this.message.visible = true;
            this.arrow.visible = true;
            this.arrow.x = param1.game.stage.stageWidth / 2;
            this.arrow.y = param1.game.stage.stageHeight - 75;
            if(this.spearton1.health < 50)
            {
               this.spearton1.health = 50;
            }
         }
         else if(this.state == S_HIT_DEFEND)
         {
            param1.userInterface.isGlobalsEnabled = false;
            this.message.setMessage("Use your forces to defend against the invading Knight.","Step #14",0,"ClickMana");
            this.message.visible = true;
            this.arrow.visible = true;
            this.arrow.x = this.spearton1.x + param1.game.battlefield.x;
            this.arrow.y = this.spearton1.y - this.spearton1.pheight * 0.8 + param1.game.battlefield.y;
         }
         else if(this.state == S_KILL_SPEARTON)
         {
            this.arrow.x = this.spearton1.x + param1.game.battlefield.x;
            this.arrow.y = this.spearton1.y - this.spearton1.pheight * 0.8 + param1.game.battlefield.y;
            this.arrow.visible = true;
         }
         else if(this.state == S_GOOD_LUCK)
         {
            this.message.setMessage("For a full list of commands, hit \'ESC\' or \'P\' for pause menu.","",0,"ClickMana");
            this.arrow.visible = false;
            CampaignGameScreen(param1).doAiUpdates = true;
         }
         else if(this.state == S_GOOD_LUCK_2)
         {
            this.message.setMessage("Your objective is to destroy the enemy statue before they destroy yours. Remember protect V. If he die, you will lose. Good luck.","",0,"ClickMana");
            this.arrow.visible = true;
            CampaignGameScreen(param1).doAiUpdates = true;
            param1.userInterface.isGlobalsEnabled = true;
            this.spawnSpeartonCounter = 30 * 30;
            this.arrow.x = this.s1.x + param1.game.battlefield.x;
            this.arrow.y = this.s1.y - this.s1.pheight * 0.8 + param1.game.battlefield.y;
            param1.game.targetScreenX = this.s1.px - param1.game.map.screenWidth / 2;
         }
         if(this.state < S_CLICK_ON_ARCHERY_RANGE)
         {
            param1.team.enemyTeam.gold = 0;
         }
         if(!this.hasSpawnedSpearton && param1.game.team.enemyTeam.statue.health / param1.game.team.enemyTeam.statue.maxHealth < 0.5)
         {
            param1.game.team.enemyTeam.statue.health = param1.game.team.enemyTeam.statue.maxHealth;
            _loc11_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
            param1.team.enemyTeam.spawn(_loc11_,param1.game);
            param1.team.enemyTeam.population += 3;
            _loc11_.x = _loc11_.px = _loc11_.team.homeX;
            _loc11_.y = _loc11_.py = param1.game.map.height / 2;
            _loc11_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
            param1.team.enemyTeam.spawn(_loc11_,param1.game);
            param1.team.enemyTeam.population += 3;
            _loc11_.x = _loc11_.px = _loc11_.team.homeX;
            _loc11_.y = _loc11_.py = param1.game.map.height / 2;
            _loc11_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
            param1.team.enemyTeam.spawn(_loc11_,param1.game);
            param1.team.enemyTeam.population += 3;
            _loc11_.x = _loc11_.px = _loc11_.team.homeX;
            _loc11_.y = _loc11_.py = param1.game.map.height / 2;
            _loc11_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
            param1.team.enemyTeam.spawn(_loc11_,param1.game);
            param1.team.enemyTeam.population += 3;
            _loc11_.x = _loc11_.px = _loc11_.team.homeX;
            _loc11_.y = _loc11_.py = param1.game.map.height / 2;
            this.hasSpawnedSpearton = true;
         }
         if(this.state != S_ALL_DONE)
         {
         }
         if(this.o1 != null)
         {
            this.o1.ai.setCommand(_loc3_,new StandCommand(_loc3_));
         }
         if(this.state == S_SET_UP)
         {
            this.state = S_BOX_UNITS;
         }
         else if(this.state == S_BOX_UNITS)
         {
            if(Boolean(this.message.hasFinishedPlayingSound()) && this.s2.selected == true)
            {
               this.state = S_MOVE_UNITS;
            }
         }
         else if(this.state == S_MOVE_UNITS)
         {
            if(Boolean(this.message.hasFinishedPlayingSound()) && this.s2.px < 2500)
            {
               this.state = S_MOVE_SCREEN;
               this.o1 = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
               param1.team.enemyTeam.spawn(this.o1,param1.game);
               this.o1.x = this.o1.px = 3350;
               this.o1.y = this.o1.py = param1.game.map.height / 2;
               param1.team.enemyTeam.population += 1;
            }
         }
         else if(this.state == S_MOVE_SCREEN)
         {
            if(Boolean(this.message.hasFinishedPlayingSound()) && param1.game.screenX > 2800)
            {
               this.state = S_ATTACK_UNITS;
            }
         }
         else if(this.state == S_ATTACK_UNITS)
         {
            if(Boolean(this.message.hasFinishedPlayingSound()) && this.o1.isDead == true)
            {
               this.o1 = null;
               this.state = S_MOVE_TO_BASE;
            }
         }
         else if(this.state == S_MOVE_TO_BASE)
         {
            if(Boolean(this.message.hasFinishedPlayingSound()) && param1.game.screenX < param1.team.homeX + 300)
            {
               this.state = S_SELECT_MINER;
            }
         }
         else if(this.state == S_SELECT_MINER)
         {
            if(Boolean(this.message.hasFinishedPlayingSound()) && this.m1.selected == true)
            {
               this.state = S_PRAY;
            }
         }
         else if(this.state == S_PRAY)
         {
            if(Boolean(this.message.hasFinishedPlayingSound()) && MinerAi(this.m1.ai).targetOre == param1.game.team.statue)
            {
               this.state = CampaignTutorial.S_PRAY_INFO;
               this.counter = 0;
            }
         }
         else if(this.state == S_PRAY_INFO)
         {
            if(Boolean(this.message.hasFinishedPlayingSound()) && param1.game.team.mana > 10)
            {
               this.state = CampaignTutorial.S_START_MINING;
            }
         }
         else if(this.state == S_SELECT_MINER_2)
         {
            if(Boolean(this.message.hasFinishedPlayingSound()) && MinerAi(this.m1.ai).targetOre != null && MinerAi(this.m1.ai).targetOre != param1.game.team.statue)
            {
               this.state = CampaignTutorial.S_START_MINING;
            }
         }
         else if(this.state == S_START_MINING)
         {
            if(Boolean(this.message.hasFinishedPlayingSound()) && MinerAi(this.m1.ai).targetOre != null && MinerAi(this.m1.ai).targetOre != param1.game.team.statue)
            {
               this.state = S_GOLD_INFO;
               param1.team.gold = 150;
               this.popBefore = param1.team.units.length;
               param1.team.defend(true);
               this.counter = 0;
               this.arrow.scaleY *= -1;
            }
         }
         else if(this.state == S_GOLD_INFO)
         {
            ++this.counter;
            if(Boolean(this.message.hasFinishedPlayingSound()) && this.counter > 150)
            {
               this.state = S_BUILD_UNIT;
               this.arrow.visible = true;
               this.arrow.scaleY *= -1;
            }
         }
         else if(this.state == S_BUILD_UNIT)
         {
            if(Boolean(this.message.hasFinishedPlayingSound()) && param1.team.units.length > this.popBefore)
            {
               this.arrow.visible = false;
               ++this.counter;
               if(this.counter > 150)
               {
                  this.arrow.visible = false;
                  this.state = S_SHOW_ENEMY;
                  param1.userInterface.isGlobalsEnabled = true;
                  this.spearton1 = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                  param1.team.enemyTeam.spawn(this.spearton1,param1.game);
                  param1.team.enemyTeam.population += 3;
                  this.spearton1.x = this.spearton1.px = this.spearton1.team.homeX - 200;
                  this.spearton1.y = this.spearton1.py = param1.game.map.height / 2;
               }
            }
         }
         else if(this.state == S_SHOW_ENEMY)
         {
            if(Boolean(this.message.hasFinishedPlayingSound()) && this.spearton1.px < param1.team.enemyTeam.homeX - 900)
            {
               this.state = S_SPEARTON_ATTACKING;
            }
         }
         else if(this.state == S_SPEARTON_ATTACKING)
         {
            _loc12_ = false;
            for each(_loc9_ in param1.team.units)
            {
               if(!_loc9_.isGarrisoned)
               {
                  _loc12_ = true;
               }
            }
            if(!_loc12_)
            {
               this.state = S_GARRISON;
            }
         }
         else if(this.state == S_GARRISON)
         {
            if(Boolean(this.message.hasFinishedPlayingSound()) && param1.game.team.forwardUnit.px < param1.team.homeX + 200)
            {
               this.state = S_CLICK_ON_ARCHERY_RANGE;
            }
         }
         else if(this.state == S_CLICK_ON_ARCHERY_RANGE)
         {
            if(Boolean(this.message.hasFinishedPlayingSound()) && Boolean(Unit(param1.team.buildings["AirBuilding"]).selected))
            {
               this.state = S_UPGRADE_CASTLE_ARCHER;
            }
         }
         else if(this.state == S_UPGRADE_CASTLE_ARCHER)
         {
            if(Boolean(this.message.hasFinishedPlayingSound()) && param1.team.tech.isResearching(Tech.CASTLE_ARCHER_1))
            {
               this.state = S_TALK_ABOUT_BUILDINGS;
            }
         }
         else if(this.state == CampaignTutorial.S_TALK_ABOUT_BUILDINGS)
         {
            if(Boolean(this.message.hasFinishedPlayingSound()) && param1.team.tech.isResearched(Tech.CASTLE_ARCHER_1))
            {
               this.spearton1.px = param1.team.homeX + 700;
               this.spearton1.py = param1.game.map.height * 3 / 4;
               this.state = S_SEND_IN_SPEARTON;
            }
         }
         else if(this.state == S_SEND_IN_SPEARTON)
         {
            _loc13_ = false;
            for each(_loc9_ in param1.team.units)
            {
               if(_loc9_.isGarrisoned)
               {
                  _loc13_ = true;
               }
            }
            if(!_loc13_)
            {
               this.state = S_HIT_DEFEND;
            }
         }
         else if(this.state == S_HIT_DEFEND)
         {
            if(Boolean(this.message.hasFinishedPlayingSound()) || param1.team.currentAttackState == Team.G_DEFEND || param1.team.currentAttackState == Team.G_ATTACK)
            {
               this.state = S_KILL_SPEARTON;
            }
         }
         else if(this.state == S_KILL_SPEARTON)
         {
            if(this.message.hasFinishedPlayingSound() && !this.spearton1.isAlive())
            {
               this.state = S_GOOD_LUCK;
               this.popBefore = param1.team.population;
               param1.team.gold = 150;
               _loc3_ = param1.game;
               _loc3_.team.spawnUnitGroup([Unit.U_MINER_ELEMENT,Unit.U_MINER_ELEMENT,Unit.U_MINER_ELEMENT,Unit.U_EARTH_ELEMENT,Unit.U_EARTH_ELEMENT,Unit.U_EARTH_ELEMENT]);
               _loc3_.team.enemyTeam.spawnUnitGroup([Unit.U_CHAOS_MINER,Unit.U_CHAOS_MINER,Unit.U_CHAOS_MINER,Unit.U_CHAOS_MINER,Unit.U_CHAOS_MINER,Unit.U_CHAOS_MINER,Unit.U_KNIGHT,Unit.U_KNIGHT,Unit.U_DEAD,Unit.U_DEAD]);
               _loc3_.team.gold = 550;
               _loc3_.team.mana = 175;
               _loc3_.team.defend(true);
               if(!this.bruh)
               {
                  _loc4_ = ChromeElement(param1.game.unitFactory.getUnit(Unit.U_CHROME_ELEMENT));
                  param1.team.spawn(_loc4_,param1.game);
                  _loc4_.vType = "v";
                  this.s1 = _loc4_;
                  this.bruh = true;
               }
            }
         }
         else if(this.state == S_GOOD_LUCK)
         {
            ++this.counter;
            if(this.counter > 300)
            {
               this.state = S_GOOD_LUCK_2;
               this.counter = 0;
            }
         }
         else if(this.state == S_GOOD_LUCK_2)
         {
            ++this.counter;
            if(this.counter > 300)
            {
               this.state = S_PRESS_ATTACK_WAIT;
               this.counter = 0;
               this.message.visible = false;
               this.arrow.visible = false;
               this.message2 = new InGameMessage("",param1.game);
               this.message2.x = param1.game.stage.stageWidth / 2;
               this.message2.y = param1.game.stage.stageHeight / 4 - 75;
               this.message2.scaleX *= 1.3;
               this.message2.scaleY *= 1.3;
               param1.addChild(this.message2);
               this.message2.setMessage("Get out!","V",0,"StartMatchmaking");
               this.frames = 0;
            }
         }
         else if(this.state == S_PRESS_ATTACK_WAIT)
         {
            ++this.counter;
            this.arrow.visible = false;
            if(this.counter > 30 * 30)
            {
               this.state = S_PRESS_ATTACK;
               _loc3_ = param1.game;
               this.miniMessage = new InGameMessage("",param1.game);
               this.miniMessage.x = _loc3_.stage.stageWidth / 2;
               this.miniMessage.y = _loc3_.stage.stageHeight / 4 - 75;
               this.miniMessage.scaleX *= 0.8;
               this.miniMessage.scaleY *= 0.8;
               param1.addChild(this.miniMessage);
               this.miniMessage.setMessage("When you\'re ready, click here to Attack the enemy!","",525);
               this.miniMessage.visible = false;
               this.arrow.x = param1.game.stage.stageWidth / 2 + 90;
               this.arrow.y = param1.game.stage.stageHeight - 75;
               this.arrow.visible = false;
               this.counter = 0;
            }
         }
         else if(this.state == S_PRESS_ATTACK)
         {
            ++this.counter;
            if(this.miniMessage.isShowingNewMessage())
            {
               this.miniMessage.visible = true;
               if(this.miniMessage.isMessageShowing())
               {
                  this.arrow.visible = true;
               }
            }
            if(this.counter > 30 * 7)
            {
               this.state = S_LAG_WAIT;
               this.miniMessage.visible = false;
               this.arrow.visible = false;
               this.counter = 0;
            }
         }
         else if(this.state == S_LAG_WAIT)
         {
            ++this.counter;
            this.miniMessage.visible = false;
            this.arrow.visible = false;
            if(this.counter > 30 * 5)
            {
               this.state = S_LAG;
               this.miniMessage.setMessage("Click here to toggle the graphics quality if the game is running slow for you.","",525);
               this.counter = 0;
            }
         }
         else if(this.state == S_LAG)
         {
            ++this.counter;
            if(this.miniMessage.isShowingNewMessage())
            {
               this.miniMessage.visible = true;
               if(this.miniMessage.isMessageShowing())
               {
                  this.arrow.visible = true;
                  this.arrow.x = param1.game.stage.stageWidth / 2 - 90;
                  this.arrow.y = param1.game.stage.stageHeight - 20;
               }
            }
            if(this.counter > 30 * 7)
            {
               this.state = S_PICK_MINER;
               this.miniMessage.visible = false;
               this.arrow.visible = false;
            }
         }
         else if(this.state == S_PICK_MINER)
         {
            ++this.counter;
            if(!this.tip)
            {
               for each(_loc15_ in param1.team.unitGroups[Unit.U_EARTH_ELEMENT])
               {
                  if(_loc15_.selected == true)
                  {
                     this.tip = new InGameMessage("",param1.game);
                     this.tip.x = param1.game.stage.stageWidth / 2;
                     this.tip.y = param1.game.stage.stageHeight / 4 - 75;
                     this.tip.scaleX *= 0.8;
                     this.tip.scaleY *= 0.8;
                     param1.addChild(this.tip);
                     this.tip.setMessage("You don\'t know how to make him become miner? Click here, he will become a miner","",525,"ClickMana",true);
                     this.arrow.x = param1.game.stage.stageWidth - 170;
                     this.arrow.y = param1.game.stage.stageHeight - 150;
                     this.arrow.visible = true;
                     this.frames = 0;
                     this.state = S_ALL_DONE;
                     break;
                  }
               }
            }
         }
         if(this.message)
         {
            if(!this.message.isMessageShowing() || this.miniMessage && !this.miniMessage.isMessageShowing())
            {
               if(this.arrow)
               {
                  this.arrow.visible = false;
               }
            }
         }
      }
   }
}
