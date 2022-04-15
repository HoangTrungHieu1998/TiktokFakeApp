import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tiktok/model/Profile.dart';
import 'package:flutter_tiktok/service/cache_manager.dart';
import 'package:flutter_tiktok/ui/const.dart';
import 'package:flutter_tiktok/ui/home/home.dart';
import 'package:flutter_tiktok/ui/profile/bloc/profile_bloc.dart';
import 'package:flutter_tiktok/ultils/dialog.dart';
import 'package:flutter_tiktok/ultils/icon.dart';
import 'package:flutter_tiktok/ultils/img.dart';
import 'package:flutter_tiktok/ultils/size.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

import '../../ultils/color.dart';
import 'item_image.dart';

class ProfilePage extends StatefulWidget {
  final ProfileBloc? bloc;
  final int? idLogin;
  const ProfilePage({Key? key,this.bloc,this.idLogin}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  final List<Widget> myTabs = const [
    Tab(icon: Icon(TikTokIcons.line,color: ConstColor.grey,)),
    Tab(icon: Icon(TikTokIcons.heartOutline,color: ConstColor.grey)),
    Tab(icon: Icon(Icons.keyboard,color: ConstColor.grey)),
    Tab(icon: Icon(TikTokIcons.lock,color: ConstColor.grey)),
  ];

  final _refreshController = RefreshController(initialRefresh: false);
  final loginName = TextEditingController();
  final loginPass = TextEditingController();
  final user = TextEditingController();
  final desc = TextEditingController();
  String name="";
  String pass="";
  String userName="";
  String description="";
  Profile? profile;

  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {

      });
    }
  }

  Profile? _getDataFromState(ProfileState state) {
    Profile? _profile;
    if (state is ProfileSuccess) {
      _profile = state.profile;
    }
    return _profile;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc,ProfileState>(
        bloc: widget.bloc,
        builder: (BuildContext ctx, ProfileState state){
          return SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            header: const WaterDropMaterialHeader(
              backgroundColor: Colors.black,
            ),
            controller: _refreshController,
            onRefresh: () {
              widget.bloc!.add(LoadProfile(id: widget.idLogin));
            },
            child: _buildView(state),
          );
        },
        listener: (BuildContext ctx, ProfileState state){
          if (state is ProfileInitial) {
            //
          } else {
            _refreshController.refreshCompleted();
          }
          if (state is ProfileUpdateLoading) {
            // dialogProgressDialog(context, Language().updating, "");
          }
          if (state is ProfileUpdateSuccess) {
            widget.bloc!.add(LoadProfile(id: state.id));
          }
          if (state is ProfileUpdateFailed) {
            loginName.clear();
            loginPass.clear();
            MyDialog.instance.dialogOK(context, state.message!, "Login Failed");
          }
          if (state is ProfileSignUpLoading) {
            // dialogProgressDialog(context, Language().updating, "");
          }
          if (state is ProfileSignUpSuccess) {
            widget.bloc!.add(LoadProfile(id: state.id));
          }
          if (state is ProfileSignUpFailed) {
            Navigator.pop(context);
            MyDialog.instance.dialogOK(context, state.error!, "Login Failed");
          }
          if (state is ProfileEditLoading) {
            // dialogProgressDialog(context, Language().updating, "");
          }
          if (state is ProfileEditSuccess) {
            widget.bloc!.add(LoadProfile(id: state.id));
          }
          if (state is ProfileEditFailed) {
            Navigator.pop(context);
            MyDialog.instance.dialogOK(context, state.error!, "Login Failed");

          }
        });
  }

  _buildView(ProfileState state){
    if(state is ProfileError){
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              const Text("Error"),
              OutlinedButton(
                child: const Text("Reload"),
                onPressed: () {
                  widget.bloc!.add(LoadProfile());
                },
              ),
            ],
          ),
        ),
      );
    }else if(state is ProfileEmpty){
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(right: ConstSize.size10,left: ConstSize.size10,top: ConstSize.size10),
                  child: Row(
                    children: const[
                      Spacer(),
                      Text("Profile",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                      Spacer(),
                      Icon(TikTokIcons.threeLine),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: ConstSize.size16),
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(color: ConstColor.black,width: 0.1),
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                          image: NetworkImage(ConstImage.userImage),
                          fit: BoxFit.cover)),
                ),
                Container(
                  margin: const EdgeInsets.only(top: ConstSize.size7),
                  child: const Text("@username",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16
                  ),),
                ),
                Container(
                  margin: const EdgeInsets.only(top: ConstSize.size10,right: ConstSize.size50,left: ConstSize.size50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text("0",style: TextStyle(fontSize: ConstSize.size18,fontWeight: FontWeight.bold),),
                          Text("Đang follow",style: TextStyle(color: ConstColor.grey.withOpacity(0.8),fontSize: ConstSize.size14)),
                        ],
                      ),
                      Column(
                        children: [
                          const Text("0",style: TextStyle(fontSize: ConstSize.size18,fontWeight: FontWeight.bold),),
                          Text("Follower",style: TextStyle(color: ConstColor.grey.withOpacity(0.8),fontSize: ConstSize.size14)),
                        ],
                      ),
                      Column(
                        children: [
                          const Text("0",style: TextStyle(fontSize: ConstSize.size18,fontWeight: FontWeight.bold),),
                          Text("Thích",style: TextStyle(color: ConstColor.grey.withOpacity(0.8),fontSize: ConstSize.size14)),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 150,
                  margin: const EdgeInsets.only(top: ConstSize.size80),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: ConstColor.pink,
                      ),
                      onPressed: () {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: const Text("Please enter your username and password to login"),
                              content: Card(
                                child: Column(
                                  children: <Widget>[
                                    TextField(
                                      onChanged: (text){
                                        name = text;
                                      },
                                      controller: loginName,
                                      decoration: const InputDecoration(
                                        icon: Icon(Icons.account_circle),
                                        labelText: 'Username',
                                      ),
                                    ),
                                    TextField(
                                      onChanged: (text){
                                        pass = text;
                                      },
                                      controller: loginPass,
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                        icon: Icon(Icons.lock),
                                        labelText: 'Password',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                CupertinoDialogAction(
                                    child: const Text("Login"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      widget.bloc!.add(LoginProfile(name, pass));
                                    }),
                                CupertinoDialogAction(
                                    child: const Text("Sign up"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      showCupertinoDialog(
                                        context: context,
                                        builder: (context) {
                                          return CupertinoAlertDialog(
                                            title: const Text("Please enter your username and password to sign up"),
                                            content: Card(
                                              child: Column(
                                                children: <Widget>[
                                                  TextField(
                                                    onChanged: (text){
                                                      name = text;
                                                    },
                                                    controller: loginName,
                                                    decoration: const InputDecoration(
                                                      icon: Icon(Icons.account_circle),
                                                      labelText: 'Username',
                                                    ),
                                                  ),
                                                  TextField(
                                                    onChanged: (text){
                                                      pass = text;
                                                    },
                                                    controller: loginPass,
                                                    obscureText: true,
                                                    decoration: const InputDecoration(
                                                      icon: Icon(Icons.lock),
                                                      labelText: 'Password',
                                                    ),
                                                  ),
                                                  TextField(
                                                    onChanged: (text){
                                                      userName = text;
                                                    },
                                                    controller: user,
                                                    decoration: const InputDecoration(
                                                      icon: Icon(Icons.home),
                                                      labelText: 'Your Name',
                                                    ),
                                                  ),
                                                  TextField(
                                                    onChanged: (text){
                                                      description = text;
                                                    },
                                                    controller: desc,
                                                    decoration: const InputDecoration(
                                                      icon: Icon(Icons.waves),
                                                      labelText: 'Description',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              CupertinoDialogAction(
                                                  child: const Text("Sign Up"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    widget.bloc!.add(SignUpProfile(name, pass, userName, description));
                                                  }),
                                            ],
                                          );
                                        },
                                      );
                                    }),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text("Login")),
                ),
              ],
            ),
          ),
        ),
      );
    }else if(state is ProfileInitial){
      return Shimmer.fromColors(
        child: const Scaffold(),
        baseColor: Colors.black,
        highlightColor: Colors.grey,
        direction: ShimmerDirection.ttb,);
    }else if(state is ProfileSuccess){
      profile = _getDataFromState(state);
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(right: ConstSize.size10,left: ConstSize.size10,top: ConstSize.size10),
                  child: Row(
                    children: [
                      const Icon(TikTokIcons.profile),
                      const Spacer(),
                      Text(profile!.name!,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                      InkWell(onTap: ()=>print("a"),
                          child: const Icon(Icons.keyboard_arrow_down)),
                      const Spacer(),
                      const Icon(Icons.remove_red_eye_outlined),
                      const SizedBox(width: ConstSize.size10,),
                      InkWell(
                        onTap: (){
                          showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder( // <-- SEE HERE
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.0),
                                ),
                              ),
                              builder: (context) {
                                return SizedBox(
                                  height: 130,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        leading: Icon(Icons.info),
                                        title: Text("About Me"),
                                        onTap: (){},
                                      ),
                                      const Divider(
                                        thickness: 1,
                                        color: ConstColor.grey,
                                        indent: 20,
                                        endIndent: 20),
                                      ListTile(
                                        leading: const Icon(Icons.settings),
                                        title: const Text("Log Out"),
                                        onTap: (){
                                          CacheManager.instance.clear();
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Home()));
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                          child: const Icon(TikTokIcons.threeLine)),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: ConstSize.size16),
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(color: ConstColor.black,width: 0.1),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(profile!.image!),
                          fit: BoxFit.cover)),
                ),
                Container(
                  margin: const EdgeInsets.only(top: ConstSize.size7),
                  child: Text(profile!.loginName!,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16
                  ),),
                ),
                Container(
                  margin: const EdgeInsets.only(top: ConstSize.size10,right: ConstSize.size50,left: ConstSize.size50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(profile!.following.toString(),style: const TextStyle(fontSize: ConstSize.size18,fontWeight: FontWeight.bold),),
                          Text("Đang follow",style: TextStyle(color: ConstColor.grey.withOpacity(0.8),fontSize: ConstSize.size14)),
                        ],
                      ),
                      Column(
                        children: [
                          Text(profile!.follow.toString(),style: const TextStyle(fontSize: ConstSize.size18,fontWeight: FontWeight.bold),),
                          Text("Follower",style: TextStyle(color: ConstColor.grey.withOpacity(0.8),fontSize: ConstSize.size14)),
                        ],
                      ),
                      Column(
                        children: [
                          Text(profile!.like.toString(),style: const TextStyle(fontSize: ConstSize.size18,fontWeight: FontWeight.bold),),
                          Text("Thích",style: TextStyle(color: ConstColor.grey.withOpacity(0.8),fontSize: ConstSize.size14)),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 150,
                  margin: const EdgeInsets.only(top: ConstSize.size8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: ConstColor.white,
                    ),
                    onPressed: (){
                      name = profile!.loginName!;
                      userName = profile!.name!;
                      showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: const Text("Please enter value to update your profile"),
                            content: Card(
                              child: Column(
                                children: <Widget>[
                                  TextField(
                                    onChanged: (text){
                                      name = text;
                                    },
                                    controller: loginName,
                                    decoration: const InputDecoration(
                                      icon: Icon(Icons.account_circle),
                                      labelText: 'Username',
                                    ),
                                  ),
                                  TextField(
                                    onChanged: (text){
                                      userName = text;
                                    },
                                    controller: user,
                                    decoration: const InputDecoration(
                                      icon: Icon(Icons.remove_red_eye),
                                      labelText: 'Your Name',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              CupertinoDialogAction(
                                  child: const Text("Update"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    widget.bloc!.add(EditProfile(profile!.id, name, userName));
                                  }),
                            ],
                          );
                        },
                      );
                    },
                    child: Text("Sửa hồ sơ",style: TextStyle(color: Colors.black.withOpacity(0.7)),),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: ConstSize.size50,left: ConstSize.size50,top: ConstSize.size15),
                  child: Text(profile!.description!,textAlign: TextAlign.center),
                ),
                Container(
                  margin: const EdgeInsets.only(top: ConstSize.size10),
                  child: Column(
                    children: [
                      TabBar(
                        controller: _tabController,
                        labelColor: Colors.black,
                        tabs: myTabs,
                      ),
                      Center(
                        child: [
                          ItemImage(userVideo: profile!.userVideo!),
                          ItemImage(userVideo: profile!.userVideo!),
                          ItemImage(userVideo: profile!.userVideo!),
                          ItemImage(userVideo: profile!.userVideo!),
                        ][_tabController.index],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(right: ConstSize.size10,left: ConstSize.size10,top: ConstSize.size10),
                child: Row(
                  children: const[
                    Spacer(),
                    Text("Profile",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                    Spacer(),
                    Icon(TikTokIcons.threeLine),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: ConstSize.size16),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    border: Border.all(color: ConstColor.black,width: 0.1),
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                        image: NetworkImage(ConstImage.userImage),
                        fit: BoxFit.cover)),
              ),
              Container(
                margin: const EdgeInsets.only(top: ConstSize.size7),
                child: const Text("@username",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16
                ),),
              ),
              Container(
                margin: const EdgeInsets.only(top: ConstSize.size10,right: ConstSize.size50,left: ConstSize.size50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Text("0",style: TextStyle(fontSize: ConstSize.size18,fontWeight: FontWeight.bold),),
                        Text("Đang follow",style: TextStyle(color: ConstColor.grey.withOpacity(0.8),fontSize: ConstSize.size14)),
                      ],
                    ),
                    Column(
                      children: [
                        const Text("0",style: TextStyle(fontSize: ConstSize.size18,fontWeight: FontWeight.bold),),
                        Text("Follower",style: TextStyle(color: ConstColor.grey.withOpacity(0.8),fontSize: ConstSize.size14)),
                      ],
                    ),
                    Column(
                      children: [
                        const Text("0",style: TextStyle(fontSize: ConstSize.size18,fontWeight: FontWeight.bold),),
                        Text("Thích",style: TextStyle(color: ConstColor.grey.withOpacity(0.8),fontSize: ConstSize.size14)),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 150,
                margin: const EdgeInsets.only(top: ConstSize.size80),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: ConstColor.pink,
                    ),
                    onPressed: () {
                      showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: const Text("Please enter your username and password to login"),
                            content: Card(
                              child: Column(
                                children: <Widget>[
                                  TextField(
                                    onChanged: (text){
                                      name = text;
                                    },
                                    controller: loginName,
                                    decoration: const InputDecoration(
                                      icon: Icon(Icons.account_circle),
                                      labelText: 'Username',
                                    ),
                                  ),
                                  TextField(
                                    onChanged: (text){
                                      pass = text;
                                    },
                                    controller: loginPass,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      icon: Icon(Icons.lock),
                                      labelText: 'Password',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              CupertinoDialogAction(
                                  child: const Text("Login"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    widget.bloc!.add(LoginProfile(name, pass));
                                  }),
                              CupertinoDialogAction(
                                  child: const Text("Sign up"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    showCupertinoDialog(
                                      context: context,
                                      builder: (context) {
                                        return CupertinoAlertDialog(
                                          title: const Text("Please enter your username and password to sign up"),
                                          content: Card(
                                            child: Column(
                                              children: <Widget>[
                                                TextField(
                                                  onChanged: (text){
                                                    name = text;
                                                  },
                                                  controller: loginName,
                                                  decoration: const InputDecoration(
                                                    icon: Icon(Icons.account_circle),
                                                    labelText: 'Username',
                                                  ),
                                                ),
                                                TextField(
                                                  onChanged: (text){
                                                    pass = text;
                                                  },
                                                  controller: loginPass,
                                                  obscureText: true,
                                                  decoration: const InputDecoration(
                                                    icon: Icon(Icons.lock),
                                                    labelText: 'Password',
                                                  ),
                                                ),
                                                TextField(
                                                  onChanged: (text){
                                                    userName = text;
                                                  },
                                                  controller: user,
                                                  decoration: const InputDecoration(
                                                    icon: Icon(Icons.home),
                                                    labelText: 'Your Name',
                                                  ),
                                                ),
                                                TextField(
                                                  onChanged: (text){
                                                    description = text;
                                                  },
                                                  controller: desc,
                                                  decoration: const InputDecoration(
                                                    icon: Icon(Icons.waves),
                                                    labelText: 'Description',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            CupertinoDialogAction(
                                                child: const Text("Sign Up"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  widget.bloc!.add(SignUpProfile(name, pass, userName, description));
                                                }),
                                          ],
                                        );
                                      },
                                    );
                                  }),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text("Login")),
              ),
            ],
          ),
        ),
      ),
    );
  }

}


