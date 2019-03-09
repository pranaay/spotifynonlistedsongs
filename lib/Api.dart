import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';



Map<String, String> tokens = {"Accept": "application/json" , "Content-Type": "application/json" };
//var url = "https://api.spotify.com/v1/playlists/2r8mbGkYcMDAYVByKDhsSp?market=IN&fields=tracks.items(track(name%2Cis_playable))";

class Api {

  static Future getSongs(String playlisturi,String country) async{
    // get new OAuth token
    Map<String, String> to = {'Authorization': 'Basic <add your own>'};
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
    Map<String, String> to = {'Authorization': 'Basic <add your own>'};
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
