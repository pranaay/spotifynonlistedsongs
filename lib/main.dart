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
        Iterable list = json.decode(response.body);
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
//  Widget _buildSuggestions() {
//    return ListView.builder(
//        padding: const EdgeInsets.all(16.0),
//        itemBuilder: /*1*/ (context, i) {
//          if (i.isOdd) return Divider(); /*2*/
//
//          final index = i ~/ 2; /*3*/
//          if (index >= _suggestions.length) {
//            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
//          }
//          return _buildRow(_suggestions[index]);
//        });
//  }

  Widget _buildRow(WordPair pair) {


    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
}
//var tokens = new Map<String,String>();

Map<String, String> tokens = {"Accept": "application/json" , "Content-Type": "application/json" , "Authorization": "Bearer BQAJlxUReJ1LVA-jgihc3vEg7xDZG4QJrVFYU7x9Vhai5KoQ8qKloc26giihcWq0aCDYoEl9GajxviMPpInjI0Alp5eTnXaylRs-7OdARQaDTGTtF_fGC0DPsxZV69-z_2k12lnzPIF-WJVPfz9mM59tKwSeweV5wY286zCxPROKiWfLG0ge6QVelIP81TvkGSTG6ZJJ-IveRsmM5MynQrqb"};
var url = "https://api.spotify.com/v1/playlists/2r8mbGkYcMDAYVByKDhsSp?market=IN&fields=tracks.items(track(name%2Cis_playable))";
//final response =  http.get(url,headers: tokens );


class Api {
  static Future getSongs(){
    var response =  http.get(url,headers: tokens );
//    response.then((response) {
////      json.
////      response.body
//      String jss = json.decode(response.body);
//      Map<String,dynamic> js =  jsonDecode(response.body);
//      js = js['tracks'];
//      js = js['items'];
//
//      debugPrint(response.body);
//    });

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

  Songs.fromJson(Map json)
      : name = json['tracks']['items']['track']['name'],
        is_available = json['tracks']['items']['track']['is_playable'];

  Map toJson(){
    return {"name" : name , "is_available" : is_available};
  }

}