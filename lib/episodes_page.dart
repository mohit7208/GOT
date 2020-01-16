//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:got/got.dart';

class EpisodesPage extends StatelessWidget {
  final List<Episodes> episodes;
  final MyImage image;
  BuildContext _context;
  EpisodesPage({this.episodes, this.image});
   showSummary(String summary){
     showDialog(context: _context,builder: (context)=>
     Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
         child: Padding(
           padding: const EdgeInsets.all(18.0),
           child: Text(summary),
         ),
       ),
            ),
     ));
  }

  Widget myBody() {
    
    return GridView.builder(
      
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1.0),
      itemCount: episodes.length,
      
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
          child: InkWell(
            
            onTap: (){
              showSummary(episodes[index].summary);
            },
                    child: Card(
                      
              child: Stack(
                
                fit: StackFit.expand,
                children: <Widget>[
                  Image.network(
                    episodes[index].image.original,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          episodes[index].name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    child: Container(
                      //color: Colors.pinkAccent,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0),color: Colors.pinkAccent),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'S0${episodes[index].season}-E${episodes[index].number}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    right: 0.0,
                    top: 0.0,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _context=context;
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: <Widget>[
          Hero(
            tag: 'g1',
            child: CircleAvatar(
              backgroundImage: NetworkImage(image.medium),
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
          Text('All Episodes'),
        ],
      ),
      ),
      body: myBody(),
    );
  }
}
