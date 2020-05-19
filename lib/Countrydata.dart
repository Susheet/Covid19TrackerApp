import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Countrydata extends StatefulWidget {
  @override
  _CountrydataState createState() => _CountrydataState();
}

class _CountrydataState extends State<Countrydata> {


 var countryData;
 bool isLoading = true;
 final String url = "https://api.covid19api.com/summary";

 Future getData() async {
   var response = await http.get(
     Uri.encodeFull(url),
   );

   var data = json.decode(response.body)['Countries'];
 
    setState(() {
      countryData = data;
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
        title: Text("World Covid 19 live tracker"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey,
        child: Center(
          child:  isLoading ? CircularProgressIndicator()
          :  ListView.builder(
            itemCount: countryData == null ? 0 : countryData.length,//extra safety check
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
                                countryData[index]['Country'],
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
                                   Text("Confirmed: ${countryData[index]['TotalConfirmed']}",style: TextStyle(color: Colors.blue),),
                                 ],
                               ),
                               Row(
                                 children: <Widget>[
                                   Icon(Icons.add_alert),
                                   Text("New Confirmed: ${countryData[index]['NewConfirmed']}",style: TextStyle(color: Colors.red),),
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
                                  Text("Recovered: ${countryData[index]['TotalRecovered']}",style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.calendar_today),
                                  Text("New Recovered: ${countryData[index]['NewRecovered']}"),
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
