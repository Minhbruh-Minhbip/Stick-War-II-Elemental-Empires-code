package elementalAssets_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="elementalAssets_fla.airhead1_119")]
   public dynamic class airhead1_119 extends MovieClip
   {
       
      
      public var hat:_airHat;
      
      public var air:MovieClip;
      
      public var glare:MovieClip;
      
      public function airhead1_119()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}
