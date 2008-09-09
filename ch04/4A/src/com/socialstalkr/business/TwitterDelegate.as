package com.socialstalkr.business {
  import mx.rpc.IResponder;
  import com.socialstalkr.util.ServiceUtils;
  
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
  }
}