import 'package:flutter/material.dart';

class LocalView extends StatelessWidget {
  const LocalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue[900],
          title: Text(
            "Crud Local",
            style: TextStyle(color: Colors.grey[200]),
          )),
      body: Container(
          margin: EdgeInsets.only(top: 8),
          child: ListView.separated(
              itemBuilder: (context, index) {
                return (ListTile(
                  onTap: () {},
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://cdn2.iconfinder.com/data/icons/linkedin-ui-flat/48/LinkedIn_UI-07-512.png")),
                        border: Border.all(color: Colors.black, width: 2)),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Nama",
                              style: TextStyle(fontSize: 19),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "example@yahoo.com",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[500]),
                            )
                          ]),
                      Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  padding: EdgeInsets.only(right: 8),
                                  constraints: BoxConstraints(),
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.remove_red_eye,
                                    color: Colors.blue[400],
                                  )),
                              IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red[400],
                                  ))
                            ]),
                      )
                    ],
                  ),
                ));
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                    height: 8,
                  ),
              itemCount: 2)),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.blue[900],
      ),
    );
  }
}
