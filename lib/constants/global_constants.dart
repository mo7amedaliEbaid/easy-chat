import 'package:flutter/material.dart';


final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
new GlobalKey<RefreshIndicatorState>();
final TextEditingController onemessagecontroller = TextEditingController();
final TextEditingController groubmessagecontroller = TextEditingController();

Color scafold_background = Color(0xffc8d7d7);
Color mygreen = Color(0xff076c2d);
Color lightgreen = Color(0xff21db69);
Color unchosencolor=Color(0xff1cfca6);
Color chosencolor=Color(0xff129664);
SizedBox smallvertical_space=SizedBox(height: 5,);
SizedBox vertical_space=SizedBox(height: 10,);
SizedBox horizontal_space=SizedBox(width: 10,);
SizedBox smallhorizontal_space=SizedBox(width: 5,);
ButtonStyle elevatedstyle= ButtonStyle(backgroundColor: MaterialStateProperty.all(mygreen));
TextStyle greenstyle = TextStyle(
  color: mygreen,
  fontSize: 25,
  fontWeight: FontWeight.bold,
  fontFamily: "IndieFlower",
);
TextStyle smallgreenstyle = TextStyle(
  color: mygreen,
  fontSize: 18,
  fontWeight: FontWeight.bold,
);
TextStyle normalgreenstyle = TextStyle(
  color: mygreen,
  fontSize: 21,
  fontWeight: FontWeight.bold,
);
TextStyle bigwhite=TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 23
);
TextStyle normalwhite=TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 18
);