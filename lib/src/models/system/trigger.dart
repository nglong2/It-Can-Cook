class Trigger {
  int changeUserInHouseNum;
  int seachNum;

  Trigger({required this.changeUserInHouseNum, required this.seachNum});

  //copyWith
  Trigger copyWith({
    int? changeUserInHouseNum,
    int? seachNum,
  }) {
    return Trigger(
      changeUserInHouseNum: changeUserInHouseNum ?? this.changeUserInHouseNum,
      seachNum: seachNum ?? this.seachNum,
    );
  }
}
