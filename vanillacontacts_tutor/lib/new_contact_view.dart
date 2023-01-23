import 'package:flutter/material.dart';
import 'package:vanillacontacts_tutor/entities/contact.dart';
import 'package:vanillacontacts_tutor/model/contact_book.dart';

class NewContactView extends StatefulWidget {
  const NewContactView({Key? key}) : super(key: key);

  @override
  State<NewContactView> createState() => _NewContactViewState();
}

class _NewContactViewState extends State<NewContactView> {
  late final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new contact'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(hintText: "Enter contact name"),
          ),
          TextButton(
            onPressed: () {
              ContactBook().add(contact: Contact(name: _nameController.text));
              Navigator.of(context).pop();
            },
            child: Text("Add contact"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
