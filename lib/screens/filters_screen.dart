import '../widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function setFilter;
  final Map<String, bool> filters;
  FiltersScreen(this.filters, this.setFilter);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarianFree = false;
  bool _veganFree = false;
  bool _lactoseFree = false;

  Widget _buildSwitchListTile(bool currentValue, String title,
      String description, Function updateValue) {
    return SwitchListTile(
      value: currentValue,
      title: Text(title),
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  void initState() {
    _glutenFree = widget.filters['gluten'];
    _vegetarianFree = widget.filters['vegetarian'];
    _veganFree = widget.filters['vegan'];
    _lactoseFree = widget.filters['lactose'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              Map<String, bool> Selectedfilters = {
                'gluten': _glutenFree,
                'vegan': _veganFree,
                'vegetarian': _vegetarianFree,
                'lactose': _lactoseFree,
              };
              widget.setFilter(Selectedfilters);
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile(
                  _glutenFree,
                  'Gluten-free',
                  'only include gluten meals.',
                  (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });
                  },
                ),
                _buildSwitchListTile(
                  _vegetarianFree,
                  'Vegetarian-free',
                  'only include vegetarian meals.',
                  (newValue) {
                    setState(() {
                      _vegetarianFree = newValue;
                    });
                  },
                ),
                _buildSwitchListTile(
                  _veganFree,
                  'Vegan-free',
                  'only include vegan meals.',
                  (newValue) {
                    setState(() {
                      _veganFree = newValue;
                    });
                  },
                ),
                _buildSwitchListTile(
                  _lactoseFree,
                  'Lactose-free',
                  'only include lactose meals.',
                  (newValue) {
                    setState(() {
                      _lactoseFree = newValue;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
