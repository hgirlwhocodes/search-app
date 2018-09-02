import 'package:flutter/material.dart';

import './search.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  String inputQuery = '';

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    return Scaffold(
        body: Center(
            child: Container(
              
      margin: EdgeInsets.all(30.0),
      padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
      child: SingleChildScrollView(child: Column(
        children: <Widget>[
          SizedBox(height: 80.0,),
          Image.asset('assets/search_logo.png', width: 100.0,),
          SizedBox(height: 30.0,),
          Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      inputQuery = value.toLowerCase();
                    });
                  },
                  decoration:
                      InputDecoration(helperText: "Search for a book by title"),
                ),
              ),
              IconButton(
                  tooltip: 'Search for a specific book',
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => SearchPage(inputQuery)
                    ));
                  }),
            ],
          ),
        ],
      ),
    ))));
  }
}
