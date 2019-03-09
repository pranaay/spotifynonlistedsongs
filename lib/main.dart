import 'package:flutter/material.dart';
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
    Api.getSongs("2r8mbGkYcMDAYVByKDhsSp","IN").then((response) {
      setState(() {
        Map l = json.decode(response.body);
        Iterable list = l['tracks']['items'];
        songs = list.map((model) => Songs.fromJson(model)).toList();
      });
    });
  }

  _getPlaylists(){

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
//var url = "https://api.spotify.com/v1/playlists/2r8mbGkYcMDAYVByKDhsSp?market=IN&fields=tracks.items(track(name%2Cis_playable))";

class Api {

  static Future getSongs(String playlisturi,String country) async{
    // get new OAuth token
    Map<String, String> to = {'Authorization': 'Basic <put in your own>'};
    var body_params = {'grant_type' : 'client_credentials'};
    var ur = "https://accounts.spotify.com/api/token";
    var reso = await http.post(ur,headers: to,body: body_params);
    Map toko = jsonDecode(reso.body);
    //set new OAuth token
    tokens["Authorization"]="Bearer " +toko["access_token"];

    String url = "https://api.spotify.com/v1/playlists/" +  playlisturi.toString() + "?market=" + country.toString() + "&fields=tracks.items(track(name%2Cis_playable))" ;
    //Get get response
    var response =  http.get(url,headers: tokens );
    return response;
  }

  static Future getPlaylists(String useruri) async{
    // get new OAuth token
    Map<String, String> to = {'Authorization': 'Basic <put in your own>'};
    var body_params = {'grant_type' : 'client_credentials'};
    var ur = "https://accounts.spotify.com/api/token";
    var reso = await http.post(ur,headers: to,body: body_params);
    Map toko = jsonDecode(reso.body);
    //set new OAuth token
    tokens["Authorization"]="Bearer " +toko["access_token"];

    String url = "https://api.spotify.com/v1/users/" + useruri.toString() +"/playlists";
    var response = http.get(url,headers: tokens);
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

class Playlists{
  String name;

}