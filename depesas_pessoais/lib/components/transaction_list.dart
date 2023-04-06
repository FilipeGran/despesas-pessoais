import 'package:depesas_pessoais/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  const TransactionList({
    super.key,
    required this.transactions,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctz, constrains) {
              return Column(
                children: [
                  Text(
                    'Vazio Primo',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: constrains.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final tr = transactions[index];
                    return Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 5),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.purple,
                          radius: 30,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: FittedBox(
                              child: Text('R\$ ${tr.value}'),
                            ),
                          ),
                        ),
                        title: Text(
                          tr.title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        subtitle: Text(
                          DateFormat('dd-MM-y').format(tr.date),
                        ),
                        trailing: MediaQuery.of(context).size.width > 480
                            ? TextButton.icon(
                                onPressed: () => onRemove(tr.id),
                                icon: const Icon(Icons.delete),
                                label: const Text(
                                  'Excluir',
                                ),
                                style: ButtonStyle(
                                  foregroundColor: MaterialStatePropertyAll(
                                      Theme.of(context).colorScheme.error),
                                ),
                              )
                            : IconButton(
                                onPressed: () => onRemove(tr.id),
                                icon: const Icon(Icons.delete),
                                color: Colors.red,
                              ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
}
