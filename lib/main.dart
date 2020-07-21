import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: MyGetHttpData(),
  ));
}

//creating a stateful widget

class MyGetHttpData extends StatefulWidget {
  @override
  _MyGetHttpDataState createState() => _MyGetHttpDataState();
}

//creating a state for our stateful widget
class _MyGetHttpDataState extends State<MyGetHttpData> {
  final String url = 'https://swapi.co/api/people';
  List data;

  //creating a function to get JSON data
  Future<String> getJSONData() async {
    var response = await http.get(
        //encode the url
        Uri.encodeFull(url),
        //only accept JSON response
        headers: {'Accept': 'application/json'});
    //logs the response body to the console
    print(response.body);

    //modifying the state of the app
    setState(() {
      //get the JSON data
      var dataConvertedToJSON = json.decode(response.body);

      //Extract the required part and assign it to the global variable
      data = dataConvertedToJSON['results'];
    });

    return 'Successfull';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Retrieve JSON Data via HTTP get'),
        backgroundColor: Colors.pinkAccent,
      ),
      //creating alistview andload data when available
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Center(
              child: Column(
                //Stretching the cards in horizontal axis
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    child: Container(
                      child: Text(
                        //Read the name field value and set it in the text widget
                        data[index]['name'],
                        //setting some style to text
                        style: TextStyle(
                            fontSize: 20.0, color: Colors.lightBlueAccent),
                      ),
                      //added padding
                      padding: const EdgeInsets.all(15.0),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    //calling the getJSONData() method when app initializes
    this.getJSONData();
  }
}
