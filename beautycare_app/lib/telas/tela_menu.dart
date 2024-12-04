import 'package:flutter/material.dart';
import 'package:beautycare_app/telas/tela_cadastro.dart';
import 'package:beautycare_app/telas/tela_aniversario.dart';
import 'package:beautycare_app/telas/tela_login.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Assuming you use Supabase for auth


class TelaMenu extends StatefulWidget {
  const TelaMenu({super.key});

  @override
  State<TelaMenu> createState() => _TelaMenuState();
}

class _TelaMenuState extends State<TelaMenu> {
  Future<void> _logout() async {
    try {
      await Supabase.instance.client.auth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TelaLogin()),
      );
    } catch (e) {
      // Handle logout errors (e.g., show a snackbar)
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao sair: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: const Color(0xFF966C5C),
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      textStyle: const TextStyle(fontSize: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFDB9B83),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDB9B83),
        elevation: 0,
        title: Image.asset(
          'assets/imagens/logo.png',
          width: 100,
          height: 100,
          fit: BoxFit.contain,
        ),
        centerTitle: true, // Center the logo
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, size: 30),
            onPressed: _logout, // Use the _logout function
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20), // Added horizontal padding
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: buttonStyle,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TelaCadastro()),
                  );
                },
                child: const Text('Cadastro'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: buttonStyle,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TelaAniversario()),
                  );
                },
                child: const Text('Aniversário'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}