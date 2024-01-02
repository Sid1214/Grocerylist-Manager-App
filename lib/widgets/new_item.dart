import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list/Themes/colors.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:http/http.dart' as http;

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formkey = GlobalKey<FormState>();
  var _enteredName = "";
  var _enteredQuantity = 1;
  var _selectedCategory = categories[Categories.vegetables]!;
  void _saveItem() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      final url = Uri.https("flutter-prac-93533-default-rtdb.firebaseio.com",
          "/shopping-list.json");
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            "name": _enteredName,
            "quantity": _enteredQuantity,
            "category": _selectedCategory.title
          }));
      // response.statusCode == 201;
      if (!context.mounted) {
        return;
      }
      Navigator.of(context).pop();
      // GroceryItem(
      //     id: DateTime.now.toString(),
      //     name: _enteredName,
      //     quantity: _enteredQuantity,
      //     category: _selectedCategory));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add a New Item",
              style: TextStyle(
                  fontFamily: "Caveat",
                  fontSize: 25,
                  color: Color1,
                  fontWeight: FontWeight.w800)),
        ),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      maxLength: 50,
                      decoration: InputDecoration(
                        label: Text("Name",
                            style: TextStyle(
                                fontFamily: "Caveat",
                                fontSize: 20,
                                color: Color2,
                                fontWeight: FontWeight.w700)),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().length <= 1 ||
                            value.trim().length > 50) {
                          return "Error: Must be between 1-50 characters.";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredName = value!;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                                label: Text("Quantity",
                                    style: TextStyle(
                                        fontFamily: "Caveat",
                                        fontSize: 20,
                                        color: Color2,
                                        fontWeight: FontWeight.w700))),
                            keyboardType: TextInputType.number,
                            initialValue: _enteredQuantity.toString(),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  int.tryParse(value) == null ||
                                  int.tryParse(value)! <= 0) {
                                return "Error: Must be a Valid Positive Number!";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredQuantity = int.parse(value!);
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: DropdownButtonFormField(
                              value: _selectedCategory,
                              items: [
                                for (final category in categories.entries)
                                  DropdownMenuItem(
                                      value: category.value,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 16,
                                            height: 16,
                                            color: category.value.color,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(category.value.title,
                                              style: TextStyle(
                                                fontFamily: "Caveat",
                                                fontSize: 18,
                                                color: Color2,
                                              )),
                                        ],
                                      ))
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _selectedCategory = value!;
                                });
                              }),
                        )
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              _formkey.currentState!.reset();
                            },
                            child: Text("Reset",
                                style: TextStyle(
                                    fontFamily: "Caveat",
                                    fontSize: 24,
                                    color: Color2,
                                    fontWeight: FontWeight.w800))),
                        ElevatedButton(
                            onPressed: _saveItem,
                            child: Text("Add Item",
                                style: TextStyle(
                                    fontFamily: "Caveat",
                                    fontSize: 24,
                                    color: Color2,
                                    fontWeight: FontWeight.w800))),
                      ],
                    )
                  ],
                ))));
  }
}
