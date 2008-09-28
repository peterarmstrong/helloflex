package com.socialstalkr.command {
  import com.adobe.cairngorm.commands.ICommand;
  import com.adobe.cairngorm.control.CairngormEvent;
  import com.socialstalkr.business.TwitterDelegate;
  import com.socialstalkr.model.SocialStalkrModelLocator;
  
  import mx.core.Application;
  
  public class LocateTweet implements ICommand {
    public function LocateTweet() {
    }
  
    public function execute(event:CairngormEvent):void {
      Application.application.mapPanel.locateTweet(event.data);
    }
  
    public function result(event:Object):void {
    }
  
    public function fault(event:Object):void {
    }
  }
}