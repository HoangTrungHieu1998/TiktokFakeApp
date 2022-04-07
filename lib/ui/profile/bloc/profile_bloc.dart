import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tiktok/model/Profile.dart';
import 'package:flutter_tiktok/service/cache_manager.dart';

import '../../../service/home_service.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
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
