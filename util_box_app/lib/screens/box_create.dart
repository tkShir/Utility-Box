import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';

import '../providers/box_info.dart';
import '../models/box_info.dart';
import 'home.dart';
import '../util/default_assets.dart';

class BoxCreatePage extends StatefulWidget {
  static const String pageRoute = 'createBox';

  BoxCreatePage();

  @override
  State<StatefulWidget> createState() {
    return _BoxCreatePageState();
  }
}

class _BoxCreatePageState extends State<BoxCreatePage> {
  BoxType _createBoxType;
  String _categoryDropDownChoice = '';
  String _appDropDownChoice = '';
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
      initialValue: _formData['boxTitle'],
      validator: (String value) {
        // if (value.trim().length <= 0) {
        if (value.isEmpty) {
          return 'Title is required';
        }
      },
      onSaved: (String value) {
        _formData['boxTitle'] = value;
      },
    );
  }

  Widget _buildBoxColorField(BuildContext context) {
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

  Widget _buildTextColorField(BuildContext context) {
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
            icon: Icon(_defaultIconChoice[_categoryDropDownChoice]),
            labelText: 'Categories',
          ),
          isEmpty: _categoryDropDownChoice == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _categoryDropDownChoice,
              isDense: true,
              onChanged: (String newValue) {
                setState(() {
                  _categoryDropDownChoice = newValue;
                  _formData["iconData"] =
                      _defaultIconChoice[_categoryDropDownChoice];
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
      initialValue: _formData['boxUrl'],
      validator: (String value) {
        if (_createBoxType == BoxType.URLBox) {
          if (value.isEmpty ||
              !RegExp(r'https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)')
                  .hasMatch(value)) {
            return 'Box URL is required and has to be a valid URL';
          }
        }
      },
      onSaved: (String value) {
        _formData['boxUrl'] = value;
      },
    );
  }

  Widget _buildAppSelectionField() {
    bool _hasError = false;
    String _errorMsg;
    return FormField<String>(
      validator: (String value) {
        if (_appDropDownChoice == '') {
          _hasError = true;
          _errorMsg = 'Please select an application';
          return;
        }
        _hasError = false;
        _errorMsg = '';
      },
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
            icon: Icon(defaultAppsInfo[_appDropDownChoice].iconData),
            labelText: 'App',
          ),
          isEmpty: _appDropDownChoice == '',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _appDropDownChoice,
                  isDense: true,
                  onChanged: (String newValue) {
                    setState(() {
                      if (newValue != '') {
                        _hasError = false;
                      }
                      _appDropDownChoice = newValue;
                      _formData['boxTitle'] =
                          defaultAppsInfo[_appDropDownChoice].boxTitle;
                      _formData['boxUrl'] =
                          defaultAppsInfo[_appDropDownChoice].boxUrl;
                      _formData["iconData"] =
                          defaultAppsInfo[_appDropDownChoice].iconData;
                    });
                  },
                  items: defaultApps.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Text(
                _hasError ? _errorMsg : '',
                style:
                    TextStyle(color: Colors.redAccent.shade700, fontSize: 12.0),
              )
            ],
          ),
        );
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
    Navigator.of(context).pushReplacementNamed(HomePage.pageRoute);
  }

  Widget _buildEditButton(boxData, int index) {
    return RaisedButton(
      child: Text('Save'),
      textColor: Colors.white,
      onPressed: () {
        _editForm(boxData, index);
      },
    );
  }

  void _editForm(BoxInfoProvider boxData, int index) {
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
    boxData.editBox(createdBoxInfo, index);
    Navigator.of(context).pushReplacementNamed(HomePage.pageRoute);
  }

  @override
  void initState() {
    if (_createBoxType == null) {
      _createBoxType = BoxType.URLBox;
    }

    super.initState();
  }

  Widget _createAppBoxContent(BuildContext context, BoxInfoProvider boxData,
      bool editingBox, int index) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10),
            children: <Widget>[
              _buildAppSelectionField(),
              _buildBoxColorField(context),
              SizedBox(height: 10.0),
              _buildTextColorField(context),
              SizedBox(height: 10.0),
              editingBox
                  ? _buildEditButton(boxData, index)
                  : _buildSubmitButton(boxData),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createUrlBoxContent(BuildContext context, BoxInfoProvider boxData,
      bool editingBox, int index) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10),
            children: <Widget>[
              _buildTitleTextField(),
              SizedBox(height: 10.0),
              _buildBoxColorField(context),
              SizedBox(height: 10.0),
              _buildTextColorField(context),
              _buildIconField(),
              _buildURLTextField(),
              SizedBox(height: 10.0),
              editingBox
                  ? _buildEditButton(boxData, index)
                  : _buildSubmitButton(boxData),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createPreMadeBoxContent() {
    return Text("Create PreMade Box");
  }

  void _handleCreateBoxTypeChange(BoxType type) {
    setState(() {
      _createBoxType = type;
    });
  }

  Widget _buildBoxTypeRadioButton() {
    return Padding(
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
    );
  }

  Widget _buildPageContent(Widget body) {
    return Column(
      children: <Widget>[
        _buildBoxTypeRadioButton(),
        body,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    BoxInfo initialBox;
    int initialBoxIndex;
    bool _editingBox = false;

    final Map<String, dynamic> navArgs =
        ModalRoute.of(context).settings.arguments;
    if (navArgs != null) {
      initialBox = navArgs['boxInfo'];
      initialBoxIndex = navArgs['index'];
      _editingBox = true;
    }
    if (initialBox != null && _formData['boxTitle'] == null) {
      _formData['boxTitle'] = initialBox.boxTitle;
      _formData['textColor'] = initialBox.textColor;
      _formData['boxColor'] = initialBox.boxColor;
      _formData['iconData'] = initialBox.iconData;
      _formData['boxUrl'] = initialBox.boxUrl;
      _createBoxType = initialBox.boxType;
      if (_createBoxType == BoxType.AppBox) {
        _appDropDownChoice = _formData['boxTitle'];
      }
    }
    final BoxInfoProvider boxData = Provider.of<BoxInfoProvider>(context);
    Widget body;
    if (_createBoxType == BoxType.PreMadeBox) {
      body = _createPreMadeBoxContent();
    } else if (_createBoxType == BoxType.AppBox) {
      body =
          _createAppBoxContent(context, boxData, _editingBox, initialBoxIndex);
    } else {
      body =
          _createUrlBoxContent(context, boxData, _editingBox, initialBoxIndex);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Testing - Create Page"),
      ),
      body: _buildPageContent(body),
    );
  }
}
