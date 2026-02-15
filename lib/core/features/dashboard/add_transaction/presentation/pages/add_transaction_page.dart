import 'package:finance_treker/core/features/dashboard/domain/entities/transaction_entity.dart';
import 'package:finance_treker/core/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:finance_treker/core/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:finance_treker/core/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';


class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() =>
      _AddTransactionPageState();
}

class _AddTransactionPageState
    extends State<AddTransactionPage> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController =
      TextEditingController();

  final TextEditingController _amountController =
      TextEditingController();

  bool _isIncome = true;
  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = "General";

  final List<String> _categories = [
    "General",
    "Food",
    "Transport",
    "Salary",
    "Shopping",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1B),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                Row(
                  children: [
                    IconButton(
                      onPressed: () => context.go('/'),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Add Transaction",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _bankingTextField(
                        controller: _titleController,
                        label: "Title",
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty) {
                            return "Enter title";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      /// 🔹 Amount
                      _bankingTextField(
                        controller: _amountController,
                        label: "Amount",
                        keyboardType:
                            TextInputType.number,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return "Enter amount";
                          }
                          if (double.tryParse(value) ==
                              null) {
                            return "Invalid number";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<bool>(
                              activeColor:
                                  const Color(0xFF6D5DF6),
                              title: const Text(
                                "Income",
                                style: TextStyle(
                                    color: Colors.white),
                              ),
                              value: true,
                              groupValue: _isIncome,
                              onChanged: (value) {
                                setState(() {
                                  _isIncome =
                                      value ?? true;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<bool>(
                              activeColor:
                                  const Color(0xFF6D5DF6),
                              title: const Text(
                                "Expense",
                                style: TextStyle(
                                    color: Colors.white),
                              ),
                              value: false,
                              groupValue: _isIncome,
                              onChanged: (value) {
                                setState(() {
                                  _isIncome =
                                      value ?? false;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                   
                      DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        dropdownColor:
                            const Color(0xFF141427),
                        style: const TextStyle(
                            color: Colors.white),
                        decoration:
                            _inputDecoration("Category"),
                        items: _categories
                            .map((category) =>
                                DropdownMenuItem(
                                  value: category,
                                  child:
                                      Text(category),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory =
                                value!;
                          });
                        },
                      ),

                      const SizedBox(height: 20),

                   
                      ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(16),
                        ),
                        tileColor:
                            const Color(0xFF141427),
                        title: const Text(
                          "Date",
                          style: TextStyle(
                              color: Colors.white),
                        ),
                        subtitle: Text(
                          DateFormatter.formatShort(
                              _selectedDate),
                          style: const TextStyle(
                              color: Colors.grey),
                        ),
                        trailing: const Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                        ),
                        onTap: () async {
                          final picked =
                              await showDatePicker(
                            context: context,
                            initialDate:
                                _selectedDate,
                            firstDate:
                                DateTime(2020),
                            lastDate:
                                DateTime(2100),
                          );

                          if (picked != null) {
                            setState(() {
                              _selectedDate = picked;
                            });
                          }
                        },
                      ),

                      const SizedBox(height: 40),

                      /// 🔥 Save Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton
                              .styleFrom(
                            backgroundColor:
                                const Color(
                                    0xFF6D5DF6),
                            padding:
                                const EdgeInsets.all(
                                    16),
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(18),
                            ),
                          ),
                          onPressed: _saveTransaction,
                          child: const Text(
                            "Save",
                            style: TextStyle(
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _bankingTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      cursorColor: Colors.white,
      decoration: _inputDecoration(label),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        color: Colors.grey,
      ),
      filled: true,
      fillColor: const Color(0xFF141427),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Colors.grey.shade800,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Color(0xFF6D5DF6),
          width: 2,
        ),
      ),
    );
  }



  void _saveTransaction() {
    if (!_formKey.currentState!.validate()) return;

    final transaction = TransactionEntity(
      title: _titleController.text.trim(),
      amount: double.parse(
          _amountController.text.trim()),
      isIncome: _isIncome,
      date: _selectedDate,
      category: _selectedCategory,
    );

    context.read<DashboardBloc>().add(
          AddTransactionEvent(transaction),
        );

    context.go('/');
  }
}
