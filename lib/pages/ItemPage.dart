import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoice_generator/model/item.dart';
import 'package:invoice_generator/redux/action.dart';
import 'package:invoice_generator/redux/app_state.dart';
import 'package:invoice_generator/util/widget_utils.dart';

class ItemPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ItemPageState();
  }
}

class ItemPageState extends State<ItemPage> {
  final _formKey = GlobalKey<FormState>();
  Item item = new Item();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Item"),
      ),
      body: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (storeContext, state) {
          return Container(
            child: Column(
              children: <Widget>[
                Flexible(flex: 8, child: _getItemsList(state)),
                Flexible(
                  flex: 1,
                  child: _getTotalCost(state),
                ),
                Flexible(
                    flex: 1,
                    child: RaisedButton(
                      child: Text("Press To Add Item"),
                      onPressed: () {
                        _openItemFormDialog(storeContext, state);
                      },
                    ))
              ],
            ),
          );
        },
      ),
    );
  }

  _getItemsList(state) {
    List<Item> items = state.invoice.items;
    return new ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext ctx, int index) {
          return _itemCard(items[index]);
        });
  }

  Widget _itemCard(Item item) {
    int itemPrice = item.cost * item.qty;
    return Card(
      child: Column(
        children: <Widget>[
          Table(
            columnWidths: {
              0: FractionColumnWidth(.26),
              1: FractionColumnWidth(.04),
              2: FractionColumnWidth(.7),
            },
            children: [
              WidgetUtil.inputLabelAsTableRpw("Name",Text(item.name)),
              WidgetUtil.inputLabelAsTableRpw("Description",Text(item.description)),
              WidgetUtil.inputLabelAsTableRpw("Cost",Text(item.cost.toString())),
              WidgetUtil.inputLabelAsTableRpw("Quantity",Text(item.qty.toString())),
              WidgetUtil.inputLabelAsTableRpw("Price",Text(itemPrice.toString()))
            ],
          ),
        ],
      ),
    );
  }

  _openItemFormDialog(stateContext, state) {
    showDialog(
        context: stateContext,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Item'),
            content: Form(
              key: _formKey,
              child: Container(
                height: (MediaQuery.of(context).size.height) / 3,
                child: Container(
                  child: _getItemFormFields(stateContext, state),
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                  item = new Item();
                },
              ),
              FlatButton(
                child: Text("Submit"),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    Navigator.of(context).pop();
                    StoreProvider.of<AppState>(stateContext)
                        .dispatch(AddItem(item));
                    item = new Item();
                  }
                },
              )
            ],
          );
        });
  }

  Widget _getItemFormFields(context, state) {
    String name = item.name != null ? item.name : "";

    String description = item.description != null ? item.description : "";

    int qty = item.qty != null ? item.qty : 0;

    int price = item.cost != null ? item.cost : 0;

    return ListView(
      children: <Widget>[
        WidgetUtil.formFieldsWrapper(getName(name, (val) {
          item.name = val;
        })),
        WidgetUtil.formFieldsWrapper(getDescription(description, (val) {
          item.description = val;
        })),
        WidgetUtil.formFieldsWrapper(
            getQuantity(qty.toString(), (val) {
          item.qty = int.parse(val);
        })),
        WidgetUtil.formFieldsWrapper(
            getPrice(price.toString(), (val) {
          item.cost = int.parse(val);
        }))
      ],
    );
  }

  Widget getName(String initialValue, Function function) {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          helperText: "Required",
          labelText: "Name"),
      autofocus: false,
      autovalidate: false,
      initialValue: initialValue,
      onSaved: (val) {
        function(val);
      },
      validator: (String val) {
        if (val.length < 3) {
          return "Please enter a valid name";
        }

        return null;
      },
    );
  }

  Widget getDescription(String initialValue, Function function) {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(), labelText: "Description"),
      autofocus: false,
      autovalidate: false,
      maxLines: 4,
      initialValue: initialValue,
      onSaved: (val) {
        function(val);
      },
      validator: (String val) {
        return null;
      },
    );
  }

  Widget getPrice(String initialValue, Function function) {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          helperText: "Required",
          labelText: "Price"),
      autofocus: false,
      keyboardType: TextInputType.number,
      autovalidate: false,
      initialValue: initialValue,
      onSaved: (val) {
        function(val);
      },
      validator: (String val) {
        return null;
      },
    );
  }

  Widget getQuantity(String initialValue, Function function) {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          helperText: "Required",
          labelText: "Quantity"),
      autofocus: false,
      keyboardType: TextInputType.number,
      autovalidate: false,
      initialValue: initialValue,
      onSaved: (val) {
        function(val);
      },
      validator: (String val) {
        if (int.parse(val) <= 0) {
          return "Quantity can not be less than or equal to zero";
        }
        return null;
      },
    );
  }

  _getTotalCost(AppState state) {
    List<Item> items = state.invoice.items;
    int sumOfProducts = 0;
    items.forEach((element) {
      sumOfProducts += element.qty * element.cost;
    });

    return Center(
      child: Text("Total price is " + sumOfProducts.toString()),
    );
  }
}
