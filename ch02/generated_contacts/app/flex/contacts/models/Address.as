package contacts.models {
  import org.ruboss.models.RubossModel;
  
  [Resource(controller="addresses")]
  [Bindable]
  public class Address extends RubossModel {
    public static const LABEL:String = "lineOne";
    
    public var lineOne:String;

    public var lineTwo:String;

    public var city:String;

    public var state:String;

    public var zip:String;

    public var country:String;

    [BelongsTo]
    public var contact:Contact;

    [BelongsTo]
    public var company:Company;

    public function Address(
      lineOne:String = "", 
      lineTwo:String = "", 
      city:String = "", 
      state:String = "", 
      zip:String = "", 
      country:String = "", 
      contact:Contact = null, 
      company:Company = null 
    ) {
      super(LABEL);
      this.lineOne = lineOne;
      this.lineTwo = lineTwo;
      this.city = city;
      this.state = state;
      this.zip = zip;
      this.country = country;
      this.contact = contact;
      this.company = company;
    }
  }
}
