part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable{
  final List? propss;

  const HomeState(this.propss);
  @override
  List<Object?> get props => (propss ?? []);
}

class HomeInitial extends HomeState {
  HomeInitial() : super([]);
}

class HomeError extends HomeState{
  final String? error;
  HomeError(this.error) : super([error]);
}

class HomeEmpty extends HomeState{
  HomeEmpty() : super([]);
}

class HomeSuccess extends HomeState{
  final List<User>? user;
  HomeSuccess(this.user) : super([user]);
}


