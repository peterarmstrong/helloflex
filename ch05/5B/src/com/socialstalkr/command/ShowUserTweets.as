package com.socialstalkr.command {
  import com.adobe.cairngorm.commands.ICommand;
  import com.adobe.cairngorm.control.CairngormEvent;
  import com.socialstalkr.business.TwitterDelegate;
  import com.socialstalkr.control.EventNames;
  import com.socialstalkr.model.SocialStalkrModelLocator;
  import com.socialstalkr.util.CairngormUtils;
  
  import mx.collections.XMLListCollection;
  import mx.rpc.IResponder;
  
  public class ShowUserTweets implements ICommand, IResponder {
    [Bindable]
    private var _model:SocialStalkrModelLocator =
      SocialStalkrModelLocator.instance;

    public function ShowUserTweets() {
    }
  
    public function execute(event:CairngormEvent):void {
      var delegate:TwitterDelegate = new TwitterDelegate(this);
      delegate.showUserTweets(_model.username);
    }
  
    public function result(event:Object):void {
      var tweetsXLC:XMLListCollection = 
        new XMLListCollection(XMLList(event.result.children()));
      _model.twitterUserTweets = tweetsXLC;
      if (tweetsXLC.length > 0) {
        var selectedTweet:XML = XML(tweetsXLC.getItemAt(0));
        if (_model.twitterUser == null) {
          _model.twitterUser = XML(selectedTweet.user);
        } else {
          CairngormUtils.dispatchEvent(EventNames.LOCATE_TWEET,
            selectedTweet);
        }
      }
    }
  
    public function fault(event:Object):void {
      trace("fault: " + event);
    }
  }
}