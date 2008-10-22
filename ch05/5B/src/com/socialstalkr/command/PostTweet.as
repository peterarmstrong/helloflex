package com.socialstalkr.command {
  import com.adobe.cairngorm.commands.ICommand;
  import com.adobe.cairngorm.control.CairngormEvent;
  import com.socialstalkr.business.TwitterDelegate;
  import com.socialstalkr.control.EventNames;
  import com.socialstalkr.model.SocialStalkrModelLocator;
  import com.socialstalkr.util.CairngormUtils;
  
  import mx.rpc.IResponder;
  import mx.rpc.events.FaultEvent;
  import mx.rpc.events.ResultEvent;
  import mx.collections.XMLListCollection;
  
  public class PostTweet implements ICommand, IResponder {
    public function PostTweet() {
    }
  
    public function execute(event:CairngormEvent):void {
      var delegate:TwitterDelegate = new TwitterDelegate(this);
      delegate.postTweet(event.data);
    }

    public function result(event:Object):void {
      trace("result: " + event);
      CairngormUtils.dispatchEvent(EventNames.SHOW_USER_TWEETS);
    }
  
    public function fault(event:Object):void {
      trace("fault: " + event);
    }
  }
}