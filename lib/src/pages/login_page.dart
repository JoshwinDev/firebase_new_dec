import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_task_firebase_june_ndz/src/cubit/authentication/authentication_cubit.dart';
import 'package:my_task_firebase_june_ndz/src/pages/home_page.dart';
import 'package:my_task_firebase_june_ndz/src/pages/signUp_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isPasswordShown = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: SafeArea(
            child: _buildLoginForm(context), //Build UI according to states
            ),
      ),
    );
  }

  _buildLoginForm(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: "Username",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(7))),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  labelText: "Email Address",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(7))),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.visibility_off),
                  ),
                  labelText: "Password",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(7))),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.library_books_outlined),
                  ),
                  labelText: "Address",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(7))),
            ),
            SizedBox(
              height: 15,
            ),
            BlocConsumer<AuthenticationCubit, AuthenticationState>(
              listener: (context, state) {
                if (state is AuthenticationSuccess) {
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => HomePage()));
                } else if (state is AuthenticationFailure) {
                  String errorMessage = state.errorMessage;
                  showDialog(context: context, builder: (_,) {
                    return AlertDialog(
                      title: const Text("Login Failed"),
                      content: Text(errorMessage),
                      actions: [
                        TextButton(onPressed: () {
                          Navigator.pop(context);
                        }, child: const Text("Ok"))
                      ],
                    );
                  });
                }
              },
              builder: (context, state) {
                if (state is AuthenticationLoading) {
                  return const Center(child: CupertinoActivityIndicator());
                }
                return ElevatedButton(
                    onPressed: () {
                      context.read<AuthenticationCubit>().loginUser(
                          _emailController.text.trim(),
                          _passwordController.text);
                    },
                    child: const Text("Login"));
              },
            ),
            SizedBox(height: 24,),
            TextButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SignUpPage()));
            }, child: Text("Sign Up"))
          ],
        ),
      ),
    );
  }
}