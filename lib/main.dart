import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'Controller/Lang/local_controller.dart';
import 'Core/Localization/translation.dart';
import 'Core/Service/service.dart';
import 'Core/constants/style.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();

  runApp(
    SmartTourism(),
  );
}

class SmartTourism extends StatelessWidget {
  const SmartTourism({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.teal,
    // ));

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
