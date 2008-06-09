package org.helloflex.contacts.models {
  import mx.collections.ArrayCollection;
  
  [Bindable]
  public class User {
    public var login:String;
    public var password:String;
    public var contact:Contact;
    public var tasks:ArrayCollection = new ArrayCollection();
    public var contacts:ArrayCollection = new ArrayCollection();
    public var messages:ArrayCollection = new ArrayCollection();
    
    public function User(
      login:String = "", 
      password:String = "", 
      contact:Contact = null 
    ) {
      this.login = login;
      this.password = password;
      this.contact = contact;
    }
  }
}
