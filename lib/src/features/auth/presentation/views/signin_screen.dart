import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_clean_archi/src/features/auth/domain/entities/signedin_user_entity.dart';
import 'package:social_media_clean_archi/src/features/auth/presentation/blocs/signin/signin_cubit.dart';

import '../../../../shared/presentation/widgets/widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signin'),
      ),
      body: BlocListener<SigninCubit, SigninState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorText ?? 'Auth failure'),
              ),
            );
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: const [
                Spacer(flex: 3),
                _Username(),
                SizedBox(height: 10),
                _Password(),
                SizedBox(height: 10),
                _SigninButton(),
                Spacer(flex: 2),
                _SignupRedirect()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SignupRedirect extends StatelessWidget {
  const _SignupRedirect({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.goNamed('signup');
      },
      child: RichText(
        text: TextSpan(children: [
          const TextSpan(text: 'Don\'t you have an account? '),
          TextSpan(
              text: 'Signup',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold))
        ]),
      ),
    );
  }
}

class _SigninButton extends StatelessWidget {
  const _SigninButton({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SigninCubit, SigninState>(
      buildWhen: (previous, current) {
        return previous.status != current.status;
      },
      builder: (context, state) {
        if (state.status == FormzStatus.submissionInProgress) {
          return const CircularProgressIndicator(
            color: Colors.white,
          );
        } else {
          return ElevatedButton(
            onPressed: () {
              if (state.status == FormzStatus.valid) {
                context.read<SigninCubit>().signInWithCredentials();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Check your username and password: ${state.status}'),
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
              'Signin',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.black),
            ),
          );
        }
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
    return BlocBuilder<SigninCubit, SigninState>(
      buildWhen: (previous, current) {
        return previous.username != current.username;
      },
      builder: (context, state) {
        return MainTextField(
          labelText: 'Username',
          errorText: state.username.invalid ? 'The username is invalid' : null,
          onChange: (username) {
            context.read<SigninCubit>().usernameChanged(username);
          },
          keyboardType: TextInputType.name,
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
    return BlocBuilder<SigninCubit, SigninState>(
      buildWhen: (previous, current) {
        return previous.password != current.password;
      },
      builder: (context, state) {
        return MainTextField(
          labelText: 'Password',
          errorText: state.username.invalid ? 'The password is invalid' : null,
          onChange: (password) {
            context.read<SigninCubit>().passwordChanged(password);
          },
          obscureText: true,
        );
      },
    );
  }
}
