import 'package:flutter/material.dart';
import 'package:grupolenotre/datas/relatorio_data.dart';
import 'package:grupolenotre/screens/relatorio/foto_detalhes_screen.dart';

class MenuFotoTile extends StatefulWidget {
  String csRelatorio;
  FotosResponse fotosResponse;
  MenuFotoTile(this.csRelatorio, this.fotosResponse);

  @override
  _MenuFotoTileState createState() => _MenuFotoTileState(this.csRelatorio, this.fotosResponse);
}

class _MenuFotoTileState extends State<MenuFotoTile> {
  String csRelatorio;
  FotosResponse fotosResponse;
  _MenuFotoTileState(this.csRelatorio, this.fotosResponse);

  final fotoCard = new Container(
    height: 124.0,
    margin: new EdgeInsets.only(left: 46.0),
    decoration: new BoxDecoration(
      color: Colors.white,
      shape: BoxShape.rectangle,
      borderRadius: new BorderRadius.circular(8.0),
      boxShadow: <BoxShadow>[
        new BoxShadow(
          color: Colors.black12,
          blurRadius: 10.0,
          offset: new Offset(0.0, 10.0),
        ),
      ],
    ),
  );

  Container fotoThumbnail(){
    return Container(
      margin: new EdgeInsets.symmetric(
          vertical: 16.0
      ),
      alignment: FractionalOffset.centerLeft,
      child: Image.network(
        this.fotosResponse.url.toString(),
        width: 92.0,
        height: 92.0,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=> FotoDetalhesScreen(this.fotosResponse.url))
          );
      },
      child: Container(
          height: 120.0,
          margin: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 24.0,
          ),
          child: new Stack(
            children: <Widget>[
              fotoCard,
              fotoThumbnail(),
              Positioned(
                top: 40.0,
                left: 100.0,
                child: Text("Foto: ", style: TextStyle(fontSize: 17.0, color: Color.fromARGB(255, 66, 163, 177), fontWeight: FontWeight.bold)),
              ),
//              Positioned(
//                top: 40.0,
//                left: 150.0,
//                child: Text(fotosResponse.identificacao == null ? '' : fotosResponse.identificacao, style: TextStyle(fontSize: 17.0, color: Colors.black, fontWeight: FontWeight.bold)),
//              ),
              Positioned(
                top: 70.0,
                left: 100.0,
                child: Text(fotosResponse.identificacao == null ? '' : fotosResponse.identificacao, style: TextStyle(fontSize: 7.0, color: Colors.black, fontWeight: FontWeight.normal)),
              ),
//              Positioned(
//                top: 75.0,
//                left: 185.0,
//                child: Text(feiraData.endereco == null ? '' : feiraData.endereco, style: TextStyle(fontSize: 10.0, color: Colors.black, fontWeight: FontWeight.bold)),
//              )
            ],
          )
      ),
    );
  }
}
