class ValidationUtils {
  static String validateEmpty(String value,String filed) {
    if (value.trim().length == 0)
      return 'must require '+filed;
    else
      return null;
  }
  static String validateClassName(String value) {
    if (value.trim().length == 0)
      return 'Enter valid class name';
    else
      return null;
  }

  static String validateRequired(String value) {
    if (value.trim().length == 0)
      return 'Required';
    else
      return null;
  }

  static String validateField(int val1,int val2,String value,String message) {
    print("validateField...value");
    double val;
    if(value.length>0){
      val = double.parse(value);
      print("val...$val");
      if (val<=(val1) && val>=(val2))
        return null;
      else
        return "Enter Valid "+message;
    }
    else{
      return message+" must require";
    }
  }
  static String validateCylinder(String value,String message) {
    print("validateCylinder...value");
    double val;
    if(value.length>0){
      val = double.parse(value);
      print("val...$val");
      if (val>=(-10) && val<=(10))
        return null;
      else
        return "Enter Valid "+message;
    }
    else{
      return message+" must require";
    }
  }
  static String validateDigree(String value,String message) {
    print("validateDigree...");
    double val;
    if(value.length>0){
      val = double.parse(value);
      if (val>=0 && val<=180)
        return null;
      else
        return "Enter Valid "+message;
    }
    else{
      return message+" must require";
    }
  }

  static String validatePosField(int val1,int val2,String value,String message) {
    print("validatePosField...$value");
    double val;
    if(value.length>0){
      val = double.parse(value);
      if (val>=35 && val<=60)
        {
          return null;
        }
      else
        {
          return "Enter Valid "+message;
        }
    }
    else{
      return message+" must require";
    }
  }
  static String validateDoubleField(double val1,double val2,String value,String message) {
    print("validatePosField...$value");
    double val;
    if(value.length>0){
      val = double.parse(value);
      if (val>=val1 && val<=val2)
      {
        return null;
      }
      else
      {
        return "Enter Valid "+message;
      }
    }
    else{
      return message+" must require";
    }
  }

  static String validateName(String value) {
    if (value.trim().length < 1)
      return 'Name must be more than 1 character';
    else
      return null;
  }
  static String validateDescription(String value) {
    if (value.trim().length < 1)
      return 'Description must require';
    else
      return null;
  }
  static String validateAddress(String value) {
    if (value.trim().length < 5)
      return 'Address must require requires at least 5 characters';
    else
      return null;
  }
  static String validatePostCode(String value) {
    if (value.trim().length < 1)
      return 'Post code must require';
    else
      return null;
  }

  static String validateBusinessName(String value) {
    if (value.trim().length < 1)
      return 'Business name must be more than 1 character';
    else
      return null;
  }

  static String validateLastName(String value) {
    if (value.trim().length < 1)
      return 'Address must be more than 1 character';
    else
      return null;
  }

  static String validateId(String value) {
    if (value.trim().length < 4)
      return 'ID must be more than 4 characters';
    else
      return null;
  }

  static String validateGender(String value) {
    if (value.toLowerCase() == "male")
      return null;
    else if (value.toLowerCase() == "female")
      return null;
    else
      return 'Gender must be male or female';
  }

  static String validateDate(DateTime date) {
    return date == null ? "Select date of birth" : null;
  }

  static String validateMobile(String value) {
    if (value.length < 9)
      return 'Enter valid mobile nubmer';
    else
      return null;
  }
  static String validateMobile2(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    }
    else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }
  static String validateHashTag(String value){
    String patttern = r"\B#+([\w]+)\b";
    RegExp regExp = new RegExp(patttern);

    if (value.length == 0) {
      return 'Please enter HashTag';
    }
    else if (!regExp.hasMatch(value)) {
      return 'Please enter valid HashTag';
    }
    return null;
  }
  static String validateMobileOrEmail(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);

    Pattern pattern1 =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex1 = new RegExp(pattern1);

    if (value.length == 0) {
      return 'Please enter mobile number or Email';
    }
    else if (!regExp.hasMatch(value) && !regex1.hasMatch(value)) {
      return 'Please enter valid mobile number or Email';
    }
    return null;
  }
  static String validateFax(String value) {
    if (value.length < 10)
      return 'Enter valid fax no';
    else
      return null;
  }

  static String validateWebSite(String value) {
    if (value.length < 5)
      return 'Enter valid website';
    else
      return null;
  }

  static String validateFacebookId(String value) {
    if (value.length < 5)
      return 'Enter valid facebook id';
    else
      return null;
  }

  static String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'The email is used for login and password retrieval, \n so make sure it\'s a valid one';
    else
      return null;
  }

  static String validateEmail2(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter valid email address';
    else
      return null;
  }

  static String validateUsername(String value) {
    if (value.length < 2 )
      return 'Name must be greater then 2';
    else
      return null;
  }

  static String validateInviteCode(String value) {
    if (value.length != 8)
      return 'Invite code must be 8 characters';
    else
      return null;
  }

  static String validateSchoolCode(String value) {
    if (value.length == 8)
      return null;
    else
      return 'School code must be 8 characters';
  }

  static String validatePassword(String value) {
    if (value.length < 3)
      return 'Required 3 to 20 characters';
    else
      return null;
  }
  static String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365)
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    if (diff.inDays > 30)
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    if (diff.inDays > 7)
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    if (diff.inDays > 0)
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    if (diff.inHours > 0)
      return "${diff.inHours} ${diff.inHours == 1 ? "hr" : "hrs"} ago";
    if (diff.inMinutes > 0)
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "min" : "mins"} ago";
    return "just now";
  }
  static String expiresIn(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    diff *=-1;

    if (diff.inDays > 365)
      return "Expires in ${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"}";
    if (diff.inDays > 30)
      {
        return "Expires in ${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"}";
      }
    if (diff.inDays > 7)
      {
        int mod = diff.inDays % 7;
        String extraDays = mod!=0?mod.toString():"";
        return "Expires in ${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week"+" $extraDays days": "weeks"}";
      }
    if (diff.inDays > 0)
      return "Expires in ${diff.inDays} ${diff.inDays == 1 ? "day" : "days"}";
    if (diff.inHours > 0)
      return "Expires in ${diff.inHours} ${diff.inHours == 1 ? "hr" : "hrs"}";
    if (diff.inMinutes > 0)
      return "Expires in ${diff.inMinutes} ${diff.inMinutes == 1 ? "min" : "mins"}";
    return "Already Expired";
  }
}