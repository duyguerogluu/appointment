import 'package:goresy/constants/constants.dart';
import 'package:goresy/widgets/widgets.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final formKey = GlobalKey<FormState>();

  String _emailAddress = "";

  Widget _buildEmailTextField(BuildContext context, bool enabled) {
    return TextInputFormField(
      labelText: S.of(context).loginFormUsername,
      keyboardType: TextInputType.emailAddress,
      suffixIcon: Icon(Icons.alternate_email_rounded),
      initialValue: _emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: (val) => setState(() {
        _emailAddress = val;
      }),
      validate: (validator) => validator.required().email(),
      enabled: enabled,
    );
  }

  Widget _buildResetButton(BuildContext context, bool loading) {
    return Center(
      child: FilledButton(
        onPressed: loading
            ? null
            : () {
                var valid = formKey.currentState!.validate();
                if (valid) {
                  //_authStore.onClickSignIn(_emailAddress, _password);
                }
              },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Opacity(
              opacity: loading ? 1 : 0,
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              ),
            ),
            Opacity(
              opacity: loading ? 0 : 1,
              child: Text(
                S.of(context).loginFormResetPassword,
                style: TextStyle(color: Colors.grey.shade200),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String? errorMessage;
    return SingleChildScrollView(
      padding: Dimens.formPadding.double,
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ActionBox.info(
              context: context,
              message: S.of(context).loginFormResetPasswordScreenInformation,
              margin: EdgeInsets.zero,
            ),
            Space.forFormFields(),
            Space.forFormFields(),
            _buildEmailTextField(context, true),
            Space.forFormFields(),
            _buildResetButton(context, false),
            Space.forFormFields(),
            Space.forFormFields(),
            if (errorMessage != null && errorMessage.isNotEmpty)
              ActionBox.errorMessage(
                context: context,
                message: errorMessage.capitalize,
              ),
          ],
        ),
      ),
    );
  }
}
