import 'package:flutter/material.dart';
import 'package:grupolenotre/api/login_api.dart';
import 'package:grupolenotre/models/user_model.dart';
import 'package:grupolenotre/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  final loginApi = LoginApi();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0xff7AC0CE),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if (model.isLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Stack(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Image.asset(
                        "assets/images/back-grupolenotre.png",
                        fit: BoxFit.cover,
                        height: 200.0,
                        alignment: Alignment.bottomCenter,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "assets/images/logo-grupolenotre.png",
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 10.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Usuário',
                              enabledBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 0.0),
                              ),
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Color(0xffD77E67),
                              )),
                          controller: emailController,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: 'Senha',
                              enabledBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 0.0),
                              ),
                              prefixIcon: const Icon(
                                Icons.security,
                                color: Color(0xffD77E67),
                              )),
                          controller: passController,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
                            child: ButtonTheme(
                                minWidth: double.infinity,
                                height: 50.0,
                                child: RaisedButton(
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(0.0),
                                    side: BorderSide(color: Color(0xffD77E67)),
                                  ),
                                  color: Color(0xffD77E67),
                                  onPressed: () {
                                    model.signIn(
                                      email: emailController.text,
                                      pass: passController.text,
                                      onSuccess: _onSuccess,
                                      onFailure: _onFailure,
                                    );
                                  },
                                  textColor: Colors.white,
                                  child: Text("Logar",
                                      style: TextStyle(fontSize: 12)),
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            child: FlatButton(
                              child: Text(
                                "Esqueceu sua senha?",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              );
            }
          },
        ));
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Sucesso"),
        backgroundColor: Colors.black,
        duration: Duration(seconds: 3)));
    Route route = MaterialPageRoute(builder: (context) => HomeScreen());
    Navigator.push(context, route);
  }

  void _onFailure() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Erro nas credenciais de acesso!"),
        backgroundColor: Colors.black,
        duration: Duration(seconds: 3)));
  }
}
