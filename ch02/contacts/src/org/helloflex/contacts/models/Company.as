package org.helloflex.contacts.models {
  import mx.collections.ArrayCollection;
  
  [Bindable]
  public class Company {
    public var name:String;
    public var notes:String;
    public var address:Address;
    public var contacts:ArrayCollection = new ArrayCollection();
    
    public function Company(
      name:String = "", 
      notes:String = "", 
      address:Address = null 
    ) {
      this.name = name;
      this.notes = notes;
      this.address = address;
    }
  }
}
