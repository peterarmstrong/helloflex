package org.helloflex.contacts.models {
  [Bindable]
  public class Address {
    public var lineOne:String;
    public var lineTwo:String;
    public var city:String;
    public var state:String;
    public var zip:String;
    public var country:String;
    public var contact:Contact;
    public var company:Company;

    public function Address(
      lineOne:String = "", 
      lineTwo:String = "", 
      city:String = "", 
      state:String = "", 
      zip:String = "", 
      country:String = "", 
      contact:Contact = null, 
      company:Company = null 
    ) {
      this.lineOne = lineOne;
      this.lineTwo = lineTwo;
      this.city = city;
      this.state = state;
      this.zip = zip;
      this.country = country;
      this.contact = contact;
      this.company = company;
    }
  }
}
