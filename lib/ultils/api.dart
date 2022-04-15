const String api = "https://10.0.2.2:5001";
const String apiLocal = "https://localhost:5001";

class Api{
  Api._();
  static final Api instance = Api._();

  String get urlVideo => '$api/api/User/GetAllVideos';
  String get urlProfile => '$api/api/User/GetProfile';
  String get urlUserVideo => '$api/api/User/GetAllUserVideos';
  String get urlCheckLogin => '$api/api/User/CheckLogin';
  String get urlSignUp => '$api/api/User/SignUp';
  String get urlEdit => '$api/api/User/EditProfile';
  String get urlAddLike => '$api/api/User/AddLike';
  String get urlDisLike => '$api/api/User/DisLike';
  String get urlUploadVideo => '$api/api/UploadController';
  String get urlSaveVideo => '$api/api/User/UploadVideo';
}