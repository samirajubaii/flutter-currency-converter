import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
void main()=> runApp(MyApp());
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
        home: Converter(),
    );
  }
}
class Converter extends StatefulWidget {
  const Converter({super.key});

  @override
  State<Converter> createState() => _converterState();
}

class _converterState extends State<Converter> {
  @override
  final List<String> currencies=
  [
    'US Dollar',
    'Euro',
    'Lebanese pound',
    'Saudi Riyal',
    'Kuwaiti Dinar',
    'UAE Dirham',
    'Egyptian pound',
  ];
  final Map<String, double> exchangeRates = {
    'US Dollar': 1.0, // Base currency is USD
    'Euro': 0.9451, // 1 USD = 0.92 Euro
    'Lebanese pound': 89000.0, // 1 USD = 1500 Lebanese pounds
    'Saudi Riyal': 3.76, // 1 USD = 3.75 Saudi Riyals
    'Kuwaiti Dinar': 0.31, // 1 USD = 0.31 Kuwaiti Dinars
    'UAE Dirham': 3.67, // 1 USD = 3.67 UAE Dirhams
    'Egyptian pound': 50.23, // 1 USD = 30 Egyptian pounds
  };
  double userInput=0;
  String? _startcurrency;
  String? _convertedcurrency;
  String _result = "";

  // Method to perform conversion
  void _convertCurrency() {
    if (_startcurrency == null || _convertedcurrency == null || userInput <= 0) {
      setState(() {
        _result = "Please provide valid input!";
      });
      return;
    }

    // Get exchange rates for selected currencies
    double fromRate = exchangeRates[_startcurrency!] ?? 1.0;
    double toRate = exchangeRates[_convertedcurrency!] ?? 1.0;

    // Convert from the starting currency to USD, then from USD to the target currency
    double amountInUSD = userInput / fromRate; // Convert to USD
    double convertedAmount = amountInUSD * toRate; // Convert to target currency

    // Update the result to display
    setState(() {
      _result = "$userInput ${_startcurrency} = ${convertedAmount.toStringAsFixed(2)} ${_convertedcurrency}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor:Colors.grey[600],
      body: Center(
        child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: [
              const Text('Currency' , style:TextStyle(
                fontSize: 45,color:Colors.white,fontWeight: FontWeight.w700
              ),),
              const Text('Converter!',style: TextStyle(
                  fontSize: 45,color:Colors.white,fontWeight: FontWeight.w700
              ),),
              const Text('Enter a number: ',style: TextStyle(
                  fontSize: 30,color:Colors.black87,fontWeight: FontWeight.w700
              ),),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 40),
                child: TextField(
                  onChanged: (text){
                    var i=double.tryParse(text);
                    if(i!=null)
                      setState(() {
                        userInput=i;
                      });
                  },
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black
                  ),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white54,
                    hintText: 'Enter your value',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 0,
              ),
              Text('From', style: TextStyle(color:Colors.black, fontSize:20,fontWeight:FontWeight.w700)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical:10, horizontal:40 ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value:_startcurrency,
                      isExpanded:true,
                      dropdownColor: Colors.black,
                      style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),
                      hint: Text('  Choose a currency',style: TextStyle(color:Colors.black87,fontWeight: FontWeight.w700,fontSize: 20)),
                      items: currencies.map((String value){
                                return DropdownMenuItem(value: value,
                                child: Text(value),);
                        }).toList(),
                                 onChanged:(value){
                        setState(() {
                          _startcurrency= value;
                        });
                                 },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 0,
              ),
              Text('To', style: TextStyle(color:Colors.black, fontSize:20,fontWeight:FontWeight.w700)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical:5, horizontal:40 ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value:_convertedcurrency,
                      isExpanded:true,
                      dropdownColor: Colors.black,
                      style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),
                      hint: Text('  Choose a currency',style: TextStyle(color:Colors.black87,fontWeight: FontWeight.w700,fontSize: 20)),
                      items: currencies.map((String value){
                        return DropdownMenuItem(value: value,
                          child: Text(value),);
                      }).toList(),
                      onChanged:(value){
                        setState(() {
                          _convertedcurrency = value;
                        });

                      },
                    ),
                  ),
                ),
              ),

              FloatingActionButton(
                onPressed: () {
                  _convertCurrency();
                },

                child: Container(width: double.infinity,
                  alignment: Alignment.center,
                  height: 70,
                  decoration: BoxDecoration(
                    color:Colors.black,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child:Text('Go', style:TextStyle(
                    fontWeight: FontWeight.w700,fontSize: 20,color: Colors.white
                  ),),
                ),
              ),

              Text('Result',style:TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600
              ),

              ),

              Container(
                alignment: Alignment.center,
                child: Text(
                  _result,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              )

            ],
          ),
        )
        ),
      )
    );
  }
}


