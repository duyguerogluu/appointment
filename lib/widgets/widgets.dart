import '../constants/dimens.dart';
import 'package:flutter/material.dart';

export 'form_fields/form_fields.dart';
export 'dialogs/dialogs.dart';

export 'action_box.dart';
export 'animated_icon.dart';
export 'backdrop.dart';
export 'custom_drawer.dart';
export 'custom_error.dart';
export 'custom_popup_menu_item.dart';
export 'default_form.dart';
export 'default_list_view.dart';
export 'default_observer_future.dart';
export 'default_tab_headers.dart';
export 'draggable_app_bar.dart';
export 'dropdown_input.dart';
export 'highlight_text.dart';
export 'horizontal_split_view.dart';
export 'html_content.dart';
export 'location_select.dart';
export 'master_detail_view.dart';
export 'measure_size.dart';
export 'popup_wrapper.dart';
export 'progress_indicator_button.dart';
export 'progress_indicator_widget.dart';
export 'progress_steps.dart';
export 'responsive.dart';
export 'selectable_card.dart';
export 'sticky_horizontal_split_view.dart';
export 'transparent_text_input_field.dart';
export 'video_player.dart';
export 'window_icons.dart';

extension WidgetListExtensions<X extends Widget> on List<X> {
  List<Widget> separated({Widget seperator = const Space.forFormFields()}) {
    return [
      for (var child in this) ...[
        child,
        if (child != this.last) seperator,
      ]
    ];
  }
}

class Space extends SizedBox {
  const Space([final double width = 0, final double height = 0])
      : super(width: width, height: height);

  const Space.width(final double width) : super(width: width);

  const Space.height(final double height) : super(height: height);

  const Space.forFormFields()
      : super(
          width: Dimens.formHorizontalSpacing,
          height: Dimens.formVerticalSpacing,
        );
}
