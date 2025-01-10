

import '../../college/model/college_model.dart';

class CollegeModel {
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
  String? classRooms;
  String? totalSeats;
  String? classType;
  String? collegeCode;
  String? collegeArea;
  String? collegeStatus;
  String? area;
  String? city;
  String? noOfFloors;
  List<Timings>? timings;
  String? moreInfo;
  String? description;
  String? history_achievements;
  String? isDeleted;
  String? totalAdmission;
  String? appliedAdmission;
  int? createdAt;
  int? iV;

  CollegeModel(
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
        this.collegeStatus,
        this.area,
        this.city,
        this.noOfFloors,
        this.timings,
        this.moreInfo,
        this.description,
        this.history_achievements,
        this.isDeleted,
        this.totalAdmission,
        this.appliedAdmission,
        this.createdAt,
        this.iV});

  CollegeModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    collegeid = json['collegeid'];
    collegename = json['collegename'];
    email = json['email'];
    if (json['phone'] != null) {
      if (json['phone'] is List) {
        phone = List<Phone>.from(json['phone'].map((v) => Phone.fromJson(v)));
      } else if (json['phone'] is Map) {
        phone = [Phone.fromJson(json['phone'])];
      }
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
    collegeStatus = json['collegeStatus'];
    area        = json['area'];
    city        = json['city'];
    noOfFloors = json['no_of_floors'];
    if (json['timings'] != null) {
      if (json['timings'] is List) {
        timings =
        List<Timings>.from(json['timings'].map((v) => Timings.fromJson(v)));
      } else if (json['timings'] is Map) {
        timings = [Timings.fromJson(json['timings'])];
      }
    }
    moreInfo = json['more_info'];
    description = json["Description"];
    history_achievements = json["History_Achievements"];
    isDeleted = json["false"];
    totalAdmission = json['total_admission'];
    appliedAdmission = json['applied_admission'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['collegeStatus'] = this.collegeStatus;
    data['area']         = this.area;
    data['city']         = this.city;
    data['no_of_floors'] = this.noOfFloors;
    if (this.timings != null) {
      data['timings'] = this.timings!.map((v) => v.toJson()).toList();
    }
    data['more_info'] = this.moreInfo;
    data["Description"] = this.description;
    data["History_Achievements"] = this.history_achievements;
    data["isDeleted"] = this.isDeleted;
    data['total_admission'] = this.totalAdmission;
    data['applied_admission'] = this.appliedAdmission;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
