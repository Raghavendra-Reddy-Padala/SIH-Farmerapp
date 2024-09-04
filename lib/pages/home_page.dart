import 'dart:convert';
import 'package:farmerapp/authpage/config.dart';
import 'package:farmerapp/componets/mydrawer.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final String token;

  const HomePage({required this.token, super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String username;
  bool isFarmAdded = false;
  String? farmName;

  @override
  void initState() {
    super.initState();
    _checkFarm();
    try {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
      username = jwtDecodedToken['username'] ?? 'Email not found';
    } catch (e) {
      username = 'Invalid token';
    }
  }

  Future<void> _checkFarm() async {
    try {
      final response = await http.get(
        Uri.parse(checkfarm),
        headers: {
          'Authorization': 'Bearer ${widget.token}',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['farmExists']) {
          setState(() {
            isFarmAdded = true;
            farmName = data['farmName'];
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to check farm existence')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error checking farm')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InstaFarm'),
        centerTitle: true,
      ),
      drawer: Mydrawer(token: widget.token),
      body: Center(
        child: isFarmAdded
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Text('Hey, $farmName', style: const TextStyle(fontSize: 24)),
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/farmer illustration.jpeg',
                    height: 500,
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/farmer illustration.jpeg',
                    height: 500,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _showAddFarmForm(context);
                    },
                    child: const Text('Add Farm'),
                  ),
                ],
              ),
      ),
    );
  }

  void _showAddFarmForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Farm'),
          content: AddFarmForm(
            token: widget.token,
            onFarmAdded: (name) {
              setState(() {
                isFarmAdded = true;
                farmName = name;
              });
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}

class AddFarmForm extends StatefulWidget {
  final Function(String farmName) onFarmAdded;
  final String token;

  const AddFarmForm(
      {required this.onFarmAdded, required this.token, super.key});

  @override
  _AddFarmFormState createState() => _AddFarmFormState();
}

class _AddFarmFormState extends State<AddFarmForm> {
  final _formKey = GlobalKey<FormState>();
  String? _farmName;
  String? _area;
  final List<String> _selectedCategories = [];

  final List<String> _categories = [
    'Staple Farm',
    'Dairy Farm',
    'Organic Farm',
    'Poultry Farm',
    'Flower Farm'
  ];

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        final response = await http.post(
          Uri.parse(addfarm),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${widget.token}',
          },
          body: json.encode({
            'farmName': _farmName,
            'area': _area,
            'category': _selectedCategories,
          }),
        );

        if (response.statusCode == 200) {
          widget.onFarmAdded(_farmName!);
        } else {
          final responseBody = jsonDecode(response.body);
          String errorMessage =
              responseBody['error'] ?? 'Failed to add farm. Please try again.';
          print('Failed to add farm: $responseBody');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage)),
          );
        }
      } on http.ClientException catch (e) {
        print('ClientException: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Network error. Please try again later.')),
        );
      } on FormatException catch (e) {
        print('FormatException: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Invalid data format. Please check your input.')),
        );
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('An unexpected error occurred. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Farm Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a farm name';
              }
              return null;
            },
            onSaved: (value) {
              _farmName = value;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Area'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the area';
              }
              return null;
            },
            onSaved: (value) {
              _area = value;
            },
          ),
          const SizedBox(height: 20),
          const Text('Category'),
          ..._categories.map((category) {
            return CheckboxListTile(
              title: Text(category),
              value: _selectedCategories.contains(category),
              onChanged: (bool? selected) {
                setState(() {
                  if (selected == true) {
                    _selectedCategories.add(category);
                  } else {
                    _selectedCategories.remove(category);
                  }
                });
              },
            );
          }),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitForm,
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
