import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pembekalan_flutter/translations/locale_keys.g.dart';

Widget customLanguageChooser({
  void Function()? onID,
  void Function()? onEN,
}) {
  return AlertDialog(
    title: Text(
      LocaleKeys.language_setting.tr(),
    ),
    content: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(Icons.language),
          title: Text(LocaleKeys.bahasa_indonesia.tr()),
          onTap: onID,
        ),
        ListTile(
          leading: Icon(Icons.language),
          title: Text(LocaleKeys.bahasa_inggris.tr()),
          onTap: onEN,
        )
      ],
    ),
  );
}
