


import 'college_model.dart';

class CollegeData {
  List<CollegeModel>? college;
  List<Infra>? infra;
  List<Highlight>? highlight;
  List<Sports>? sports;
  List<Cultural>? cultural;
  List<Acedemic>? acedemic;
  List<AluminiAndToppers>? aluminiAndToppers;
  List<ManagementStaff>? managementStaff;
  List<Subject>? subject;
  List<FeeStructure>? feeStructure;
  List<Clgimage>? clgimage;
  List<ClgpolicySocialMedia>? clgpolicySocialMedia;
  List<VideoUrl>? videoUrl;

  CollegeData(
      {this.college,
        this.infra,
        this.highlight,
        this.sports,
        this.cultural,
        this.acedemic,
        this.aluminiAndToppers,
        this.managementStaff,
        this.subject,
        this.feeStructure,
        this.clgimage,
        this.clgpolicySocialMedia,
        this.videoUrl});

  CollegeData.fromJson(Map<String, dynamic> json) {
    college = _convertToList<CollegeModel>(
        json['college'], (v) => CollegeModel.fromJson(v));
    infra = _convertToList<Infra>(json['infra'], (v) => Infra.fromJson(v));
    highlight = _convertToList<Highlight>(
        json['highlight'], (v) => Highlight.fromJson(v));
    sports = _convertToList<Sports>(json['sports'], (v) => Sports.fromJson(v));
    cultural =
        _convertToList<Cultural>(json['cultural'], (v) => Cultural.fromJson(v));
    acedemic =
        _convertToList<Acedemic>(json['acedemic'], (v) => Acedemic.fromJson(v));
    aluminiAndToppers = _convertToList<AluminiAndToppers>(
        json['alumini_and_toppers'], (v) => AluminiAndToppers.fromJson(v));
    managementStaff = _convertToList<ManagementStaff>(
        json['management_staff'], (v) => ManagementStaff.fromJson(v));
    subject =
        _convertToList<Subject>(json['subject'], (v) => Subject.fromJson(v));
    feeStructure = _convertToList<FeeStructure>(
        json['feeStructure'], (v) => FeeStructure.fromJson(v));
    clgimage =
        _convertToList<Clgimage>(json['clgimage'], (v) => Clgimage.fromJson(v));
    clgpolicySocialMedia = _convertToList<ClgpolicySocialMedia>(
        json['clgpolicySocialMedia'], (v) => ClgpolicySocialMedia.fromJson(v));
    videoUrl =
        _convertToList<VideoUrl>(json['videoUrl'], (v) => VideoUrl.fromJson(v));
  }

