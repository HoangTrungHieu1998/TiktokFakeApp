part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  final List? propss;
  const ProfileState(this.propss);
  @override
  List<Object?> get props => (propss ?? []);
}

class ProfileInitial extends ProfileState {
  ProfileInitial() : super([]);
}
class ProfileError extends ProfileState {
  final String? error;
  ProfileError(this.error) : super([]);
}
class ProfileSuccess extends ProfileState {
  final Profile? profile;
  ProfileSuccess({this.profile}) : super([]);
}
class ProfileEmpty extends ProfileState {
  ProfileEmpty() : super([]);
}


class ProfileUpdateLoading extends ProfileState{
  ProfileUpdateLoading():super([]);
}

class ProfileUpdateSuccess extends ProfileState{
  final int? id;
  ProfileUpdateSuccess({this.id}):super([]);
}

class ProfileUpdateFailed extends ProfileState{
  final String? message;
  ProfileUpdateFailed(this.message):super([]);
}

class ProfileSignUpLoading extends ProfileState{
  ProfileSignUpLoading():super([]);
}

class ProfileSignUpSuccess extends ProfileState{
  final int? id;
  ProfileSignUpSuccess({this.id}):super([]);
}

class ProfileSignUpFailed extends ProfileState{
  final String? error;
  ProfileSignUpFailed(this.error):super([]);
}

class ProfileEditLoading extends ProfileState{
  ProfileEditLoading():super([]);
}

class ProfileEditSuccess extends ProfileState{
  final int? id;
  ProfileEditSuccess({this.id}):super([]);
}

class ProfileEditFailed extends ProfileState{
  final String? error;
  ProfileEditFailed(this.error):super([]);
}