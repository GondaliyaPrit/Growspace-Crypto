import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:growspacecrypto/Utils/Reponsive.dart';
import 'package:growspacecrypto/Utils/colors.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String screenname = "SellCrypto";
  bool sell = true;
  bool withdraw = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: black,
          ),
          onPressed: () {},
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Sell & Withdraw",
          style: TextStyle(color: black),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: Responsive.height(2, context),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: Responsive.height(7, context),
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          sell = true;
                          withdraw = false;
                          setState(() {});
                        },
                        child: Container(
                          child: Center(
                              child: Text(
                            "Sell Crypto Request",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: sell ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04),
                          )),
                          decoration: BoxDecoration(
                              color: sell ? black : Colors.transparent,
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          sell = false;
                          withdraw = true;
                          setState(() {});
                        },
                        child: Container(
                          child: Center(
                              child: Text(
                            "Withdraw Cash",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: withdraw ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04),
                          )),
                          decoration: BoxDecoration(
                              color: withdraw ? black : Colors.transparent,
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: sell ? Sell() : Withdraw(),
              ),
            )

          ],
        ),
      ),
    );
  }
}

class Sell extends StatefulWidget {
  const Sell({Key? key}) : super(key: key);

  @override
  State<Sell> createState() => _SellState();
}

class _SellState extends State<Sell> {
  final List<double> values = [10,25 ,100];
  int selectedIndex = 0;
  TextEditingController Amountcontroller = new TextEditingController();
  var amounterror ;




  Future<void> send(String amount) async {
    final Email email = Email(
      body: 'Growspace Crypto Total sell request  Amount '+amount +'\n\n\n Thank YOU :) ',
      subject: 'Sell Request ',
      recipients: ['sanketbutani01@gmail.com'],
      cc: ['sanketbutani01@gmail.com'],
      bcc: ['pritgondaliya.pro@gmail.com'],
      isHTML: false,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      print(error);
      platformResponse = error.toString();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.black12, borderRadius: BorderRadius.circular(10)),
            height: Responsive.height(20, context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Crypto Balance",
                        style: TextStyle(
                            color: black,
                            fontSize:
                                MediaQuery.of(context).size.width * 0.045),
                      ),
                      SizedBox(
                        height: Responsive.height(0.2, context),
                      ),
                      Text(
                        '\u{20B9}${35000}',
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.06),
                      ),
                      SizedBox(
                        height: Responsive.height(0.2, context),
                      ),
                      Text(
                        "in INR",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize:
                                MediaQuery.of(context).size.width * 0.038),
                      ),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  child: Image.asset("assets/sell.png"),
                )
              ],
            ),
          ),
          SizedBox(
            height: Responsive.height(2, context),
          ),
          Text(
            'How much want to sell ?',
            style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width * 0.05),
          ),
          SizedBox(
            height: Responsive.height(1, context),
          ),
          Text(
            'Slide and adjust Your amount ',
            style: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w500,
                fontSize: MediaQuery.of(context).size.width * 0.04),
          ),
          Slider(
            value: selectedIndex.toDouble(),
            min: 0,
            max: values.length -1,
            divisions: values.length - 1,
            label: values[selectedIndex].toString(),
            activeColor: black,
            inactiveColor: Colors.black26,
            onChanged: (double value) {
              setState(() {
                var amount ;
                selectedIndex = value.toInt();
                if(selectedIndex ==0)
                  {
                    amount =(35000*(10/100)).toString();
                  }
                if(selectedIndex ==1)
                {
                  amount =(35000*(25/100)).toString();
                }
                if(selectedIndex ==2)
                {
                  amount = (35000*(100/100)).toString();
                }
                Amountcontroller.text=amount.toString();
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 9,left: 9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("10%",style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045,fontWeight: FontWeight.bold),),
                Text("25%",style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045,fontWeight: FontWeight.bold),),
                Text("100%",style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045,fontWeight: FontWeight.bold),),
              ],
            ),
          ),
          TextFormField(
            style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.06),
            controller: Amountcontroller,
            keyboardType: TextInputType.number,
            decoration:   InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Amount',
              errorText: amounterror,
            ),
          ),
          SizedBox(
            height: Responsive.height(4, context),
          ),
          InkWell(
            onTap: ()  {
              String amount  = Amountcontroller.text;
              if(amount.isEmpty)
              {
                amounterror="Please Enter amount".toString();
                setState((){});
              }
              else
              {
                send(amount);
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.height * 1),
                color:  Colors.indigo,
              ),
              padding: EdgeInsets.all(Responsive.height(1.5, context)),
              child: Text(
                'Submit',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    color: Colors.white,
                    fontFamily: "poppinsmedium "),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Withdraw extends StatefulWidget {
  const Withdraw({Key? key}) : super(key: key);

  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {

  TextEditingController Amountcontroller = new TextEditingController();

  Future<void> send(String amount) async {
    final Email email = Email(
      body: 'Growspace Crypto Total Withdraw request  Amount '+amount +'\n\n\n Thank YOU :) ',
      subject: 'Withdraw Request ',
      recipients: ['sanketbutani01@gmail.com'],
      cc: ['sanketbutani01@gmail.com'],
      bcc: ['pritgondaliya.pro@gmail.com'],
      isHTML: false,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      print(error);
      platformResponse = error.toString();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }

var amounterror = "";



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.black12, borderRadius: BorderRadius.circular(10)),
            height: Responsive.height(20, context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Cash Balance",
                        style: TextStyle(
                            color: black,
                            fontSize:
                            MediaQuery.of(context).size.width * 0.045),
                      ),
                      SizedBox(
                        height: Responsive.height(0.2, context),
                      ),
                      Text(
                        '\u{20B9}${120000}',
                        style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.06),
                      ),
                      SizedBox(
                        height: Responsive.height(0.2, context),
                      ),
                      Text(
                        "in INR",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize:
                            MediaQuery.of(context).size.width * 0.038),
                      ),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  child: Image.asset("assets/with.png"),
                )
              ],
            ),
          ),
          SizedBox(
            height: Responsive.height(2, context),
          ),
          Text(
            'Withdraw Your amount ',
            style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width * 0.05),
          ),
          SizedBox(
            height: Responsive.height(1, context),
          ),
          Text(
            'You can here define Your Amount',
            style: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w500,
                fontSize: MediaQuery.of(context).size.width * 0.04),
          ),
          SizedBox(
            height: Responsive.height(4, context),
          ),
          TextFormField(
            controller: Amountcontroller,
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.06),
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Amount',
              errorText: amounterror,
            ),
          ),
          SizedBox(
            height: Responsive.height(4, context),
          ),
          InkWell(
            onTap: (){
              String amount  = Amountcontroller.text;
              if(amount.isEmpty)
                {
                  amounterror="Please Enter amount".toString();
                  setState((){});
                }
              else
                {
                  send(amount);
                }
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.height * 1),
                color:  Colors.indigo,
              ),
              padding: EdgeInsets.all(Responsive.height(1.5, context)),
              child: Text(
                'Submit',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    color: Colors.white,
                    fontFamily: "poppinsmedium "),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
