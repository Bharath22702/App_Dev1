
import 'package:flutter/material.dart';
import 'package:hydrogen/util/hexcolor.dart';

class BillSplitter extends StatefulWidget {
  const BillSplitter({Key? key}) : super(key: key);

  @override
  State<BillSplitter> createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  int _tipPercentage = 0;
  int _personCounter = 1;
  double _billAmount = 0.0;

  Color _purple = HexColor("#6908D6");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: [
            Container(
              width: 150,
              height: 200,
              decoration: BoxDecoration(
                color: _purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("Total Per Person",
                      style: TextStyle(
                      fontWeight: FontWeight.normal,
                        fontSize: 17.0,
                        color: _purple,
                      ),),
                    ),
                    Text("\$ ${calculateTotalPerPerson(_tipPercentage, _billAmount, _personCounter)}",
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: _purple,
                    ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: _purple,
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(
                      color:_purple,),
                    decoration: InputDecoration(
                      prefixText: "Bill Amount ",
                        prefixIcon: Icon(Icons.attach_money),
                    ),

                    onChanged: (String value){
                      try{
                        setState(() {
                          _billAmount = double.parse(value);
                        });

                      }catch(exception ){
                        _billAmount = 0.0;
                      }
                    },
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Split", style: TextStyle(
                        color: Colors.grey.shade700,
                      ),
                      ),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_personCounter > 1) {
                                  _personCounter--;
                                }
                              }
                              );
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: _purple.withOpacity(0.1),
                              ),
                              child: Center(
                                child: Text(
                                  "-", style: TextStyle(
                                  color: _purple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0,
                                ),
                                ),
                              ),
                            ),
                          ),
                          Text("$_personCounter", style: TextStyle(
                            color: _purple,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                _personCounter++;
                              });
                            },
                            child: Container(
                               width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: _purple.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                              child: Center(
                                child: Text("+",
                                style: TextStyle(
                                  color: _purple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0,
                                ),),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget> [
                      Text("Tip",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("\$ ${calculateTotalTip(_billAmount, _personCounter, _tipPercentage)}",
                        style: TextStyle(
                          color: _purple,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text("$_tipPercentage%",
                        style: TextStyle(
                          color: _purple,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Slider(
                        min: 0.0,
                          max: 100.0,
                          activeColor: _purple,
                          inactiveColor: Colors.grey,
                          divisions: 10,
                          value: _tipPercentage.toDouble(),
                          onChanged: (double newValue){
                          setState(() {
                            _tipPercentage= newValue.round();
                          });
                          }

                      )
                    ],
                  )
                  ],
              ),
            )
          ],
        ),
      ),
    );
  }

  calculateTotalPerPerson(int tipPercentage, double billAmount, int splitBy){
  var totalPerPerson = ( billAmount*tipPercentage/100 + billAmount)/splitBy;
  return totalPerPerson;

  }
  calculateTotalTip(double billAmount, int splitBy, int tipPercentage){
  double totatTip = 0.0;

  if(billAmount<0 || billAmount.toString().isEmpty || billAmount == null){
//no go!
  debugPrint("Not Possible");
  }
  else{
    totatTip = billAmount*tipPercentage/100;
  }

  return totatTip;
  }
}
