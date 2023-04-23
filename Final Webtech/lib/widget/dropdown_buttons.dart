import 'package:flutter/material.dart';

// This is a dropdown button that is used to select a major
class MajorDropdown extends StatefulWidget {
  final Function(int) onTap;
  final int majorInt;
  final TextStyle textStyle;
  final Color color;
  const MajorDropdown(
      {super.key,
      required this.onTap,
      required this.majorInt,
      required this.textStyle,
      required this.color});

  @override
  State<MajorDropdown> createState() => _MajorDropdownState();
}

class _MajorDropdownState extends State<MajorDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      dropdownColor: widget.color,
      value: widget.majorInt,
      items: [
        DropdownMenuItem(
          value: 1,
          child: Text("BS", style: widget.textStyle),
        ),
        DropdownMenuItem(
          value: 2,
          child: Text("CS", style: widget.textStyle),
        ),
        DropdownMenuItem(
          value: 3,
          child: Text("MIS", style: widget.textStyle),
        ),
        DropdownMenuItem(
          value: 4,
          child: Text("CE", style: widget.textStyle),
        ),
        DropdownMenuItem(
          value: 5,
          child: Text("EEE", style: widget.textStyle),
        ),
        DropdownMenuItem(
          value: 6,
          child: Text("ME", style: widget.textStyle),
        ),
        DropdownMenuItem(
          value: 7,
          child: Text("Select Major", style: widget.textStyle),
        ),
      ],
      onChanged: (val) {
        setState(() {
          widget.onTap(val!);
        });
      },
    );
  }
}

// This is a dropdown button that is used to select a class
class ClassDropDown extends StatefulWidget {
  final Function(int) onTap;
  final int classInt;
  final TextStyle textStyle;
  final Color color;
  const ClassDropDown(
      {super.key,
      required this.onTap,
      required this.classInt,
      required this.textStyle,
      required this.color});

  @override
  State<ClassDropDown> createState() => _ClassDropDownState();
}

class _ClassDropDownState extends State<ClassDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      dropdownColor: widget.color,
      value: widget.classInt,
      items: [
        DropdownMenuItem(
          value: 1,
          child: Text("2023", style: widget.textStyle),
        ),
        DropdownMenuItem(
          value: 2,
          child: Text("2024", style: widget.textStyle),
        ),
        DropdownMenuItem(
          value: 3,
          child: Text("2025", style: widget.textStyle),
        ),
        DropdownMenuItem(
          value: 4,
          child: Text("2026", style: widget.textStyle),
        ),
        DropdownMenuItem(
          value: 5,
          child: Text("Other", style: widget.textStyle),
        ),
        DropdownMenuItem(
          value: 6,
          child: Text("Select Class", style: widget.textStyle),
        ),
      ],
      onChanged: (val) {
        setState(() {
          widget.onTap(val!);
        });
      },
    );
  }
}
