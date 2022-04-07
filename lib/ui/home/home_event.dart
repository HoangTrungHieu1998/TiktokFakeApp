part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {
  Stream<HomeState> applyAsync({HomeState? state, HomeBloc? bloc});
}

class LoadUser extends HomeEvent{
  @override
  Stream<HomeState> applyAsync({HomeState? state, HomeBloc? bloc}) async*{
    try{
      yield HomeInitial();
      final user = await HomeService.instance.getUser();
      if(user != null){
        if(user.isEmpty){
          HomeEmpty();
        }else{
          yield HomeSuccess(user);
        }
      }else{
        yield HomeError("User is null");
      }

    }catch (_) {
      yield HomeError(_.toString());
    }
  }

}
