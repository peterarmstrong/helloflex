package contacts.models {
  import org.ruboss.models.ModelsCollection;
  import org.ruboss.models.RubossModel;
  
  [Resource(controller="users")]
  [Bindable]
  public class User extends RubossModel {
    public static const LABEL:String = "login";
    
    public var login:String;

    public var password:String;

    [HasOne]
    public var contact:Contact;
    
    [HasMany]
    public var tasks:ModelsCollection;
    
    [HasMany]
    public var contacts:ModelsCollection;
    
    [HasMany]
    public var messages:ModelsCollection;
    
    public function User(
      login:String = "", 
      password:String = "", 
      contact:Contact = null 
    ) {
      super(LABEL);
      this.login = login;
      this.password = password;
      this.contact = contact;
    }
  }
}
