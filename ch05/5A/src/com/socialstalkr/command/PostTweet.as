package com.socialstalkr.command {
  import com.adobe.cairngorm.commands.ICommand;
  import com.adobe.cairngorm.control.CairngormEvent;
  import com.socialstalkr.business.TwitterDelegate;
  import com.socialstalkr.model.SocialStalkrModelLocator;
  
  import mx.rpc.IResponder;
  import mx.rpc.events.FaultEvent;
  import mx.rpc.events.ResultEvent;
  import mx.collections.XMLListCollection;
  
  public class PostTweet implements ICommand, IResponder {
    [Bindable]
    private var _model:SocialStalkrModelLocator =
      SocialStalkrModelLocator.instance;

    public function PostTweet() {
    }
  
    public function execute(event:CairngormEvent):void {
      var delegate:TwitterDelegate = new TwitterDelegate(this);
      delegate.postTweet(_model.username, _model.password,
        event.data);
    }

    public function result(event:Object):void {
      trace("result: " + event);
    }
  
    public function fault(event:Object):void {
      trace("fault: " + event);
    }
  }
}