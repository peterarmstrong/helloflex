package com.socialstalkr.command {
  import com.adobe.cairngorm.commands.ICommand;
  import com.adobe.cairngorm.control.CairngormEvent;
  import com.socialstalkr.business.TwitterDelegate;
  import com.socialstalkr.control.EventNames;
  import com.socialstalkr.model.SocialStalkrModelLocator;
  import com.socialstalkr.util.CairngormUtils;
  
  import mx.core.Application;
  import mx.rpc.IResponder;
  
  public class VerifyCredentials implements ICommand, IResponder {
    [Bindable]
    private var _model:SocialStalkrModelLocator =
      SocialStalkrModelLocator.instance;

    public function VerifyCredentials() {
    }
  
    public function execute(event:CairngormEvent):void {
      _model.userName = event.data.twitterName;
      var delegate:TwitterDelegate = new TwitterDelegate(this);
      delegate.verifyCredentials(_model.userName,
        event.data.twitterPassword);
    }

    public function result(event:Object):void {
      CairngormUtils.dispatchEvent(EventNames.SHOW_USER_TWEETS);
      CairngormUtils.dispatchEvent(EventNames.SHOW_USER_FRIENDS,
        _model.userName);
      Application.application.currentState = "showMainApp";
    }
  
    public function fault(event:Object):void {
    }
  }
}