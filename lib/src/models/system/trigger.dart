class Trigger {
  int changeUserInHouseNum;
  int seachNum;
  int shipNum;

  Trigger(
      {required this.changeUserInHouseNum,
      required this.seachNum,
      required this.shipNum});

  //copyWith
  Trigger copyWith({
    int? changeUserInHouseNum,
    int? seachNum,
    int? shipNum,
  }) {
    return Trigger(
      changeUserInHouseNum: changeUserInHouseNum ?? this.changeUserInHouseNum,
      seachNum: seachNum ?? this.seachNum,
      shipNum: shipNum ?? this.shipNum,
    );
  }
}
