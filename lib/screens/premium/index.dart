import 'package:flutter/material.dart';
import 'package:homi/helper/helper.dart';

class PremiumPage extends StatefulWidget {
  const PremiumPage({Key? key}) : super(key: key);

  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeAppBarColors(),
      appBar: AppBar(
        backgroundColor: themeAppBarColors(),
        elevation: 0,
        title: sText("Go Premium",weight: FontWeight.bold,size: 20),
        centerTitle: false,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: themeAppColors(),)),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Expanded(
             child: ListView(
               children: [
                 SizedBox(height: 20,),
                 Center(
                   child: Image.asset("assets/images/Homi-logo-white.png"),
                 ),
                 SizedBox(height: 20,),
                 Center(
                   child: sText("Get a Full-Fledged Video Experience",size: 20,weight: FontWeight.bold),
                 ),
                 SizedBox(height: 20,),
                 SizedBox(
                   height: 350,
                   child: ListView(
                     scrollDirection: Axis.horizontal,
                     children: [
                       Container(
                         margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),

                         width: 300,
                         decoration: BoxDecoration(
                             color: Colors.black26,
                             borderRadius: BorderRadius.circular(5)

                         ),
                         child: Container(
                           child: Column(
                             children: [
                               Container(
                                 padding: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                                 width: 300,
                                 child: sText("ANNUAL STANDARD",align: TextAlign.center),
                                 decoration: BoxDecoration(
                                     color: dPurple,
                                     borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5))
                                 ),

                               ),
                               Container(
                                 padding: EdgeInsets.symmetric(horizontal: 70,vertical: 10),
                                 child: sText("US\$20.99",weight: FontWeight.bold),
                               ),
                               Container(
                                 width: 300,
                                 height: 1,
                                 color: Colors.grey,
                               ),
                               Container(
                                 padding: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                                 child: sText("You can watch 4 screens at the same time"),
                               ),
                               Container(
                                 width: 300,
                                 height: 1,
                                 color: Colors.grey,
                               ),
                               Container(
                                 padding: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                                 child: sText("Stream on your favourite device"),
                               ),
                               Container(
                                 width: 300,
                                 height: 1,
                                 color: Colors.grey,
                               ),
                               Container(
                                 padding: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                                 child: sText("Watch on your laptop, TV, phone and tablet"),
                               ),
                               Container(
                                 width: 300,
                                 height: 1,
                                 color: Colors.grey,
                               ),
                               Container(
                                 padding: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                                 child: sText("HD videos available"),
                               ),
                               Container(
                                 width: 300,
                                 height: 1,
                                 color: Colors.grey,
                               ),
                               Container(
                                 padding: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                                 child: sText("Unlimited films and TV programmes"),
                               ),
                               Container(
                                 width: 300,
                                 height: 1,
                                 color: Colors.grey,
                               ),
                               SizedBox(height: 10,),
                               Container(
                                 padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                                 child: sText("Subscribe Now",align: TextAlign.center),
                                 decoration: BoxDecoration(
                                     color: dPurple,
                                     borderRadius: BorderRadius.circular(30)
                                 ),

                               ),
                               SizedBox(height: 10,),
                             ],
                           ),
                         ),
                       ),
                       Container(
                         margin: EdgeInsets.only(right: 20,top: 10,bottom: 10),

                         width: 300,
                         decoration: BoxDecoration(
                             color: Colors.black26,
                             borderRadius: BorderRadius.circular(5)

                         ),
                         child: Container(
                           child: Column(
                             children: [
                               Container(
                                 padding: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                                 width: 300,
                                 child: sText("MONTHLY STANDARD",align: TextAlign.center),
                                 decoration: BoxDecoration(
                                     color: dPurple,
                                     borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5))
                                 ),

                               ),
                               Container(
                                 padding: EdgeInsets.symmetric(horizontal: 70,vertical: 10),
                                 child: sText("US\$0.99",weight: FontWeight.bold),
                               ),
                               Container(
                                 width: 300,
                                 height: 1,
                                 color: Colors.grey,
                               ),
                               Container(
                                 padding: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                                 child: sText("You can watch 4 screens at the same time"),
                               ),
                               Container(
                                 width: 300,
                                 height: 1,
                                 color: Colors.grey,
                               ),
                               Container(
                                 padding: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                                 child: sText("Stream on your favourite device"),
                               ),
                               Container(
                                 width: 300,
                                 height: 1,
                                 color: Colors.grey,
                               ),
                               Container(
                                 padding: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                                 child: sText("Watch on your laptop, TV, phone and tablet"),
                               ),
                               Container(
                                 width: 300,
                                 height: 1,
                                 color: Colors.grey,
                               ),
                               Container(
                                 padding: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                                 child: sText("HD videos available"),
                               ),
                               Container(
                                 width: 300,
                                 height: 1,
                                 color: Colors.grey,
                               ),
                               Container(
                                 padding: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                                 child: sText("Unlimited films and TV programmes"),
                               ),
                               Container(
                                 width: 300,
                                 height: 1,
                                 color: Colors.grey,
                               ),
                               SizedBox(height: 10,),
                               Container(
                                 padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                                 child: sText("Subscribe Now",align: TextAlign.center),
                                 decoration: BoxDecoration(
                                     color: dPurple,
                                     borderRadius: BorderRadius.circular(30)
                                 ),

                               ),
                               SizedBox(height: 10,),
                             ],
                           ),
                         ),
                       )
                     ],
                   ),
                 )
               ],
             ),
           )
          ],
        ),
      ),
    );
  }
}
