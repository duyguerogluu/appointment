import 'package:goresy/constants/dimens.dart';
import 'package:goresy/constants/l10n/l10n.dart';
import 'package:goresy/models/copyable.dart';
import 'package:goresy/utils/logger.dart';
import 'package:goresy/widgets/widgets.dart';
import 'package:flutter/material.dart';

enum FormMode { view, edit }

typedef FieldsBuilder<FormD extends Copyable<FormD>, SubmitResultD>
    = List<Widget> Function(
  BuildContext context,
  void Function(VoidCallback) setState,
  FormD? data,
  SubmitResultD? submitResultData,
  Object? submitError,
  bool enabled,
  bool readOnly,
);

class DefaultForm<FormD extends Copyable<FormD>, SubmitResultD>
    extends StatefulWidget {
  final FieldsBuilder<FormD, SubmitResultD> fieldsBuilder;
  final FormD? initialData;
  final Object? error;
  final bool loading;
  final Future<SubmitResultD?> Function(FormD data)? submitAction;
  final bool scrollable;
  final bool useSafeAreaForBottom;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final List<FormMode> modes;
  final FormMode initialMode;
  final String? title;

  /// Set null if you want to disable auto cleaner feature on succeed
  final Duration? successResultAutoCleanerDuration;

  /// Set null if you want to disable auto cleaner feature on failed
  final Duration? errorResultAutoCleanerDuration;

  final bool resetOnSuccess;
  final bool saveOnSuccess;
  final bool resetOnError;
  final String? submitButtonText;
  final IconData submitButtonIcon;
  final String? editButtonText;
  final IconData editButtonIcon;
  final String? cancelEditingButtonText;
  final IconData cancelEditingButtonIcon;
  final Function()? onClickCancelEditing;

  DefaultForm({
    super.key,
    required this.fieldsBuilder,
    this.loading = false,
    required this.initialData,
    this.error,
    this.submitAction,
    this.scrollable = true,
    this.useSafeAreaForBottom = true,
    this.margin = Dimens.formMargin,
    this.padding = Dimens.formPadding,
    this.modes = const [FormMode.view, FormMode.edit],
    this.initialMode = FormMode.view,
    this.title,
    this.successResultAutoCleanerDuration = const Duration(seconds: 5),
    this.errorResultAutoCleanerDuration = const Duration(seconds: 5),
    this.resetOnSuccess = true,
    this.saveOnSuccess = false,
    this.resetOnError = false,
    this.submitButtonText,
    this.submitButtonIcon = Icons.save_rounded,
    this.editButtonText,
    this.editButtonIcon = Icons.edit_note_rounded,
    this.cancelEditingButtonText,
    this.cancelEditingButtonIcon = Icons.arrow_back_rounded,
    this.onClickCancelEditing,
  }) : assert(modes.length > 0);

  @override
  State<DefaultForm<FormD, SubmitResultD>> createState() =>
      _DefaultFormState<FormD, SubmitResultD>();
}

