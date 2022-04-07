class CategoryList{
  String categoryName ;
  String categoryId;
  CategoryList({this.categoryName = '',this.categoryId = ''});
}
List<CategoryList> listCategories = [CategoryList(categoryName: "Headache",categoryId: "1"),CategoryList(categoryName: "Supplements",categoryId: "2"),CategoryList(categoryName: "Infants",categoryId: "3",),CategoryList(categoryName: "Cough",categoryId: "4")];
