package com.socialstalkr.util {
  import mx.rpc.IResponder;
  import mx.rpc.AsyncToken;
  import mx.rpc.http.HTTPService;
  
  public class ServiceUtils {
    public static function send(
      url:String,
      responder:IResponder = null,
      request:Object = null,
      sendXML:Boolean = false,
      resultFormat:String = "e4x",
      method:String = null,
      useProxy:Boolean = false):void
    {
      var service:HTTPService = new HTTPService();
      service.url = url;
      service.request = request;
      service.contentType = sendXML ? "application/xml" :
          "application/x-www-form-urlencoded";
      service.resultFormat = resultFormat;
      if (method == null) {
        service.method = (request == null) ? "GET" : "POST";
      } else {
        service.method = method;
      }
      service.useProxy = useProxy;
      var call:AsyncToken = service.send();
      if (responder != null) {
        call.addResponder(responder);
      }
    }
  }
}
