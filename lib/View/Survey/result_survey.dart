import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/Survay/survay_controller.dart';
import 'package:smart_tourism/Core/constants/font.dart';

class ResultSurvey extends StatelessWidget {
  ResultSurvey({super.key});
  final SurveySaveController surveyController = Get.put(SurveySaveController());

  @override
  Widget build(BuildContext context) {
    // Fetch survey results when the screen is built
    surveyController.fetchSurveyResults();

    return Scaffold(
        appBar: AppBar(
          title: Text('Survey Results'.tr),
        ),
        body: Obx(
          () => surveyController.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Column(children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Results of Survey '.tr,
                          style: TextStyle(
                            fontSize: 20.0.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 5.0,
                          ),
                          itemCount: surveyController.surveyResults.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.white,
                              elevation: 2.0,
                              child: Center(
                                child: Text(
                                  '${surveyController.surveyResults[index]}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontFamily: TextFontStyle.Mano),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          },
                        ),
                      ]),
                ]),
        ));
  }
}
