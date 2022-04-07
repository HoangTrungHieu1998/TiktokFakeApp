import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tiktok/model/User.dart';
import 'package:flutter_tiktok/service/home_service.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async{
      try {
        await for (final events in event.applyAsync(state: state,bloc: this)){
          emit(events);
        }
        //event.applyAsync(currentState: state, bloc: this);
      } catch (_, stackTrace) {
        emit(state);
      }
    });
  }
}
