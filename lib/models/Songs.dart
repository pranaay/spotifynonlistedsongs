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