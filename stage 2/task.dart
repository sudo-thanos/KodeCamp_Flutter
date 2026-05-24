// import 'learn.dart';
import 'dart:io';

class MenuItem {
  String _name;
  double _price;
  String _category;

  MenuItem(this._name, this._price, this._category);

  String get name => _name;
  double get price => _price;
  String get category => _category;

  void displayMethod() {
    print(name);
    print(category);
    print(price);
  }
}

class Food extends MenuItem {
  String portionSize;

  Food(String name, double price, String category, this.portionSize)
    : super(name, price, category);

  @override
  void displayMethod() {
    print(
      "${name.padRight(20)}${category.toString().padRight(15)}${price.toString().padRight(10)}${portionSize.padRight(10)}",
    );
  }
}

class Drink extends MenuItem {
  // bool isCold;
  String temperature; // Cole or hot
  String size;

  Drink(String name, double price, String category, this.temperature, this.size)
    : super(name, price, category);

  @override
  void displayMethod() {
    print(
      "${name.padRight(20)}${category.padRight(15)}${price.toString().padRight(10)}${size.padRight(10)}${temperature.padRight(10)}",
    );
  }
}

class Order {
  String _customerName;
  List<MenuItem> _items = [];
  double _total = 0;

  Order(this._customerName);

  String get customerName => _customerName;
  List<MenuItem> get items => _items;
  double get total => _total;

  void addItem(MenuItem item) {
    _items.add(item);
    _total += item.price;
  }

  void removeItem(String name) {
    bool found = false;
    // String itemName;

    for (int i = 0; i < _items.length; i++) {
      if (_items[i].name == name) {
        String itemName = _items[i].name;

        print("Found ${_items[i].name}");
        _total -= _items[i].price;
        _items.remove(_items[i]);
        print("Removed $itemName from order");
        found = true;
        break;
      }
    }

    if (found == false) {
      print("Couldn't find item in list!");
    }
  }

  void printBill() {
    print("Customer: $_customerName");

    for (int i = 0; i < _items.length; i++) {
      _items[i].displayMethod();
    }

    print("Total $_total");

    _items.clear();
    _total = 0;
  }
}

/**
 * Remove Item Method
    Create a method removeItem(String name) that searches _items by name using a loop:
    If found, subtract the item price from _total, remove it from the list, and print a success message
    If not found, print an error message  
 */

void main() {
  Food jollofRice = Food('Jollof Rice', 2500, 'Main Course', 'large');
  Food friedRice = Food('Fried Rice', 2200, 'Main Course', 'medium');
  Food pepperSoup = Food('Pepper Soup', 3000, 'Dessert', 'small');
  Drink coldCoke = Drink('Coke', 500, 'Fizzy', 'cold', 'small');
  Drink hotTea = Drink('Tea', 400, 'tea', 'hot', 'medium');
  Drink coldJuice = Drink('Orange Juice', 700, 'juice', 'cold', 'large');

  Order order = Order("Daniel"); // change to get customer name

  void printMenu() {
    // Used Ai to structure this into table format
    print("\n=== MENU ===");
    print(
      "${'#'.padRight(5)}${'Name'.padRight(20)}${'Category'.padRight(15)}${'Price'.padRight(10)}${'Size'.padRight(10)}${'Temperature'.padRight(10)}",
    );
    print("-" * 72);
    stdout.write("1.   ");
    jollofRice.displayMethod();
    stdout.write("2.   ");
    friedRice.displayMethod();
    stdout.write("3.   ");
    pepperSoup.displayMethod();
    stdout.write("4.   ");
    coldCoke.displayMethod();
    stdout.write("5.   ");
    hotTea.displayMethod();
    stdout.write("6.   ");
    coldJuice.displayMethod();
  }

  while (true) {
    print("\n=== RESTAURANT ORDER SYSTEM ===");
    print("1. View Menu");
    print("2. Add Item to Order");
    print("3. Remove Item from Order");
    print("4. Print Bill");
    print("5. Exit");
    stdout.write("=> ");
    String? choice = stdin.readLineSync();

    // print(choice);

    if (choice == "1") {
      printMenu();
    } else if (choice == "2") {
      printMenu();

      stdout.writeln("\nEnter order number: ");
      String? itemChoice = stdin.readLineSync();
      print(itemChoice);

      if (itemChoice == "1") {
        order.addItem(jollofRice);
        print("Jollof Rice added to order");
      } else if (itemChoice == "2") {
        order.addItem(friedRice);
        print("Fried Rice added to order");
      } else if (itemChoice == "3") {
        order.addItem(pepperSoup);
        print("Pepper Soup added to order");
      } else if (itemChoice == "4") {
        order.addItem(coldCoke);
        print("Cold Coke added to order");
      } else if (itemChoice == "5") {
        order.addItem(hotTea);
        print("Hot Tea added to order");
      } else if (itemChoice == "6") {
        order.addItem(coldJuice);
        print("Cold Juice added to order");
      } else {
        print("Invalid order option!");
      }
    } else if (choice == "3") {
      stdout.write("Enter item number to remove: ");
      String? itemName = stdin.readLineSync();
      order.removeItem(itemName!);
    } else if (choice == "4") {
      order.printBill();
    } else if (choice == "5") {
      print("Goodbye!");
      break;
    } else {
      print("Invalid selection");
    }
  }
}

// Make remove item take number, so that I can check via index, because user might not type name exactly.

// Make add order loop till they choose to exit
