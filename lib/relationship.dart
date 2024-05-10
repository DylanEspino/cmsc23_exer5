import 'package:flutter/material.dart';
import 'form.dart';

class RelationshipStatusSwitch extends StatefulWidget {
  FormAnswers answers = FormAnswers();
  RelationshipStatusSwitch({super.key, required this.answers});

  @override
  State<RelationshipStatusSwitch> createState() => RelationshipStatusSwitchState();
}

class RelationshipStatusSwitchState extends State<RelationshipStatusSwitch> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("In a relationship?"),
        const SizedBox(width: 7),
        FormField(
          initialValue: false,
          builder: (FormFieldState<bool> state) {
            bool light = state.value!;
            return Switch(
              value: light,
              onChanged: (value) {
                setState(() {
                  state.didChange(value);
                });
              });
          },
          onSaved: (value) {
            setState(() {
              widget.answers.inARelationship = value!;
            });
          },
        )
      ],
    );
  }
}
