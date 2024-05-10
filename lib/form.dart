import 'package:flutter/material.dart';
import 'title.dart';
import 'relationship.dart';
import 'superpower.dart';
import 'drawer.dart';

class FormAnswers {
  String name = '';
  String nickname = '';
  int age = 0;
  bool inARelationship = false;
  double happinessLevel = 0;
  String superpower = '';
  String motto = '';

  Table getValues() {
    return Table(
      children: [
        TableRow(children: [
          const Text("Name:", style: TextStyle(fontWeight: FontWeight.w900)),
          Text("$name"),
        ]),
        TableRow(children: [
          const Text("Nickname:", style: TextStyle(fontWeight: FontWeight.w900)),
          Text("$nickname"),
        ]),
        TableRow(children: [
          const Text("Age:", style: TextStyle(fontWeight: FontWeight.w900)),
          Text("${age.toString()}"),
        ]),
        TableRow(children: [
          const Text("Relationship Status:", style: TextStyle(fontWeight: FontWeight.w900)),
          Text("${inARelationship.toString()}"),
        ]),
        TableRow(children: [
          const Text("Happiness:", style: TextStyle(fontWeight: FontWeight.w900)),
          Text("${happinessLevel.toString()}"),
        ]),
        TableRow(children: [
          const Text("Superpower:", style: TextStyle(fontWeight: FontWeight.w900)),
          Text("$superpower"),
        ]),
        TableRow(children: [
          const Text("Motto in Life:", style: TextStyle(fontWeight: FontWeight.w900)),
          Text("$motto"),
        ])
      ],
    );
  }
}

class SlambookForm extends StatefulWidget {
  final List friendsList;
  const SlambookForm(this.friendsList, {super.key});
  static const routename = '/slambookForm';

  @override
  State<SlambookForm> createState() => _MyAppState();
}


class _MyAppState extends State<SlambookForm> {
  FormAnswers answers = FormAnswers();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          drawer: DrawerWidget(widget.friendsList),
          appBar: AppBar(
            title: const Text("Hello, Friend :)"),
            backgroundColor: const Color.fromARGB(255, 8, 3, 255),
          ),
          body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    const FormTitle(),
                    NameTextField(answers: answers),
                    const SizedBox(height: 25),
                    NicknameTextField(answers: answers),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(child: AgeTextField(answers: answers)),
                        const SizedBox(width: 15),
                        Flexible(child: RelationshipStatusSwitch(answers: answers))
                      ],
                    ),
                    const SizedBox(height: 20),
                    HappinessLevelSlider(answers: answers),
                    const SizedBox(height: 10),
                    SuperpowerDropdown(answers: answers),
                    const SizedBox(height: 20),
                    MottoRadio(answers: answers),
                    const SizedBox(height: 20),
                    AddResetButton(widget.friendsList, formKey: _formKey, answers: answers)
                  ]),
                ),
              )),
        );
  }
}

class AddResetButton extends StatefulWidget {
  final List friendsList;
  late GlobalKey<FormState> _formKey;
  FormAnswers answers = FormAnswers();

  AddResetButton(
      this.friendsList, {super.key, required GlobalKey<FormState> formKey, required this.answers}) {
    this._formKey = formKey;
  }

  @override
  State<AddResetButton> createState() => AddResetButtonState();
}

class AddResetButtonState extends State<AddResetButton> {
  Widget? result;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    if (widget._formKey.currentState!.validate()) {
                      widget._formKey.currentState!.save();
                      setState(() {
                        widget.friendsList.add(widget.answers);
                        result = widget.answers.getValues();
                      });
                    } else {
                      // not valid
                      setState(() {
                        result = null;
                      });
                    }
                  },
                  child: const Text("SUBMIT")),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget._formKey.currentState!.reset();
                      result = null;
                    });
                  },
                  child: const Text("RESET")),
            ),
          ],
        ),
        Column(
          children: [
            if (result != null)
              Column(children: [
                const Divider(),
                const Center(
                  child: Text("Summary",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
                const SizedBox(height: 10),
                result!,
              ]),
          ],
        ),
      ],
    );
  }
}

class AgeTextField extends StatelessWidget {
  FormAnswers answers = FormAnswers();
  AgeTextField({super.key, required this.answers});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (value) {
        answers.age = int.parse(value!);
      },
      validator: (value) {
        if (value!.isEmpty || int.tryParse(value) == null)
          return "Please enter an integer";
      },
      decoration:
        const InputDecoration(
          border: OutlineInputBorder(), 
          hintText: "Age")
      );
  }
}

class HappinessLevelSlider extends StatefulWidget {
  FormAnswers answers = FormAnswers();
  HappinessLevelSlider({super.key, required this.answers});

  @override
  State<HappinessLevelSlider> createState() => HappinessLevelSliderState();
}

class HappinessLevelSliderState extends State<HappinessLevelSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Happiness Level", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),),
        const Text("On a scale of 1-happy, gaano kasaya ang adulting?"),
        FormField<double>(
            initialValue: 3.0,
            builder: (FormFieldState state) {
              return Slider(
                value: state.value,
                min: 1,
                max: 10,
                divisions: 9,
                onChanged: (value) {
                  setState(() {
                    state.didChange(value);
                  });
                });
            },
            onSaved: (value) {
              widget.answers.happinessLevel = value!;
            })
      ],
    );
  }
}

class MottoRadio extends StatefulWidget {
  FormAnswers answers = FormAnswers();
  MottoRadio({super.key, required this.answers});

  @override
  State<MottoRadio> createState() => MottoRadioState();
}

class MottoRadioState extends State<MottoRadio> {
  static final List<String> _motto = [
    "haters gonna hate",
    "bakers gonna bake",
    "if you cannot be, borrow one from three",
    "less is more, more is less",
    "better late than sorry",
    "dont talk to strangers when your mouth is full",
    "let's burn the bridge when we get there"
  ]; 

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Text("Motto", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
      FormField(
        initialValue: _motto[0],
        builder: (FormFieldState state){
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _motto.length,
            itemBuilder: (context, index) {
              return RadioListTile(
                title: Text(_motto[index]),
                value: _motto[index],
                groupValue: state.value,
                onChanged: (value) {
                  setState(() {
                    state.didChange(value);
                  });
                }
              );
            }
          );
        },
        onSaved: (value) {
          widget.answers.motto = value!; 
        },
      )
    ]);
  }
}

class NameTextField extends StatelessWidget {
  FormAnswers answers = FormAnswers();
  NameTextField({super.key, required this.answers});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (value) {
        answers.name = value!;
      },
      validator: (value) {
        if (value!.isEmpty) return "Please enter some text";
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Name"));
  }
}

class NicknameTextField extends StatelessWidget {
  FormAnswers answers = FormAnswers();

  NicknameTextField({super.key, required this.answers});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (value) {
        answers.nickname = value!;
      },
      validator: (value) {
        if (value!.isEmpty) return "Please enter some text";
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(), 
        hintText: "Nickname"
        ));
  }
}
