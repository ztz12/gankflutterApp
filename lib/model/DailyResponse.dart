class DailyResponse{
  List<dynamic> category;
  bool error;
  Map<String,dynamic> results;
  DailyResponse(this.results,this.category,this.error);

  DailyResponse.fromJson(Map<String,dynamic> json){
    this.error = json['error'];
    this.category = json['category'];
    this.results = json['results'];
  }

  Map<String,dynamic> toJson() =>{
     'error':error,
     'category':category,
     'results':results,
  };
}

class CategoryResponse{
  bool error;
  List<dynamic> results;

  CategoryResponse(this.results,this.error);

  CategoryResponse.fromJson(Map<String,dynamic> json){
    this.error = json['error'];
    this.results = json['results'];
  }

  Map<String,dynamic> toJson()=>{
    'error':error,
    'results':results,
  };
}

class PostData {
  String _id;
  String createdAt;
  String desc;
  List<dynamic> images;
  String publishedAt;
  String source;
  String type;
  String url;
  bool used;
  String who;

  PostData(this._id, this.createdAt, this.desc, this.images, this.publishedAt,
      this.source, this.type, this.url, this.used, this.who);

  PostData.fromJson(Map<String, dynamic> json) {
    this._id = json['_id'];
    this.createdAt = json['createdAt'];
    this.desc = json['desc'];
    this.images = json['images'];
    this.publishedAt = json['publishedAt'];
    this.source = json['source'];
    this.type = json['type'];
    this.url = json['url'];
    this.used = json['used'];
    this.who = json['who'];
  }

  Map<String, dynamic> toJson() => {
    '_id': _id,
    'createdAt': createdAt,
    'desc': desc,
    'images': images,
    'publishedAt': publishedAt,
    'source': source,
    'type': type,
    'url': url,
    'used': used,
    'who': who,
  };
}

class SearchResponse {
  int count;
  bool error;
  List<dynamic> results;

  SearchResponse(this.count, this.error, this.results);

  SearchResponse.fromJson(Map<String, dynamic> json) {
    this.count = json['count'];
    this.error = json['error'];
    this.results = json['results'];
  }
}

class SearchData {
  String ganHuoId;
  String desc;
  String publishedAt;
  String readability;
  String type;
  String url;
  String who;

  SearchData(this.ganHuoId, this.desc, this.publishedAt, this.readability,
      this.type, this.url, this.who);

  SearchData.fromJson(Map<String, dynamic> json) {
    this.ganHuoId = json['ganHuoId'];
    this.desc = json['desc'];
    this.publishedAt = json['publishedAt'];
    this.readability = json['readability'];
    this.type = json['type'];
    this.url = json['url'];
    this.who = json['who'];
  }

  Map<String, dynamic> toJson() => {
    'ganHuoId': ganHuoId,
    'desc': desc,
    'publishedAt': publishedAt,
    'readability': readability,
    'type': type,
    'url': url,
    'who': who,
  };
}