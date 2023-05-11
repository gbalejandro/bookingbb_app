import 'package:flutter/material.dart';

import 'package:bookingbb_app/screens/screens.dart';
import 'package:provider/provider.dart';
import 'package:bookingbb_app/services/services.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => ReservationsService() )
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BookingBB App',
      initialRoute: 'home',
      routes: {
        'login'      : ( _ ) => LoginScreen(),
        'home'       : ( _ ) => HomeScreen(),
        'reservation': ( _ ) => ReservationScreen(),
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: Colors.indigo
        ),
        floatingActionButtonTheme:  FloatingActionButtonThemeData(
          backgroundColor: Colors.indigo,
          elevation: 0
        )
      ),
    );
  }
}