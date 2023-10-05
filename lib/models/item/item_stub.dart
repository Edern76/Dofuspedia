import 'dart:convert';

class ItemStub{
  final int ankamaId;
  final ImageUrls imageUrls;
  final String name;
  final String subtype; //TODO: Convert to enum

  ItemStub({
    required this.ankamaId,
    required this.imageUrls,
    required this.name,
    required this.subtype
  });

  factory ItemStub.fromJson(Map<String, dynamic> json){
    String name = json["name"] as String;
    return ItemStub(ankamaId: json["ankama_id"],
        imageUrls: ImageUrls.fromJson(json["image_urls"]),
        name: utf8.decode(name.codeUnits),
        subtype: json["subtype"]
    );
  }
}

class ImageUrls{
  final String? hdUrl;
  final String? hqUrl;
  final String? iconUrl;
  final String? sdUrl;

  ImageUrls({
    this.hdUrl,
    this.hqUrl,
    this.iconUrl,
    this.sdUrl
  });

  factory ImageUrls.fromJson(Map<String, dynamic> json){
    return ImageUrls(hdUrl: json["hd"],
        hqUrl: json["hq"],
        iconUrl: json["icon"],
        sdUrl: json["sd"]
    );
  }

  Map<String, String?> _toMap(){
    return {
      "hd": this.hdUrl,
      "hq" : this.hqUrl,
      "icon": this.iconUrl,
      "sd": this.sdUrl
    };
  }

  String? getImageUrl(String quality){
    Map<String, String?> urlMap = this._toMap();
    List<String> qualities = urlMap.keys.toList();
    if (!urlMap.containsKey(quality)){
      throw Exception("Key $quality not in the image url map's entries");
    }
    qualities.remove(quality);
    if (urlMap[quality] != null){
      return urlMap[quality];
    }
    else{
      for (String q in qualities){
        if (urlMap[q] != null){
          return urlMap[q];
        }
      }
      return null;
    }
  }

}
