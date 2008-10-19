package com.socialstalkr.business {
  import com.socialstalkr.model.SocialStalkrModelLocator;
  import com.socialstalkr.util.ServiceUtils;
  
  import mx.rpc.IResponder;
  
  public class TwitterDelegate {
    [Bindable]
    private var _model:SocialStalkrModelLocator =
      SocialStalkrModelLocator.instance;
    
    private var _responder:IResponder;
    
    public function TwitterDelegate(responder:IResponder) {
      _responder = responder;
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
      var url:String = 
        "http://" + _model.username + ":" + _model.password +
        "@twitter.com/statuses/update.xml";
      ServiceUtils.send(url, _responder, {status:tweet});
    }
  }
}