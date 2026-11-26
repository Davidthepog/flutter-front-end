import 'package:material_ui/material_ui.dart';

import 'package:flutter_application_1/data/services/api_handler.dart';
import 'package:flutter_application_1/data/models/login_dto.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final ApiHandler _apiHandler = ApiHandler();

  bool _isLoading = false;

  //metodo per postare a api/auth/login
  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    //assegnazione a oggetto da campi del form
    final creds = LoginDto(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    setState(() {
      _isLoading = true;
    });

    try {
      //chiamata post e risposta
      final response = await _apiHandler.login(creds);

      if (!mounted) return; //uscita in caso di

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.message)));
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Errore durante il login: $e')));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  //dispose valori del form all'unmount della pagina
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //creazione della schermata da montare
  @override
  Widget build(BuildContext context) {
    //Scaffold = "window"
    return Scaffold(
      //AppBar = elemento material per header di "pagina"
      appBar: AppBar(title: const Text('Login'), centerTitle: true),
      body: Padding(
        //
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Inserisci la tua email';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci la password';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _isLoading ? null : _login,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Accedi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
