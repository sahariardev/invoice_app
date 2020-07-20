

import 'package:invoice_generator/redux/app_state.dart';

import 'action.dart';

AppState reducer(AppState prevState, dynamic action){
   print("Action trigger");
   print(action.payload);
   AppState newState = AppState.fromPrevState(prevState);

   if(action is FormId){
      print("Action trigger");
      print(action.payload);
      newState.invoice.id = action.payload;
   }

   return newState;

}