import 'package:flutter/material.dart';

class CustomerDetail extends StatefulWidget {
  const CustomerDetail({super.key});

  @override
  _CustomerDetailState createState() => _CustomerDetailState();
}

class _CustomerDetailState extends State<CustomerDetail> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  bool isMoneyGiven = false;

  @override
  void dispose() {
    _dateController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void saveTransaction() {
    final name = _dateController.text;
    final amount = _amountController.text;

    if (name.isNotEmpty && amount.isNotEmpty) {
      final transaction = {
        'name': name,
        'amount': double.tryParse(amount) ?? 0.0,
        'isMoneyGiven': isMoneyGiven,
      };

      Navigator.pop(context, transaction);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customer Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Money Details',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isMoneyGiven = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isMoneyGiven ? Colors.green : Colors.grey,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text(
                    'Money Given',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isMoneyGiven = false; 
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: !isMoneyGiven ? Colors.red : Colors.grey,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text(
                    'Money to Give',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveTransaction,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 50.0),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Save Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
