import 'package:flutter/material.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/screens/ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<WeatherBloc>(
                create: (context) => WeatherBloc(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Home',
              theme: ThemeData(
                // primarySwatch: Colors.grey,
                // primaryColor: Colors.grey[900],
                appBarTheme: AppBarTheme(
                  backgroundColor: Color(0xFF222222), // Custom dark color
                ),
              ),
              home: CityListScreen(),
              // home: PageThree(),
            ),
          );
        });
  }
}
