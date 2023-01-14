import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/register_cubit.dart';
import 'package:shopapp/register_states.dart';
import 'package:shopapp/shared_prefrences.dart';
import 'package:shopapp/shop_layout.dart';

class ScreenRegister extends StatefulWidget {
  const ScreenRegister({Key? key}) : super(key: key);

  @override
  State<ScreenRegister> createState() => _ScreenRegisterState();
}

class _ScreenRegisterState extends State<ScreenRegister> {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer(
        listener: (context, state) {
 if (state is RegisterSuccessState) {
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
                        Text('Register'),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter name';
                            }
                          },
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'name',
                            border: OutlineInputBorder(),
                            prefix: Icon(Icons.person),
                          ),
                          keyboardType: TextInputType.name,
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
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'email',
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
                              return 'please enter password';
                            }
                          },
                          controller: passController,
                          decoration: InputDecoration(
                            labelText: 'pass',
                            border: OutlineInputBorder(),
                            prefix: Icon(Icons.password),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter phone';
                            }
                          },
                          controller: phoneController,
                          decoration: InputDecoration(
                            labelText: 'phone',
                            border: OutlineInputBorder(),
                            prefix: Icon(Icons.phone_android),
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            width: double.infinity,
                            color: Colors.blue,
                            child: state is RegisterLoadingState
                                ? Center(child: CircularProgressIndicator())
                                : MaterialButton(
                                    onPressed: () {
                                      ShopRegisterCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passController.text,
                                           name: nameController.text,
                                          phone: phoneController.text,


                                          
                                          );
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
      ),
    );
  }
}
