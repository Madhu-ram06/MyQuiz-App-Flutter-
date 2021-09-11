

import 'package:flutter/material.dart';

import 'home.dart';

class Splash extends StatefulWidget {
  const Splash({ key }) : super(key: key);

 @override 
 _SplashState createState() => _SplashState();

  
}

 class _SplashState extends State<Splash>{
@override
void initState()
{
    super.initState();
    _navigatetohome();
}
_navigatetohome() async {
  await Future.delayed(Duration(milliseconds: 2000),() {});
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
  @override
  // ignore: unused_element
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Container(
          child:Text(
            'Data Structures and Algo quiz',
            style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold )
          ),
          ),
          ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  
 

} 
