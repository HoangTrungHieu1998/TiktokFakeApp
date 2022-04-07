import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tiktok/ui/home/home_page.dart';
import 'package:flutter_tiktok/ultils/color.dart';
import 'package:shimmer/shimmer.dart';

import '../../model/User.dart';
import '../../ultils/img.dart';
import 'home_bloc.dart';

class HomeBuilder extends StatefulWidget {
  const HomeBuilder({Key? key}) : super(key: key);

  @override
  State<HomeBuilder> createState() => _HomeBuilderState();
}

class _HomeBuilderState extends State<HomeBuilder> {

  late HomeBloc bloc;
  List<User>? user;
  @override
  void initState() {
    bloc = HomeBloc();
    bloc.add(LoadUser());
    super.initState();
  }

  List<User>? _getDataFromState(HomeState state) {
    List<User>? _list = [];
    if (state is HomeSuccess) {
      _list = state.user;
    }
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc,HomeState>(
        bloc: bloc,
        builder: (BuildContext ctx, HomeState state){
          if(state is HomeError){
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    const Text("Error"),
                    OutlinedButton(
                      child: const Text("Reload"),
                      onPressed: () {
                        bloc.add(LoadUser());
                      },
                    ),
                  ],
                ),
              ),
            );
          }else if(state is HomeEmpty){
            return Center(
              child: Container(
                padding: const EdgeInsets.only(top: 30),
                height: 300,
                child: Column(
                  children: [
                    const Image(
                      height: 200,
                      image: AssetImage(ConstImage.liveGirl),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: const Text(
                        "No User",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }else if(state is HomeInitial){
            return Shimmer.fromColors(
                child: const Scaffold(),
                baseColor: Colors.black,
                highlightColor: Colors.grey,
              direction: ShimmerDirection.ttb,);
          }else if(state is HomeSuccess){
            user = _getDataFromState(state);
            return HomePage(user: user,);
          }
          return const CupertinoActivityIndicator();
        }
    );
  }
}
