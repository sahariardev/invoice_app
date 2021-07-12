import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoice_generator/model/item.dart';
import 'package:invoice_generator/redux/action.dart';
import 'package:invoice_generator/redux/app_state.dart';
import 'package:invoice_generator/util/constants.dart';
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
        title: Text(ITEM),
      ),
      body: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (storeContext, state) {
          return new Column(
            children: <Widget>[
              Flexible(flex: 8, child: _getItemsList(state, storeContext)),
              Flexible(
                flex: 1,
                child: _getTotalCost(state),
              ),
              Flexible(
                  flex: 1,
                  child: WidgetUtil.getCustomButton(
                      ITEM_ADD, () => _openItemFormDialog(storeContext, state)))
            ],
          );
        },
      ),
    );
  }

  _getItemsList(state, storeContext) {
    List<Item> items = state.invoice.items;
    return new ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext ctx, int index) {
          return _getDismissableItemCard(items[index], storeContext, state);
        });
  }

  _getDismissableItemCard(Item item, storeContext, state) {
    return Dismissible(
      key: Key(item.hashCode.toString()),
      onDismissed: (direction) {
        StoreProvider.of<AppState>(storeContext).dispatch(RemoveItem(item));
      },
      child: GestureDetector(
        child: _itemCard(item),
        onTap: () {
          this.item = item;
          _openItemFormDialog(storeContext, state);
        },
      ),
    );
  }

  Widget _itemCard(Item item) {
    int itemPrice = item.cost * item.qty;
    return WidgetUtil.getCustomCard(
      Column(
        children: <Widget>[
          Table(
            columnWidths: {
              0: FractionColumnWidth(.26),
              1: FractionColumnWidth(.04),
              2: FractionColumnWidth(.7),
            },
            children: [
              WidgetUtil.inputLabelAsTableRpw(NAME, Text(item.name)),
              WidgetUtil.inputLabelAsTableRpw(
                  DESCRIPTION, Text(item.description)),
              WidgetUtil.inputLabelAsTableRpw(COST, Text(item.cost.toString())),
              WidgetUtil.inputLabelAsTableRpw(
                  QUANTITY, Text(item.qty.toString())),
              WidgetUtil.inputLabelAsTableRpw(PRICE, Text(itemPrice.toString()))
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
            title: Text(ITEM),
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
                child: Text(BUTTON_CANCEL),
                onPressed: () {
                  Navigator.of(context).pop();
                  item = new Item();
                },
              ),
              FlatButton(
                child: Text(BUTTON_SUBMIT),
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
        WidgetUtil.formFieldsWrapper(getQuantity(qty.toString(), (val) {
          item.qty = int.parse(val);
        })),
        WidgetUtil.formFieldsWrapper(getPrice(price.toString(), (val) {
          item.cost = int.parse(val);
        }))
      ],
    );
  }

  Widget getName(String initialValue, Function function) {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(), helperText: REQUIRED, labelText: NAME),
      autofocus: false,
      autovalidate: false,
      initialValue: initialValue,
      onSaved: (val) {
        function(val);
      },
      validator: (String val) {
        if (val.length < 3) {
          return VALIDATION_NAME;
        }

        return null;
      },
    );
  }

  Widget getDescription(String initialValue, Function function) {
    return TextFormField(
      decoration:
          InputDecoration(border: OutlineInputBorder(), labelText: DESCRIPTION),
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
          border: OutlineInputBorder(), helperText: REQUIRED, labelText: PRICE),
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
          helperText: REQUIRED,
          labelText: QUANTITY),
      autofocus: false,
      keyboardType: TextInputType.number,
      autovalidate: false,
      initialValue: initialValue,
      onSaved: (val) {
        function(val);
      },
      validator: (String val) {
        if (int.parse(val) <= 0) {
          return VALIDATION_QUANTITY;
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
      child: Text(TOTAL_PRICE + sumOfProducts.toString()),
    );
  }
}
