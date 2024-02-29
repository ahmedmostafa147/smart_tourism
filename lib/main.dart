import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get/get.dart';
import 'routes.dart';
import 'Controller/local_controller.dart';
import 'Core/Localization/translation.dart';
import 'Core/Service/service.dart';
import 'constants/style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();

  initializeDateFormatting().then((_) => runApp(DevicePreview(
        enabled: false,
        builder: (context) => const SmartTourism(), // Wrap your app
      )));
}

class SmartTourism extends StatefulWidget {
  const SmartTourism({Key? key}) : super(key: key);

  @override
  State<SmartTourism> createState() => _SmartTourismState();
}

class _SmartTourismState extends State<SmartTourism> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.teal,
    ));

    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          LocaleController controller = Get.put(LocaleController());
          return GetMaterialApp(
            translations: MyTranslation(),
            locale: controller.language,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: controller.themeData!,
            title: 'Smart Tourism',
            debugShowCheckedModeBanner: false,
            routes: routes,
            initialRoute: AppRoute.splash,
          );
        });
  }
}
