package org.helloflex.contacts.models {
  [Bindable]
  public class Message {
    public var content:String;
    public var user:User;
    public var contact:Contact;
    public var channel:Channel;

    public function Message(
      content:String = "", 
      user:User = null, 
      contact:Contact = null, 
      channel:Channel = null 
    ) {
      this.content = content;
      this.user = user;
      this.contact = contact;
      this.channel = channel;
    }
  }
}
