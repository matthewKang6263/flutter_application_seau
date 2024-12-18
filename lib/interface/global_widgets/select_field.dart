import 'package:flutter/material.dart';

class SelectField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final List<String> items;

  const SelectField({
    Key? key,
    required this.controller,
    required this.label,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 44,
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButtonFormField<String>(
              value: controller.text.isEmpty ? null : controller.text,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 0),
                filled: true,
                fillColor: Color.fromRGBO(247, 247, 247, 1),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF338BEF)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              hint: Text(
                '예시) 용인 딥스테이션',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16,
                ),
              ),
              items: items.map((String item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  controller.text = value;
                }
              },
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Color.fromRGBO(181, 181, 181, 1),
                size: 20,
              ),
              dropdownColor: Colors.white,
              menuMaxHeight: 300,
              // elevation: 0,
              // isExpanded: true,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
