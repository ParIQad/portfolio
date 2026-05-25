import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_cubit.dart';
import '../bloc/auth_state.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController(text: 'emilys');
  final TextEditingController _passwordController = TextEditingController(text: 'emilyspass');

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Select specific state property to rebuild only when loading changes
    final isLoading = context.select((AuthCubit cubit) => cubit.state is AuthLoading);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26, 
            offset: Offset(6, 6), 
            blurRadius: 0
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          
          // Reusable Input Widget
          _LoginInputField(
            controller: _usernameController,
            label: "Username",
            icon: Icons.person,
            isLoading: isLoading,
          ),
          const SizedBox(height: 16),
          
          _LoginInputField(
            controller: _passwordController,
            label: "Password",
            icon: Icons.lock,
            isObscure: true,
            isLoading: isLoading,
          ),
          
          const SizedBox(height: 24),
          
          // Login Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: const RoundedRectangleBorder(),
                elevation: 0,
              ),
              onPressed: isLoading 
                ? null 
                : () {
                    final user = _usernameController.text;
                    final pass = _passwordController.text;
                    // Trigger Logic
                    context.read<AuthCubit>().login(user, pass);
                  },
              child: isLoading 
                ? const SizedBox(
                    height: 20, 
                    width: 20, 
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                  )
                : const Text("LOGIN", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black),
          ),
          child: const Icon(Icons.security, size: 48, color: Colors.black),
        ),
        const SizedBox(height: 16),
        const Text(
          "ACCESS CONTROL",
          style: TextStyle(
            fontFamily: 'Courier',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
      ],
    );
  }
}

// Private widget for the Input Field style
class _LoginInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool isObscure;
  final bool isLoading;

  const _LoginInputField({
    required this.controller,
    required this.label,
    required this.icon,
    this.isObscure = false,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      enabled: !isLoading,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black54),
        prefixIcon: Icon(icon, color: Colors.black),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}