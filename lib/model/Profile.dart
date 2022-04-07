import 'UserVideo.dart';

class Profile {
    String? description;
    int? follow;
    int? following;
    int? id;
    int? like;
    String? name;
    String? image;
    String? loginName;
    List<UserVideo>? userVideo;

    Profile({this.description, this.follow, this.following, this.id, this.like, this.name, this.image,this.userVideo,this.loginName});

    factory Profile.fromJson(Map<String, dynamic> json) {
        return Profile(
            description: json['description'],
            follow: json['follow'], 
            following: json['following'], 
            id: json['id'], 
            like: json['like'], 
            name: json['name'], 
            image: json['image'],
            loginName: json['loginName'],
            userVideo: json['userVideo'] != null ? (json['userVideo'] as List).map((i) => UserVideo.fromJson(i)).toList() : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['description'] = description;
        data['follow'] = follow;
        data['following'] = following;
        data['id'] = id;
        data['like'] =like;
        data['name'] = name;
        data['image'] = image;
        data['loginName'] = loginName;
        if (userVideo != null) {
            data['userVideo'] = userVideo!.map((v) => v.toJson()).toList();
        }
        return data;
    }
}