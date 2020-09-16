//class User {
//  User({
//    this.id,
//    this.username,
//    this.email,
//    this.password,
//    this.apiKey,
//    this.token,
//    this.status,
//    this.createdAt,
//    this.updatedAt,
//    this.emailToken,
//  });
//
//  String id;
//  String username;
//  String email;
//  String password;
//  String apiKey;
//  String token;
//  String status;
//  DateTime createdAt;
//  DateTime updatedAt;
//  dynamic emailToken;
//
//  factory User.fromJson(Map<String, dynamic> json) => User(
//    id: json["id"],
//    username: json["username"],
//    email: json["email"],
//    password: json["password"],
//    apiKey: json["api_key"],
//    token: json["token"],
//    status: json["status"],
//    createdAt: DateTime.parse(json["created_at"]),
//    updatedAt: DateTime.parse(json["updated_at"]),
//    emailToken: json["email_token"],
//  );
//
//  Map<String, dynamic> toJson() => {
//    "id": id,
//    "username": username,
//    "email": email,
//    "password": password,
//    "api_key": apiKey,
//    "token": token,
//    "status": status,
//    "created_at": createdAt.toIso8601String(),
//    "updated_at": updatedAt.toIso8601String(),
//    "email_token": emailToken,
//  };
//}

class User {
  User({
    this.uid,
    this.uname,
    this.upassword,
    this.entryDate,
    this.doctorName,
    this.hospitalName,
    this.addressLine1,
    this.addressLine2,
    this.addressLine3,
    this.city,
    this.pincodeNo,
    this.state,
    this.country,
    this.region,
    this.contactno,
    this.countryCode,
    this.areaCode,
    this.landline,
    this.emailid,
    this.userHits,
    this.phakicUserHits,
    this.bioringUserHits,
    this.activeStatus,
  });

  String uid;
  String uname;
  String upassword;
  DateTime entryDate;
  String doctorName;
  String hospitalName;
  String addressLine1;
  String addressLine2;
  String addressLine3;
  String city;
  String pincodeNo;
  String state;
  String country;
  String region;
  String contactno;
  String countryCode;
  String areaCode;
  String landline;
  String emailid;
  String userHits;
  String phakicUserHits;
  String bioringUserHits;
  String activeStatus;

  factory User.fromJson(Map<String, dynamic> json) => User(
    uid: json["uid"],
    uname: json["uname"],
    upassword: json["upassword"],
    entryDate: DateTime.parse(json["entry_date"]),
    doctorName: json["doctor_name"],
    hospitalName: json["hospital_name"],
    addressLine1: json["address_line1"],
    addressLine2: json["address_line2"],
    addressLine3: json["address_line3"],
    city: json["city"],
    pincodeNo: json["pincode_no"],
    state: json["state"],
    country: json["country"],
    region: json["region"],
    contactno: json["contactno"],
    countryCode: json["country_code"],
    areaCode: json["area_code"],
    landline: json["landline"],
    emailid: json["emailid"],
    userHits: json["user_hits"],
    phakicUserHits: json["phakic_user_hits"],
    bioringUserHits: json["bioring_user_hits"],
    activeStatus: json["active_status"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "uname": uname,
    "upassword": upassword,
    "entry_date": "${entryDate.year.toString().padLeft(4, '0')}-${entryDate.month.toString().padLeft(2, '0')}-${entryDate.day.toString().padLeft(2, '0')}",
    "doctor_name": doctorName,
    "hospital_name": hospitalName,
    "address_line1": addressLine1,
    "address_line2": addressLine2,
    "address_line3": addressLine3,
    "city": city,
    "pincode_no": pincodeNo,
    "state": state,
    "country": country,
    "region": region,
    "contactno": contactno,
    "country_code": countryCode,
    "area_code": areaCode,
    "landline": landline,
    "emailid": emailid,
    "user_hits": userHits,
    "phakic_user_hits": phakicUserHits,
    "bioring_user_hits": bioringUserHits,
    "active_status": activeStatus,
  };
}