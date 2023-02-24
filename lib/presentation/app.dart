import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'ticker_viewer/ticker_viewer_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 735),
      minTextAdapt: false,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          title: 'Binance Ticker Viewer',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: GoogleFonts.barlowTextTheme(),
          ),
          home: const TickerViewerScreen(),
        );
      },
    );
  }
}
