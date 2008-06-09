package org.helloflex.contacts.models {
  import mx.collections.ArrayCollection;
  
  [Bindable]
  public class Contact {
    public var firstName:String;
    public var lastName:String;
    public var email:String;
    public var homePhone:String;
    public var mobilePhone:String;
    public var workPhone:String;
    public var skype:String;
    public var facebook:String;
    public var twitter:String;
    public var blog:String;
    public var notes:String;
    public var user:User;
    public var company:Company;
    public var address:Address;
    public var tasks:ArrayCollection;
    public var messages:ArrayCollection;
    
    public function Contact(
      firstName:String = "", 
      lastName:String = "", 
      email:String = "", 
      homePhone:String = "", 
      mobilePhone:String = "", 
      workPhone:String = "", 
      skype:String = "", 
      facebook:String = "", 
      twitter:String = "", 
      blog:String = "", 
      notes:String = "", 
      user:User = null, 
      company:Company = null, 
      address:Address = null 
    ) {
      this.firstName = firstName;
      this.lastName = lastName;
      this.email = email;
      this.homePhone = homePhone;
      this.mobilePhone = mobilePhone;
      this.workPhone = workPhone;
      this.skype = skype;
      this.facebook = facebook;
      this.twitter = twitter;
      this.blog = blog;
      this.notes = notes;
      this.user = user;
      this.company = company;
      this.address = address;
    }
  }
}
