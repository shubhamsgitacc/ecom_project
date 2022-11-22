import 'package:flutter/material.dart';

class MyNoti extends StatefulWidget {
  const MyNoti({super.key});

  @override
  State<MyNoti> createState() => _MyNotiState();
}

List<String> viewd = [];

class _MyNotiState extends State<MyNoti> {
  Color actvclr = Color.fromARGB(181, 207, 240, 172);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(1000, 238, 238, 238),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                color: Colors.white,
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            IconData(
                              0xe793,
                              fontFamily: 'MaterialIcons',
                              matchTextDirection: true,
                            ),
                            color: Colors.green,
                            size: 30,
                          ),
                        ),
                        const Text(
                          'Notification',
                          style: TextStyle(
                              fontSize: 22,
                              color: Color.fromRGBO(0, 155, 55, 1)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: InkWell(
                            onTap: () {},
                            child: Image.asset(
                              'assests/images/carticn.png',
                              height: 25,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 15),
                          child: InkWell(
                            onTap: () {},
                            child: Image.asset(
                              'assests/images/bellicn.png',
                              height: 30,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                // color: Colors.amber,
                height: MediaQuery.of(context).size.height - 50,
                child: ListView.builder(
                  itemCount: notday.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.white),
                          height: 30,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, top: 4),
                            child: Text(notday[index].days.toString()),
                          ),
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: notdata.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  if (viewd.contains(
                                      notdata[index].title.toString())) {
                                    viewd.add(notdata[index].title.toString());
                                    print(viewd.toString());
                                  } else {
                                    viewd.add(notdata[index].toString());
                                    print(viewd.length);
                                  }
                                });
                              },
                              child: ListTile(
                                tileColor:
                                    viewd.contains(notdata[index].toString())
                                        ? Colors.grey
                                        : actvclr,
                                leading: const CircleAvatar(
                                  backgroundColor: Colors.green,
                                  child: Icon(Icons.notifications_active),
                                ),
                                title: Text(notdata[index].title.toString()),
                                subtitle:
                                    Text(notdata[index].subtitle.toString()),
                                onTap: () {},
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Notifications {
  String? days;
  final List<Notificationsdata>? notifi;
  Notifications({this.days, this.notifi});
}

class Notificationsdata {
  bool? tap;

  String? day, title, subtitle;
  Notificationsdata({this.day, this.tap, this.title, this.subtitle});
}

final List<Notifications> notday = [
  Notifications(days: 'yesterday'),
  Notifications(days: 'Today')
];
final List<Notificationsdata> notdata = [
  Notificationsdata(
      day: 'yesterday',
      tap: false,
      title: 'Hello this is product title',
      subtitle: 'hello this is subtitle yest'),
  Notificationsdata(
      day: 'yesterday',
      tap: false,
      title: 'Hello this is product title',
      subtitle: 'hello this is subtitle yest'),
  Notificationsdata(
      day: 'yesterday',
      tap: false,
      title: 'Hello this is product title',
      subtitle: 'hello this is subtitle today'),
  Notificationsdata(
      day: 'yesterday',
      tap: false,
      title: 'Hello this is product title',
      subtitle: 'hello this is subtitle yest today'),
];
