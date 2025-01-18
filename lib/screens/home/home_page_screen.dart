import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata_book/screens/add/transactions/add_transaction_details_screen.dart';
import 'package:khata_book/screens/home/controller/transaction_list_controller.dart';
import 'package:khata_book/screens/home/search_page.dart';
import 'package:khata_book/screens/home/widget/transaction_list.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int selectedIndex = 0;
  VoidCallback? refreshTransactionList;

  final TransactionListController controller =
      Get.put(TransactionListController());

  @override
  void initState() {
    super.initState();
    controller.fetchAllTransactions();
  }

  Widget pageContent() {
    switch (selectedIndex) {
      case 0:
        return TransactionList(
          reserveCallback: (refreshTransactionList) {
            this.refreshTransactionList = refreshTransactionList;
          },
        );
      case 1:
        return SearchPage(
          reserveCallback: (refreshTransactionList) {
            this.refreshTransactionList = refreshTransactionList;
          },
        );
      case 2:
        return const Center(child: Text('App Info'));
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Khata Book', style: TextStyle(fontSize: 26)),
      ),
      body: Column(
        children: [
          // Add Obx to make the UI reactive and update when data changes
          Obx(() {
            final totalMoneyGiven = controller.totalMoneyGiven;
            final totalMoneyToGive = controller.totalMoneyToGive;
            return selectedIndex == 0
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('Money Given',
                                style: TextStyle(fontSize: 18)),
                            Text(
                              '+ ₹${totalMoneyGiven.toStringAsFixed(1)}',
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.green),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('Money To Give',
                                style: TextStyle(fontSize: 18)),
                            Text(
                              '- ₹${totalMoneyToGive.toStringAsFixed(1)}',
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.red),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('Total', style: TextStyle(fontSize: 18)),
                            Text(
                              '₹${(totalMoneyGiven - totalMoneyToGive).toStringAsFixed(1)}',
                              style: TextStyle(
                                fontSize: 20,
                                color: (totalMoneyGiven - totalMoneyToGive) >= 0
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : SizedBox
                    .shrink(); // Return empty container if not on the correct page
          }),

          Expanded(child: pageContent()),
        ],
      ),
      floatingActionButton: selectedIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () async {
                final refresh =
                    await Get.to(const AddTransactionDetailScreen());
                if (refresh == true) {
                  refreshTransactionList?.call();
                }
              },
              label: const Text('Add Transaction'),
              icon: const Icon(Icons.person_add),
            )
          : null,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: const Color.fromARGB(255, 212, 192, 243),
        height: 55.0,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const <Widget>[
          Icon(Icons.home_outlined, size: 30),
          Icon(Icons.search_sharp, size: 30),
          Icon(Icons.info_outlined, size: 30),
        ],
      ),
    );
  }
}
 