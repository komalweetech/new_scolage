import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../../utils/commonWidget/keyboard_off.dart';
import '../../../../utils/constant/asset_icons.dart';
import '../../../../utils/theme/common_color.dart';
import '../../../nearby/view/screen/nearby_screen.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class DashboardAppBar extends StatefulWidget {
  const DashboardAppBar({super.key,});


  @override
  State<DashboardAppBar> createState() => _DashboardAppBarState();
}

class _DashboardAppBarState extends State<DashboardAppBar> {
  // Original data (replace this with your actual data)
  final List<Map<String, dynamic>> allRepositories = [
    {'b_name': 'Name1', 'b_code': 'Code1'},
    {'b_name': 'Name2', 'b_code': 'Code2'},
  ];

  late List<Map<String, dynamic>> filteredRepositories;

//   Controller for the search text field
  final TextEditingController searchController = TextEditingController();
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _speechText = "";

  @override
  void initState() {
    super.initState();
    filteredRepositories = List.from(allRepositories);
    searchController.addListener(() {
      filterData();
    });
    _speech = stt.SpeechToText();
  }

  // Function to filter data based on the search term
  void filterData() {
    String searchWord = searchController.text.toLowerCase();
    setState(() {
      filteredRepositories = allRepositories.where((value) {
        // Check if any property within the nested objects or arrays contains the search word
        return ((value['b_name']
                    ?.toLowerCase()
                    ?.contains(searchWord.toLowerCase()) ??
                false) ||
            (value['b_code']
                    ?.toString()
                    .toLowerCase()
                    .contains(searchWord.toLowerCase()) ??
                false) ||
            (value['b_mobile']
                    ?.toString()
                    .toLowerCase()
                    .contains(searchWord.toLowerCase()) ??
                false) ||
            (value['b_last_att_time']
                    ?.toString()
                    .contains(searchWord.toLowerCase()) ??
                false) ||
            (value['b_email']?.toString().contains(searchWord.toLowerCase()) ??
                false) ||
            (value['b_att_range']?.toString().contains(searchWord.toLowerCase()) ??
                false) ||
            (value['b_latitude']?.toString().contains(searchWord.toLowerCase()) ??
                false) ||
            (value['b_longitude']?.toString().contains(searchWord.toLowerCase()) ??
                false) ||
            // Add additional checks for nested objects or arrays
            (value['nestedObject']?['nestedProperty']
                    ?.toString()
                    .contains(searchWord.toLowerCase()) ??
                false) ||
            (value['nestedArray']?.any(
                    (item) => item.toString().contains(searchWord.toLowerCase())) ??
                false));
      }).toList();
    });
  }

  // Function to start/stop listening
  void _listen() async {
    if (!_isListening && await _speech.initialize()) {
      setState(() {
        _isListening = true;
      });

      _speech.listen(onResult: (result) {
        setState(() {
          _speechText = result.recognizedWords; // Capture the recognized speech
        });
      });
    } else {
      setState(() {
        _isListening = false;
      });
      _speech.stop(); // Stop listening
    }
  }


  @override
  Widget build(BuildContext context) {
    return KeyBoardOff(
      child: Stack(
        children: [
          Container(
            height: 130 + MediaQuery.of(context).padding.top,
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(
                  MediaQuery.of(context).size.width,
                  60.0,
                ),
              ),
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  Center(
                      child: Image.asset("assets/image/appbar_bg_image.png"),),
                  Padding(
                    padding:  EdgeInsets.only(top: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 6.w),
                        IconButton(
                          onPressed: () {
                            final FocusScopeNode currentScope =
                                FocusScope.of(context);
                            if (!currentScope.hasPrimaryFocus &&
                                currentScope.hasFocus) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            }
                            Scaffold.of(context).openDrawer();
                          },
                          icon: Image.asset(
                            AssetIcons.DRAWER_ICON,
                            color: Colors.white,
                            height: 15.h,
                          ),
                        ),
                        Expanded(
                          child: Image.asset(
                            AssetIcons.APP_BAR_APP_LOGO_ICON,
                            height: 35,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            AssetIcons.NOTIFICATION_ICON,
                            color: Colors.white,
                            height: 29,
                          ),
                        ),
                        SizedBox(width: 6.w),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 20,
            right: 20,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 0.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.1),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 14.w),
                        Image.asset(
                          AssetIcons.SEARCH_ICON,
                          height: 20.h,
                        ),
                        SizedBox(width: 7.w),
                        Expanded(
                          child: TextFormField(
                            onTap: () {
                               Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NearbyScreen(cityName: "",)),
                              );
                            },
                            /*selectionControls: searchsController,*/

                            keyboardType: TextInputType.text,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            controller: searchController,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(bottom: 11.h, top: 6.5.h),
                              border: InputBorder.none,
                              hintText: 'Enter city, area or location',
                              hintStyle: TextStyle(fontSize: 16.sp),
                              isDense: true,
                            ),
                          ),
                        ),
                        /*ListView.builder(
                          itemCount: filteredRepositories.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> repository =
                                filteredRepositories[index];
                            return ListTile(
                              title: Text(repository['b_name'] ?? ''),
                              subtitle: Text(repository['b_code'] ?? ''),
                              // Add more widgets to display other properties as needed
                            );
                          },
                        ),*/
                        GestureDetector(
                          onTap:  _listen,
                          child: Image.asset(
                            AssetIcons.MICROPHONE_ICON,
                            height: 20,
                          ),
                        ),
                        SizedBox(width: 17.w),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
