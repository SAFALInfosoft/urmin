class Item {
  String? itemCode;
  double? wspRate;
  double? gstPer;
  String? priceCalc;
  int? unitPerCarton;
  int? quantity;
  double? unitPerBox;
  double? schemeDisc;
  double? tradeDisc;
  double? otherDisc;

  Item({
     this.itemCode,
     this.wspRate,
     this.gstPer,
     this.priceCalc,
     this.unitPerCarton,
     this.quantity,
     this.unitPerBox,
     this.schemeDisc,
     this.tradeDisc,
     this.otherDisc,
  });
}



double calculateTotal(Item item) {
  double total;

  if (item.priceCalc == 'unit') {
    total = (item.unitPerCarton! * item.quantity! * item.wspRate!).roundToDouble();
  } else if (item.priceCalc == 'box') {
    total = ((item.quantity! * item.unitPerCarton! / item.unitPerBox!) * item.wspRate!).roundToDouble();
  } else {
    total = 0.0; // You may want to choose a default value or handle this case differently
  }

  return total;
}

void CalculateTotal() {
  // Example usage:
  Item item = Item(
    priceCalc: 'unit',
    unitPerCarton: 2,
    quantity: 5,
    wspRate: 10.0,
    unitPerBox: 3,
  );

  double total = calculateTotal(item);
  print('Total: $total');
}
double calculateGstCharge(Item item) {
  double gstCharge;

  if (item.priceCalc == 'unit') {
    gstCharge = ((
        ((item.unitPerCarton! * item.quantity! * item.wspRate!) -
            ((item.quantity! * item.unitPerCarton! / item.unitPerBox!) * item.schemeDisc!) -
            ((item.quantity! * item.unitPerCarton! / item.unitPerBox!) * item.tradeDisc!) -
            ((item.quantity! * item.unitPerCarton! / item.unitPerBox!) * item.otherDisc!)) *
            item.gstPer!) /
        100)
        .roundToDouble();
  } else if (item.priceCalc == 'box') {
    gstCharge = ((
        (((item.quantity! * item.unitPerCarton! / item.unitPerBox!) - item.schemeDisc!) -
            item.tradeDisc! -
            item.otherDisc!) *
            item.wspRate! *
            item.gstPer!) /
        100)
        .roundToDouble();
  } else {
    // Handle the case when priceCalc is neither 'unit' nor 'box'
    gstCharge = 0.0; // You may want to choose a default value or handle this case differently
  }

  return gstCharge;
}

void gstCharge() {
  // Example usage:
  Item item = Item(
    itemCode: 'ABC123',
    wspRate: 10.0,
    gstPer: 18.0,
    priceCalc: 'unit',
    unitPerCarton: 2,
    quantity: 5,
    unitPerBox: 3.0,
    schemeDisc: 1.0,
    tradeDisc: 2.0,
    otherDisc: 0.5,
  );

  double gstCharge = calculateGstCharge(item);
  print('GST Charge: $gstCharge');
}