package com.socialstalkr.business {
  import com.socialstalkr.model.SocialStalkrModelLocator;
  import com.socialstalkr.util.ServiceUtils;
  
  import flash.net.URLRequest;
  import flash.net.navigateToURL;
  
  import mx.rpc.IResponder;
  
  public class TwitterDelegate {
    [Bindable]
    private var _model:SocialStalkrModelLocator =
      SocialStalkrModelLocator.instance;
    
    private var _responder:IResponder;
    
    public function TwitterDelegate(responder:IResponder) {
      _responder = responder;
    }

    public function verifyCredentials(twitterName:String,
    twitterPassword:String):void {
      var url:String = 
        "http://" + twitterName + ":" + twitterPassword +
        "@twitter.com/account/verify_credentials.xml";
      ServiceUtils.send(url, _responder);
    }
    
    public function showUserFriends():void {
      ServiceUtils.send("http://twitter.com/statuses/friends/" +
        _model.username + ".xml", _responder);
    }

    public function showUserTweets(twitterName:String):void {
      ServiceUtils.send(
        "http://twitter.com/statuses/user_timeline/" +
        twitterName + ".xml", _responder);
    }
    
    public function postTweet(tweet:String):void {
      ServiceUtils.send("http://twitter.com/statuses/update.xml",
        _responder, {status:tweet});
    }
    
    public static function endSession():void {
      ServiceUtils.send("http://twitter.com/account/end_session");
      try {
        navigateToURL(new URLRequest("http://ruboss.com"),
          "_top");
      } catch (e:Error) {
      }
   }
  }
}