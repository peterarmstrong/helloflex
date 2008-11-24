package com.socialstalkr.model {
  import mx.collections.XMLListCollection;
  import com.adobe.cairngorm.model.IModelLocator;
  
  [Bindable]
  public class SocialStalkrModelLocator implements IModelLocator {
    public var userName:String;
    
    public var twitterUser:XML;

    public var twitterUserTweets:XMLListCollection;

    public var twitterUserFriends:XMLListCollection;

    public var selectedFriend:XML;

    public var selectedFriendTweets:XMLListCollection;
    
    private static var _modelLocator:SocialStalkrModelLocator;
  
    public function SocialStalkrModelLocator(
      enforcer:SingletonEnforcer) {
    }
    
    public static function get instance():
    SocialStalkrModelLocator {
      if (_modelLocator == null) {
        _modelLocator = new SocialStalkrModelLocator(
          new SingletonEnforcer());
      }
      return _modelLocator;
    }
  }
}

class SingletonEnforcer {}