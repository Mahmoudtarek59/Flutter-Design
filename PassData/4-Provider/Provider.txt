import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Data>(
      create: (context) => Data(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: MyText(),
          ),
          body: Level1(),
        ),
      ),
    );
  }
}

class Level1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Level2(),
    );
  }
}

class Level2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextField(),
        Level3(),
      ],
    );
  }
}

class Level3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyText();
  }
}

class MyText extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Text(Provider.of<Data>(context).data,style: TextStyle(fontSize: Provider.of<Data>(context).size));
  }
}

class MyTextField extends StatefulWidget {
  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  double val=12;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          onChanged: (newText) {
            Provider.of<Data>(context,listen: false).changeString(newText);
          },
        ),
        Slider(value: val, onChanged: (value){
          Provider.of<Data>(context,listen: false).changeSize(val);
          setState(() {
            val=value;
          });
        },max: 50,min: 10,),
      ],
    );
  }
}

class Data extends ChangeNotifier{
  String data = 'Some data';
  double size =18;

  void changeString(String newString) {
    this.data= newString;
    notifyListeners();
  }
  void changeSize(double size){
    this.size=size;
    notifyListeners();
  }
}