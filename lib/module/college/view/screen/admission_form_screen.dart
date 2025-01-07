import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

import '../../../../utils/StudentDetails.dart';
import '../../../../utils/apiData/api_base_port.dart';
import '../../../../utils/commonWidget/common_datepicker.dart';
import '../../../../utils/commonWidget/common_vertical_divider.dart';
import '../../../../utils/commonWidget/keyboard_off.dart';
import '../../../../utils/constant/asset_icons.dart';
import '../../../../utils/size/app_sizing.dart';
import '../../../../utils/theme/common_color.dart';
import '../../dependencies/college_dependencies.dart';
import '../widget/admission_form_content_title.dart';
import '../widget/admission_form_screen_drop_down.dart';
import '../widget/admission_form_screen_text_field.dart';
import '../widget/file_picker_box.dart';
import '../widget/t&c_button.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class AdmissionForm extends StatefulWidget {
  const AdmissionForm(
      {super.key,
      required this.collegeName,
      required this.collegeId,
      this.subjectName,
      required this.collegeImage});

  final String collegeImage;
  final String collegeName;
  final String collegeId;
  final List<dynamic>? subjectName;

  @override
  State<AdmissionForm> createState() => _AdmissionFormState();
}

class _AdmissionFormState extends State<AdmissionForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Map<String, TextEditingController> controllers = {};

  List<Map<String, dynamic>> perSubOfCollegeList = [];
  List<String> subNamesList = [];
  String selectedCourseId = "";
  // int currentStep = 0;

  void _createTextEditingController(String fieldName) {
    controllers[fieldName] = TextEditingController();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    List subList = widget.subjectName as List<dynamic>;

    for (var i = 0; i < subList.length; i++) {
      if (subList[i]["collegeid"] == widget.collegeId) {
        print("your i === $i");
        perSubOfCollegeList.add(subList[i]);
        subNamesList.add(subList[i]["subjectname"]);
      }
    }
    print("subject List = $subNamesList");

    //Student details.
    _createTextEditingController('name');
    _createTextEditingController('surname');
    _createTextEditingController('select_subject');
    _createTextEditingController('nationality');
    _createTextEditingController('mother_tongue');
    _createTextEditingController('gender');
    _createTextEditingController('dob');
    _createTextEditingController('blood_group');
    _createTextEditingController('city');
    _createTextEditingController('district');
    _createTextEditingController('state');
    _createTextEditingController('religion');
    _createTextEditingController('caste_name');
    _createTextEditingController('sub_caste_name');
    _createTextEditingController('caste_category');
    _createTextEditingController('reservation');
    _createTextEditingController('examination_passed');
    _createTextEditingController('school_last_studied');
    _createTextEditingController('exam_year');
    // _createTextEditingController('group_applied');
    _createTextEditingController('second_language');
    _createTextEditingController('hall_ticket_no');
    _createTextEditingController('aadhar_no');

    // Parents details..

    _createTextEditingController('name_of_father');
    _createTextEditingController('occupation');
    _createTextEditingController('annual_income');
    _createTextEditingController('address_residence');
    _createTextEditingController('address_permanent');
    _createTextEditingController('city');
    _createTextEditingController('state');
    _createTextEditingController('phone');
    _createTextEditingController('email');
  }

  void _populateFormData() async {
    final SharedPreferences prefs = await _prefs;

    controllers['name']!.text = prefs.getString('name') ?? '';
    controllers['surname']!.text = prefs.getString('surname') ?? '';
    controllers['nationality']!.text = prefs.getString('nationality') ?? '';
    controllers['mother_tongue']!.text = prefs.getString('mother_tongue') ?? '';
    // controllers['gender']!.text = prefs.getString('gender')  ?? '';    // not show save data..
    controllers['dob']!.text = prefs.getString('dob') ?? '';
    // controllers['blood_group']!.text = prefs.getString('blood_group')  ?? '';       // not show save data..
    // controllers['city']!.text = prefs.getString('city')  ?? '';                     // not show save data..
    // controllers['district']!.text =  prefs.getString('district')  ?? '';                // not show save data..
    // controllers['state']!.text =  prefs.getString('state')  ?? '';              // not show save data..
    // controllers['religion']!.text = prefs.getString('religion')  ?? '';             // not show save data..
    controllers['caste_name']!.text = prefs.getString('caste_name') ?? '';
    controllers['sub_caste_name']!.text =
        prefs.getString('sub_caste_name') ?? '';
    // controllers['caste_category']!.text = prefs.getString('caste_category')  ?? '';            // not show save data..
    // controllers['reservation']!.text =prefs.getString('reservation')  ?? '';             // not show save data..
    controllers['examination_passed']!.text =
        prefs.getString('examination_passed') ?? '';
    controllers['school_last_studied']!.text =
        prefs.getString('school_last_studied') ?? '';
    controllers['exam_year']!.text = prefs.getString('exam_year') ?? '';
    // controllers['group_applied']!.text = prefs.getString('group_applied')  ?? '';            // not show save data..
    // controllers['second_language']!.text = prefs.getString('second_language')  ?? '';         // not show save data..
    controllers['hall_ticket_no']!.text =
        prefs.getString('hall_ticket_no') ?? '';
    controllers['aadhar_no']!.text = prefs.getString('aadhar_no') ?? '';
  }

  @override
  void dispose() {
    controllers.forEach((key, controller) => controller.dispose());

    kCollegeController.dateOfBirth.value = null;
    kCollegeController.studentPhotoDocument.value = null;
    kCollegeController.hallTicketDocument.value = null;
    kCollegeController.adharCardDocument.value = null;
    kCollegeController.casteCertificateDocument.value = null;
    kCollegeController.termsAndConditionRead.value = false;
    kCollegeController.admissionDetailRead.value = false;
    super.dispose();
  }


  Future<void> _submitAdmissionData() async {
    String apiUrl = '${ApiBasePort.apiBaseUrl}/v2/apply/clg';

    // String apiUrl = 'https://backend.scolage.com/v2/apply/clg';
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String subjectID = "";
    String? studentId = prefs.getString("studentId");

    for (int i = 0; i < perSubOfCollegeList.length; i++) {
      if (perSubOfCollegeList[i]["subjectname"] ==
          controllers['select_subject']?.text) {
        subjectID = perSubOfCollegeList[i]["subjectid"];
        break;
      }
    }
    print("your student id ===== ${prefs.getString("studentId")}");
    print("your subject id ===== ${subjectID}");
    print("your student = ${StudentDetails.studentId}");
    print("current college id === ${widget.collegeId}");



    Map<String, dynamic> admissionData = {
      "studentid": studentId,
      "collegeid": widget.collegeId,
      "subjectid": subjectID,
      "student_detail": {
        'name': controllers['name']?.text,
        'surname': controllers['surname']?.text,
        'select_subject': controllers['select_subject']?.text,
        'nationality': controllers['nationality']?.text,
        'mother_tongue': controllers['mother_tongue']?.text,
        'gender': controllers['gender']?.text,
        'dob': "13/11/2002",
        'blood_group': controllers['blood_group']?.text,
        'city': controllers['city']!.text,
        'district': controllers['district']!.text,
        'state': controllers['state']!.text,
        'religion': controllers['religion']!.text,
        'caste_name': controllers['caste_name']?.text,
        'sub_caste_name': controllers['sub_caste_name']?.text,
        'caste_category': controllers['caste_category']!.text,
        'reservation': controllers['reservation']!.text,
        'examination_passed': controllers['examination_passed']?.text,
        'school_last_studied': controllers['school_last_studied']?.text,
        'exam_year': controllers['exam_year']?.text,
        // 'groupe_applied':controllers['group_applied']!.text,
        'second_language': controllers['second_language']!.text,
        'hall_ticket_no': controllers['hall_ticket_no']?.text,
        'aadhar_no': controllers['aadhar_no']?.text,
      },
      "parent_detail": {
        "name_of_father": controllers['name_of_father']?.text,
        "occupation": controllers["occupation"]?.text,
        "annual_income": controllers['annual_income']?.text,
        "address_residence": controllers['address_residence']?.text,
        "city": controllers['city']?.text,
        "state": controllers['state']?.text,
        "address_permanent": controllers['address_permanent']?.text,
        "phone": controllers['phone']?.text,
        "email": controllers['email']?.text
      },
      // "upload_document": {
      //   "photo_url": "dxlhkaq",
      //   "hallticket_url": "qdhxl",
      //   "aadharcard_url": "sqdbhl",
      //   "castcertificate_url": "sqihd",
      // }
    };
    
    print("your details == $admissionData");

    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl))
        ..fields['collegeid'] = widget.collegeId ?? ''
        ..fields['studentid'] = studentId ?? ''
        ..fields['subjectid'] = subjectID
        ..fields['student_detail'] = json.encode(admissionData['student_detail'])
        ..fields['parent_detail'] = json.encode(admissionData['parent_detail']);

      // Add files to the request
      if (kCollegeController.studentPhotoDocument.value != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'photo_url',
          kCollegeController.studentPhotoDocument.value!.path!,
          filename: basename(kCollegeController.studentPhotoDocument.value!.path!),
        ));
      }
      if (kCollegeController.hallTicketDocument.value != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'hallticket_url',
          kCollegeController.hallTicketDocument.value!.path!,
          filename: basename(kCollegeController.hallTicketDocument.value!.path!),
        ));
      }
      if (kCollegeController.adharCardDocument.value != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'aadharcard_url',
          kCollegeController.adharCardDocument.value!.path!,
          filename: basename(kCollegeController.adharCardDocument.value!.path!),
        ));
      }
      if (kCollegeController.casteCertificateDocument.value != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'castcertificate_url',
          kCollegeController.casteCertificateDocument.value!.path!,
          filename: basename(kCollegeController.casteCertificateDocument.value!.path!),
        ));
      }

    request.headers.addAll({'Content-Type': 'multipart/form-data'});
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print("Response ====");
      print(response.body);

      Map<String, dynamic> map = jsonDecode(response.body);

      // var response = await http.post(
      //   Uri.parse(apiUrl),
      //   body: json.encode(admissionData),
      //   headers: {'Content-Type': 'application/json'},
      // );
      // print("Response ====");
      // print(response.body);
      //
      // Map<String, dynamic> map = jsonDecode(response.body);

      if (response.statusCode == 201) {
        Fluttertoast.showToast(
            msg: "applied succesfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: kPrimaryColor,
            textColor: Colors.white,
            fontSize: 16.0);
        await saveData();
        Future.delayed(const Duration(seconds: 5), () {
          Get.back();
        });
      } else {
        Fluttertoast.showToast(
            msg: map["message"],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (error) {
      print('Error submitting admission data: $error');
      Fluttertoast.showToast(
          msg: 'Error submitting admission data',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }


  Future<void> _pickFile(Rx<PlatformFile?> fileField) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      fileField.value = result.files.single;
    }
  }

  Future<void> saveData() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('name', controllers['name']!.text);
    prefs.setString('surname', controllers['surname']!.text);
    prefs.setString('nationality', controllers['nationality']!.text);
    prefs.setString('mother_tongue', controllers['mother_tongue']!.text);
    prefs.setString('caste_name', controllers['caste_name']!.text);
    prefs.setString('sub_caste_name', controllers['sub_caste_name']!.text);
    prefs.setString(
        'examination_passed', controllers['examination_passed']!.text);
    prefs.setString(
        'school_last_studied', controllers['school_last_studied']!.text);
    prefs.setString('exam_year', controllers['exam_year']!.text);
    prefs.setString('hall_ticket_no', controllers['hall_ticket_no']!.text);
    prefs.setString('aadhar_no', controllers['aadhar_no']!.text);
  }

  @override
  Widget build(BuildContext context) {
    return KeyBoardOff(
      child: Scaffold(
        appBar: AppBar(
          leading: Center(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(100.r),
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    AssetIcons.NEARBY_SCREEN_BACK_ARROW_ICON,
                    height: 17.h,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: kPrimaryColor,
          title: const Text(
            "Admission Form",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 330,
                    width: kScreenWidth(context),
                    child: Image.network(
                      widget.collegeImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            kPrimaryColor,
                            Color.fromRGBO(157, 123, 194, 1),
                          ],
                          stops: [0.0, 1.0],
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          tileMode: TileMode.repeated,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.w, vertical: 10.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.collegeName,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "SC code-0083",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.sp,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    const AdmissionFormContentTitle(title: "Student Details"),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                          onPressed: () {
                            _populateFormData();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryColor),
                          child: const Text(
                            "Auto fill Form",
                            style: TextStyle(color: commonYellowColor),
                          )),
                    ),

                    // NAME AND SURNAME
                    Row(
                      children: [
                        Expanded(
                          child: AdmissionFormScreenTextField(
                            controller: controllers['name']!,
                            // labelText: "Name",
                            hintText: "Name",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a name';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: AdmissionFormScreenTextField(
                            controller: controllers['surname']!,
                            // labelText: "Surname",
                            hintText: "Surname",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a surname';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    // Nationality AND Mother Tongue
                    Row(
                      children: [
                        Expanded(
                          child: AdmissionFormScreenTextField(
                            controller: controllers['nationality']!,
                            // labelText: "Nationality",
                            hintText: "Nationality",
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: AdmissionFormScreenTextField(
                            controller: controllers['mother_tongue']!,
                            // labelText: "Mother Tongue",
                            hintText: "Mother Tongue",
                          ),
                        ),
                      ],
                    ),
                    // Gender, DOB AND Blood Group
                    Row(
                      children: [
                        Expanded(
                          child: AdmissionFormScreenDropDown(
                            value: controllers['gender']!.text,
                            // labelText: "Gender",
                            hintText: "Gender",
                            onChanged: (newValue) {
                              setState(() {
                                controllers['gender']!.text = newValue!;
                                saveData();
                              });
                            },
                            items: const ['Male', 'Female', 'Other'],
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                            child: // DATE OF BIRTH FIELD
                                AdmissionFormScreenTextField(
                          // labelText: "Date of birth",
                          hintText: "Date of birth",
                          controller: controllers["dob"]!,
                          onTap: () async {
                            DateTime? selectDate =
                                await CommonDatePicker.showCustomDatePicker(
                                    context: context,
                                    initialDate: DateTime.now());
                            if (selectDate != null) {
                              String formattedDate =
                                  DateFormat('dd-MM-yyyy').format(selectDate);
                              controllers["dob"]!.text = formattedDate;
                              saveData();
                            }
                          },
                        )
                            // Obx(
                            //       () =>
                            //       AdmissionFormScreenTextField(
                            //         labelText: "Date of birth",
                            //         readOnly: true,
                            //         onTap: () async {
                            //           kCollegeController.dateOfBirth.value =
                            //               await CommonDatePicker
                            //                   .showCustomDatePicker(
                            //                   context: context,
                            //                   initialDate: DateTime.now());
                            //
                            //                   // initialDate: kCollegeController
                            //                   //     .dateOfBirth.value ??
                            //                   //     DateTime.now()) ??
                            //                   // DateTime.now();
                            //         },
                            //         controller: TextEditingController(
                            //           text: CommonDateFormats.dtToDDMMYYYY(
                            //             kCollegeController.dateOfBirth.value ??
                            //                 DateTime.now(),
                            //           ),
                            //          ),
                            //       ),
                            // ),
                            ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: AdmissionFormScreenDropDown(
                            value: controllers['blood_group']!.text,
                            // labelText: "Blood Group",
                            hintText: "Blood Group",
                            onChanged: (newValue) {
                              setState(() {
                                controllers['blood_group']!.text = newValue!;
                                saveData();
                              });
                            },
                            items: const [
                              'A',
                              'A+',
                              'B',
                              'B+',
                              'O',
                              'O+',
                              'AB+',
                              'AB-'
                            ],
                          ),
                        ),
                      ],
                    ),
                    // City, District AND State Group
                    Row(
                      children: [
                        Expanded(
                          child: AdmissionFormScreenDropDown(
                            value: controllers['city']!.text,
                            // labelText: "City",
                            hintText: "City",
                            onChanged: (newValue) {
                              setState(() {
                                controllers['city']!.text = newValue!;
                              });
                            },
                            items: const [
                              'Mumbai',
                              'Surat',
                              'Rajkot',
                              'Patan',
                              'Bhuj',
                              'Vadodara',
                            ],
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: AdmissionFormScreenDropDown(
                            value: controllers['district']!.text,
                            // labelText: "District",
                            hintText: "District",
                            onChanged: (newValue) {
                              setState(() {
                                controllers['district']!.text = newValue!;
                              });
                            },
                            items: const [
                              'Gujarat',
                              'Chhattisgarh',
                              'Maharashtra',
                              'Punjab',
                              'Uttar Pradesh',
                              'Kerala',
                            ],
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: AdmissionFormScreenDropDown(
                            value: controllers['state']!.text,
                            // labelText: "State",
                            hintText: "State",
                            onChanged: (newValue) {
                              setState(() {
                                controllers['state']!.text = newValue!;
                              });
                            },
                            items: const [
                              'Gujarat',
                              'Maharashtra',
                              'Uttar Pradesh',
                              'Kerala',
                            ],
                          ),
                        ),
                      ],
                    ),
                    AdmissionFormScreenDropDown(
                      value: controllers['religion']!.text,
                      // labelText: "Religion",
                      hintText: "Religion",
                      onChanged: (newValue) {
                        setState(() {
                          controllers['religion']!.text = newValue!;
                        });
                      },
                      items: const [
                        'Hinduism',
                        'Christianity',
                        'Islam',
                        'Buddhism',
                        'Sikhism',
                        'Judaism'
                      ],
                    ),
                    // Caste Name AND Sub Caste Name
                    Row(
                      children: [
                        Expanded(
                          child: AdmissionFormScreenTextField(
                            controller: controllers['caste_name']!,
                            // labelText: "Caste Name",
                            hintText: "Caste Name",
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: AdmissionFormScreenTextField(
                            controller: controllers['sub_caste_name']!,
                            // labelText: "Sub Caste Name",
                            hintText: "Sub Caste Name",
                          ),
                        ),
                      ],
                    ),
                    // Caste Category AND Reservation
                    Row(
                      children: [
                        Expanded(
                          child: AdmissionFormScreenDropDown(
                            value: controllers['caste_category']!.text,
                            // labelText: "Caste Category",
                            hintText: "Caste Category",
                            onChanged: (newValue) {
                              setState(() {
                                controllers['caste_category']!.text = newValue!;
                              });
                            },
                            items: const [
                              'ST',
                              'SC',
                              'OBC',
                              'GENERAl',
                              'OTHER',

                            ],
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: AdmissionFormScreenDropDown(
                            value: controllers['reservation']!.text,
                            // labelText: "Reservation",
                            hintText: "Reservation",
                            onChanged: (newValue) {
                              setState(() {
                                controllers['reservation']!.text = newValue!;
                              });
                            },
                            items: const ['Handicapped ','Physically Disabled','Hearing Impaired' ],
                          ),
                        ),
                      ],
                    ),
                    // Examination Passed (SSC/OSSC/ specify if any other)
                    AdmissionFormScreenTextField(
                      controller: controllers['examination_passed']!,
                      // labelText: "Examination Passed (SSC/OSSC/ specify if any other)",
                      hintText: "Examination Passed (SSC/OSSC/ specify if any other)",

                    ),
                    // School Last studied as AND Exam Year
                    Row(
                      children: [
                        Expanded(
                          flex: 75,
                          child: AdmissionFormScreenTextField(
                            controller: controllers['school_last_studied']!,
                            // labelText: "School Last studied",
                            hintText: "School Last studied",
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          flex: 25,
                          child: AdmissionFormScreenTextField(
                            controller: controllers['exam_year']!,
                            // labelText: "Exam Year",
                            hintText: "Exam Year",
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),

                    // Subject  AND Second Language
                    Row(
                      children: [
                        Expanded(
                          child: AdmissionFormScreenDropDown(
                              value: controllers['select_subject']!.text,
                              // labelText: "Select Subject",
                              hintText: "Select Subject",
                              onChanged: (newValue) {
                                controllers['select_subject']!.text = newValue!;
                                print(
                                    "your selected subject ${controllers['select_subject']!.text}");
                              },
                              items: subNamesList
                              // items: _dropdownItems,
                              ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: AdmissionFormScreenDropDown(
                            value: controllers['second_language']!.text,
                            // labelText: "Second Language",
                            hintText: "Second Language",
                            onChanged: (newValue) {
                              setState(() {
                                controllers['second_language']!.text =
                                    newValue!;
                              });
                            },
                            items: const [
                              'English',
                              'Gujarati',
                              'Hindi',
                              'tamil',
                              'Marathi'
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Hall Ticket No:
                    Row(
                      children: [
                        // Text(
                        //   "Hall Ticket No:",
                        //   style: TextStyle(
                        //     fontSize: 16.sp,
                        //     fontFamily: "Poppins",
                        //   ),
                        // ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: AdmissionFormScreenTextField(
                            controller: controllers['hall_ticket_no']!,
                            hintText: "Hall Ticket No:",
                          ),
                        ),
                      ],
                    ),
                    // Aadhar No:
                    Row(
                      children: [
                        // Text(
                        //   "Aadhar No:",
                        //   style: TextStyle(
                        //     fontSize: 16.sp,
                        //     fontFamily: "Poppins",
                        //   ),
                        // ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: AdmissionFormScreenTextField(
                            controller: controllers['aadhar_no']!,
                            keyboardType: TextInputType.number,
                            hintText: "Aadhar No:",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),

                    // Name of Father/Guardian (As Per SSC Certificate)
                    const AdmissionFormContentTitle(
                      title: "Parents / Local Guardian",
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    AdmissionFormScreenTextField(
                      controller: controllers['name_of_father']!,
                      // labelText: "Name of Father/Guardian (As Per SSC Certificate)",
                      hintText: "Name of Father/Guardian (As Per SSC Certificate)",
                    ),

                    // Occupation and Annual Income

                    Row(
                      children: [
                        Expanded(
                          child: AdmissionFormScreenTextField(
                            controller: controllers['occupation']!,
                            // labelText: "Occupation",
                            hintText: "Occupation",
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: AdmissionFormScreenTextField(
                            // labelText: 'Annual Income',
                            hintText: 'Annual Income',
                            controller: controllers['annual_income']!,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    // Address(Residence)
                    AdmissionFormScreenTextField(
                      controller: controllers['address_residence']!,
                      // labelText: "Address(Residence)",
                      hintText:  "Address(Residence)",
                    ),
                    // City AND State Group
                    Row(
                      children: [
                        Expanded(
                          child: AdmissionFormScreenDropDown(
                            value: controllers['select_subject']!.text,
                            // labelText: "City",
                            hintText: "City",
                            onChanged: (value) {},
                            items: const [
                              'Mumbai',
                              'Surat',
                              'Rajkot',
                              'Patan',
                              'Bhuj',
                              'Vadodara',
                            ],
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: AdmissionFormScreenDropDown(
                            value: controllers['select_subject']!.text,
                            // labelText: "State",
                            hintText: "State",
                            onChanged: (value) {},
                            items: const [
                              'Gujarat',
                              'Chhattisgarh',
                              'Maharashtra',
                              'Punjab',
                              'Uttar Pradesh',
                              'Kerala',
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Address(Residence)
                    AdmissionFormScreenTextField(
                      controller: controllers['address_permanent']!,
                      // labelText: "Address(Permanent)",
                      hintText: "Address(Permanent)",
                    ),
                    // City AND State Group
                    Row(
                      children: [
                        Expanded(
                          child: AdmissionFormScreenDropDown(
                            value: controllers['city']!.text,
                            // labelText: "City",
                            hintText: "City",
                            onChanged: (value) {},
                            items: const [
                              'Mumbai',
                              'Surat',
                              'Rajkot',
                              'Patan',
                              'Bhuj',
                              'Vadodara',
                            ],
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: AdmissionFormScreenDropDown(
                            value: controllers['state']!.text,
                            // labelText: "State",
                            hintText: "State",
                            onChanged: (value) {},
                            items: const [
                              'Gujarat',
                              'Chhattisgarh',
                              'Maharashtra',
                              'Punjab',
                              'Uttar Pradesh',
                              'Kerala',
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Phone and Email
                    Row(
                      children: [
                        Expanded(
                          child: AdmissionFormScreenTextField(
                            controller: controllers["phone"]!,
                            // labelText: "Phone",
                            hintText: "Phone",
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: AdmissionFormScreenTextField(
                            // labelText: 'Email',
                            hintText: 'Email',
                            controller: controllers["email"]!,
                          ),
                        ),
                      ],
                    ),

                    const AdmissionFormContentTitle(
                      title: "Upload Documents",
                    ),
                    SizedBox(height: 30.h),
                    // file for student,,
                    Row(
                      children: [
                        SizedBox(width: 30.w),
                        Expanded(
                          child: Obx(
                            () => FilePickerBox(
                              documentName: 'Student Photo',
                              pickedFileName: kCollegeController
                                  .studentPhotoDocument.value?.name,
                              onTap: () async {
                                await _pickFile(kCollegeController.studentPhotoDocument);
                                // kCollegeController.studentPhotoDocument.value = await commonFilePicker(context);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Obx(
                            () => FilePickerBox(
                              documentName: 'Hall Ticket',
                              pickedFileName: kCollegeController.hallTicketDocument.value?.name,
                              onTap: () async {
                                await _pickFile(kCollegeController.hallTicketDocument);
                                // kCollegeController.hallTicketDocument.value = await commonFilePicker(context);
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 30.w),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        SizedBox(width: 30.w),
                        Expanded(
                          child: Obx(
                            () => FilePickerBox(
                              documentName: 'Aadhar Card',
                              pickedFileName: kCollegeController
                                  .adharCardDocument.value?.name,
                              onTap: () async {
                                await _pickFile(kCollegeController.adharCardDocument);
                                // kCollegeController.adharCardDocument.value = await commonFilePicker(context);
                              },
                            ),
                          ),
                        ),
                          const SizedBox(width: 20),
                        Expanded(
                          child: Obx(
                            () => FilePickerBox(
                              documentName: 'Caste Certificate',
                              pickedFileName: kCollegeController
                                  .casteCertificateDocument.value?.name,
                              onTap: () async {
                                await _pickFile(kCollegeController.casteCertificateDocument);
                                // kCollegeController.casteCertificateDocument.value = await commonFilePicker(context);
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 30.w),
                      ],
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          minimum: EdgeInsets.only(bottom: 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CommonDivider(thickness: .7),
              Padding(
                padding: EdgeInsets.only(left: 35.w, right: 35.w, top: 16.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => TAndCButton(
                              name: 'Terms and conditions*',
                              isSelected: kCollegeController
                                  .termsAndConditionRead.value,
                              onTap: () {
                                kCollegeController.termsAndConditionRead.value =
                                    !kCollegeController
                                        .termsAndConditionRead.value;
                              },
                            ),
                          ),
                          Obx(
                            () => TAndCButton(
                              name: 'Admission details*',
                              isSelected:
                                  kCollegeController.admissionDetailRead.value,
                              onTap: () {
                                kCollegeController.admissionDetailRead.value =
                                    !kCollegeController
                                        .admissionDetailRead.value;
                                print(
                                    "val == ${kCollegeController.admissionDetailRead.value}");
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20.w),
                    InkWell(
                      borderRadius: BorderRadius.circular(8.r),
                      onTap: () async {
                        // Navigator.pop(context);
                        if (kCollegeController.termsAndConditionRead.value ==
                                true &&
                            kCollegeController.admissionDetailRead.value ==
                                true) {
                          Fluttertoast.showToast(
                              msg: "wait for some time",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: kPrimaryColor,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          _submitAdmissionData();
                          // await saveData();
                        } else {
                          Fluttertoast.showToast(
                              msg: "plz accept the terms and conditions",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 2,
                              backgroundColor:kPrimaryColor,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.h,vertical: 10.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(.7),
                              offset: const Offset(2, 3),
                              spreadRadius: 1,
                              blurRadius: 6,
                            )
                          ],
                          color: kPrimaryColor,
                        ),
                        child: Text(
                          "SUBMIT",
                          style: TextStyle(
                              color: commonYellowColor,
                              fontSize: 14.sp,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
