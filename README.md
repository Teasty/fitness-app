# Приложение личного кабинета клиента фитнесс-клуба
### Приложение разработано как курсовая работа по СУБД студентом 3 курса РТУ МИРЭА Лихачёвым Андреем Валерьевичем.

## Реализация технического задания
По заданию было необходимо разработать сайт/десктопное приложение/мобильное приложение, котрое выводит, изменяет и удаляет данные из базы данных, используя **SQL**  запросы. Приложение общается с сервером по **http** (не было смысла в более защещенном подключении) и получает данные в формате **json**. На сервере есть **php**  файл с протоколами, которые и осуществляют взаимодействие с базой данных.

## Приложение
Само приложение написано на **Swift 4.2**. Это мой первый опыт использования данного языка, выбор был сделан благодаря тому, что у меня были возможности работы с ним, и я был заинтерисован в изучении **Swift**. Я начал изучение **Swift** с книги "Swift. Основы разработки приложений под iOS" и на протяжении работы обращался к [официальной документации предоставленной компанией Apple](https://docs.swift.org/swift-book/). 
 Далее я опишу фунционал основных экранов приложения.
 
* Страница покупки нового абонемента:\
 ![Refresh page](https://github.com/Teasty/fitness-app/blob/master/screenshots/bDhOuOgViUY.jpg?raw=true)\
 Экран покупки нового абонемента - это **UITableViewControllet**  со статическими ячейками. Пользователю предоставлен выбор: зарегистрироватся как владелец окончевшегося абонемента, чтобы вся информация о пользователе загрузилась из базы данных, либо пользователь может ввести свои данные, после чего сначала произойдет регистрация нового пользователя и закрепление абонемента за этим пользователем.
 
* Главная страница: 
 ![Main page](https://github.com/Teasty/fitness-app/blob/master/screenshots/wbglLBPsyWE.jpg?raw=true) 
 Этот экран - **UIViewController**, в котором есть **UICollectionView** для новостей фитнесс-клуба и **UITableView** выводящий ближайшие занятия но которые записан пользователь.
    * Новости 
    В новостях показываюся объявления, у которых задается дата начала показа и конец. При нажатии на новость пользователь переходит на экран новости в котором текст и заголовок новости подгружаются в зависимоти от того, какую новость он выбрал.
    * Записи пользователя
    В приложении реализоваеа возможность пользовалеля записаться на занятия пребующие запись либо на индивидуальное занятие к определенному инструктору. Все эти записи выводятся начиная с самого близкого по времени.

* Экран с расписанием занятий в фитнесс-клубе: 
 ![Schedule page](https://github.com/Teasty/fitness-app/blob/master/screenshots/Ts-YWQ3Wzeo.jpg?raw=true)
Это **UITableViewControllet**, где переключая **UISegmentedControl** можно выбрать, расписание какого зала пользователь хочет увидеть. Значки напротив названия обозначают, какие занятия платные и на какие необходима предварительная запись. При выборе определенного заняти пользователь переходит на окно с описанием этого занятия, а также может записаться на то, где необходима предварительная запись: 
 ![Schedule page](https://github.com/Teasty/fitness-app/blob/master/screenshots/CjfdDwXLMFE.jpg?raw=true)

* Экран записи на индивидуальное занятие: 
  ![Sing page](https://github.com/Teasty/fitness-app/blob/master/screenshots/dTZItmfcmL4.jpg?raw=true) 
  **UITableViewControllet**  со статическими ячейками. Поле выбора инструктора - **UIPickerView**, информация в который загружается из базы данных. Поле выбора даты - **UIDatePicker**. Поле выбора времени - **UIPickerView**, оно становится активным только после выбора инструктора и даты, так как выводится только то время, когда у инструктора нет занятий ни по расписанию, ни по записям.
  
  * Экран настроек: 
  ![Settings page](https://github.com/Teasty/fitness-app/blob/master/screenshots/lZ10MZ3ZBlc.jpg?raw=true) 
  Экран настроек - это **UITableViewControllet**  со статическими ячейками. 
    * Изменение персональных данных:
    После входа пользователя в приложение, все его персональные данные хранятся в **UserDefaults**, после регестрации пользователь может менять телефон и e-mail. При их изменении они меняются и в **UserDefaults**, и в базе данных.
    * Информация об обонементе:
    Из быза данных подгружается все информация о действующем абонементе пользователя: вид абонемента, дата начала, дата конца и количество оствшихся дней.
    * О приожении:
    Выводит информацию о создателе приложения и о его цели.
    * Выход: 
    Обнуляет **UserDefaults** и преходит на экран входа.
