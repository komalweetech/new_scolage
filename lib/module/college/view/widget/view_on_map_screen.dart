import 'package:flutter/material.dart';


class ViewOnMapScreen extends StatefulWidget {
  const ViewOnMapScreen({
    super.key,
  });

  @override
  _ViewOnMapScreenState createState() => _ViewOnMapScreenState();
}

class _ViewOnMapScreenState extends State<ViewOnMapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Location Image on Map'),
        ),
        body: Container()
        );
  }
}
