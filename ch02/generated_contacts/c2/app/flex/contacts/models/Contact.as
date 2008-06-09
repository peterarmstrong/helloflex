package contacts.models {
  import org.ruboss.models.ModelsCollection;
  import org.ruboss.models.RubossModel;
  
  [Resource(controller="contacts")]
  [Bindable]
  public class Contact extends RubossModel {
    public static const LABEL:String = "firstName";
    
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

    [BelongsTo]
    public var user:User;

    [BelongsTo]
    public var company:Company;

    [HasOne]
    public var address:Address;
    
    [HasMany]
    public var tasks:ModelsCollection;
    
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
      super(LABEL);
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
