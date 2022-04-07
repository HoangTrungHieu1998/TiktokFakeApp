class User {
    String? caption;
    int? comment;
    int? id;
    String? image;
    int? like;
    int? share;
    String? songName;
    String? userName;
    String? videoUrl;

    User({this.caption, this.comment, this.id, this.image, this.like, this.share, this.songName, this.userName, this.videoUrl});

    factory User.fromJson(Map<String, dynamic> json) {
        return User(
            caption: json['caption'], 
            comment: json['comment'], 
            id: json['id'], 
            image: json['image'], 
            like: json['like'], 
            share: json['share'], 
            songName: json['songName'], 
            userName: json['userName'], 
            videoUrl: json['videoUrl'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['caption'] = caption;
        data['comment'] = comment;
        data['id'] = id;
        data['image'] = image;
        data['like'] = like;
        data['share'] = share;
        data['songName'] = songName;
        data['userName'] = userName;
        data['videoUrl'] = videoUrl;
        return data;
    }
}