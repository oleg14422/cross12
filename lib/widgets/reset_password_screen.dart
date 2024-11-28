import 'package:flutter/material.dart';
import 'package:cross12/main.dart';
import 'package:http/http.dart' as http;


class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});
  final TextEditingController emailController = TextEditingController();

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
                Text('Reset password',
                  style: Theme.of(context).textTheme.bodyLarge
                  )]
              ),
            ),
            const SizedBox(height: 16),
            Form(
              key: resetFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Email:',
                      style: Theme.of(context).textTheme.bodyLarge
                  ),
                  TextFormField(
                    controller: emailController,
                    validator: (value) => value != null && value.contains('@') ? null : 'Enter a valid email',
                  ),
                ],
              )
            ),

            const SizedBox(height: 16),
            SizedBox(
              height: 48,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (resetFormKey.currentState?.validate() ?? false) {
                    final email = emailController.text.trim(); // Отримуємо email з контролера
                    try {
                      // Виконання HTTP запиту без додавання нових об'єктів
                      final response = await http.post(
                        Uri.parse('https://crosslaba12.requestcatcher.com/'),
                        body: {'email': email},
                        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                      );
                      // Перевірка відповіді сервера
                      if (response.statusCode == 200) {
                        showDialog(
                          context: context,
                          builder: (BuildContext ctx) {
                            return const AlertDialog(
                              title: Text('Success'),
                              content: Text("Запит успішно надіслано 🎉"),
                            );
                          },
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Помилка: ${response.reasonPhrase}')),
                        );
                      }
                    } catch (e) {
                      // Помилка при відправці запиту
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('status code: $e')),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Форма не валідна')),
                    );
                  }
                },




                child: const Text("Reset password"),
              ),
            ),
            const SizedBox(height: 16),
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
          ]
        )
      )
    );
  }
}
