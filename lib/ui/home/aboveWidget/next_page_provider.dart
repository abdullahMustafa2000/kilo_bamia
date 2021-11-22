import 'package:flutter/material.dart';

class NextPageProvider extends ChangeNotifier {
  int currentPage = 0;

  int moveToNextPage() {
    currentPage += 1;
    return currentPage;
  }
}