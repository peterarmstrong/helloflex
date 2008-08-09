package com.socialstalkr.command {
  import com.adobe.cairngorm.commands.ICommand;
  import com.adobe.cairngorm.control.CairngormEvent;
  import com.socialstalkr.business.TwitterDelegate;
  import com.socialstalkr.model.SocialStalkrModelLocator;
  
  import mx.collections.XMLListCollection;
  import mx.rpc.IResponder;
  
  public class ShowUserTweets implements ICommand, IResponder {
    public function ShowUserTweets() {
    }
  
    public function execute(event:CairngormEvent):void {
      var delegate:TwitterDelegate = new TwitterDelegate(this);
      delegate.showUserTweets(event.data);
    }
  
    public function result(event:Object):void {
      var tweetsXLC:XMLListCollection = 
        new XMLListCollection(XMLList(event.result.children()));
      SocialStalkrModelLocator.instance.twitterUserTweets =
        tweetsXLC;
      if (tweetsXLC.length > 0) {
        SocialStalkrModelLocator.instance.twitterUser =
          XML(tweetsXLC.getItemAt(0).user);
      }
    }
  
    public function fault(event:Object):void {
      trace("fault: " + event);
    }
  }
}