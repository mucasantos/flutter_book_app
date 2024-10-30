import 'dart:convert';

import 'package:aula_http_flutter/views/homepage.dart';
import 'package:aula_http_flutter/views/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    String? email, password, name;

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
                        labelText: "Name",
                        hintText: "Informe o seu nome"),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Voce precisa digitar o nome';
                      }

                      return null;
                    },
                    onSaved: (String? newValue) {
                      name = newValue;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
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
                              'cadastroButton'),

                          onPressed: () async {
                            //Validacao das info do form
                            final form = formKey.currentState;
                            if (form == null || !form.validate()) {
                              return;
                            }
                            form.save();

                            print(email);
                            print(password);

                            var client = http.Client();
                            var url = 'http://10.92.198.38:4000/user/cadastro';

                            var bodyRegistro = {
                              "name": name,
                              "email": email,
                              "password": password,
                            };

                            try {
                              var response = await client.post(
                                Uri.parse(url),
                                headers: {
                                  "Content-Type": "application/json",
                                },
                                body: json.encode(bodyRegistro),
                              );

                              print(response.body);
                            } finally {
                              client.close();
                            }

                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const Homepage(),
                              ),
                            );
                          },
                          child: const Text(
                            "Cadastrar",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Já tem conta?"),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Faça login.",
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
