import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FML',
      home: RandomWords(),

    );
  }
}
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}


class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }
  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    var tokens = new Map();
    tokens = {"Accept": "application/json" , "Content-Type": "application/json" , "Authorization": "Bearer BQAgItb-wsabeWI0EWpsFc0wcWLujcxDvBZUUm4Vp_9-jWWNAbMO6vtffSQ7L9JBKSdb_jzggLFN3K841jI_Kthng38uY6A_szP1dzGwat1vtXYK9ZIMctN_EF6GzPaNHt_x8QmRZubQMk_qVAoSBrMO1j1Zt0-ln-nEYp00pKWpEUa8vHdYnjJgYNVKnJdSXVQf4UPyyDSyPgiI6W1UarTx"};
    var url = "https://api.spotify.com/v1/playlists/2r8mbGkYcMDAYVByKDhsSp?market=IN&fields=tracks.items(track(name%2Cis_playable))";
    http.get(url,headers: tokens );

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
}