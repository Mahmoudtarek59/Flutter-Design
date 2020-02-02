import 'package:flutter/material.dart';
import 'TimeDisplay.dart';
import 'dart:async';
class TimeCounter extends StatefulWidget{
  @override
  _TimeState createState()=>_TimeState();
}

class _TimeState extends State<TimeCounter>{

  Stopwatch _stopwatch;
  Timer _timer;
  Duration _duration;

  void _onStart(){
    setState(() {
      _stopwatch=new Stopwatch();
      _timer=new Timer.periodic(new Duration(milliseconds: 250), _onTimeOut);
    });
    _stopwatch.start();
  }

  void _onStop(){
    _stopwatch.stop();
    _timer.cancel();
  }

  void _onTimeOut(Timer timer){
    if(!_stopwatch.isRunning) return;
    setState(()=>_duration=_stopwatch.elapsed);
  }

  void _onClear(Duration value){
    setState((){
      _duration=new Duration();
      _stopwatch.stop();
      _timer.cancel();});
  }


  @override
  void initState() {
    _duration=new Duration();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.all(30.0),
      child:new Center(
        child: new Column(
          children: <Widget>[
            new TimeDisplay(
              duration: _duration,
              color: Colors.red,
              onClear: _onClear,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(
                  padding: new EdgeInsets.all(5.0),
                  child: new RaisedButton(onPressed: _onStart,child: new Text("Start"),),
                ),
                new RaisedButton(onPressed: _onStop,child: new Text("Stop"),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}