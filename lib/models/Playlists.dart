class Playlists{
  String name;
  String uri;

  Playlists(String n, String u){
    this.name = n;
    this.uri = u;
  }

  Playlists.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        uri = json["id"];

  Map toJson(){
    return {"name" : name, "uri" : uri};
  }

}