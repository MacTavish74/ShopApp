import 'dart:developer';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/login_cubit.dart';
import 'package:shopapp/login_states.dart';
import 'package:shopapp/register.dart';
import 'package:shopapp/shared_prefrences.dart';
import 'package:shopapp/shop_layout.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({Key? key}) : super(key: key);

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passController = TextEditingController();
    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          if (state.loginModel!.status!) {
            CacheHelper.savaData(
                    key: 'token', value: state.loginModel!.data!.token)
                .then((value) {
 Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => const Shoplayout()),
          (route) {
        return false;
      });




                });
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('LOGIN'),
                      Text('Please Enter Your Name and Password'),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter Text';
                          }
                        },
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          border: OutlineInputBorder(),
                          prefix: Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is Too Short';
                          }
                        },
                        controller: passController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          prefix: Icon(Icons.lock),
                          suffix: Icon(
                            Icons.remove_red_eye,
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          width: double.infinity,
                          color: Colors.blue,
                          child: state is LoginLoadingState
                              ? Center(child: CircularProgressIndicator())
                              : MaterialButton(
                                  onPressed: () {
                                    ShopLoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passController.text);
                                  },
                                  child: Text(
                                    'LOGIN',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Text('Dont Have an Account ? '),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ScreenRegister()));
                              },
                              child: Text('Register'))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
