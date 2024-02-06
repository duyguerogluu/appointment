import 'package:goresy/constants/constants.dart';
import 'package:goresy/stores/auth_store.dart';
import 'package:goresy/stores/language_store.dart';
import 'package:goresy/ui/settings/application_settings_screen.dart';
import 'package:goresy/widgets/widgets.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import 'forgot_password_form.dart';

class LoginForm extends StatefulWidget {
  final bool loading;
  final String? errorMessage;
  const LoginForm({super.key, this.loading = false, this.errorMessage});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final LanguageStore _languageStore = getIt<LanguageStore>();
  final AuthStore _authStore = getIt<AuthStore>();

  final formKey = GlobalKey<FormState>();

  final FocusNode _passwordFieldFocusNode = FocusNode();

  String _username = "";
  String _password = "";

  Widget _buildLanguageSelectButton(BuildContext context) {
    return Align(
      alignment: FractionalOffset.centerRight,
      child: TextButton.icon(
        onPressed: () => ApplicationSettingsScreenState.showLanguageDialog(
            context, _languageStore),
        icon: Icon(
          Icons.language,
          size: 15,
        ),
        label: Text(
          _languageStore
              .localeNameByLanguageCode(_languageStore.locale.languageCode),
        ),
        style: ButtonStyle(
          foregroundColor:
              MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
          padding: MaterialStatePropertyAll(EdgeInsets.all(0.0)),
        ),
      ),
    );
  }

  Widget _buildEmailTextField(BuildContext context, bool enabled) {
    return TextInputFormField(
      labelText: S.of(context).loginFormUsername,
      keyboardType: TextInputType.emailAddress,
      suffixIcon: null,
      useFloatingLabel: false,
      icon: Icons.person,
      initialValue: _username,
      textInputAction: TextInputAction.next,
      onChanged: (val) => setState(() {
        _username = val;
      }),
      onFieldSubmitted: (val) => _passwordFieldFocusNode.requestFocus(),
      validate: (val) => val.required(),
      enabled: enabled,
    );
  }

  Widget _buildPasswordTextField(BuildContext context, bool enabled) {
    String fieldName = S.of(context).loginFormPassword;
    return TextInputFormField(
      labelText: fieldName,
      obscureText: true,
      userCanSeeObscureText: true,
      useFloatingLabel: false,
      suffixIcon: null,
      icon: Icons.lock,
      textInputAction: TextInputAction.done,
      initialValue: _password,
      onChanged: (val) => setState(() {
        _password = val;
      }),
      validate: (val) => val.required(),
      enabled: enabled,
      focusNode: _passwordFieldFocusNode,
    );
  }

  Widget _buildForgotPasswordButton(BuildContext context, bool enabled) {
    final title = S.of(context).loginFormForgotPassword;

    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        child: Text(title),
        onPressed: !enabled
            ? null
            : () {
                BackdropDialog.show(
                  context: context,
                  body: ForgotPasswordForm(),
                  barrierColor: Colors.black.withOpacity(0.2),
                  title: title,
                  height: 500,
                );
              },
        style: ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(
            Theme.of(context).colorScheme.primary,
          ),
          padding: MaterialStatePropertyAll(EdgeInsets.all(0.0)),
        ),
      ),
    );
  }

  Widget _buildSignInButton(BuildContext context, bool loading) {
    return Center(
      child: ProgressIndicatorButton(
        labelText: S.of(context).loginFormSignIn,
        loading: loading,
        onPressed: loading
            ? null
            : () {
                var valid = formKey.currentState!.validate();
                if (valid) {
                  _authStore.onClickSignIn(_username, _password);
                }
              },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final errorMessage = widget.errorMessage;
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 18),
          Center(
            child: Image.asset(
              Assets.appLogo,
              colorBlendMode: BlendMode.modulate,
              color: Theme.of(context).primaryColor,
              width: 150,
            ),
          ),
          _buildLanguageSelectButton(context),
          _buildEmailTextField(context, !widget.loading),
          SizedBox(
            height: 8,
          ),
          _buildPasswordTextField(context, !widget.loading),
          _buildForgotPasswordButton(context, !widget.loading),
          _buildSignInButton(context, widget.loading),
          SizedBox(
            height: 16,
          ),
          if (errorMessage != null && errorMessage.isNotEmpty)
            ActionBox.errorMessage(
              context: context,
              message: errorMessage.toLowerCase().capitalize,
            ),
        ],
      ),
    );
  }
}
