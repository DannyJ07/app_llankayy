import 'package:app_llankay/home.dart';
import 'package:app_llankay/vistas/createUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String email, password;
  final _formKey = GlobalKey<FormState>();

  String error = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'LLANKAY', // Título en grande
                style: TextStyle(
                    fontSize: 60.0, // Tamaño de fuente grande
                    fontWeight: FontWeight.bold, // Negrita
                    color: Color.fromARGB(255, 241, 182, 3)),
              ),
              _buildLogo(), // Logo debajo del título
              const SizedBox(height: 20.0),
              Offstage(
                offstage: error == '',
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(error,
                      style: TextStyle(color: Colors.red, fontSize: 16)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _formulario(),
              ),

              const SizedBox(height: 20.0),
              _buildLoginButton(),
              const SizedBox(height: 20.0),
              _buildSignUpText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image(
      // Especifica un tamaño si es necesario
      width: 300,
      height: 300,
      image:
          AssetImage('assets/logo.png'), // Cambiado de Image.asset a AssetImage
      // Ajusta el comportamiento de la imagen según tus necesidades
      fit: BoxFit.contain,
    );
  }

  Widget _formulario() {
    return Form(
      key: _formKey,
      child: Column(children: [
        _buildEmailField(),
        const SizedBox(height: 20.0),
        _buildPasswordField()
      ]),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
        decoration: InputDecoration(
          hintText: 'Email',
          prefixIcon: Icon(Icons.email, color: Color.fromARGB(255, 4, 62, 109)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        onSaved: (String? value) {
          email = value!;
        },
        validator: (value) {
          if (value!.isEmpty) {
            return "El campo es obligatorio";
          }
          return null;
        });
  }

  Widget _buildPasswordField() {
    return TextFormField(
        decoration: InputDecoration(
          hintText: 'Password',
          prefixIcon: Icon(Icons.lock, color: Color.fromARGB(255, 4, 62, 109)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        obscureText: true,
        validator: (value) {
          if (value!.isEmpty) {
            return "El campo es obligatorio";
          }
          return null;
        },
        onSaved: (String? value) {
          password = value!;
        });
  }

/*  Widget _buildForgotPasswordButton() {
    return GestureDetector(
      onTap: () {
        // Handle forgot password action
      },
      child: Text(
        'Forgot Password?',
        style: TextStyle(color: Colors.blue),
      ),
    );
  }*/

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          try {
            UserCredential? credenciales = await login(email, password);
            if (credenciales != null) {
              if (credenciales.user != null) {
                if (credenciales.user!.emailVerified) {
                  Navigator.pushAndRemoveUntil(
                      context as BuildContext,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                      (Route<dynamic> route) => false);
                } else {
                  setState(() {
                    error = "Debes verificar tu correo antes de acceder";
                  });
                }
              }
            }
          } catch (e) {
            setState(() {
              error =
                  e.toString(); // Mostrar la excepción como mensaje de error
            });
          }
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(
            255, 4, 62, 109), // Cambia el color de texto del botón
      ),
      child: Text(
        'Login',
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget _buildSignUpText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('¿No tienes una cuenta?', style: TextStyle(fontSize: 15)),
        const SizedBox(width: 10.0),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CreateUser()));
          },
          child: Text(
            'Registrarse',
            style: TextStyle(color: Color.fromARGB(255, 202, 156, 18)),
          ),
        ),
      ],
    );
  }

  Future<UserCredential?> login(String email, String passwd) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        //todo usuario no encontrado
        setState(() {
          error = "usuario no encontrado";
        });
      }
      if (e.code == 'wrong-password') {
        //todo contrasenna incorrecta
        setState(() {
          error = "contrasenna incorrecta";
        });
      }
    }
  }
}
