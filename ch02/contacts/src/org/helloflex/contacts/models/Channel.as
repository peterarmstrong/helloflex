package org.helloflex.contacts.models {
  import mx.collections.ArrayCollection;
  
  [Bindable]
  public class Channel {
    public var name:String;
    public var characterLimit:int;
    public var messages:ArrayCollection;
    
    public function Channel(
      name:String = "", 
      characterLimit:int = 0 
    ) {
      this.name = name;
      this.characterLimit = characterLimit;
    }
  }
}
