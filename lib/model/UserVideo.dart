class UserVideo {
    String? caption;
    int? comment;
    int? id;
    int? like;
    int? share;
    String? songName;
    String? videoUrl;

    UserVideo({this.caption, this.comment, this.id, this.like, this.share, this.songName, this.videoUrl});

    factory UserVideo.fromJson(Map<String, dynamic> json) {
        return UserVideo(
            caption: json['caption'], 
            comment: json['comment'], 
            id: json['id'], 
            like: json['like'], 
            share: json['share'], 
            songName: json['songName'], 
            videoUrl: json['videoUrl'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['caption'] = caption;
        data['comment'] = comment;
        data['id'] = id;
        data['like'] = like;
        data['share'] = share;
        data['songName'] = songName;
        data['videoUrl'] = videoUrl;
        return data;
    }
}