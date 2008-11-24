package com.socialstalkr.command {
  import com.adobe.cairngorm.commands.ICommand;
  import com.adobe.cairngorm.control.CairngormEvent;
  import com.socialstalkr.business.TwitterDelegate;
  import com.socialstalkr.model.SocialStalkrModelLocator;
  
  import mx.rpc.IResponder;
  import mx.rpc.events.FaultEvent;
  import mx.rpc.events.ResultEvent;
  import mx.collections.XMLListCollection;
  
  public class ShowFriendTweets implements ICommand, IResponder {
    public function ShowFriendTweets() {
    }
  
    public function execute(event:CairngormEvent):void {
      var delegate:TwitterDelegate = new TwitterDelegate(this);
      delegate.showUserTweets(event.data.screen_name);
    }
  
    public function result(event:Object):void {
      SocialStalkrModelLocator.instance.selectedFriendTweets =
        new XMLListCollection(XMLList(event.result.children()));
    }
  
    public function fault(event:Object):void {
      trace("fault: " + event);
    }
  }
}