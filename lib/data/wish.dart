class Wish {
  int? no;
  int? putout_id;

  // 생성자로 값읋 바로 받고 멤버변수에 넣어준다.
  Wish({this.no, this.putout_id});

  // 내부 디비용(sqlite)
  Map<String, dynamic> toMap() {
    return <String, dynamic>{'no': no, 'putout_id': putout_id};
  }
}
