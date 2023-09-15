import 'package:flutter/material.dart';

class OptionDialog extends StatefulWidget {
  const OptionDialog(
      {super.key,
      required this.title,
      required this.options,
      required this.selected});
  final String title;
  final List<String> options;
  final String selected;
  @override
  State<OptionDialog> createState() => _OptionDialogState();
}

class _OptionDialogState extends State<OptionDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(
            maxHeight: 300.0, maxWidth: 250.0, minWidth: 144.0),
        child: ListView.builder(
            itemCount: widget.options.length,
            itemBuilder: (context, index) {
              //BUG: Radio cant be selected when it is already selected.
              return RadioListTile.adaptive(
                value: widget.options[index],
                groupValue: widget.selected,
                title: Text(widget.options[index]),
                onChanged: (String? value) {
                  final val = value ?? '';
                  if (val.isNotEmpty) {
                    Navigator.pop(context, val);
                  }
                },
              );
            }),
      ),
    );
  }
}
