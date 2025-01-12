import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata_book/constants/constants.dart';
import 'package:khata_book/model/transaction_model.dart';
import 'package:khata_book/screens/add/transactions/controller/add_transaction_controller.dart';

class AddTransactionDetailScreen extends StatefulWidget {
  final TransactionModel? transaction;

  const AddTransactionDetailScreen({super.key, this.transaction});

  @override
  _AddTransactionDetailScreenState createState() =>
      _AddTransactionDetailScreenState();
}

class _AddTransactionDetailScreenState
    extends State<AddTransactionDetailScreen> {
  final controller = Get.put(AddTransactionController());

  @override
  void initState() {
    super.initState();
    controller.initialize(transaction: widget.transaction);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void saveTransaction() async {
    final success = await controller.saveTransaction();
    if (success == true) {
      Get.back(result: success);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text(AddTransactionConstants.transactionDetails)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                AddTransactionConstants.moneyDetails,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  labelText: AddTransactionConstants.name,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller.descriptionController,
                decoration: InputDecoration(
                  labelText: AddTransactionConstants.description,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller.amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: AddTransactionConstants.amount,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        controller.moneyGiven = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          controller.moneyGiven ? Colors.green : Colors.grey,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: const Text(
                      AddTransactionConstants.moneyGiven,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        controller.moneyGiven = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          !controller.moneyGiven ? Colors.red : Colors.grey,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: const Text(
                      AddTransactionConstants.moneyToGive,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: saveTransaction,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 8, 205, 235),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 50.0),
                    elevation: 8,
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  child: const Text(
                    AddTransactionConstants.saveTransaction,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
