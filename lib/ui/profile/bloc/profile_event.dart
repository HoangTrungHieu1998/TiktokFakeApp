part of 'profile_bloc.dart';

abstract class ProfileEvent{
  Stream<ProfileState> applyAsync({ProfileState? state, ProfileBloc? bloc});
}

class LoadProfile extends ProfileEvent{
  final int? id;


  LoadProfile({this.id});

  @override
  Stream<ProfileState> applyAsync({ProfileState? state, ProfileBloc? bloc}) async*{
    try{
      yield ProfileInitial();
      final profile = await HomeService.instance.getProfile(id: id);
      if(profile != null){
        yield ProfileSuccess(profile: profile);
      }else{
        yield ProfileEmpty();
      }
    }catch (_) {
      yield ProfileError(_.toString());
    }
  }

}

class LoginProfile extends ProfileEvent{
  final String? loginName;
  final String? loginPassword;

  LoginProfile(this.loginName, this.loginPassword);

  @override
  Stream<ProfileState> applyAsync({ProfileState? state, ProfileBloc? bloc}) async*{
    try{
      yield ProfileUpdateLoading();
      if(loginName!.isNotEmpty && loginPassword!.isNotEmpty){
        final result = await HomeService.instance.checkLogin(loginName: loginName,loginPassword: loginPassword);
        if(result.access!){
          yield ProfileUpdateSuccess(id: result.data);
        }else{
          yield ProfileUpdateFailed(result.error);
        }
      }else{
        yield ProfileUpdateFailed("You are not enter value");
      }
    }catch (_) {
      yield ProfileUpdateFailed("Api is not response");
    }
  }

}

class SignUpProfile extends ProfileEvent{
  final String? loginName;
  final String? loginPassword;
  final String? userName;
  final String? description;

  SignUpProfile(this.loginName, this.loginPassword,this.userName,this.description);

  @override
  Stream<ProfileState> applyAsync({ProfileState? state, ProfileBloc? bloc}) async*{
    try{
      yield ProfileSignUpLoading();
      final result = await HomeService.instance.signUp(loginName: loginName,loginPassword: loginPassword,description: description,userName: userName);
      if(result.access!){
        yield ProfileSignUpSuccess(id: result.data);
      }else{
        yield ProfileSignUpFailed(result.error);
      }
    }catch (_) {
      yield ProfileSignUpFailed("Update Failed");
    }
  }

}

class EditProfile extends ProfileEvent{
  final int? id;
  final String? loginName;
  final String? userName;

  EditProfile(this.id,this.loginName,this.userName);

  @override
  Stream<ProfileState> applyAsync({ProfileState? state, ProfileBloc? bloc}) async*{
    try{
      yield ProfileEditLoading();
      final result = await HomeService.instance.editProfile(loginName: loginName,userName: userName,id: id);
      if(result.access!){
        yield ProfileEditSuccess(id: id);
      }else{
        yield ProfileEditFailed(result.error);
      }
    }catch (_) {
      yield ProfileEditFailed("Update Failed");
    }
  }

}
