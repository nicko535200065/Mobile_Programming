import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

}
@overrideWidget build(buildcontext context) {
  return MaterialApp(
    title: 'Flutter Demo',
    home: Text('Hello, World'),
  );
}
}