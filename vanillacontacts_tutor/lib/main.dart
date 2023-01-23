import 'package:flutter/material.dart';
import 'package:vanillacontacts_tutor/entities/contact.dart';
import 'package:vanillacontacts_tutor/model/contact_book.dart';
import 'package:vanillacontacts_tutor/new_contact_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Flutter Demo Home Page'),
      routes: {
        "/new-contact": (_) => NewContactView(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactBook contactBook = ContactBook();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ValueListenableBuilder(
        valueListenable: contactBook,
        builder: (BuildContext context, List<Contact> value, Widget? child) {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              final contact = value[index];
              return Dismissible(
                onDismissed: (_) {
                  contactBook.remove(contact: contact);
                },
                key: ValueKey(contact.id),
                child: Material(
                  elevation: 6,
                  child: ListTile(
                    title: Text(contact.name),
                  ),
                ),
              );
            },
            itemCount: value.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).pushNamed('/new-contact');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
