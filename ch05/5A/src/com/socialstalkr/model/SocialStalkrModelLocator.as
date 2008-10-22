package com.socialstalkr.model {
  import com.adobe.cairngorm.model.IModelLocator;
  
  import mx.collections.XMLListCollection;
  
  [Bindable]
  public class SocialStalkrModelLocator implements IModelLocator {
    public var username:String;
    
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