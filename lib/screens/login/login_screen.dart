import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_checker/bloc/auth_bloc.dart';
import 'package:time_checker/const/colors.dart';
import 'package:time_checker/const/spacing.dart';
import 'package:time_checker/const/text_field.dart';
import 'package:time_checker/service/app/di.dart';
import 'package:time_checker/service/repository/repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Repository _repository = instance<Repository>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    // Input validation
    if (username.isEmpty || password.isEmpty) {
      _showValidationDialog(
          'Уучлаарай', 'Нэвтрэх нэр болон нууц үг оруулна уу.');
      return;
    }

    try {
      final token = await _repository.login(username, password);

      if (mounted) {
        if (token == 'DeviceNotFound') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Төхөөрөмж олдсонгүй.')),
          );
        } else if (token == 'InvalidCredentials') {
          _showValidationDialog(
              'Алдаа', 'Утасны дугаар болон нууц үг буруу байна.');
        } else {
          // Амжилттай нэвтрэх үед
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: successColor7,
                content: Text(
                  'Амжилттай нэвтэрлээ.',
                  style: ktsBodyMediumBold.copyWith(color: whiteColor),
                )),
          );

          // AuthBloc рүү token дамжуулах
          context.read<AuthBloc>().add(LoggedIn(token: token));

          if (kDebugMode) {
            print(token);
          }
        }
      }
    } catch (error) {
      if (!mounted) {
        return; // Check if the widget is still mounted before using BuildContext
      }

      // Show error message on exception
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: dangerColor7,
            content: Text(
              'Та утасны дугаар болон нууц үгээ шалгана уу.',
              style: ktsBodyMediumBold.copyWith(color: whiteColor),
            )),
      );
    }
  }

  void _showValidationDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // AnimationController for controlling the animation
        AnimationController controller = AnimationController(
          duration: const Duration(milliseconds: 800), // Animation duration
          vsync:
              Navigator.of(context), // This provides the ticker for animation
        );

        // Scale animation, grows from 0.5x to 1.0x size
        Animation<double> scaleAnimation = CurvedAnimation(
          parent: controller,
          curve: Curves.elasticInOut, // Elastic effect curve for the animation
        );

        controller.forward(); // Start the animation

        return ScaleTransition(
          scale: scaleAnimation, // Apply the scale animation to the dialog
          child: AlertDialog(
            backgroundColor: Colors.white, // Background color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0), // Rounded corners
            ),
            title: Row(
              children: [
                const Icon(Icons.error, color: dangerColor5), // Error icon
                const SizedBox(width: 10), // Space between icon and text
                Text(
                  title,
                  style: ktsBodyMassiveBold.copyWith(color: greyColor8),
                ),
              ],
            ),
            content: Text(
              message,
              style: ktsBodyMedium.copyWith(color: greyColor8),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'ОК',
                  style: ktsBodyLargeBold.copyWith(
                    color: informationColor7, // Custom button text color
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  controller.dispose(); // Dispose of the animation controller
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 1.0,
            colors: [Color(0xFF6A95FF), Color(0xFFFFE29F)],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 60),
              _buildBackButton(),
              const SizedBox(height: 250),
              _buildLoginForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: whiteColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.arrow_back_ios, color: greyColor5),
              h4(),
              Text('Буцах',
                  style: ktsBodyMediumBold.copyWith(color: greyColor5)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Container(
      decoration: const BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Нэвтрэх',
                style: ktsBodyMassivePlusSemiBold.copyWith(color: greyColor8)),
            h8(),
            Text('Өөрийн мэдээллээ оруулна уу',
                style: ktsBodyMedium.copyWith(color: greyColor4)),
            const SizedBox(height: 20),
            _buildTextField(_usernameController, 'Нэвтрэх нэр', false),
            h8(),
            _buildTextField(_passwordController, 'Нууц үг', true),
            h48(),
            _buildLoginButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String hintText, bool isPassword) {
    return TextField(
      cursorColor: informationColor6,
      controller: controller,
      obscureText: isPassword ? _isObscured : false,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: ktsBodyMedium.copyWith(color: greyColor4),
        filled: true,
        fillColor: greyColor1,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon:
                    Icon(_isObscured ? Icons.visibility_off : Icons.visibility),
                color: greyColor5,
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              )
            : null,
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity, // Дэлгэцийн өргөнийг ашиглах
      child: ElevatedButton(
        onPressed: _login,
        style: ElevatedButton.styleFrom(
          backgroundColor: informationColor8,
          padding: const EdgeInsets.symmetric(horizontal: 140, vertical: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: Text('Нэвтрэх',
            style: ktsBodyLargeBold.copyWith(color: whiteColor)),
      ),
    );
  }
}
