package com.socialstalkr.command {
  import com.adobe.cairngorm.commands.ICommand;
  import com.adobe.cairngorm.control.CairngormEvent;
  import com.socialstalkr.business.TwitterDelegate;
  import com.socialstalkr.model.SocialStalkrModelLocator;
  
  import mx.rpc.IResponder;
  import mx.rpc.events.FaultEvent;
  import mx.rpc.events.ResultEvent;
  import mx.collections.XMLListCollection;
  
  public class ShowUserFriends implements ICommand, IResponder {
    public function ShowUserFriends() {
    }
  
    public function execute(event:CairngormEvent):void {
      var delegate:TwitterDelegate = new TwitterDelegate(this);
      delegate.showUserFriends(event.data);
    }

    public function result(event:Object):void {
      SocialStalkrModelLocator.instance.twitterUserFriends =
        new XMLListCollection(XMLList(event.result.children()));
    }
  
    public function fault(event:Object):void {
      trace("fault: " + event);
    }
  }
}