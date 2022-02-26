
class NextPageProvider {
  int currentPage = 0;

  int moveToNextPage() {
    currentPage += 1;
    return currentPage;
  }

  int moveToPrevPage() {
    currentPage -= 1;
    return currentPage;
  }

  int moveToInitPage() {
    currentPage = 0;
    return currentPage;
  }
}