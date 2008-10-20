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
    private var _username:String;
    private var _password:String;
    
    [Bindable]
    private var _model:SocialStalkrModelLocator =
      SocialStalkrModelLocator.instance;

    public function VerifyCredentials() {
    }
  
    public function execute(event:CairngormEvent):void {
      _username = event.data.twitterName;
      _password = event.data.twitterPassword;
      var delegate:TwitterDelegate = new TwitterDelegate(this);
      delegate.verifyCredentials(_username, _password);
    }

    public function result(event:Object):void {
      trace("VerifyCredentials#result: " + event);
      _model.username = _username;
      _model.password = _password;
      CairngormUtils.dispatchEvent(EventNames.SHOW_USER_TWEETS);
      CairngormUtils.dispatchEvent(EventNames.SHOW_USER_FRIENDS);
      Application.application.currentState = "showMainApp";
    }
  
    public function fault(event:Object):void {
      trace("VerifyCredentials#fault: " + event);
    }
  }
}