import 'package:flutter/material.dart';

import 'package:shopping_list/models/category.dart';

const categories = {
  Categories.vegetables: Category(
    'Vegetables',
    Color.fromARGB(255, 151, 222, 187),
  ),
  Categories.fruit: Category(
    'Fruit',
    Color.fromARGB(255, 245, 236, 64),
  ),
  Categories.meat: Category(
    'Meat',
    Color.fromARGB(255, 239, 136, 63),
  ),
  Categories.dairy: Category(
    'Dairy',
    Color.fromARGB(255, 101, 218, 234),
  ),
  Categories.carbs: Category(
    'Carbs',
    Color.fromARGB(255, 110, 132, 241),
  ),
  Categories.sweets: Category(
    'Sweets',
    Color.fromARGB(255, 250, 185, 93),
  ),
  Categories.spices: Category(
    'Spices',
    Color.fromARGB(255, 240, 98, 98),
  ),
  Categories.convenience: Category(
    'Convenience',
    Color.fromARGB(255, 148, 141, 243),
  ),
  Categories.hygiene: Category(
    'Hygiene',
    Color.fromARGB(255, 241, 87, 177),
  ),
  Categories.other: Category(
    'Other',
    Color.fromARGB(255, 232, 197, 145),
  ),
};
