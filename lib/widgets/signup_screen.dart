import 'package:flutter/material.dart';
import 'package:cross12/main.dart';
import 'package:http/http.dart' as http;

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(children: [
                Image.network(
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/Google-flutter-logo.svg/1024px-Google-flutter-logo.svg.png",
                  width: 200,
                ),
                const SizedBox(height: 16,),
                Text('Sing up',
                    style: Theme.of(context).textTheme.bodyLarge)]
              ),
            ),
            const SizedBox(height: 16),


            Form(
              key: singupFormKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Name:',
                      style: Theme.of(context).textTheme.bodyLarge
                  ),
                  TextFormField(
                    controller: nameController,
                    validator: (value) => value != null && value.length >= 3 ? null : 'Name must be at least 3 characters',
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Email:',
                      style: Theme.of(context).textTheme.bodyLarge
                  ),
                  TextFormField(
                    controller: emailController,
                    validator: (value) => value != null && value.contains('@') ? null : 'Enter a valid email',
                  ),
                  const SizedBox(height: 16),
                  Text(
                      'Password:',
                      style: Theme.of(context).textTheme.bodyLarge
                  ),
                  TextFormField(
                    controller: passwordController,
                    validator: (value) => value != null && value.length >= 7 ? null : 'Password must be at least 7 characters',

                  ),
                  const SizedBox(height: 16),
                ]
            )),
            SizedBox(
              height: 48,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // Перевірка валідності форми
                  if (singupFormKey.currentState?.validate() ?? false) {
                    // Якщо форма валідна, отримуємо значення полів
                    final name = nameController.text;
                    final email = emailController.text;
                    final password = passwordController.text;

                    // Відправка даних на сервер
                    try {
                      final response = await http.post(
                        Uri.parse('https://crosslaba12.requestcatcher.com/'),
                        body: {
                          'name': name,
                          'email': email,
                          'password': password,
                        },
                        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                      );

                      // Перевірка відповіді від сервера
                      if (response.statusCode == 200) {
                        showDialog(
                          context: context,
                          builder: (BuildContext ctx) {
                            return const AlertDialog(
                              title: Text('Success'),
                              content: Text("Registration successful! 🎉"),
                            );
                          },
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: ${response.reasonPhrase}')),
                        );
                      }
                    } catch (e) {
                      // Помилка при відправці запиту
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $e')),
                      );
                    }
                  } else {
                    // Якщо форма не валідна, показуємо повідомлення про помилку
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Form is invalid')),
                    );
                  }
                },

                child: const Text("Sing up"),
              )
            ),
            SizedBox(height: 16,),
            SizedBox(
              height: 48,
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => {
                  Navigator.pop(context)
                },
                child: const Text("Back"),
              ),
            )
          ],
        )
      )
    );
  }

}
