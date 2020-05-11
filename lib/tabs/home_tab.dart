import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _buildBodyBack() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Colors.white,
          ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
        )
      ),
    );
    return SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            _buildBodyBack(),
            Column(
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  height: 200.0,
                  child:  Card(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Text('Quinta-Feira'),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text('Janeiro', style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0
                            )),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text('09', style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 40.0
                            )),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text('2020', style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0
                            )),
                          ),
                        ],
                      )
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 120.0,
                  child:  Card(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Text('Clientes', style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text('210', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40.0,
                              color: Color(0xffD77E67),
                            )),
                          ),
                        ],
                      )
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 120.0,
                  child:  Card(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Text('Veículos', style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text('0', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40.0,
                              color: Color(0xffD77E67),
                            )),
                          ),
                        ],
                      )
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 120.0,
                  child:  Card(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Text('Fornecedores', style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text('232', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40.0,
                              color: Color(0xffD77E67),
                            )),
                          ),
                        ],
                      )
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 120.0,
                  child:  Card(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Text('Funcionários', style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text('1', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40.0,
                              color: Color(0xffD77E67),
                            )),
                          ),
                        ],
                      )
                  ),
                ),
              ],
            )
          ],
        )
      );

  }
}
