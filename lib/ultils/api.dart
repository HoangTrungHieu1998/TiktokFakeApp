const String api = "https://10.0.2.2:5001";

class Api{
  Api._();
  static final Api instance = Api._();

  String get urlVideo => '$api/api/User/GetAllVideos';
  String get urlProfile => '$api/api/User/GetProfile';
  String get urlUserVideo => '$api/api/User/GetAllUserVideos';
  String get urlCheckLogin => '$api/api/User/CheckLogin';
  String get urlSignUp => '$api/api/User/SignUp';
}