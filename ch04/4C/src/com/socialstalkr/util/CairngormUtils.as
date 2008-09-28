package com.socialstalkr.util {
  import com.adobe.cairngorm.control.CairngormEvent;
  import com.adobe.cairngorm.control.CairngormEventDispatcher;
  
  public class CairngormUtils {
    public static function dispatchEvent(
      eventName:String, data:Object = null):void {
      var event:CairngormEvent = new CairngormEvent(eventName);
      event.data = data;
      event.dispatch();
    }
  }
}