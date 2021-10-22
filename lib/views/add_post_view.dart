import 'package:flutter/material.dart';

class AddPostView extends StatelessWidget {
  const AddPostView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              hintText: 'Add Post Title'
            )
            ),
            const SizedBox(height: 16,),
            TextFormField(maxLines: 5,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Add Post Description'
            ),),
            const Spacer(),
            Row(
              children: [
                Expanded(child: ElevatedButton(onPressed: (){}, child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Save', style: TextStyle(fontSize: 16),),
                ))),
              ],
            )
          ]
        ),
      ),
    );
  }
}