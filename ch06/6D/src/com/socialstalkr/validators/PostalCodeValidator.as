package com.socialstalkr.validators {
  import mx.events.ValidationResultEvent;
  import mx.validators.ValidationResult;
  import mx.validators.Validator;
  import mx.validators.ZipCodeValidator;
  import mx.validators.ZipCodeValidatorDomainType;
  
  public class PostalCodeValidator extends Validator {
    public var format:String;
    
    private var _zipCodeValidator:ZipCodeValidator;
    
    public function PostalCodeValidator() {
      super();
      _zipCodeValidator = new ZipCodeValidator();
      _zipCodeValidator.domain = ZipCodeValidatorDomainType.US_OR_CANADA;
    }
    
    override protected function doValidation(val:Object):Array {
      var results:Array = super.doValidation(val);
      var postalCode:String = val as String;
      if (postalCode.length != 0 && postalCode.length != 6) {
          results.push(
              new ValidationResult(
                  true,
                  "wrong_length",
                  "wrongLength",
        "The postal code is the wrong length."));
      } else {
        var resultEvent:ValidationResultEvent =
          _zipCodeValidator.validate(val);
        if (resultEvent.results != null &&
          resultEvent.results.length > 0) {
          results.concat(resultEvent.results);
        }
      }
      return results;
    }
  }
}