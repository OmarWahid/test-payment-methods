import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_c6/modules/register/cubit/states.dart';
import 'package:payment_c6/shared/network/remote/dio.dart';
import '../../../shared/common/constants.dart';

class PaymentCubit extends Cubit<PaymentStates> {
  PaymentCubit() : super(PaymentInitState());

  static PaymentCubit get(context) => BlocProvider.of(context);

  Future getFirstToken(String firstName, String lastName, String email,
      String phone, String amount) async {
    emit(getFirstTokenLoadingState());
    await DioHelper.postData(endPoint: 'auth/tokens', data: {"api_key": APIKEY})
        .then((value) {
      PAYMENT_FIRST_TOKEN = value.data['token'];
      getOrderId(firstName, lastName, email, phone, amount);
    }).catchError((error) {
      print(error.toString());
      emit(getFirstTokenErrorState());
    });
  }

  Future getOrderId(String firstName, String lastName, String email,
      String phone, String amount) async {
    await DioHelper.postData(endPoint: 'ecommerce/orders', data: {
      "auth_token": PAYMENT_FIRST_TOKEN,
      "delivery_needed": "false",
      "amount_cents": amount,
      "currency": "EGP",
      "items": [],
    }).then((value) {
      PAYMENT_ORDER_ID = value.data['id'].toString();
      getFinalTokenCardVisa(firstName, lastName, email, phone, amount);
      getFinalTokenKiosk(firstName, lastName, email, phone, amount);
    }).catchError((error) {
      print(error.toString());
      emit(getOrderIdErrorState());
    });
  }

  Future getFinalTokenCardVisa(String firstName, String lastName, String email,
      String phone, String amount) async {
    await DioHelper.postData(endPoint: 'acceptance/payment_keys', data: {
      "auth_token": PAYMENT_FIRST_TOKEN,
      "amount_cents": amount,
      "expiration": 3600,
      "order_id": PAYMENT_ORDER_ID,
      "billing_data": {
        "apartment": "NA",
        "email": email,
        "floor": "NA",
        "first_name": firstName,
        "street": "NA",
        "building": "NA",
        "phone_number": phone,
        "shipping_method": "NA",
        "postal_code": "NA",
        "city": "NA",
        "country": "NA",
        "last_name": lastName,
        "state": "NA"
      },
      "currency": "EGP",
      "integration_id": INTGRATION_ID_VISACARD
    }).then((value) {
      PAYMENT_FINAL_TOKEN_VISA = value.data['token'];
    }).catchError((error) {
      print(error.toString());
      emit(getFinalTokenErrorState());
    });
  }

  Future getFinalTokenKiosk(String firstName, String lastName, String email,
      String phone, String amount) async {
    await DioHelper.postData(endPoint: 'acceptance/payment_keys', data: {
      "auth_token": PAYMENT_FIRST_TOKEN,
      "amount_cents": amount,
      "expiration": 3600,
      "order_id": PAYMENT_ORDER_ID,
      "billing_data": {
        "apartment": "NA",
        "email": email,
        "floor": "NA",
        "first_name": firstName,
        "street": "NA",
        "building": "NA",
        "phone_number": phone,
        "shipping_method": "NA",
        "postal_code": "NA",
        "city": "NA",
        "country": "NA",
        "last_name": lastName,
        "state": "NA"
      },
      "currency": "EGP",
      "integration_id": INTGRATION_ID_KIOSK
    }).then((value) {
      PAYMENT_FINAL_TOKEN_KIOSK = value.data['token'];
      getReferenceCode();
    }).catchError((error) {
      print(error.toString());
      emit(getFinalTokenKIOSKErrorState());
    });
  }

  Future getReferenceCode() async {
    await DioHelper.postData(endPoint: 'acceptance/payments/pay', data: {
      "source": {"identifier": "AGGREGATOR", "subtype": "AGGREGATOR"},
      "payment_token": PAYMENT_FINAL_TOKEN_KIOSK
    }).then((value) {
      REFCODE = value.data['id'].toString();
      emit(getRefCodeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(getRefCodeErrorState());
    });
  }
}
