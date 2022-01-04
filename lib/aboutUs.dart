import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "About Us",
          style: TextStyle(fontSize: 60),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Column(
              children: [
                Text(
                  "Description : ",
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "TFARHIDA.tn est un annuaire interactif des différents intervenants dans le domaine du Tfarhid en Tunisie.Vous pouvez facilement décidez de l’endroit où vous dînerez ce soir, de l''hôtel dans lequel vous vouler séjourner ou encore l''évènement auquel vous pouvez participer."),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Contacts : ",
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("phone number:",style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text("70 038 74"),
                ]),
                SizedBox(height: 20,),
                 Row(children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("E-mail:",style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text("contact@tfarhida.tn"),
                ]),
                SizedBox(height: 20,),
                 Row(children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Location:",style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                 Expanded(child:  Text("Manaret el Hammamet Barreket Essahel, Hammamet Sud, Hammamet, nabeul 8056, Tunisie"),)
                ]),
                
                // Center(child:  Text("About Us", style: TextStyle(fontSize: 60),),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
