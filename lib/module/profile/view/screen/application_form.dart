import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/commonWidget/common_save_and_submit_button.dart';
import '../../../../utils/constant/asset_icons.dart';
import '../../../../utils/theme/common_color.dart';
import '../../../college/view/widget/admission_form_screen_text_field.dart';

class ApplicationForm extends StatefulWidget {
  const ApplicationForm({super.key});

  @override
  State<ApplicationForm> createState() => _ApplicationFormState();
}

class _ApplicationFormState extends State<ApplicationForm>  {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Map<String, TextEditingController>  controllers = {};

  void _createTextEditingController(String fieldName) {
    controllers[fieldName] = TextEditingController();
  }

  // when user logout the data is clear.
  Future<void> clearUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear(); // This will clear all the data in SharedPreferences
  }

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    _createTextEditingController('name');
    _createTextEditingController('surname');
    _createTextEditingController('nationality');
    _createTextEditingController('mother_tongue');
    _createTextEditingController('caste_name');
    _createTextEditingController('sub_caste_name');
    _createTextEditingController('examination_passed');
    _createTextEditingController('school_last_studied');
    _createTextEditingController('exam_year');
    _createTextEditingController('hall_ticket_no');
    _createTextEditingController('aadhar_no');

  }

  Future<Map<String, String>>  loadStudentData() async {
    final prefs = await _prefs;

    final name = controllers['name']!.text = prefs.getString('name') ?? '';
    final surname =  controllers['surname']!.text = prefs.getString('surname')  ?? '';
    final nationality =  controllers['nationality']!.text = prefs.getString('nationality')  ?? '';
    final motherTongue =   controllers['mother_tongue']!.text =  prefs.getString('mother_tongue')  ?? '';
    final casteName =   controllers['caste_name']!.text = prefs.getString('caste_name')  ?? '';
    final subCaste =  controllers['sub_caste_name']!.text = prefs.getString('sub_caste_name')  ?? '';
    final examinationPassed =   controllers['examination_passed']!.text =prefs.getString('examination_passed')  ?? '';
    final schoolLastStudied =   controllers['school_last_studied']!.text = prefs.getString('school_last_studied')  ?? '';
    final examYear =   controllers['exam_year']!.text = prefs.getString('exam_year')  ?? '';
    final hallTicket =   controllers['hall_ticket_no']!.text = prefs.getString('hall_ticket_no')  ?? '';
    final aadharNo =   controllers['aadhar_no']!.text = prefs.getString('aadhar_no')  ?? '';


    return {
      'name': name,
      'surname': surname,
      'nationality': nationality,
      'mother_tongue': motherTongue,
      'caste_name': casteName,
      'sub_caste_name': subCaste,
      'examination_passed': examinationPassed,
      'school_last_studied': schoolLastStudied,
      'exam_year': examYear,
      'hall_ticket_no': hallTicket,
      'aadhar_no': aadharNo,
    };
  }

  void populateFormFields() async {
    final studentData = await loadStudentData();
    setState(() {
      controllers['name']!.text = studentData['name'] ?? '';
      controllers['surname']!.text = studentData['surname'] ?? '';
      controllers['nationality']!.text = studentData['nationality'] ?? '';
      controllers['mother_tongue']!.text = studentData['mother_tongue'] ?? '';
      controllers['caste_name']!.text = studentData['caste_name'] ?? '';
      controllers['sub_caste_name']!.text = studentData['sub_caste_name'] ?? '';
      controllers['examination_passed']!.text = studentData['examination_passed'] ?? '';
      controllers['school_last_studied']!.text = studentData['school_last_studied'] ?? '';
      controllers['exam_year']!.text = studentData['exam_year'] ?? '';
      controllers['hall_ticket_no']!.text = studentData['hall_ticket_no'] ?? '';
      controllers['aadhar_no']!.text = studentData['aadhar_no'] ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
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
          "Application Form",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body:  Padding(
        padding:  EdgeInsets.only(left: 20,right: 20),
        child: ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: [
           FutureBuilder(
             future: loadStudentData(),
             builder: (context,snapshot){
               if (snapshot.connectionState == ConnectionState.done) {
                 return Center(
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       SizedBox(height: 10.h,),
                       const Text("Save Student Data",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                       SizedBox(height: 10.h,),
                       Row(
                         children: [
                           Expanded(
                             child: AdmissionFormScreenTextField(
                               controller: controllers['name']!,
                               hintText: (snapshot.data?["name"]?.isEmpty ?? true) ? "Name" : snapshot.data?["name"]!,
                               validator: (value) {
                                 if(value == null || value.isEmpty){
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
                               hintText: (snapshot.data?["surname"]?.isEmpty ?? true ) ?  "Surname" : snapshot.data?["surname"]!,
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
                               hintText:(snapshot.data?["nationality"]?.isEmpty ?? true) ?  "Nationality" : snapshot.data?["nationality"]!,
                             ),
                           ),
                           SizedBox(width: 10.w),
                           Expanded(
                             child: AdmissionFormScreenTextField(
                               controller: controllers['mother_tongue']!,
                               hintText: (snapshot.data?["mother_tongue"]?.isEmpty ?? true) ?  "Mother tongue" : snapshot.data?["mother_tongue"]!,
                             ),
                           ),
                         ],
                       ),
                       // Caste Name AND Sub Caste Name
                       Row(
                         children: [
                           Expanded(
                             child: AdmissionFormScreenTextField(
                               controller: controllers['caste_name']!,
                               hintText: (snapshot.data?['caste_name']?.isEmpty ?? true) ?  'Caste name' : snapshot.data?['caste_name']!,
                             ),
                           ),
                           SizedBox(width: 10.w),
                           Expanded(
                             child: AdmissionFormScreenTextField(
                               controller: controllers['sub_caste_name']!,
                               hintText: (snapshot.data?['sub_caste_name']?.isEmpty ?? true ) ? "Sub caste name" : snapshot.data?['sub_caste_name']!,
                             ),
                           ),
                         ],
                       ),
                       // Examination Passed (SSC/OSSC/ specify if any other)
                       AdmissionFormScreenTextField(
                         // labelText: "Examination passed",
                         controller: controllers['examination_passed']!,
                         hintText: (snapshot
                                        .data?['examination_passed']?.isEmpty ??
                                    true) ?  "Examination passed" : snapshot.data?['examination_passed'],
                       ),
                       // School Last studied as AND Exam Year
                       Row(
                         children: [
                           Expanded(
                             flex: 75,
                             child: AdmissionFormScreenTextField(
                               controller: controllers['school_last_studied']!,
                               hintText: (snapshot.data?['school_last_studied']?.isEmpty ?? true) ? "School last studied" : snapshot.data?['school_last_studied']!,
                             ),
                           ),
                           SizedBox(width: 10.w),
                           Expanded(
                             flex: 25,
                             child: AdmissionFormScreenTextField(
                               controller: controllers['exam_year']!,
                               keyboardType: TextInputType.number,
                               hintText: (snapshot.data?['exam_year']?.isEmpty ?? true )?  "Exam year" : snapshot.data?['exam_year']!,
                             ),
                           ),
                         ],
                       ),
                       // Hall Ticket No:
                       SizedBox(width: 10.w),
                       AdmissionFormScreenTextField(
                         controller: controllers['hall_ticket_no']!,
                         hintText: (snapshot.data?['hall_ticket_no']?.isEmpty ?? true ) ?  "Hall ticket no" : snapshot.data?['hall_ticket_no']! ,
                       ),
                       // Aadhar No:
                       SizedBox(width: 10.w),
                       AdmissionFormScreenTextField(
                         controller: controllers['aadhar_no']!,
                         keyboardType: TextInputType.number,
                         hintText: (snapshot.data?['aadhar_no']?.isEmpty ?? true) ? "Aadhar nomber" : snapshot.data?['aadhar_no']!,
                       ),
                     SizedBox(height: 50.h,),
                     CommonSaveAndSubmitButton(
                         name: "Save",
                         onTap: (){}),
                       SizedBox(height: 10.h),
                     ],
                   ),
                 );
               } else {
                 return CircularProgressIndicator();
               }
             },
           ),
         ],
        ),
      )
    );
  }

}
