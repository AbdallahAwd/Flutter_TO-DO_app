import 'package:flutter/material.dart';
import 'package:learning/shared/compnents/component.dart';


class loginScreen extends StatefulWidget {
  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  var email = TextEditingController();

  var password = TextEditingController();

  var formKey = GlobalKey<FormState>();
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Log In' ,
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  SizedBox(height: 20.0,),
                  defaultTextFormFeild(
                    controller: email,
                    KeyType: TextInputType.emailAddress ,
                      pre: Icons.email_outlined,
                      HintText: 'Email',
                      validate: (String Value)
                      {
                        if(Value.isEmpty)
                          {
                            return'Email is required';
                          }
                        return null;
                      },
                  ),
                  SizedBox(height: 20.0,),
                  defaultTextFormFeild(
                    controller: password,
                    KeyType: TextInputType.visiblePassword,
                      pre: Icons.lock_open_rounded,
                      HintText: 'Password',
                      isObscure: isObscure,
                      suffPress: ()
                      {
                        setState(() {
                          isObscure = !isObscure ;
                        });
                      },
                      suff: isObscure ? Icons.visibility : Icons.visibility_off_rounded,
                      validate: (String Value)
                      {
                        if(Value.isEmpty)
                          {
                            return'Password is required';
                          }
                        return null;
                      },
                  ),
                  SizedBox(height: 20.0,),
                  defaultButton(
                    text: 'log in',
                    onpressed: ()
                      {
                        if(formKey.currentState.validate())
                          {
                            print(email.text);
                            print(password.text);
                          }
                      }
                  ),
                  SizedBox(height: 20.0,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Text('Don\'t have an account?' ,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                        ),
                        ),
                        SizedBox(width: 10.0,),
                        TextButton(onPressed: (){},
                          child: Text('Register now' ,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}
