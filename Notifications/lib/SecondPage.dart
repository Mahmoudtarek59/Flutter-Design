import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  final String payload;

  const SecondPage({
    @required this.payload,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              'Second page - Payload:',
              style: Theme.of(context).textTheme.title,
            ),
            const SizedBox(height: 8),
            Text(
              " ok ${payload}",
              style: Theme.of(context).textTheme.subtitle,
            ),
            const SizedBox(height: 8),
            RaisedButton(
              child: Text('Back'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
