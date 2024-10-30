import 'package:aula_http_flutter/views/homepage.dart';
import 'package:aula_http_flutter/views/signup_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    String? email, password;

    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/animation/book_login.gif',
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Email",
                        hintText: "Informe o seu email"),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Voce precisa digitar o email';
                      }

                      return null;
                    },
                    onSaved: (String? newValue) {
                      email = newValue;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Senha",
                      hintText: "Digite a sua senha",
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Voce precisa digitar a senha';
                      }

                      if (value.length < 6) {
                        return 'A senha precisa de 6 caracteres';
                      }

                      return null;
                    },
                    onSaved: (String? newValue) {
                      password = newValue;
                    },
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          key: const ValueKey(
                              'loginButton'), // Adicione uma chave aqui

                          onPressed: () {
                            //Validacao das info do form
                            final form = formKey.currentState;
                            if (form == null || !form.validate()) {
                              return;
                            }
                            form.save();

                            print(email);
                            print(password);
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const Homepage(),
                              ),
                            );
                          },
                          child: const Text(
                            "Login",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Não tem conta?"),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Crie a sua conta.",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
