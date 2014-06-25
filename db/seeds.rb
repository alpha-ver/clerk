# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#root category
root=Category.new(
  name: "root",
  parent_id: -1
  ).save

### Demo data
Category.create(
  [
    {name: "Договора", parent_id: 1},
    {name: "Налоговые документы", parent_id:1}
  ]
)

Category.create(
  [
    {name: "Типовые договора", parent_id: 2},
    {name: "Покупка продажа",  parent_id: 2}
  ]
)

user = User.new(
  {
    :email      => "hav0k@me.com", 
    :admin      => true, 
    :password   => "1q2w3e4r"
  }
)
user.save

User.new(
  {
    :email      => "user@me.com", 
    :admin      => false, 
    :password   => "1q2w3e4r"
  }
).save

Template.new(
  :name    => "Рога и копыта",
  :about   => "Шаблон фирмы рога и копыта",
  :user_id => user.id
  ).save

Field.new(
  name: "Название организации",
  code: "{org_name}"
  ).save

Field.new(
  name:  "ФИО директора",
  code:  "{org_director}",
  about: "Пример: Иванов Иван Иванович"
  ).save

Field.new(
  name: "Юридический адресc",
  code: "{org_address}",
  about: "Полный адресс огранизации. Пример: г.Москва, ул. Московская, дом 86"
  ).save

Field.new(
  name: "Телефон",
  code: "{org_phone}",
  about: "Основной телефон фирмы"
  ).save

Document.new(
  name: "Типовой договор",
  extension: "docx",
  category_id: 4,
  path: "9f48096e38b21f94d2903aa974e28028067488d6ef49b9b11fed01627d8550f7"
  ).save

TemplateField.new(
  template_id: 1, 
  field_id:    1,
  val:    "Рога и копыта"
  ).save

TemplateField.new(
  template_id: 1, 
  field_id:    2,
  val:    "Абдимумин Пирбабаев Уморжанович"
  ).save

TemplateField.new(
  template_id: 1, 
  field_id:    3,
  val:         "г.Москва, ул. Московская, дом 86"
  ).save

TemplateField.new(
  template_id: 1, 
  field_id:    4,
  val:    "8(800)520-08-90"
  ).save