import 'dart:io';

void main() {
  List<Map<String, dynamic>> product = [
    {'name': 'Olma', 'price': 12000, 'amount': 10, 'mass': 'KG'},
    {'name': 'Xurmo', 'price': 15000, 'amount': 40, 'mass': 'KG'},
    {'name': 'Suv', 'price': 5000, 'amount': 10, 'mass': '1L'},
    {'name': 'Uzum', 'price': 14000, 'amount': 25, 'mass': 'KG'},
    {'name': 'Ananas', 'price': 27000, 'amount': 5, 'mass': 'Dona'},
    {'name': 'Banan', 'price': 17000, 'amount': 15, 'mass': 'KG'},
  ];

  List<Map<String, dynamic>> promoCode = [
    {'title': 'SALOM', 'percent': 10, 'expire_date': '12-05-2024'},
    {'title': 'PROMO', 'percent': 15, 'expire_date': '29-03-2024'},
    {'title': 'BONUS', 'percent': 5, 'expire_date': '1-04-2024'}
  ];

  List<Map<String, dynamic>> cart = [];

  print("\nWelcome to Market\n");

  void display() {
    int productCount = 0;

    print("🍇 Fruits\n");

    product.forEach((element) {
      productCount++;
      print(
          """Product [$productCount]: Name: ${element['name']} | Price: ${element['price']} sum | Amount: ${element['amount']} | Mass: ${element['mass']}\n""");
    });

    print("🔸 Enter 'c' for showing Cart");
    print("🔸 Enter 'e' for Exit");

    stdout.write("\nChoose product: ");
    String? numberProduct = stdin.readLineSync();

    try {
      int.parse(numberProduct!);
    } catch (e) {
      if (numberProduct!.toLowerCase() == 'c') {
        print("\x1B[2J\x1B[0;0H");
        print("🛒 My Cart\n");
        int count = 0;
        num total = 0;
        cart.forEach((element) {
          total +=
              element['amount'] * product[element['product_number']]['price'];
          count++;
          print(
              "Product [$count]: Name: ${product[element['product_number']]['name']} | Amount: ${element['amount']} | Total price: ${element['amount'] * product[element['product_number']]['price']} sum");
        });

        print("\n💸 Total price $total sum\n");

        print("🔸 Enter 'b' for back");

        String outputText = cart.length == 0
            ? "Empyt, go back"
            : "Do you finish to buy? (y/n)";

        stdout.write("\n$outputText: ");
        String? userInput = stdin.readLineSync();

        if (userInput!.toLowerCase() == "y") {
          print("\x1B[2J\x1B[0;0H");
          print("🎫 Promocodes\n");
          stdout.write("Do you have a promocode (y/n): ");
          String? promo = stdin.readLineSync();

          if (promo!.toLowerCase() == "y") {
            print("\x1B[2J\x1B[0;0H");
            print("🎫 Promocodes\n");
            bool status = false;
            int percent = 0;
            void promoCheck() {
              stdout.write("Enter promocode: ");
              String? promocode = stdin.readLineSync();
              promoCode.forEach((element) {
                if (element['title'] == promocode!.toUpperCase()) {
                  status = true;
                  percent = element['percent'];
                }
              });
            }

            promoCheck();

            if (status) {
              cart.clear();
              total -= (total / 100) * percent;
              print("\x1B[2J\x1B[0;0H");
              print(
                  "😊 Thank you for your purchase. You bought with $percent % discount. You paid $total sum\n");
              display();
            } else {
              print("🚫 Promo code is wrong. Enter again!\n");
              promoCheck();
            }
          } else if (promo.toLowerCase() == "n") {
            cart.clear();
            print("\x1B[2J\x1B[0;0H");
            print("😊 Thank you for your purchase. You paid $total sum\n");
            display();
          }
        } else if (userInput.toLowerCase() == "n") {
          print("\x1B[2J\x1B[0;0H");
          print("🔸 You are back\n");
          display();
        } else if (userInput.toLowerCase() == 'b') {
          print("\x1B[2J\x1B[0;0H");
          print("🔸 You are back\n");
          display();
        }
      } else if (numberProduct.toLowerCase() == "e") {
        print("\nYou leaved!");
        exit(0);
      }
    }

    int intNumberProduct = int.parse(numberProduct) - 1;

    if (product[intNumberProduct]['amount'] == 0) {
      print("\x1B[2J\x1B[0;0H");
      print("🔸 ${product[intNumberProduct]['name']} is over!\n");
      display();
    }

    while (numberProduct == '' || product.length < intNumberProduct) {
      stdout.write("Enter valid number: ");
      String? numberProduct = stdin.readLineSync();

      if (numberProduct != null ||
          numberProduct != '' ||
          product.length < intNumberProduct) {
        break;
      }
    }

    stdout.write("Enter amount of ${product[intNumberProduct]['name']}: ");
    String? amount = stdin.readLineSync();

    int intAmount = int.parse(amount!);


    if (product[intNumberProduct]['amount'] >= intAmount) {
      Map<String, int> order = {
        'product_number': intNumberProduct,
        'amount': int.parse(amount)
      };

      cart.add(order);

      product[intNumberProduct]['amount'] -= intAmount;

      print("\x1B[2J\x1B[0;0H"); print("\x1B[2J\x1B[0;0H");
      print("🟢 ${product[intNumberProduct]['name']} added to Cart\n");
      display();
    } else {
      print("\x1B[2J\x1B[0;0H");
      print("🔸 No $amount product\n");
      display();
    }
  }

  display();
}
