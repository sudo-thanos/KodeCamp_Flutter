// import 'learn.dart';
import 'dart:io';

/**
 * THis is the Super class that all sub classes extends from.
 * It includes the name, price and category, all private, but exposed with getters. 
 * Also includes a displayMethod() method.
 */
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

/**
 * Subclass inheriting properties from MenuItem, but also adds
 * its own property, portionSize, with an override that prints extra properties
 * in the displayMethod.
 */
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

/**
 * Subclass inheriting properties from MenuItem, but also adds
 * its own properties, temperature and size with an override that prints the extra properties
 * in the displayMethod.
 */
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

/**
 * Order class is complex. It has properties and a list that tracks the menu
 * items in the order. It includes methosd that adds an item to the List, a method
 * that removes items from the array, which prints an error if item is not found,
 * a printBill function that prints the user's bill and clears the session for another
 * user.
 */
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

    print("Looking for: '$name'");
    print("Items in order:");

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
    print("\nCustomer: $_customerName");

    for (int i = 0; i < _items.length; i++) {
      _items[i].displayMethod();
    }

    print("Total ₦$_total");

    _items.clear();
    _total = 0;
  }
}

void main() {
  /**
   * THis is the list of menu items that my restruant has to offer
   */
  Food egusiSoup = Food('Egusi Soup', 3500, 'Main Course', 'large');
  Food friedPlantain = Food('Fried Plantain', 1500, 'Side Dish', 'medium');
  Food spaghetti = Food('Spaghetti', 2800, 'Main Course', 'large');
  Food noodles = Food('Noodles', 1800, 'Main Course', 'medium');

  Drink fanta = Drink('Fanta', 500, 'Fizzy', 'cold', 'small');
  Drink water = Drink('Water', 200, 'Beverage', 'hot', 'large');
  Drink pineappleJuice = Drink(
    'Pineapple Juice',
    800,
    'Juice',
    'cold',
    'medium',
  );

  // Gets users name dynamically. user enters his name on startup.
  stdout.write("Please Enter Your Name: ");
  String? customerName = stdin.readLineSync();

  Order order = Order(customerName!);

  /**
   * Rather than printing my menu everytime, I made it a function tht i can
   * call to print all my menu items anytime
   */
  void printMenu() {
    // Used Ai to structure this into table format
    print("\n=== MENU ===");
    print(
      "${'#'.padRight(5)}${'Name'.padRight(20)}${'Category'.padRight(15)}${'Price(₦)'.padRight(10)}${'Size'.padRight(10)}${'Temperature'.padRight(10)}",
    );
    print("-" * 72);
    stdout.write("1.   ");
    egusiSoup.displayMethod();
    stdout.write("2.   ");
    friedPlantain.displayMethod();
    stdout.write("3.   ");
    spaghetti.displayMethod();
    stdout.write("4.   ");
    noodles.displayMethod();
    stdout.write("5.   ");
    fanta.displayMethod();
    stdout.write("6.   ");
    water.displayMethod();
    stdout.write("7.   ");
    pineappleJuice.displayMethod();
  }

  while (true) {
    /**
     * This is the main menu, where the customer can selecct an input or exit the 
     * program.
     */
    print("\n=== RESTAURANT ORDER SYSTEM ===");
    print("1. View Menu");
    print("2. Add Item to Order");
    print("3. Remove Item from Order");
    print("4. Print Bill");
    print("5. Exit\n");
    stdout.write("=> ");
    String? choice = stdin.readLineSync();

    // print(choice);

    /**
     * This checks the users choices, and performs relevant operations based on 
     * the choice of the user. I also added a while loop so that the user can 
     * place all their orders before every goign back to the main menu. It also
     * prints an error if the selection is invalid. 
     * 
     * 0 - Takes you back to main menu.
     */
    if (choice == "1") {
      printMenu();
    } else if (choice == "2") {
      bool orderInProgress = true;

      while (orderInProgress == true) {
        printMenu();
        print("0. Done - Go back to main menu");

        stdout.write("\nEnter Order Number: ");
        String? itemChoice = stdin.readLineSync();
        // print(itemChoice);

        if (itemChoice == "0") {
          orderInProgress = false;
        } else if (itemChoice == "1") {
          order.addItem(egusiSoup);
          print("Egusi Soup added to order");
        } else if (itemChoice == "2") {
          order.addItem(friedPlantain);
          print("Fried Plantain added to order");
        } else if (itemChoice == "3") {
          order.addItem(spaghetti);
          print("Spaghetti added to order");
        } else if (itemChoice == "4") {
          order.addItem(noodles);
          print("Noodles added to order");
        } else if (itemChoice == "5") {
          order.addItem(fanta);
          print("Fanta added to order");
        } else if (itemChoice == "6") {
          order.addItem(water);
          print("Water Juice added to order");
        } else if (itemChoice == "7") {
          order.addItem(pineappleJuice);
          print("Pineapple Juice added to order");
        } else {
          print("Invalid order option!");
        }
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

/**
 * ToDo
 * Make remove item take number, so that I can check via index, because user might not type name exactly.
 * Make add order loop till they choose to exit - Done
 * Add Naira symbol to wherever there's money printed - Done
 * Collect customer name dynamically - Done
 * Add Comments to every major code block
 */
