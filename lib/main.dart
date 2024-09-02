import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/design/colors.dart';
import 'package:weather_app/routes.dart';

void main() async{
  await dotenv.load(fileName: "assets/.env");
  runApp(const MainApp());
}
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather',
      theme:_Wtheme() ,
      initialRoute: '/home',
      routes: Routes.getRoutes(),
    );
  }
}

 // ignore: non_constant_identifier_names
 ThemeData _Wtheme(){
  return ThemeData(
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
     backgroundColor: Color.fromARGB(102, 107, 159, 215) 
    ),
    scaffoldBackgroundColor: Cols.pacificCoast,
  );
}

