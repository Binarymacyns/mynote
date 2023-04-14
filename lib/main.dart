import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notlar Uygulaması',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(key: UniqueKey(), title: 'Notlar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({required Key key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<String> _notes;

  @override
  void initState() {
    super.initState();
    _notes = [];
  }

  void _addNote(String note) {
    setState(() {
      _notes.add(note);
    });
  }

  void _deleteNote(String note) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Notu Sil'),
          content: Text('Bu notu silmek istediğinize emin misiniz?'),
          actions: [
            TextButton(
              child: Text('Vazgeç'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Sil'),
              onPressed: () {
                setState(() {
                  _notes.remove(note);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView.builder(
        itemCount: _notes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_notes[index]),
            onTap: () {
              _deleteNote(_notes[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNotePage(),
            ),
          ).then((note) {
            if (note != null) {
              _addNote(note);
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddNotePage extends StatefulWidget {
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  String _newNote = '';

  void _saveNote() {
    Navigator.pop(context, _newNote);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Yeni Not Ekle')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _newNote = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Notu Girin',
              ),
            ),
            ElevatedButton(
              onPressed: _saveNote,
              child: Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }
}