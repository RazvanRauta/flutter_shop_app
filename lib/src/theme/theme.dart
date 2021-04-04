import '../utility/libraries.dart';

ThemeData themeData = ThemeData(
    primarySwatch: Colors.purple,
    accentColor: Colors.deepOrange,
    fontFamily: 'Lato',
    pageTransitionsTheme: PageTransitionsTheme(builders: {
      TargetPlatform.android: CustomPageTransitionBuilder(),
      TargetPlatform.iOS: CustomPageTransitionBuilder(),
    }));
