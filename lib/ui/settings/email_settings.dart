import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/settings/email_settings_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_scaffold.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class EmailSettings extends StatefulWidget {
  const EmailSettings({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final EmailSettingsVM viewModel;

  @override
  _EmailSettingsState createState() => _EmailSettingsState();
}

class _EmailSettingsState extends State<EmailSettings> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool autoValidate = false;

  final _replyToEmailController = TextEditingController();
  final _bccEmailController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void dispose() {
    _controllers.forEach((dynamic controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _controllers = [
      _replyToEmailController,
      _bccEmailController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    /*
    final product = widget.viewModel.product;
    _productKeyController.text = product.productKey;
      */

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  void _onChanged() {
    /*
    final product = widget.viewModel.product.rebuild((b) => b
      ..customValue2 = _custom2Controller.text.trim());
    if (product != widget.viewModel.product) {
      widget.viewModel.onChanged(product);
    }
    */
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    //final viewModel = widget.viewModel;

    return SettingsScaffold(
      title: localization.emailSettings,
      onSavePressed: null,
      body: AppForm(
        formKey: _formKey,
        children: <Widget>[
          FormCard(
            children: <Widget>[
              DecoratedFormField(
                label: localization.replyToEmail,
                controller: _replyToEmailController,
                keyboardType: TextInputType.emailAddress,
              ),
              DecoratedFormField(
                label: localization.bccEmail,
                controller: _bccEmailController,
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
