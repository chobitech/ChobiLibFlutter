import 'package:flutter/material.dart';

class PermissionInfoDialog extends StatelessWidget {


  final Widget? title;
  final Widget? icon;
  final Widget? message;
  final DialogTheme? dialogTheme;
  final List<Widget>? actions;

  const PermissionInfoDialog({super.key, this.dialogTheme, this.title, this.icon, this.message, this.actions,});


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dialogTheme: dialogTheme);

    return Theme(
      data: theme,
      child: AlertDialog(
        title: title,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16,),

            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16,),
                child: icon,
              ),

            if (message != null)
              message!,
          ],
        ),
        actions: actions,
      ),
    );

  }
}