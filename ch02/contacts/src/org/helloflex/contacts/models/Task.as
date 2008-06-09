package org.helloflex.contacts.models {
  [Bindable]
  public class Task {
    public var name:String;
    public var notes:String;
    public var due:Date;
    public var completed:Boolean;
    public var user:User;
    public var contact:Contact;

    public function Task(
      name:String = "", 
      notes:String = "", 
      due:Date = null, 
      completed:Boolean = false, 
      user:User = null, 
      contact:Contact = null 
    ) {
      this.name = name;
      this.notes = notes;
      this.due = due;
      this.completed = completed;
      this.user = user;
      this.contact = contact;
    }
  }
}
