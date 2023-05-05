import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app_flutter/views/screens/Splashscreen.dart';
import 'package:to_do_app_flutter/views/screens/task_list_view.dart';

import 'controllers/Providers/ThemeProvider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      builder: (context, _) {
        return MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
              color: Color(0XFF2684FC),
            ),
          ),
          darkTheme: ThemeData.dark(
            useMaterial3: true,
          ),
          themeMode: (Provider.of<ThemeProvider>(context).ld1.isDark == false)
              ? ThemeMode.light
              : ThemeMode.dark,
          debugShowCheckedModeBanner: false,
         initialRoute:'splashscreen',
          routes: {
            '/': (context) =>  const TaskListView(),
           'splashscreen': (context) => const Splashscreen(),
          },
        );
      },
    );
  }
}