class _DefaultFormState<FormD extends Copyable<FormD>, SubmitResultD>
    extends State<DefaultForm<FormD, SubmitResultD>> {
  late FormD? _lastSubmittedData;
  late FormD? _data;
  late GlobalKey<FormState> _formKey;
  late bool _editMode;
  late ScrollController _scrollController;
  SubmitResultD? _submitActionResult;
  Object? _submitActionError;
  bool _loadingSubmitAction = false;

  final List<FocusNode> _focusNodes = [];

  @override
  void initState() {
    super.initState();
    _lastSubmittedData = widget.initialData?.copy();
    _resetForm();
    if (widget.scrollable) {
      _scrollController = ScrollController();
    }
  }

  void _resetForm() {
    var resetFunc = () {
      _data = _lastSubmittedData?.copy();
      _formKey = GlobalKey<FormState>();
      _editMode = widget.modes.contains(FormMode.edit) &&
          (widget.initialMode == FormMode.edit ||
              !widget.modes.contains(FormMode.view));
    };
    if (mounted) {
      setState(resetFunc);
    } else {
      resetFunc.call();
    }
  }

  void _changeMode(FormMode mode) {
    assert(widget.modes.contains(mode));
    if (mode == FormMode.edit) {
      setState(() {
        _editMode = true;
      });
    } else if (mode == FormMode.view) {
      setState(() {
        _resetForm();
        _editMode = false;
      });
    }

    if (widget.scrollable)
      _scrollController.animateTo(
        0,
        duration: Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
      );
  }

  static Widget _buildTitle(BuildContext context, String title) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(
        left: 12,
        bottom: 8,
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: 13, color: Theme.of(context).primaryColor),
      ),
    );
  }

  static Widget? _buildResults<FormD, SubmitResultD>(
    BuildContext context,
    FormD? data,
    Object? widgetError,
    SubmitResultD? submitActionResult,
    Object? submitActionError,
  ) {
    final actionBoxMargin =
        EdgeInsets.symmetric(horizontal: Dimens.formPadding.horizontal / 2);

    var results = [
      if (submitActionResult != null &&
          submitActionResult is DefaultFormSubmitResponse)
        ActionBox.success(
          context: context,
          message: submitActionResult.responseMessage,
          margin: actionBoxMargin,
        ),
      if (submitActionError != null)
        ActionBox.errorAutoDetect(
          context: context,
          error: submitActionError,
          margin: actionBoxMargin,
        ),
      if (widgetError != null)
        ActionBox.errorAutoDetect(
          context: context,
          error: widgetError,
          margin: actionBoxMargin,
        ),
    ];

    return results.length == 0
        ? null
        : Column(
            children: results.separated(),
          );
  }

  Widget? _buildActionButtons(
    BuildContext context,
    FormMode formMode,
    List<FormMode> modes,
    bool enabled,
    Function(FormMode) changeMode,
    Function()? onSubmit,
    String? submitButtonText,
    IconData submitButtonIcon,
    String? editButtonText,
    IconData editButtonIcon,
    String? cancelEditingButtonText,
    IconData cancelEditingButtonIcon,
  ) {
    if (_focusNodes.length == 0)
      _focusNodes.addAll([FocusNode(), FocusNode(), FocusNode()]);

    final actionButtons = [
      if (formMode == FormMode.edit) ...[
        if (modes.contains(FormMode.view))
          FilledButton.icon(
            onPressed: !enabled
                ? null
                : widget.onClickCancelEditing ??
                    () => changeMode(FormMode.view),
            icon: Icon(cancelEditingButtonIcon),
            label: Text(cancelEditingButtonText ?? S.of(context).formCancel),
            focusNode: _focusNodes[0],
          ),
        if (onSubmit != null)
          ProgressIndicatorButton(
            onPressed: onSubmit,
            icon: submitButtonIcon,
            labelText: submitButtonText ?? S.of(context).formSave,
            loading: !enabled,
            focusNode: _focusNodes[1],
          ),
      ] else ...[
        if (modes.contains(FormMode.edit))
          ProgressIndicatorButton(
            onPressed: () => changeMode(FormMode.edit),
            icon: editButtonIcon,
            labelText: editButtonText ?? S.of(context).formEdit,
            loading: !enabled,
            focusNode: _focusNodes[2],
          ),
      ],
    ];

    return actionButtons.length == 0
        ? null
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: actionButtons.separated(),
          );
  }

  _setCleanerForResultState(final dynamic result, Duration duration) {
    Future.delayed(
        const Duration(seconds: 5),
        () => Future.microtask(
              () => mounted
                  ? setState(() {
                      if (result == _submitActionResult)
                        _submitActionResult = null;
                      if (result == _submitActionError)
                        _submitActionError = null;
                    })
                  : null,
            ));
  }

  @override
  Widget build(BuildContext context) {
    final onSubmit = _data == null
        ? null
        : () {
            var valid = _formKey.currentState!.validate();
            if (valid && widget.submitAction != null) {
              setState(() {
                _loadingSubmitAction = true;
              });
              final future = widget.submitAction!.call(_data!).then((value) {
                if (mounted)
                  setState(() {
                    if (widget.saveOnSuccess)
                      _lastSubmittedData = _data!.copy();
                    _loadingSubmitAction = false;

                    _submitActionResult = value;

                    if (widget.successResultAutoCleanerDuration != null)
                      _setCleanerForResultState(
                          value, widget.successResultAutoCleanerDuration!);
                    if (widget.resetOnSuccess) _resetForm();
                  });
                return value;
              });

              future.onError((error, stackTrace) {
                Log.e(error, stackTrace: stackTrace);
                if (mounted)
                  setState(() {
                    _submitActionError = error;
                    _loadingSubmitAction = false;

                    if (widget.errorResultAutoCleanerDuration != null)
                      _setCleanerForResultState(
                          error, widget.errorResultAutoCleanerDuration!);
                    if (widget.resetOnError) _resetForm();
                  });
                return null;
              });
            }
          };

    final _actionButtons = _buildActionButtons(
      context,
      _editMode ? FormMode.edit : FormMode.view,
      widget.modes,
      !widget.loading && !_loadingSubmitAction,
      _changeMode,
      onSubmit,
      widget.submitButtonText,
      widget.submitButtonIcon,
      widget.editButtonText,
      widget.editButtonIcon,
      widget.cancelEditingButtonText,
      widget.cancelEditingButtonIcon,
    );

    final _results = _buildResults(
        context, _data, widget.error, _submitActionResult, _submitActionError);

    EdgeInsets margin = widget.margin;
    if (widget.useSafeAreaForBottom)
      margin = margin + Dimens.safeBottomPaddingOf(context);

    Widget form = Responsive(
      child: Card(
        margin: margin,
        child: Padding(
          padding: widget.padding,
          child: Form(
            key: _formKey,
            child: Wrap(
              runSpacing: Dimens.formVerticalSpacing,
              spacing: Dimens.formHorizontalSpacing,
              alignment: WrapAlignment.center,
              children: [
                if (widget.title != null) _buildTitle(context, widget.title!),
                ...widget.fieldsBuilder(
                  context,
                  setState,
                  _data,
                  _submitActionResult,
                  _submitActionError,
                  !widget.loading && !_loadingSubmitAction,
                  !_editMode,
                ),
                if (_results != null) _results,
                if (_actionButtons != null) _actionButtons,
              ],
            ),
          ),
        ),
      ),
    );

    return widget.scrollable
        ? SingleChildScrollView(
            controller: _scrollController,
            child: form,
          )
        : form;
  }
}

abstract class DefaultFormSubmitResponse {
  String? responseMessage;
}

/*abstract class FormController {
  reset();
  changeMode(FormMode mode);
  buildTitle();
  buildFields();
  buildActionButtons();
  buildResults();
}*/
