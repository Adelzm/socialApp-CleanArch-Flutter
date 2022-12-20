import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_clean_archi/src/features/auth/domain/entities/signed_in_user_entity.dart';
import 'package:social_media_clean_archi/src/features/auth/presentation/blocs/signup/signup_cubit.dart';

import '../../../../shared/presentation/widgets/widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: const [
              Spacer(flex: 3),
              _Username(),
              SizedBox(height: 10),
              _Email(),
              SizedBox(height: 10),
              _Password(),
              SizedBox(height: 10),
              _SignupButton(),
              Spacer(flex: 2),
              _SigninRedirect()
            ],
          ),
        ),
      ),
    );
  }
}

class _SigninRedirect extends StatelessWidget {
  const _SigninRedirect({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.goNamed('signin');
      },
      child: RichText(
        text: TextSpan(children: [
          const TextSpan(text: 'Already have an account? '),
          TextSpan(
              text: 'Signin',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold))
        ]),
      ),
    );
  }
}

class _SignupButton extends StatelessWidget {
  const _SignupButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) {
        return previous.status != current.status;
      },
      builder: (context, state) {
        return state.status == FormzStatus.submissionInProgress
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : ElevatedButton(
                onPressed: () {
                  if (state.status == FormzStatus.valid) {
                    context.read<SignupCubit>().signUpWithCredentials();
                    context.pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Check your username, email or password: ${state.status}'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: const Size(100, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  'Signup',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black),
                ),
              );
      },
    );
  }
}

class _Username extends StatelessWidget {
  const _Username({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) {
        return previous.username != current.username;
      },
      builder: (context, state) {
        return MainTextField(
          labelText: 'Username',
          errorText: state.username.invalid ? 'The username is invalid' : null,
          keyboardType: TextInputType.name,
          onChange: (username) {
            context.read<SignupCubit>().usernameChanged(username);
          },
        );
      },
    );
  }
}

class _Email extends StatelessWidget {
  const _Email({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) {
        return previous.email != current.email;
      },
      builder: (context, state) {
        return MainTextField(
          labelText: 'Email',
          errorText: state.email.invalid ? 'The email is invalid' : null,
          keyboardType: TextInputType.emailAddress,
          onChange: (email) {
            context.read<SignupCubit>().emailChanged(email);
          },
        );
      },
    );
  }
}

class _Password extends StatelessWidget {
  const _Password({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) {
        return previous.password != current.password;
      },
      builder: (context, state) {
        return MainTextField(
          labelText: 'Password',
          obscureText: true,
          errorText: state.password.invalid ? 'The password is invalid' : null,
          onChange: (password) {
            context.read<SignupCubit>().passwordChanged(password);
          },
        );
      },
    );
  }
}
