import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  
  var stateData;
  bool isLoading = true;
  final String url = "https://api.covid19india.org/data.json";


  Future getData() async{
    var response = await http.get(
      Uri.encodeFull(url),
    );

    var data = (json.decode(response.body)['statewise']);
      
    setState(() {
      stateData = data;
      isLoading = false;
    });
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All India Covid-19 live tracker"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Made by-"),
              accountEmail: Text("SUSHEET KUMAR"),
              currentAccountPicture: CircleAvatar(
                child: Image.asset("Images/download.jpg"),
              ),
            ),
            ListTile(
              title: Text("India"),
              trailing: Icon(Icons.home),
              onTap: ()=> Navigator.of(context).pushNamed("/India"),

            ),
            ListTile(
              title: Text("World"),
              trailing: Icon(Icons.map),
              onTap: ()=> Navigator.of(context).pushNamed("/world"),
            )
          ],
        ),
      ),
      body: Container(
        color: Colors.grey,
        child: Center(
          child:  isLoading ? CircularProgressIndicator()
          :  ListView.builder(
            itemCount: stateData == null ? 0 : stateData.length,//extra safety check
            itemBuilder: (context, index){
              return Card(
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.location_on),
                              Text(
                                stateData[index]['state'],
                                style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold
                                ),
                                ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                               Row(
                                 children: <Widget>[
                                   Icon(Icons.check),
                                   Text("Confirmed: ${stateData[index]['confirmed']}",style: TextStyle(color: Colors.blue),),
                                 ],
                               ),
                               Row(
                                 children: <Widget>[
                                   Icon(Icons.add_alert),
                                   Text("Active: ${stateData[index]['active']}",style: TextStyle(color: Colors.red),),
                                 ],
                               ),
                            ],
                          ),
                         
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(Icons.thumb_up),
                                  Text("Recovered: ${stateData[index]['recovered']}",style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.clear),
                                  Text("Deaths: ${stateData[index]['deaths']}"),
                                ],
                              ),
                            ],
                          ),
                           Padding(
                             padding: EdgeInsets.all(15.0),
                           ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}