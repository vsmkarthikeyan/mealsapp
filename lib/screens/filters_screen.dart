import 'package:flutter/material.dart';
import 'package:mealsapp/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  late Map<String, bool> current_filters;
  Function saveFilters;
  FiltersScreen({required this.current_filters, required this.saveFilters});

  static const routeName = '/filters-screen';

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegan = false;
  bool _vegitarian = false;
  bool _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.current_filters['guleten']!;
    _vegan = widget.current_filters['vegan']!;
    _vegitarian = widget.current_filters['vegeterian']!;
    _lactoseFree = widget.current_filters['lactose']!;
  }

  Widget buildSwitchtile(String title, String description,
      Function(bool) updateValue, bool currentValue) {
    return SwitchListTile(
        value: currentValue,
        title: Text(title),
        subtitle: Text(description),
        onChanged: updateValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Filters'),
        actions: [
          IconButton(
              onPressed: () {
                final selectedFilters = {
                  'guleten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegeterian': _vegitarian,
                };

                widget.saveFilters(selectedFilters);
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Apply Meals filter',
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          buildSwitchtile('Gluten Free', 'Only Gluten Free Meals', (newValue) {
            setState(() {
              _glutenFree = newValue;
            });
          }, _glutenFree),
          buildSwitchtile('Vegan', 'Only Vegan Meals', (newValue) {
            setState(() {
              _vegan = newValue;
            });
          }, _vegan),
          buildSwitchtile('Vegeterian', 'Only Vegeterian Meals', (newValue) {
            setState(() {
              _vegitarian = newValue;
            });
          }, _vegitarian),
          buildSwitchtile('Lactose Free', 'Only Lactose free Meals',
              (newValue) {
            setState(() {
              _lactoseFree = newValue;
            });
          }, _lactoseFree),
        ],
      ),
    );
  }
}
