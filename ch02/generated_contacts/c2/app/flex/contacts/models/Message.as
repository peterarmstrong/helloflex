package contacts.models {
  import org.ruboss.models.RubossModel;
  
  [Resource(controller="messages")]
  [Bindable]
  public class Message extends RubossModel {
    public static const LABEL:String = "content";
    
    public var content:String;

    [BelongsTo]
    public var user:User;

    [BelongsTo]
    public var contact:Contact;

    [BelongsTo]
    public var channel:Channel;

    public function Message(
      content:String = "", 
      user:User = null, 
      contact:Contact = null, 
      channel:Channel = null 
    ) {
      super(LABEL);
      this.content = content;
      this.user = user;
      this.contact = contact;
      this.channel = channel;
    }
  }
}
