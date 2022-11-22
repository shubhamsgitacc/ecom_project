import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    var name = 'abhishek';
    var lastname = 'abhishek';
    // bool isignor = true;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actionsIconTheme: const IconThemeData(size: 10),
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Profile", style: TextStyle(color: Colors.green)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          InkWell(
            onTap: () {},
            child: Image.asset(
              'assests/images/Vector.png',
              height: 30,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: InkWell(
              onTap: () {},
              child: Image.asset('assests/images/appbarnoti.png'),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        // scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        height: 150,
                        width: MediaQuery.of(context).size.width / 2.5,
                        // color: Colors.amber,

                        child: Stack(children: [
                          Center(
                            child: CircleAvatar(
                              radius: 65,
                              backgroundColor: Colors.green[400],
                              child: const CircleAvatar(
                                radius: 60,
                                backgroundImage:
                                    AssetImage('assests/images/smile.jpg'),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(1, .7),
                            child: Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: const Offset(0, 0),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 197, 197, 197)),
                              ),
                              child: Center(
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.grey,
                                        size: 20,
                                      ))),
                            ),
                          )
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: const [
                            Text(
                              'First Name',
                            ),
                            Spacer(),
                            Spacer(),
                            Spacer(),

                            // Icon(Icons.edit,size: 18,color: Colors.grey,),
                            Spacer(),
                            Spacer(),
                            Spacer(), 
                            Text('Last Name'),
                            Spacer(),
                            Spacer(),
                            Spacer(),
                            Spacer(),
                            

                            // IconButton( onPressed:(){
                            //   setState(() {
                            //     isignor=false;
                            //   });
                            // } ,icon: Icon(Icons.edit,size: 18,color: Colors.grey,)),

                            Spacer()
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                              height: 55,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5)),
                              width: MediaQuery.of(context).size.width / 2.2,
                              child: Row(
                                children: [
                                  Center(
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 15),
                                      height: 40,
                                      width: MediaQuery.of(context).size.width /
                                          2.8,
                                      // color: Colors.amber,
                                      child: TextField(
                                        enableInteractiveSelection: false,
                                        autofocus: false,
                                        cursorHeight: .1,
                                        cursorWidth: .1,
                                        decoration: InputDecoration(
                                            hintText: lastname.toString(),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          const Spacer(),
                          Container(
                              height: 55,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5)),
                              width: MediaQuery.of(context).size.width / 2.2,
                              child: Row(
                                children: [
                                  Center(
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 15),
                                      height: 40,
                                      width: MediaQuery.of(context).size.width /
                                          2.8,
                                      // color: Colors.amber,
                                      child: IgnorePointer(
                                        ignoring: false,
                                        child: TextField(
                                          enableInteractiveSelection: false,
                                          cursorHeight: .1,
                                          cursorWidth: .1,
                                          autofocus: false,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: lastname.toString(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          // Container(
                          //   height: 70,                                        width: MediaQuery.of(context).size.width/2.3,
                          //   decoration: BoxDecoration(
                          //     color: Colors.white
                          //     ,border: Border.all(color: const Color.fromARGB(136, 189, 187, 187)),borderRadius: BorderRadius.circular(5),
                          //   ),
                          //   child: Container(
                          //     color: Colors.amber,
                          //     height: 40,
                          //     width: MediaQuery.of(context).size.width/5,
                          //     child:  const TextField(

                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: const [
                            Text('Email'),

                            Spacer()
                            // ,IconButton(onPressed: (){}, icon: const  Icon(Icons.edit,size: 18,color: Colors.grey,)),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4)),
                        height: 55,
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: Row(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(left: 10),
                                height: 40,
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: const TextField())
                          ],
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: const [
                              Text(
                            'Gender',
                          ),
                          Spacer(),
                          Spacer(),
                          Spacer(),

                          // Icon(Icons.edit,size: 18,color: Colors.grey,),
                          Spacer(),
                          Spacer(),
                          Spacer(), 
                          Text('Date of Birth'),
                          Spacer(),
                          Spacer(),
                          Spacer(),

                          // IconButton( onPressed:(){
                          //   setState(() {
                          //     isignor=false;
                          //   });
                          // } ,icon: Icon(Icons.edit,size: 18,color: Colors.grey,)),

                          Spacer()
                            ],
                          )),
                      Row(
                        children: [
                          Container(
                            // width: MediaQuery.of(context).size,

                            // color: Colors.amber,
                            height: 50,
                            // width: MediaQuery.of(context).size.width / 2.2,
                            child: Row(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Radio(
                                          value: 1,
                                          groupValue: idvals,
                                          onChanged: (value) {
                                            setState(() {
                                              idvals = value!;
                                            });
                                          }),
                                      Text('Male')
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Radio(
                                        value: 2,
                                        groupValue: idvals,
                                        onChanged: (value) {
                                          setState(() {
                                            idvals = value!;
                                          });
                                        }),
                                    Text('Female')
                                  ],
                                )
                              ],
                            ),
                          ),
                          const Spacer(),
                          Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width / 2.2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey)),
                            child: Row(
                              children: [
                                Spacer(),
                                Container(
                                  height: 50,
                                  width: 20,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(2)
                                    ],
                                  ),
                                ),
                                Text(' / '),
                                Container(
                                  height: 50,
                                  width: 20,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(2)
                                    ],
                                  ),
                                ),
                                Text(' / '),
                                Container(
                                  height: 50,
                                  width: 40,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(4)
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.calendar_month),
                                Spacer(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: const [
                              Text('Mobile no'),
                              Spacer(),
                            ],
                          )),
                      Container(
                        decoration: BoxDecoration(

                            // color: Colors.amber,

                            border: Border.all(color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(5)),
                        height: 52,
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 9),
                              child: Text(
                                '+91',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Image.asset(
                              'assests/images/line2.png',
                              height: 40,
                            ),
                            Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 55,
                                width: MediaQuery.of(context).size.width / 1.8,
                                // color: Colors.amber,

                                child: TextField(
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  scrollPadding:
                                      const EdgeInsets.only(bottom: 200),
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 150,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

int idvals = 1;

class Myval {
  String? valname;
  int? valid;
  Myval({this.valname, this.valid});
}

List<Myval> myvalues = [
  Myval(valname: 'male', valid: 1),
  Myval(valname: 'Female', valid: 2)
];
