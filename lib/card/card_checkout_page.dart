import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:app/home/home_page.dart';

enum PaymentMethod { card, cash }

class CardCheckoutPage extends StatefulWidget {
  final String phone;
  final dynamic location;
  final double total;

  const CardCheckoutPage({
    super.key,
    required this.phone,
    required this.location,
    required this.total,
  });

  @override
  State<CardCheckoutPage> createState() => _CardCheckoutPageState();
}

class _CardCheckoutPageState extends State<CardCheckoutPage> {
  PaymentMethod _paymentMethod = PaymentMethod.card;

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final Color primaryGreen = const Color(0xFF74B625);

  void _onCreditCardModelChange(CreditCardModel data) {
    setState(() {
      cardNumber = data.cardNumber;
      expiryDate = data.expiryDate;
      cardHolderName = data.cardHolderName;
      cvvCode = data.cvvCode;
      isCvvFocused = data.isCvvFocused;
    });
  }

  void _processPayment() {
    if (_paymentMethod == PaymentMethod.card) {
      if (formKey.currentState!.validate()) {
        final maskedCard = cardNumber.length >= 4
            ? cardNumber.replaceRange(0, cardNumber.length - 4, '*' * (cardNumber.length - 4))
            : '****';

        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('confirm_payment'.tr()),
            content: Text('${'will_charge'.tr()} ${widget.total.toStringAsFixed(2)} EGP\n${'card_number'.tr()}: $maskedCard'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('cancel'.tr()),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showSuccessBanner();
                },
                child: Text('confirm'.tr()),
              ),
            ],
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('cash_payment'.tr()),
          content: Text('${'you_chose_cash'.tr()}\n${'total'.tr()}: ${widget.total.toStringAsFixed(2)} EGP'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('cancel'.tr()),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _showSuccessBanner();
              },
              child: Text('confirm'.tr()),
            ),
          ],
        ),
      );
    }
  }

  void _showSuccessBanner() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('order_placed_message'.tr()),
        backgroundColor: Colors.green[700],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Colors.green, width: 2),
        ),
        duration: const Duration(seconds: 3),
      ),
    );

    Future.delayed(const Duration(seconds: 3), () {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const HomePage()),
        (route) => false,
      );
    });
  }

  String _getLocationText() {
    if (widget.location is String) {
      return widget.location;
    } else {
      return widget.location.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2E3),
      appBar: AppBar(
        backgroundColor: primaryGreen,
        title: Text(
          'checkout'.tr(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoBox(icon: Icons.phone, label: 'phone'.tr(), value: widget.phone),
            const SizedBox(height: 12),
            _buildInfoBox(icon: Icons.location_on, label: 'address'.tr(), value: _getLocationText()),
            const SizedBox(height: 12),
            _buildInfoBox(icon: Icons.money, label: 'total'.tr(), value: '${widget.total.toStringAsFixed(2)} EGP'),
            const SizedBox(height: 25),

            Text(
              'payment_method'.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),

            RadioListTile(
              title: Text('credit_card'.tr()),
              value: PaymentMethod.card,
              groupValue: _paymentMethod,
              activeColor: primaryGreen,
              onChanged: (value) => setState(() => _paymentMethod = value!),
            ),
            RadioListTile(
              title: Text('cash_on_delivery'.tr()),
              value: PaymentMethod.cash,
              groupValue: _paymentMethod,
              activeColor: primaryGreen,
              onChanged: (value) => setState(() => _paymentMethod = value!),
            ),
            const SizedBox(height: 20),

            if (_paymentMethod == PaymentMethod.card) ...[
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                onCreditCardWidgetChange: (_) {},
              ),
              CreditCardForm(
                formKey: formKey,
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                onCreditCardModelChange: _onCreditCardModelChange,
              ),
            ],

            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: primaryGreen,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: _processPayment,
                icon: const Icon(Icons.check),
                label: Text(
                  _paymentMethod == PaymentMethod.card ? 'pay_now'.tr() : 'place_order'.tr(),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBox({required IconData icon, required String label, required String value}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFF74B625),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
        border: Border.all(color: primaryGreen, width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, color: primaryGreen),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(value, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
