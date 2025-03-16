class Penguin : Bird {
  void make_sound(void* this) override;
  void move(void* this) override;
  void fly(void* this) override;
  void slide(void* this);
}