  List<T>? _convertToList<T>(dynamic jsonValue, T Function(dynamic) fromJson) {
    if (jsonValue == null) {
      return null;
    } else if (jsonValue is List) {
      return jsonValue.map<T>((item) => fromJson(item)).toList();
    } else if (jsonValue is Map) {
      return [fromJson(jsonValue)];
    } else {
      throw ArgumentError("Unexpected type: $jsonValue");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.college != null) {
      data['college'] = this.college!.map((v) => v.toJson()).toList();
    }
    if (this.infra != null) {
      data['infra'] = this.infra!.map((v) => v.toJson()).toList();
    }
    if (this.highlight != null) {
      data['highlight'] = this.highlight!.map((v) => v.toJson()).toList();
    }
    if (this.sports != null) {
      data['sports'] = this.sports!.map((v) => v.toJson()).toList();
    }
    if (this.cultural != null) {
      data['cultural'] = this.cultural!.map((v) => v.toJson()).toList();
    }
    if (this.acedemic != null) {
      data['acedemic'] = this.acedemic!.map((v) => v.toJson()).toList();
    }
    if (this.aluminiAndToppers != null) {
      data['alumini_and_toppers'] =
          this.aluminiAndToppers!.map((v) => v.toJson()).toList();
    }
    if (this.managementStaff != null) {
      data['management_staff'] =
          this.managementStaff!.map((v) => v.toJson()).toList();
    }
    if (this.subject != null) {
      data['subject'] = this.subject!.map((v) => v.toJson()).toList();
    }
    if (this.feeStructure != null) {
      data['feeStructure'] = this.feeStructure!.map((v) => v.toJson()).toList();
    }
    if (this.clgimage != null) {
      data['clgimage'] = this.clgimage!.map((v) => v.toJson()).toList();
    }
    if (this.clgpolicySocialMedia != null) {
      data['clgpolicySocialMedia'] =
          this.clgpolicySocialMedia!.map((v) => v.toJson()).toList();
    }
    if (this.videoUrl != null) {
      data['videoUrl'] = this.videoUrl!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Phone {
  String? phone;
  String? phone2;

  Phone({this.phone, this.phone2});

  Phone.fromJson(Map<String, dynamic> json) {
    phone = json['phone '];
    phone2 = json['phone2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone '] = this.phone;
    data['phone2'] = this.phone2;
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

class Infra {
  String? sId;
  String? collegeid;
  String? infraid;
  bool? smartclass;
  bool? staffroom;
  bool? auditorium;
  bool? computerlab;
  bool? hostel;
  bool? bustransport;
  bool? parking;
  bool? cctv;
  bool? library;
  bool? elevator;
  bool? powerbackup;
  bool? canteen;
  bool? medicalsupport;
  bool? firesafety;
  bool? emergencyexit;
  bool? playground;
  int? createdAt;
  int? iV;
  String? moreinfo;
  String? isDeleted;

  Infra(
      {this.sId,
        this.collegeid,
        this.infraid,
        this.smartclass,
        this.staffroom,
        this.auditorium,
        this.computerlab,
        this.hostel,
        this.bustransport,
        this.parking,
        this.cctv,
        this.library,
        this.elevator,
        this.powerbackup,
        this.canteen,
        this.medicalsupport,
        this.firesafety,
        this.emergencyexit,
        this.playground,
        this.createdAt,
        this.iV,
        this.moreinfo,
        this.isDeleted});

  Infra.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    collegeid = json['collegeid'];
    infraid = json['infraid'];
    smartclass = json['smartclass'];
    staffroom = json['staffroom'];
    auditorium = json['auditorium'];
    computerlab = json['computerlab'];
    hostel = json['hostel'];
    bustransport = json['bustransport'];
    parking = json['parking'];
    cctv = json['cctv'];
    library = json['library'];
    elevator = json['elevator'];
    powerbackup = json['powerbackup'];
    canteen = json['canteen'];
    medicalsupport = json['medicalsupport'];
    firesafety = json['firesafety'];
    emergencyexit = json['emergencyexit'];
    playground = json['playground'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    moreinfo = json['moreinfo'];
    isDeleted = json["isDeleted"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['collegeid'] = this.collegeid;
    data['infraid'] = this.infraid;
    data['smartclass'] = this.smartclass;
    data['staffroom'] = this.staffroom;
    data['auditorium'] = this.auditorium;
    data['computerlab'] = this.computerlab;
    data['hostel'] = this.hostel;
    data['bustransport'] = this.bustransport;
    data['parking'] = this.parking;
    data['cctv'] = this.cctv;
    data['library'] = this.library;
    data['elevator'] = this.elevator;
    data['powerbackup'] = this.powerbackup;
    data['canteen'] = this.canteen;
    data['medicalsupport'] = this.medicalsupport;
    data['firesafety'] = this.firesafety;
    data['emergencyexit'] = this.emergencyexit;
    data['playground'] = this.playground;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    data['moreinfo'] = this.moreinfo;
    data["isDeleted"] = this.isDeleted;
    return data;
  }
}

class Highlight {
  String? sId;
  String? collegeid;
  String? highlightid;
  List<dynamic>? skillDevelopment;
  List? career;
  List? scholarship;
  String? safetySecurity;
  String? isDeleted;
  int? createdAt;
  int? iV;

  Highlight(
      {this.sId,
        this.collegeid,
        this.highlightid,
        this.skillDevelopment,
        this.career,
        this.scholarship,
        this.safetySecurity,
        this.isDeleted,
        this.createdAt,
        this.iV});

  Highlight.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    collegeid = json['collegeid'];
    highlightid = json['highlightid'];
    if (json['skill_development'] != null) {
      skillDevelopment = <SkillDevelopment>[];
      json['skill_development'].forEach((v) {
        skillDevelopment!.add(new SkillDevelopment.fromJson(v));
      });
    }
    if (json['career'] != null) {
      career = [];
      json['career'].forEach((v) {
        career!.add(v);
      });
    }
    if (json['scholarship'] != null) {
      scholarship = [];
      json['scholarship'].forEach((v) {
        scholarship!.add(v);
      });
    }
    safetySecurity = json['safety_security'];
    isDeleted = json["isDeleted"];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['collegeid'] = collegeid;
    data['highlightid'] = highlightid;
    if (skillDevelopment != null) {
      data['skill_development'] =
          // skillDevelopment!.map((v) => v.toJson()).toList();
      skillDevelopment!.toList();

    }
    if (career != null) {
      // data['career'] = career!.map((v) => v.toJson()).toList();
      data['career'] = career!.toList();

    }
    if (scholarship != null) {
      // data['scholarship'] = scholarship!.map((v) => v.toJson()).toList();
      data['scholarship'] = scholarship!.toList();

    }
    data['safety_security'] = safetySecurity;
    data["isDeleted"] = isDeleted;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    return data;
  }
}

class SkillDevelopment {
  bool? status;
  String? description;

  SkillDevelopment({this.status, this.description});

  SkillDevelopment.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['description'] = this.description;
    return data;
  }
}

class Sports {
  String? sId;
  String? sportsid;
  String? collegeid;
  String? imageUrl;
  String? moreInfo;
  String? imagename;
  String? isDeleted;
  int? createdAt;
  int? iV;

  Sports(
      {this.sId,
        this.sportsid,
        this.collegeid,
        this.imageUrl,
        this.moreInfo,
        this.imagename,
        this.isDeleted,
        this.createdAt,
        this.iV});

  Sports.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sportsid = json['sportsid'];
    collegeid = json['collegeid'];
    imageUrl = json['imageUrl'];
    moreInfo = json['more_info'];
    imagename = json['imagename'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['sportsid'] = this.sportsid;
    data['collegeid'] = this.collegeid;
    data['imageUrl'] = this.imageUrl;
    data['more_info'] = this.moreInfo;
    data['imagename'] = this.imagename;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Cultural {
  String? sId;
  String? culturalid;
  String? collegeid;
  String? imageUrl;
  String? imagename;
  String? moreInfo;
  String? isDeleted;
  int? createdAt;
  int? iV;

  Cultural(
      {this.sId,
        this.culturalid,
        this.collegeid,
        this.imageUrl,
        this.imagename,
        this.moreInfo,
        this.isDeleted,
        this.createdAt,
        this.iV});

  Cultural.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    culturalid = json['culturalid'];
    collegeid = json['collegeid'];
    imageUrl = json['imageUrl'];
    imagename = json['imagename'];
    moreInfo = json['more_info'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['culturalid'] = this.culturalid;
    data['collegeid'] = this.collegeid;
    data['imageUrl'] = this.imageUrl;
    data['imagename'] = this.imagename;
    data['more_info'] = this.moreInfo;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Acedemic {
  String? sId;
  String? academicid;
  String? collegeid;
  String? imageUrl;
  String? imagename;
  String? moreInfo;
  String? isDeleted;
  int? createdAt;
  int? iV;

  Acedemic(
      {this.sId,
        this.academicid,
        this.collegeid,
        this.imageUrl,
        this.imagename,
        this.moreInfo,
        this.isDeleted,
        this.createdAt,
        this.iV});

  Acedemic.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    academicid = json['academicid'];
    collegeid = json['collegeid'];
    imageUrl = json['imageUrl'];
    imagename = json['imagename'];
    moreInfo = json['more_info'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['academicid'] = this.academicid;
    data['collegeid'] = this.collegeid;
    data['imageUrl'] = this.imageUrl;
    data['imagename'] = this.imagename;
    data['more_info'] = this.moreInfo;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class AluminiAndToppers {
  String? sId;
  String? alutopperid;
  String? collegeid;
  String? imageUrl;
  String? name;
  int? passingOutYear;
  int? marks;
  String? isDeleted;
  String? moreInfo;
  int? createdAt;
  int? iV;

  AluminiAndToppers(
      {this.sId,
        this.alutopperid,
        this.collegeid,
        this.imageUrl,
        this.name,
        this.passingOutYear,
        this.marks,
        this.isDeleted,
        this.moreInfo,
        this.createdAt,
        this.iV});

  AluminiAndToppers.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    alutopperid = json['alutopperid'];
    collegeid = json['collegeid'];
    imageUrl = json['imageUrl'];
    name = json['name'];
    passingOutYear = json['passing_out_year'];
    marks = json['marks']?.toInt(); // Convert marks to an integer
    isDeleted = json['isDeleted'];
    moreInfo = json['more_info'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['alutopperid'] = this.alutopperid;
    data['collegeid'] = this.collegeid;
    data['imageUrl'] = this.imageUrl;
    data['name'] = this.name;
    data['passing_out_year'] = this.passingOutYear;
    data['marks'] = this.marks;
    data['isDeleted'] = this.isDeleted;
    data['more_info'] = this.moreInfo;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class ManagementStaff {
  String? sId;
  String? collegeid;
  String? url;
  String? staffid;
  String? name;
  String? qualification;
  List<Experience>? experience;
  String? designation;
  String? about;
  bool? isOpen;
  String? isDeleted;
  int? createdAt;
  int? iV;

  ManagementStaff(
      {this.sId,
        this.collegeid,
        this.url,
        this.staffid,
        this.name,
        this.qualification,
        this.experience,
        this.designation,
        this.about,
        this.isOpen,
        this.isDeleted,
        this.createdAt,
        this.iV});

  ManagementStaff.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    collegeid = json['collegeid'];
    url = json['url'];
    staffid = json['staffid'];
    name = json['name'];
    qualification = json['qualification'];
    if (json['experience'] != null) {
      experience = <Experience>[];
      json['experience'].forEach((v) {
        experience!.add(new Experience.fromJson(v));
      });
    }
    designation = json['designation'];
    about = json['about'];
    isOpen = json['isOpen'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['collegeid'] = this.collegeid;
    data['url'] = this.url;
    data['staffid'] = this.staffid;
    data['name'] = this.name;
    data['qualification'] = this.qualification;
    if (this.experience != null) {
      data['experience'] = this.experience!.map((v) => v.toJson()).toList();
    }
    data['designation'] = this.designation;
    data['about'] = this.about;
    data['isOpen'] = this.isOpen;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Experience {
  String? total;
  String? current;

  Experience({this.total, this.current});

  Experience.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    current = json['current'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['current'] = this.current;
    return data;
  }
}

class Subject {
  String? sId;
  String? collegeid;
  String? subjectid;
  String? subjectname;
  String? description;
  int? noOfSeats;
  int? minFees;
  int? maxFees;
  String? isDeleted;
  int? createdAt;
  int? iV;

  Subject(
      {this.sId,
        this.collegeid,
        this.subjectid,
        this.subjectname,
        this.description,
        this.noOfSeats,
        this.minFees,
        this.maxFees,
        this.isDeleted,
        this.createdAt,
        this.iV});

  Subject.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    collegeid = json['collegeid'];
    subjectid = json['subjectid'];
    subjectname = json['subjectname'];
    description = json['description'];
    noOfSeats = json['no_of_seats'];
    minFees = json['minFees'];
    maxFees = json['maxFees'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['collegeid'] = this.collegeid;
    data['subjectid'] = this.subjectid;
    data['subjectname'] = this.subjectname;
    data['description'] = this.description;
    data['no_of_seats'] = this.noOfSeats;
    data['minFees'] = this.minFees;
    data['maxFees'] = this.maxFees;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class FeeStructure {
  String? sId;
  String? collegeid;
  String? feeStructureid;
  String? eligibilityCriteria;
  String? feeTerms;
  String? isDeleted;
  int? createdAt;
  int? iV;

  FeeStructure(
      {this.sId,
        this.collegeid,
        this.feeStructureid,
        this.eligibilityCriteria,
        this.feeTerms,
        this.isDeleted,
        this.createdAt,
        this.iV});

  FeeStructure.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    collegeid = json['collegeid'];
    feeStructureid = json['fee_structureid'];
    eligibilityCriteria = json['eligibility_criteria'];
    feeTerms = json['fee_terms'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['collegeid'] = this.collegeid;
    data['fee_structureid'] = this.feeStructureid;
    data['eligibility_criteria'] = this.eligibilityCriteria;
    data['fee_terms'] = this.feeTerms;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Clgimage {
  String? sId;
  String? clgimageid;
  String? collegeid;
  String? imageUrl;
  String? name;
  String? isDeleted;
  int? createdAt;
  int? iV;

  Clgimage(
      {this.sId,
        this.clgimageid,
        this.collegeid,
        this.imageUrl,
        this.name,
        this.isDeleted,
        this.createdAt,
        this.iV});

  Clgimage.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    clgimageid = json['clgimageid'];
    collegeid = json['collegeid'];
    imageUrl = json['imageUrl'];
    name = json['name'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['clgimageid'] = this.clgimageid;
    data['collegeid'] = this.collegeid;
    data['imageUrl'] = this.imageUrl;
    data['name'] = this.name;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class ClgpolicySocialMedia {
  String? sId;
  String? collegeid;
  String? clgpolicyid;
  String? termsCondition;
  String? website;
  String? facebook;
  String? youtube;
  String? instagram;
  String? isDeleted;
  int? createdAt;
  int? iV;

  ClgpolicySocialMedia(
      {this.sId,
        this.collegeid,
        this.clgpolicyid,
        this.termsCondition,
        this.website,
        this.facebook,
        this.youtube,
        this.instagram,
        this.isDeleted,
        this.createdAt,
        this.iV});

  ClgpolicySocialMedia.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    collegeid = json['collegeid'];
    clgpolicyid = json['clgpolicyid'];
    termsCondition = json['terms_condition'];
    website = json['website'];
    facebook = json['facebook'];
    youtube = json['youtube'];
    instagram = json['instagram'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['collegeid'] = this.collegeid;
    data['clgpolicyid'] = this.clgpolicyid;
    data['terms_condition'] = this.termsCondition;
    data['website'] = this.website;
    data['facebook'] = this.facebook;
    data['youtube'] = this.youtube;
    data['instagram'] = this.instagram;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class VideoUrl {
  String? sId;
  String? collegeid;
  String? videourlid;
  String? videoUrl0;
  String? videoUrl1;
  String? videoUrl2;
  String? videoUrl3;
  String? videoUrl4;
  String? isDeleted;
  int? createdAt;
  int? iV;

  VideoUrl(
      {this.sId,
        this.collegeid,
        this.videourlid,
        this.videoUrl0,
        this.videoUrl1,
        this.videoUrl2,
        this.videoUrl3,
        this.videoUrl4,
        this.isDeleted,
        this.createdAt,
        this.iV});

  VideoUrl.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    collegeid = json['collegeid'];
    videourlid = json['videourlid'];
    videoUrl0 = json['videoUrl0'];
    videoUrl1 = json['videoUrl1'];
    videoUrl2 = json['videoUrl2'];
    videoUrl3 = json['videoUrl3'];
      videoUrl4 = json['videoUrl4'];
      isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['collegeid'] = this.collegeid;
    data['videourlid'] = this.videourlid;
    data['videoUrl0'] = this.videoUrl0;
    data['videoUrl1'] = this.videoUrl1;
    data['videoUrl2'] = this.videoUrl2;
    data['videoUrl3'] = this.videoUrl3;
    data['videoUrl4'] = this.videoUrl4;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
