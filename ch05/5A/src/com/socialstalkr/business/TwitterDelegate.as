package com.socialstalkr.business {
  import com.socialstalkr.util.ServiceUtils;
  
  import mx.rpc.IResponder;
  
  public class TwitterDelegate {
    private var _responder:IResponder;
    
    public function TwitterDelegate(responder:IResponder) {
      _responder = responder;
    }
    
    public function showUserFriends(twitterName:String):void {
      ServiceUtils.send("http://twitter.com/statuses/friends/" +
        twitterName + ".xml", _responder);
    }

    public function showUserTweets(twitterName:String):void {
      ServiceUtils.send(
        "http://twitter.com/statuses/user_timeline/" +
        twitterName + ".xml", _responder);
    }
    
    public function postTweet(twitterName:String,
      twitterPassword:String, tweet:String):void {
      var url:String = 
        "http://" + twitterName + ":" + twitterPassword + "@" +
        "twitter.com/statuses/update.xml";
      ServiceUtils.send(url, _responder, {status:tweet});
    }
  }
}