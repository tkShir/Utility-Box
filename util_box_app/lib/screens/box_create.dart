import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';

import '../providers/box_info.dart';
import '../models/box_info.dart';

class BoxCreatePage extends StatefulWidget {
  static const String pageRoute = 'createBox';

  @override
  State<StatefulWidget> createState() {
    return _BoxCreatePageState();
  }
}

class _BoxCreatePageState extends State<BoxCreatePage> {
  BoxType _createBoxType;
  String _dropDownChoice = '';
  final List<String> _defaultCategories = defaultCategories;
  final Map<String, IconData> _defaultIconChoice = defaultIconChoice;

  final Map<String, dynamic> _formData = {
    'boxTitle': null,
    'textColor': null,
    'boxColor': null,
    'iconData': null,
    'boxUrl': null,
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitleTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Box Title'),
      initialValue: null,
      validator: (String value) {
        // if (value.trim().length <= 0) {
        if (value.isEmpty || value.length < 5) {
          return 'Title is required and should be 5+ characters long.';
        }
      },
      onSaved: (String value) {
        _formData['boxTitle'] = value;
      },
    );
  }

  Widget _buildBoxColorPicker(BuildContext context) {
    return FormField(
      builder: (FormFieldState<Color> state) {
        return ListTile(
          title: Text("Box Color"),
          subtitle: Text("Choose a color"),
          leading: CircleAvatar(
            backgroundColor: _formData["boxColor"] == null
                ? Colors.grey
                : _formData["boxColor"],
          ),
          onTap: () {
            _showColorPicker(context).then((color) {
              setState(() {
                if (color != null) {
                  _formData["boxColor"] = color;
                }
              });
            });
          },
        );
      },
    );
  }

  Widget _buildTextColorPicker(BuildContext context) {
    return FormField(
      builder: (FormFieldState<Color> state) {
        return ListTile(
          title: Text("Box Text Color"),
          subtitle: Text("Choose a color"),
          leading: CircleAvatar(
            backgroundColor: _formData["textColor"] == null
                ? Colors.grey
                : _formData["textColor"],
          ),
          onTap: () {
            _showColorPicker(context).then((color) {
              setState(() {
                if (color != null) {
                  _formData["textColor"] = color;
                }
              });
            });
          },
        );
      },
    );
  }

  Future<Color> _showColorPicker(BuildContext context) {
    Color _choosedColor = _formData['boxColor'];
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select assignment'),
            children: <Widget>[
              MaterialColorPicker(
                onColorChange: (Color color) {
                  _choosedColor = color;
                  // Handle color changes
                },
                selectedColor:
                    _choosedColor == null ? Colors.grey : _choosedColor,
              ),
              SimpleDialogOption(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(null);
                },
              ),
              SimpleDialogOption(
                child: const Text('Confirm'),
                onPressed: () {
                  Navigator.of(context).pop(_choosedColor);
                },
              ),
            ],
          );
        });
  }

  Widget _buildIconField() {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
            icon: Icon(_defaultIconChoice[_dropDownChoice]),
            labelText: 'Categories',
          ),
          isEmpty: _dropDownChoice == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _dropDownChoice,
              isDense: true,
              onChanged: (String newValue) {
                setState(() {
                  _dropDownChoice = newValue;
                  _formData["iconData"] = _defaultIconChoice[_dropDownChoice];
                });
              },
              items: _defaultCategories.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildURLTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Box Link'),
      initialValue: null,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)')
                .hasMatch(value)) {
          return 'Box URL is required and has to be a valid URL';
        }
      },
      onSaved: (String value) {
        _formData['boxUrl'] = value;
      },
    );
  }

  Widget _buildSubmitButton(BoxInfoProvider boxData) {
    return RaisedButton(
      child: Text('Save'),
      textColor: Colors.white,
      onPressed: () {
        _submitForm(boxData);
      },
    );
  }

  // final Map<String, dynamic> _formData = {
  //   'boxTitle': null,
  //   'textColor': null,
  //   'boxColor': null,
  //   'iconData': null,
  //   'boxUrl': null,
  // };

  void _submitForm(BoxInfoProvider boxData) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    BoxInfo createdBoxInfo = BoxInfo(
      boxTitle: _formData['boxTitle'],
      textColor: _formData['textColor'],
      boxColor: _formData['boxColor'],
      iconData: _formData['iconData'],
      boxType: _createBoxType,
      boxUrl: _formData['boxUrl'],
    );
    boxData.addBox(createdBoxInfo);
    // TODO: Create Add Box function in the providers and implement here
  }

  @override
  void initState() {
    if (_createBoxType == null) {
      _createBoxType = BoxType.URLBox;
    }
    super.initState();
  }

  Widget _createUtilBoxContent(context, BoxInfoProvider boxData) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          children: <Widget>[
            _buildTitleTextField(),
            SizedBox(height: 10.0),
            _buildBoxColorPicker(context),
            SizedBox(height: 10.0),
            _buildTextColorPicker(context),
            _buildIconField(),
            _buildURLTextField(),
            SizedBox(height: 10.0),
            _buildSubmitButton(boxData),
          ],
        ),
      ),
    );
  }

  Widget _createAppBoxContent() {
    return Text("Create App Box");
  }

  Widget _createPreMadeBoxContent() {
    return Text("Create PreMade Box");
  }

  void _handleCreateBoxTypeChange(BoxType type) {
    setState(() {
      _createBoxType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    final BoxInfoProvider boxData = Provider.of<BoxInfoProvider>(context);

    Widget _pageContent;
    if (_createBoxType == BoxType.PreMadeBox) {
      _pageContent = Text("Not Ready Yet! Please Come Back Later :)");
    } else if (_createBoxType == BoxType.AppBox) {
      _pageContent = Text("AppBox");
    } else {
      _pageContent = _createUtilBoxContent(context, boxData);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Testing - Create Page"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Text("URL Box"),
                Radio(
                  value: BoxType.URLBox,
                  groupValue: _createBoxType,
                  activeColor: Colors.blue,
                  onChanged: _handleCreateBoxTypeChange,
                ),
                Text("App Box"),
                Radio(
                  value: BoxType.AppBox,
                  groupValue: _createBoxType,
                  activeColor: Colors.blue,
                  onChanged: _handleCreateBoxTypeChange,
                ),
                Text("Pre-made Box"),
                Radio(
                  value: BoxType.PreMadeBox,
                  groupValue: _createBoxType,
                  activeColor: Colors.blue,
                  onChanged: _handleCreateBoxTypeChange,
                ),
              ],
            ),
          ),
          Expanded(
            child: _pageContent,
          )
        ],
      ),
    );
  }
}
