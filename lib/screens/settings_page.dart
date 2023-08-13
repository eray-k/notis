import 'package:flutter/material.dart';
import 'package:notis/main.dart';
import 'package:notis/models/data_manager.dart';
import 'package:notis/models/settings.dart';
import 'package:notis/util/util.dart';
import 'package:notis/widgets/custom_popup.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final DataManager _dataManager;
  @override
  void initState() {
    _dataManager = DataManager.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Settings',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: ListView(
        children: [
          addVerticaLSpace(20.0),
          //Visuals
          Card(
              margin: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  selectableRow(
                    context,
                    title: 'Theme',
                    current: getKeyfromValue(
                        themeMap, _dataManager.settings.getThemeMode()),
                    values: themeMap,
                    onSubmit: (value) {
                      MyApp.of(context).setThemeMode(themeMap[value]);
                    },
                  ),
                  switchableRow(context,
                      title: 'Auto Save',
                      current: _dataManager.settings.enableAutoSave,
                      onChange: (value) {
                    setState(() {
                      _dataManager.settings.enableAutoSave = value;
                      _dataManager.saveSettings();
                    });
                  })
                ],
              )),
        ],
      ),
    );
  }

  Row selectableRow(BuildContext context,
      {required String title,
      required String current,
      required Map<String, dynamic> values,
      required Function(String value) onSubmit}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 96.0,
            child: Center(
              child: TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => CustomPopUp(
                            title: title,
                            options: values.keys.toList(),
                            selected: current,
                          )).then((value) {
                    setState(() {
                      if (value != null) {
                        onSubmit(value);
                      }
                    });
                  });
                },
                child: Text(
                  current,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row switchableRow(BuildContext context,
      {required String title,
      required bool current,
      required Function(bool value) onChange}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 96.0,
            child: Center(
              child: Switch.adaptive(
                  value: current,
                  onChanged: ((value) {
                    current = value;
                    onChange(value);
                  })),
            ),
          ),
        )
      ],
    );
  }
}
