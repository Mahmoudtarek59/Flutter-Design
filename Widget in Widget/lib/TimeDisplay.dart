import 'package:flutter/material.dart';

class TimeDisplay extends StatelessWidget{

  TimeDisplay({Key key,Color this.color,Duration this.duration,this.onClear}) : super(key: key);

  Duration duration= new Duration();
  Color color = Colors.green;
  final ValueChanged<Duration> onClear; //this value is going to be set in somewhere else , not only in this class

  void _onClicked(){
    onClear(duration);
  }
  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Padding(
          padding: new EdgeInsets.all(5),
          child: new Text(duration.toString(),style: new TextStyle(fontSize: 32.0,color: color),),
        ),
        new IconButton(icon:new Icon(Icons.close) , onPressed: _onClicked),
      ],
    );
  }
}