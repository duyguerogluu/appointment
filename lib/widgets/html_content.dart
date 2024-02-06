import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HtmlContent extends Html {
  HtmlContent({
    super.key,
    super.data,
    style = const {},
    onImageError,
    onImageTap,
    shrinkWrap = false,
    onLinkTap,
    required Color linkTextColor,
    required Color textColor,
  }) : super(
          style: {
            "body": Style(
              padding: EdgeInsets.zero,
              margin: Margins.zero,
            ),
            "*": Style(
              color: textColor,
              fontSize: FontSize(14, Unit.px),
            ),
            "a": Style(
              color: linkTextColor,
              textDecoration: TextDecoration.none,
            ),
            ...style
          },
          onImageError: onImageError,
          onImageTap: onImageTap,
          shrinkWrap: shrinkWrap,
          onLinkTap: (url, _, __, ___) {
            if (url != null) launchUrlString(url);
          },
        );
}
