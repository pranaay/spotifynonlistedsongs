import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:spotifynonlistedsongs/models/Playlists.dart';
import 'package:spotifynonlistedsongs/models/Songs.dart';
import 'package:spotifynonlistedsongs/Api.dart';
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
  var playlists = new List<Playlists>();
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
    Api.getPlaylists("f68lmzo7ouo9skhuaiojbq2ne").then((response){
      setState(() {
        Map l = json.decode(response.body);
        Iterable list = l["items"];
        playlists = list.map((model) => Playlists.fromJson(model)).toList();
      });
    });
    
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSongs();
    _getPlaylists();
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
        itemCount: playlists.length*2,
        itemBuilder: (context, index) {
          if(index.isOdd) return Divider();
          else return ListTile(title: Text(playlists[index ~/ 2].name));
        },
      ));
  }

}




