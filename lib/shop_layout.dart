// onPressed: () {
//   CacheHelper.removeData(key: 'token');
//     Navigator.pushAndRemoveUntil(context,
//     MaterialPageRoute(builder: (context) => const ScreenLogin()),
//     (route) {
//   return false;
// });
// },

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/shared_prefrences.dart';
import 'package:shopapp/shopCubit.dart';
import 'package:shopapp/shopStates.dart';

class Shoplayout extends StatelessWidget {
  const Shoplayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(title: Text('Shop App'), actions: [
            IconButton(
                onPressed: () {
                },
                icon: Icon(Icons.brightness_4_outlined))
          ]),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            items: cubit.buttonitems,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.onchanged(index);
            },
          ),
        );
      },
    );
  }
}
