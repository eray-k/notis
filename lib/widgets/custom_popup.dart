import 'package:flutter/material.dart';

class CustomPopUp extends StatefulWidget {
  const CustomPopUp(
      {super.key,
      required this.title,
      required this.options,
      required this.selected});
  final String title;
  final List<String> options;
  final String selected;
  @override
  State<CustomPopUp> createState() => _CustomPopUpState();
}

class _CustomPopUpState extends State<CustomPopUp> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            widget.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          ListView.builder(
              itemCount: widget.options.length,
              itemBuilder: (context, index) {
                return RadioListTile.adaptive(
                  value: widget.options[index],
                  groupValue: widget.selected,
                  title: Text(widget.options[index]),
                  onChanged: (String? value) {
                    setState(() {
                      final val = value ?? '';
                      if (val.isNotEmpty) {
                        Navigator.pop(context,val);
                      }
                    });
                  },
                );
              })
        ],
      ),
    );
  }
}
