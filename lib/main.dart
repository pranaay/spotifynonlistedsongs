import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FML',
      home: MyListScreen(),

    );
  }
}
class MyListScreen extends StatefulWidget {
  @override
  createState() => _MyListScreenState();
}


class _MyListScreenState extends State {
  var songs = new List<Songs>();
  final _biggerFont = const TextStyle(fontSize: 18.0);
  _getSongs() {
    Api.getSongs().then((response) {
      setState(() {
        Map l = json.decode(response.body);
        Map ll = l["tracks"];
        Iterable list = ll['items'];
        songs = list.map((model) => Songs.fromJson(model)).toList();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSongs();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context)  {


    return Scaffold(
      appBar: AppBar(
        title: Text('Unavailable songs'),
      ),
      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          if(index.isOdd) return Divider();
          else return ListTile(title: Text(songs[index].name));
        },
      ));
  }

}

Map<String, String> tokens = {"Accept": "application/json" , "Content-Type": "application/json" };
var url = "https://api.spotify.com/v1/playlists/2r8mbGkYcMDAYVByKDhsSp?market=IN&fields=tracks.items(track(name%2Cis_playable))";
//final response =  http.get(url,headers: tokens );


class Api {
  static Future getSongs() async{
    Map<String, String> to = {'Authorization': 'Basic <put in your token>'};
    var body_params = {'grant_type' : 'client_credentials'};

    var ur = "https://accounts.spotify.com/api/token";
    var reso = await http.post(ur,headers: to,body: body_params);
    Map toko = jsonDecode(reso.body);
    tokens["Authorization"]="Bearer " + toko["access_token"];



    var response =  http.get(url,headers: tokens );

    return response;
  }
}

class Songs{
  String name;
  bool is_available;

  Songs(String n,bool i){
    this.name = n;
    this.is_available = i;
  }

  Songs.fromJson(Map<String, dynamic> json)
      : name = json['track']['name'],
        is_available = json['track']['is_playable'];

  Map toJson(){
    return {"name" : name , "is_available" : is_available};
  }

}