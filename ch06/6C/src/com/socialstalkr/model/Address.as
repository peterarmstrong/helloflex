package com.socialstalkr.model {
  [Bindable]
  public class Address {
    public var lineOne:String;
    public var lineTwo:String;
    public var city:String;
    public var zipCode:String;
    public var state:String;
    public var country:String;

    public function Address(
      lineOne:String = "",
      lineTwo:String = "",
      city:String = "",
      state:String = "",
      country:String = "",
      zipCode:String = "") {
      this.lineOne = lineOne;
      this.lineTwo = lineTwo;
      this.city = city;
      this.state = state;
      this.country = country;
      this.zipCode = zipCode;
    }
    
    private function getAddrStr(str:String):String {
      return (str == null || str == "") ? "" : str + " ";
    }
    
    public function toString():String {
      return getAddrStr(lineOne) + getAddrStr(lineTwo) +
        getAddrStr(city) + getAddrStr(state) +
        getAddrStr(country) + getAddrStr(zipCode);
    }
  }
}
