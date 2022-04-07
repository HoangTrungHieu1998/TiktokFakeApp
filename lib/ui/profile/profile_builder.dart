import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tiktok/service/cache_manager.dart';
import 'package:flutter_tiktok/ui/home/home.dart';
import 'package:flutter_tiktok/ui/profile/profile_page.dart';
import 'package:shimmer/shimmer.dart';

import '../../model/Profile.dart';
import '../../ultils/img.dart';
import 'bloc/profile_bloc.dart';

class ProfileBuilder extends StatefulWidget {
  const ProfileBuilder({Key? key}) : super(key: key);

  @override
  State<ProfileBuilder> createState() => _ProfileBuilderState();
}

class _ProfileBuilderState extends State<ProfileBuilder> {

  late ProfileBloc bloc;
  Profile? profile;
  int? idLogin = CacheManager.instance.get("login", 0);
  @override
  void initState() {
    bloc = ProfileBloc();
    bloc.add(LoadProfile(id: idLogin));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProfilePage(bloc: bloc,idLogin: idLogin,);
  }
}