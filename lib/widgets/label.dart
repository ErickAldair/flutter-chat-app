import 'package:flutter/material.dart';

class Labels extends StatelessWidget {

  final String ruta;
  final String msm1;
  final String msm2;

  const Labels({
    Key key, 
    @required this.ruta, @required this.msm1, @required this.msm2
    }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
        Text(this.msm1, style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300)),
        SizedBox(height: 10),
        GestureDetector(
          child: Text(this.msm2, style: TextStyle(color: Colors.blue[600], fontSize: 18, fontWeight: FontWeight.bold)),
          onTap: (){
            Navigator.pushReplacementNamed(context, this.ruta);
          },
          )
      ],
      ),
    );
  }
}