import 'package:flutter/material.dart';
import 'package:projeto_mobile/settings/assets.dart';
import 'package:projeto_mobile/settings/color.dart';
import 'package:projeto_mobile/settings/fonts.dart';
import 'package:projeto_mobile/settings/routes.dart';
import '../helper/validator_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.center,
            height: 200,
            child: Image.asset(AppAssets.logoImage),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.all(30),
            child: Form(
              key: _key,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Login",
                    style: AppFonts.boldLarge.copyWith(
                      color: AppColors.backgroundColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: (_) {
                      if (_emailController.text.isEmpty) {
                        return 'Preencha seu email';
                      }
                      if (!ValidatorHelper.validateEmail(_emailController.text)) {
                        return 'Email inválido';
                      }
                      return null;
                    },
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: AppFonts.boldRegular.copyWith(
                        color: AppColors.greyColor,
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.greyColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.greyColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: (_) {
                      if (_passwordController.text.isEmpty) {
                        return 'Preencha sua senha';
                      }
                      if (_passwordController.text.length < 8) {
                        return 'Senha deve ter mais que 8 caracteres';
                      }
                      return null;
                    },
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      labelStyle: AppFonts.boldRegular.copyWith(
                        color: AppColors.greyColor,
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.greyColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.greyColor),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: AppColors.greyColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(AppRoutes.register);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        ),
                        child: Text('Cadastre-se'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (!_key.currentState!.validate()) return;
                          Navigator.of(context).pushReplacementNamed(AppRoutes.profile);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.backgroundColor,
                          foregroundColor: AppColors.menuTextColor,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        ),
                        child: Text('Login'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
