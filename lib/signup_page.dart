import 'package:flutter/material.dart';
import 'package:untitled/login_page.dart';
class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var _formKey = GlobalKey<FormState>();
  var _userNameController = TextEditingController();
  var _passwordController = TextEditingController();
  var _password2Controller = TextEditingController();
  var _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 27,
              color:Colors.grey,
            ), onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          ),
        ),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Đăng ký',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 30),
                        )),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Form(
                        key:_formKey,
                        child: TextFormField(
                          validator: (value){
                            if (value==null || value.isEmpty)
                              return "Tên đăng nhập rỗng";
                            return null;
                          },
                          controller: _userNameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Tài khoản',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        obscureText: true,
                        controller: _nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Họ tên',
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        obscureText: true,
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Mật khẩu',
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        obscureText: true,
                        controller: _password2Controller,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Nhập lại mật khẩu',
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10)),
                            color: Colors.green
                        ),
                        child: ElevatedButton(
                          child: const Text('Đăng ký'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()){
                              var snackBar = SnackBar(
                                  content: Row(
                                    children: [
                                      Icon(Icons.person,color:Colors.white),
                                      Text("Tài khoản vừa được đăng ký : ${_userNameController.text}")
                                    ],
                                  )
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                          },
                        )
                    ),
                    SizedBox(height: 15,),
                    Row(
                      children: <Widget>[
                        const Text('Đăng nhập tài khoản?'),
                        TextButton(
                          child: const Text(
                            'Đăng nhập',
                            style: TextStyle(fontSize: 16,color:Colors.green),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
                            );
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ],
                )
            )
        )
    );
  }
}
