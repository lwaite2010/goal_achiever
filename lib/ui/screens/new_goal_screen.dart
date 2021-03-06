import 'package:accomplisher/app_state_container.dart';
import 'package:accomplisher/models/goals_model.dart';
import 'package:accomplisher/strings.dart';
import 'package:accomplisher/ui/scaffold.dart';
import 'package:accomplisher/ui/screens/add_action_steps_screen.dart';
import 'package:flutter/material.dart';

class NewGoalScreen extends StatelessWidget {
  static const String routeName = "/NewGoal";

  final InputDecoration _inputStyles =
    InputDecoration(
      labelText: "Goal Title",
      border: OutlineInputBorder()
    );

  void _saveGoal(context, title) {
    AppStateContainer.of(context).goalState.addGoal(Goal(title));
  }

  Widget _instructionText() => 
    Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        strings().setGoalInstructions
      )
    );

  Widget _goalTitleTextField(context) =>
    Padding(
      padding: EdgeInsets.all(10.0),
      child: TextFormField(
        decoration: _inputStyles,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
        },
        onSaved: (title) => _saveGoal(context, title),
      ),
    );

  Widget _submitButton(GlobalKey<FormState> formKey, BuildContext context) => 
    RaisedButton(
    onPressed: () {
      if (formKey.currentState.validate()) {
        formKey.currentState.save();
        Navigator.of(context).pushNamed(AddActionStepsScreen.routeName);             
      }
    },
    child: Text('Submit'),
  );

  Widget _newGoalForm(context) {
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _instructionText(),
          _goalTitleTextField(context),
          _submitButton(_formKey, context),
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return AScaffold(
      appBarTitle: strings().setNewGoal,
      body: _newGoalForm(context),
      backgroundColor: Colors.white,
    );
  }
}