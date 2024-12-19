class CollegeDataModel {
  String? sId;
  String? collegeid;
  String? collegename;
  String? email;
  List<Phone>? phone;
  String? address;
  String? location;
  String? collegeType;
  String? systemType;
  String? academicType;
  String? affiliated;
  int? classRooms;
  int? totalSeats;
  String? classType;
  int? collegeCode;
  int? collegeArea;
  int? noOfFloors;
  List<Timings>? timings;
  String? moreInfo;
  int? totalAdmission;
  int? appliedAdmission;
  int? createdAt;
  int? iV;

  CollegeDataModel(
      {this.sId,
        this.collegeid,
        this.collegename,
        this.email,
        this.phone,
        this.address,
        this.location,
        this.collegeType,
        this.systemType,
        this.academicType,
        this.affiliated,
        this.classRooms,
        this.totalSeats,
        this.classType,
        this.collegeCode,
        this.collegeArea,
        this.noOfFloors,
        this.timings,
        this.moreInfo,
        this.totalAdmission,
        this.appliedAdmission,
        this.createdAt,
        this.iV});

  CollegeDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    collegeid = json['collegeid'];
    collegename = json['collegename'];
    email = json['email'];
    if (json['phone'] != null) {
      phone = <Phone>[];
      json['phone'].forEach((v) {
        phone!.add(new Phone.fromJson(v));
      });
    }
    address = json['address'];
    location = json['location'];
    collegeType = json['college_type'];
    systemType = json['system_type'];
    academicType = json['academic_type'];
    affiliated = json['affiliated'];
    classRooms = json['class_rooms'];
    totalSeats = json['total_seats'];
    classType = json['class_type'];
    collegeCode = json['college_code'];
    collegeArea = json['college_area'];
    noOfFloors = json['no_of_floors'];
    if (json['timings'] != null) {
      timings = <Timings>[];
      json['timings'].forEach((v) {
        timings!.add( Timings.fromJson(v));
      });
    }
    moreInfo = json['more_info'];
    totalAdmission = json['total_admission'];
    appliedAdmission = json['applied_admission'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['_id'] = this.sId;
    data['collegeid'] = this.collegeid;
    data['collegename'] = this.collegename;
    data['email'] = this.email;
    if (this.phone != null) {
      data['phone'] = this.phone!.map((v) => v.toJson()).toList();
    }
    data['address'] = this.address;
    data['location'] = this.location;
    data['college_type'] = this.collegeType;
    data['system_type'] = this.systemType;
    data['academic_type'] = this.academicType;
    data['affiliated'] = this.affiliated;
    data['class_rooms'] = this.classRooms;
    data['total_seats'] = this.totalSeats;
    data['class_type'] = this.classType;
    data['college_code'] = this.collegeCode;
    data['college_area'] = this.collegeArea;
    data['no_of_floors'] = this.noOfFloors;
    if (this.timings != null) {
      data['timings'] = this.timings!.map((v) => v.toJson()).toList();
    }
    data['more_info'] = this.moreInfo;
    data['total_admission'] = this.totalAdmission;
    data['applied_admission'] = this.appliedAdmission;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Phone {
  String? phone;


  Phone({this.phone});

  Phone.fromJson(Map<String, dynamic> json) {
    phone = json['phone '];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone '] = this.phone;

    return data;
  }
}

class Timings {
  String? open;
  String? close;
  String? monToSat;
  String? sId;

  Timings({this.open, this.close, this.monToSat, this.sId});

  Timings.fromJson(Map<String, dynamic> json) {
    open = json['open'];
    close = json['close'];
    monToSat = json['Mon_to_Sat'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['open'] = this.open;
    data['close'] = this.close;
    data['Mon_to_Sat'] = this.monToSat;
    data['_id'] = this.sId;
    return data;
  }
}
