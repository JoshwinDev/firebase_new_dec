import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_task_firebase_june_ndz/src/cubit/authentication/authentication_cubit.dart';
import 'package:my_task_firebase_june_ndz/src/models/user_model.dart';
import 'package:my_task_firebase_june_ndz/src/pages/home_page.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthenticationCubit(),
        child: Scaffold(
          appBar: AppBar(
            title: Text("Sign Up"),
          ),
          body: Form(child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    hintText: "Email"
                ),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                    hintText: "Password"
                ),
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                    hintText: "Address"
                ),
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                    hintText: "Name"
                ),
              ),
              SizedBox(
                height: 24,
              ),
              BlocConsumer<AuthenticationCubit, AuthenticationState>(
                listener: (context, state) {
                  if(state is AuthenticationSuccess){
                    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>HomePage()));
                  }
                  if(state is AuthenticationFailure){
                    // Show the dialog
                  }
                },
                builder: (context, state) {
                  if(state is AuthenticationLoading){
                    return CircularProgressIndicator();
                  }
                  return ElevatedButton(onPressed: () {
                    UserModel user = UserModel(
                      email: _emailController.text,
                      address: _addressController.text,
                      password: _passwordController.text,
                      mobileNo: "908797898",
                      id: '',);
                    context.read<AuthenticationCubit>().createUser(user);
                  }, child: Text("SignUp"));
                },
              )
            ],
          ),
          ),
        ));
  }
}
