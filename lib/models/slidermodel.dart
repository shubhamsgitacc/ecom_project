class MYSliderdataapi{
  String ? sldimages,sldname;
  int ? sldid,sldactual_price,slddiscounted_price;
  MYSliderdataapi({this.sldname, this.sldimages, this.sldid,this.sldactual_price,this.slddiscounted_price});

  factory MYSliderdataapi.fromMap(Map sliderdataapi){
    return MYSliderdataapi(
      sldimages: sliderdataapi['images'],
      sldid: sliderdataapi['ID'],
      sldactual_price: sliderdataapi['actual_price'],
      slddiscounted_price: sliderdataapi['final_price'],
      sldname: sliderdataapi['name']


    );

    
  }
}
class ImagesfromApi{
String ? sliderimages;
ImagesfromApi({ this.sliderimages});





}
