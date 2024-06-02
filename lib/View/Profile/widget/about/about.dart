import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Smart Tourism',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Welcome to Smart Tourism, your ultimate travel companion designed to enhance your tourism experience. Whether you\'re exploring a new city or revisiting your favorite destinations, Smart Tourism provides a suite of features to make your journey more enjoyable, informative, and convenient.',
                  style: TextStyle(fontSize: 12.sp),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Key Features',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                _buildFeatureListItem('User Registration and Authentication'),
                _buildFeatureListItem('Location Services'),
                _buildFeatureListItem('Detailed Information'),
                _buildFeatureListItem('Custom Recommendations'),
                _buildFeatureListItem('Interactive Maps'),
                _buildFeatureListItem('User Reviews and Ratings'),
                _buildFeatureListItem('Offline Access'),
                SizedBox(height: 20.h),
                Text(
                  'Why Choose Smart Tourism?',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                _buildFeatureListItem('Ease of Use'),
                _buildFeatureListItem('Comprehensive Coverage'),
                _buildFeatureListItem('Personalization'),
                _buildFeatureListItem('Community Driven'),
                SizedBox(height: 20.h),
                Text(
                  'Developer Information',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Smart Tourism is developed by [Your Company Name], dedicated to providing innovative solutions to enhance your travel experience. Our team is passionate about technology and travel, striving to create an app that brings the best of both worlds to your fingertips.',
                  style: TextStyle(fontSize: 12.sp),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Contact and Support',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'For support or inquiries, please contact us at:',
                  style: TextStyle(fontSize: 12.sp),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Email: support@smarttourismapp.com\nPhone: +123-456-7890\nWebsite: www.smarttourismapp.com',
                  style: TextStyle(fontSize: 12.sp),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Stay connected with us on social media for updates, travel tips, and more:',
                  style: TextStyle(fontSize: 12.sp),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Facebook: Smart Tourism\nTwitter: @SmartTourism\nInstagram: @SmartTourism',
                  style: TextStyle(fontSize: 12.sp),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureListItem(String feature) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check, color: Colors.teal),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              feature,
              style: TextStyle(fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }
}
