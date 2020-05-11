import 'package:flutter/material.dart';
import 'package:grupolenotre/models/user_model.dart';
import 'package:grupolenotre/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(

      model: UserModel(),
      child: MaterialApp(
        title: 'GrupoLeNotre',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      )
    );
  }
}
