package contacts.models {
  import org.ruboss.models.ModelsCollection;
  import org.ruboss.models.RubossModel;
  
  [Resource(controller="channels")]
  [Bindable]
  public class Channel extends RubossModel {
    public static const LABEL:String = "name";
    
    public var name:String;

    public var characterLimit:int;

    [HasMany]
    public var messages:ModelsCollection;
    
    public function Channel(
      name:String = "", 
      characterLimit:int = 0 
    ) {
      super(LABEL);
      this.name = name;
      this.characterLimit = characterLimit;
    }
  }
}
