import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var goodsPriceController = TextEditingController();

  double vat = 0.00, covidLevy = 0.00, portCharges = 0.00, nhis = 0.00, totalCharges = 0.00;

  void calculateTaxes() {
    // Convert the inputed the value of goods to a double variable
    double goodsPrice = double.parse(goodsPriceController.text);
    
    // Calculate the taxes
    vat = goodsPrice * (10/100);
    covidLevy = goodsPrice * (2.5/100);
    portCharges = goodsPrice * (3/100);
    nhis = goodsPrice * (1/100);
    
    // Calculate the total charges
    totalCharges = vat + covidLevy + portCharges + nhis;
    
    // Refresh the UI
    setState(() { });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tax Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Enter value of goods:'),
            TextField(
              keyboardType: TextInputType.number,
              controller: goodsPriceController,
            ),
            const SizedBox(height: 20,),
            Center(
              child: ElevatedButton(
                onPressed: (){
                  if(goodsPriceController.text.isNotEmpty == true){
                    calculateTaxes();
                  }
                }, 
                child: const Text('Calculate Taxes'),
              ),
            ),
            const SizedBox(height: 30,),
            showTax(
              taxType: 'Value Added Tax (VAT):',
              taxValue: vat
            ),
            const SizedBox(height: 10,),
            showTax(taxType: 'COVID Levy:', taxValue: covidLevy),
            const SizedBox(height: 10,),
            showTax(taxType: 'Port Charges:', taxValue: portCharges),
            const SizedBox(height: 10,),
            showTax(
              taxType: 'NHIS (National Health Insurance Scheme):', 
              taxValue: nhis
            ),
            const SizedBox(height: 40,),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(
                    'Total Charges:',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                Text(
                  'GHS ${totalCharges.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.purple,
                    fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget showTax({required String taxType, required double taxValue}){ {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(taxType)),
        const SizedBox(width: 10,),
        Text(
          'GHS ${taxValue.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500
          ),
        )
      ],
    );
  }

  }
}