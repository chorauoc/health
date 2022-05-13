import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthapp/util/colors.dart';

class HealthTextFormFeild extends StatelessWidget {
  final String text;
  final String? placeholder;
  final bool obscureText;
  final TextEditingController controller;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  const HealthTextFormFeild({
    Key? key,
    required this.text,
    this.obscureText = false,
    required this.controller,
    this.enabled = true,
    this.inputFormatters,
    this.validator, this.placeholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 2.0),
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 16, color: kBlue),
                ),
              ),
              const Text(
                '*',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            ],
          ),
          const SizedBox(height: 6),
          SizedBox(
            child: TextFormField(
              enabled: enabled,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: controller,
              obscureText: obscureText,
              validator: validator ??
                  (value) {
                    if (value == null || value.isEmpty) {
                      return '$text is required';
                    }
                    return null;
                  },
              inputFormatters: inputFormatters,
              style: const TextStyle(color: kBlue),
              decoration: InputDecoration(
                helperText: placeholder,
                filled: !enabled,
                fillColor: !enabled ? Colors.blueGrey.withOpacity(0.5) : null,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: kBlue.withOpacity(0.2))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kBlue.withOpacity(0.2))),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kBlue.withOpacity(0.2))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HealthDropDown extends StatefulWidget {
  final TextEditingController controller;
  final String text;
  final List<String> items;
  const HealthDropDown(
      {Key? key,
      required this.controller,
      required this.text,
      required this.items})
      : super(key: key);

  @override
  State<HealthDropDown> createState() => _HealthDropDownState();
}

class _HealthDropDownState extends State<HealthDropDown> {
  var selected;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 2.0),
                child: Text(
                  widget.text,
                  style: const TextStyle(fontSize: 16, color: kBlue),
                ),
              ),
              const Text(
                '*',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            ],
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            hint: selected ??
                Text(
                  widget.text,
                  style: const TextStyle(fontSize: 16, color: kBlue),
                ),
            value: selected,
            items: widget.items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                widget.controller.text == value;
                selected == value;
              });
            },
            onSaved: (value) {
              setState(() {
                widget.controller.text == value;
                selected == value;
              });
            },
            style: const TextStyle(color: kBlue),
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: kBlue.withOpacity(0.2))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kBlue.withOpacity(0.2))),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kBlue.withOpacity(0.2))),
            ),
          ),
        ],
      ),
    );
  }
}
