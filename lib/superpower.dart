import 'package:flutter/material.dart';
import 'form.dart';

class SuperpowerDropdown extends StatefulWidget {
  FormAnswers answers = FormAnswers();
  SuperpowerDropdown({super.key, required this.answers});

  @override
  State<SuperpowerDropdown> createState() => SuperpowerDropdownState();
}

class SuperpowerDropdownState extends State<SuperpowerDropdown> {
  static final List<String> _dropdownOptions = [
    "Makalipad",
    "Maging invisible",
    "Mapaibig siya",
    "Mapabago ang isip niya",
    "Mabalik ang nakaraan",
    "Mapaghiwalay sila",
    "Makarma siya",
    "Masagasaan ng truck",
    "Doner Durum"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Superpower", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
        const Text("If you were to have a superpower, what would you choose?",textAlign: TextAlign.center),
        const SizedBox(height: 15),
        FormField(
          initialValue: _dropdownOptions[0],
          builder: (FormFieldState state) {
            return DropdownMenu(
              initialSelection: _dropdownOptions[0],
              onSelected: (value) {
                setState(() {
                  state.didChange(value);
                });
              },
              dropdownMenuEntries: _dropdownOptions.map((entry) {
                return DropdownMenuEntry<String>(
                  label: entry, value: entry);
              }).toList());
          },
          onSaved: (value) {
            widget.answers.superpower = value!;
          },
        )
      ],
    );
  }
}
