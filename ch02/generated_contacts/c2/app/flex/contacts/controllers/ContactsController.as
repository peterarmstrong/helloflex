package contacts.controllers {
  import contacts.models.*;
  import contacts.commands.*;
	
  import org.ruboss.Ruboss;
  import org.ruboss.controllers.RubossCommandController;

  public class ContactsController extends RubossCommandController {
    private static var controller:ContactsController;
    
    public static var models:Array = [Address, Channel, Company, Contact, Message, Task, User]; /* Models */
    
    public function ContactsController(enforcer:SingletonEnforcer, extraServices:Array,
      defaultServiceId:int = -1) {
      super([] /* Commands */, 
        models, extraServices, defaultServiceId);
    }
    
    public static function get instance():ContactsController {
      if (controller == null) initialize();
      return controller;
    }
    
    public static function initialize(extraServices:Array = null, defaultServiceId:int = -1):void {
      controller = new ContactsController(new SingletonEnforcer, extraServices,
        defaultServiceId);
      Ruboss.commands = controller;
    }
  }
}

class SingletonEnforcer {}
