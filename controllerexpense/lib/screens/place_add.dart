import 'package:flutter/material.dart';
import '../widgets/image_input.dart';
class AddPlace extends StatefulWidget {
  const AddPlace({Key? key})
      : super(key: key); //beacuse we will add this later to our routes table
  @override
  State<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  final _titleController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new hairSaloon'),
      ),
      body: Column(
        // we romeved main axis alinment because we useed exapnded which will enable first child to take all height it can get, but will leaved"Add place button the required space it needs" , mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    controller: _titleController,
                  ),
                  SizedBox(height: 10,),//to store our preview and take picture
                  ImageInput(),  
                  ],
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              MaterialPageRoute(builder: (context) => AddPlace());
            },
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            // ignore: deprecated_member_use
          )
        ],
      ),
    );
  }
}
