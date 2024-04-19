import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/buku/response_search_buku.dart';
import '../../../data/provider/api_provider.dart';

class BukuController extends GetxController with StateMixin{


  final TextEditingController searchController = TextEditingController();
  
  var searchBook = RxList<DataSearch>();

  @override
  void onInit() {
    super.onInit();
    getDataSearchBook();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getDataSearchBook() async {
    try {
      change(null, status: RxStatus.loading()); // Ubah status menjadi loading

      final keyword = searchController.text.toString();
      final response;

      if (keyword == ''){
        response = await ApiProvider.instance().get('${Endpoint.searchBuku}/null');
      }else{
        response = await ApiProvider.instance().get('${Endpoint.searchBuku}/$keyword');
      }


      if (response.statusCode == 200) {
        final ResponseSearchBuku responseData = ResponseSearchBuku.fromJson(response.data);

        if (responseData.data!.isEmpty) {
          searchBook.clear();
          change(null, status: RxStatus.empty());
        } else {
          searchBook.assignAll(responseData.data!);
          change(null, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Gagal Memanggil Data"));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final responseData = e.response?.data;
        if (responseData != null) {
          final errorMessage = responseData['message'] ?? "Unknown error";
          change(null, status: RxStatus.error(errorMessage));
        }
      } else {
        change(null, status: RxStatus.error(e.message));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
