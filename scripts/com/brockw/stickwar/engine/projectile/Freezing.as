package com.brockw.stickwar.engine.projectile
{
   import com.brockw.stickwar.engine.StickWar;
   import com.brockw.stickwar.engine.units.Unit;
   import flash.display.MovieClip;
   
   public class Freezing extends Projectile
   {
       
      
      internal var spellMc:MovieClip;
      
      public var startX:Number;
      
      public var startY:Number;
      
      public var endX:Number;
      
      public var endY:Number;
      
      public function Freezing(param1:StickWar)
      {
         super();
         type = FREEZING;
         this.spellMc = new poisonMagikilleffect();
         this.addChild(this.spellMc);
      }
      
      override public function cleanUp() : void
      {
         super.cleanUp();
         removeChild(this.spellMc);
         this.spellMc = null;
      }
      
      override public function update(param1:StickWar) : void
      {
         var _loc4_:* = NaN;
         this.visible = true;
         this.spellMc.nextFrame();
         this.scaleX = 1 * (param1.backScale + py / param1.map.height * (param1.frontScale - param1.backScale));
         this.scaleY = 1 * (param1.backScale + py / param1.map.height * (param1.frontScale - param1.backScale));
         var _loc2_:Array = team.enemyTeam.units;
         var _loc3_:* = _loc2_.length;
         if((_loc4_ = Number(this.spellMc.currentFrame) / 20) > 1)
         {
            return;
         }
         var _loc5_:* = _loc4_ * (this.endX - this.startX) + this.startX;
         var _loc6_:* = _loc4_ * (this.endY - this.startY) + this.startY;
         var _loc7_:int = 0;
         while(_loc7_ < _loc3_)
         {
            if(Unit(_loc2_[_loc7_]).team != this.team && _loc2_[_loc7_] is Unit)
            {
               if(Math.pow(Number(Unit(_loc2_[_loc7_]).px) - _loc5_,2) + Math.pow(Number(Unit(_loc2_[_loc7_]).py) - _loc6_,2) < Math.pow(param1.xml.xml.Order.Units.magikill.freezing.area,2))
               {
                  Unit(_loc2_[_loc7_]).slow(this.slowFrames);
               }
            }
            _loc7_++;
         }
      }
      
      override public function isReadyForCleanup() : Boolean
      {
         return this.spellMc.currentFrame == this.spellMc.totalFrames;
      }
      
      override public function isInFlight() : Boolean
      {
         return this.spellMc.currentFrame != this.spellMc.totalFrames;
      }
   }
}
