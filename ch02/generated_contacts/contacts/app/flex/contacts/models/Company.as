package contacts.models {
  import org.ruboss.models.ModelsCollection;
  import org.ruboss.models.RubossModel;
  
  [Resource(controller="companies")]
  [Bindable]
  public class Company extends RubossModel {
    public static const LABEL:String = "name";
    
    public var name:String;

    public var notes:String;

    [HasOne]
    public var address:Address;
    
    [HasMany]
    public var contacts:ModelsCollection;
    
    public function Company(
      name:String = "", 
      notes:String = "", 
      address:Address = null 
    ) {
      super(LABEL);
      this.name = name;
      this.notes = notes;
      this.address = address;
    }
  }
}
