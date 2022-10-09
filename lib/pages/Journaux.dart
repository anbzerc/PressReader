import 'package:flutter/material.dart';
import 'package:pressreaderflutter/media/Lefigaro.dart';
import 'package:pressreaderflutter/media/opex360.dart';

class Journaux extends StatelessWidget {
  const Journaux({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  Widget contenuJournaux(BuildContext context){

    return SingleChildScrollView(
      child: Column(
        children: [
          //thematiques
          Row(),
          //Media
          Column(
            children: [
              SizedBox(
                  width: 330,
                  height: 190,
                  child:GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> Opex360(urlpourlaliste: "http://www.opex360.com",))),
                    child: Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                        margin: EdgeInsets.all(10.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(borderRadius: BorderRadius.circular(15.0),
                              child: Image.asset("assets/globe.jpg"),),
                            Text("Opex360", style: TextStyle(fontSize: 25, fontFamily: "titre", color: Colors.blue),),

                          ],
                        )
                    ),
                  )
              ),
              SizedBox(
                  width: 330,
                  height: 190,
                  child:GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> LeFigaro())),
                    child: Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                        margin: EdgeInsets.all(10.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(borderRadius: BorderRadius.circular(15.0),
                              child: Image.asset("assets/globe.jpg"),),
                            Text("Le figaro", style: TextStyle(fontSize: 25, fontFamily: "titre", color: Colors.blue),),

                          ],
                        )
                    ),
                  )
              )

            ],
          )
        ],
      ),
    );

  }
}
