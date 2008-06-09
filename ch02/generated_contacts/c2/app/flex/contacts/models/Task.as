package contacts.models {
  import org.ruboss.models.RubossModel;
  
  [Resource(controller="tasks")]
  [Bindable]
  public class Task extends RubossModel {
    public static const LABEL:String = "name";
    
    public var name:String;

    public var notes:String;

    public var due:Date;

    public var completed:Boolean;

    [BelongsTo]
    public var user:User;

    [BelongsTo]
    public var contact:Contact;

    public function Task(
      name:String = "", 
      notes:String = "", 
      due:Date = null, 
      completed:Boolean = false, 
      user:User = null, 
      contact:Contact = null 
    ) {
      super(LABEL);
      this.name = name;
      this.notes = notes;
      this.due = due;
      this.completed = completed;
      this.user = user;
      this.contact = contact;
    }
  }
}
