# BooksKeeper

Общее описание: 

    Приложение, написанное на Swift по принципам VIPER, представляет собой простой список книг, взятых в библиотеке. 

Launch screen

Первый экран: 

    1. Загрузочное окно. Анимированный спиннер с длительностью прокрутки 2-5 сек. Имеет два вида:
    
            а) Разноцветная прокрутка (4 цвета, которые сменяют друг-друга);
            
            б) Классическая прокрутка 
            
            P.S.: чтобы активировать б, необходимо в коде найти строку: 
            BaseViewController --> //MARK: - innerLayer without color animation configure --> self.view.layer.addSublayer(self.innerLayer) --> раскомментировать, а строку //MARK: - innerLayer with color animation configure --> self.view.addSubview(self.innerLayerSpinner) --> закоментировать
            
        По прошествии времени анимации происходит переход к Стартовому окну.
            
    2. Стартовое окно с анимированным появлением изображений и кнопки. При нажатии на кнопку происходит переход ко второму экрану со списком книг.
    
Второй экран: 

    Таблица со списком книг. 
    
    - При свайпе влево по книге появляется книпка "Удалить". 
    - При нажатии на книгу, происходит переход на третий экран в окно "Редактирование"
    - На экране есть кнопки сортировки (по названию и дате), а также кнопка добавления новой книги "+", при нажатии на которую происходит переход на третий экран в окно "Добавление книги"
    
Третий экран: 

    1. Экран "Добавить книгу"
        - Поле для ввода названия;
        - DatePicker для выбора даты (интервал: 3 мес.);
        - Кнопка для сохранения книги в таблице;
        - Переход к предыдущему экрану.

    2. Экран "Отредактировать"
        - Поле для редактирования текущего названия;
        - DatePicker для изменения даты;
        - Кнопка для обновления книги в таблице;
        - Переход к предыдущему экрану.

Локализация

    Чтобы переключить язык, перейдите на симуляторе в Settings -> General -> Language & Region -> iPhine Language -> Russian.
    
 Архитектура
 
    View. Отображает то, что сообщил Presenter и передает информацию, полученную при взаимодействии пользователя с интерфейсом Presentor`у
    Interactor. Содержит бизнес-логику
    Presenter. Содержит логику подготовки содержимого для отображения (получает из Interactor`а) и для реакции на ввод данных пользователем
    Entity. Описание модели
    Router. Слой логики навигации
    Configurator. Сборка View, Interactor, и Presenter
    
 # Screenshots
 
[Цветной спиннер](https://github.com/Avopihra/BooksKeeper/blob/master/Screenshots/ColorAnimation.png "Цветной спиннер")

[Обычный спиннер](https://github.com/Avopihra/BooksKeeper/blob/master/Screenshots/ClassicAnimation.png "Обычный спиннер")

[Стартовая страница](https://github.com/Avopihra/BooksKeeper/blob/master/Screenshots/StartPage.png "Стартовая страница")

[Список книг](https://github.com/Avopihra/BooksKeeper/blob/master/Screenshots/BookList.png "Список книг")

[Список с просроченными книгами](https://github.com/Avopihra/BooksKeeper/blob/master/Screenshots/BookListWithExpiredBooks.png "Список с просроченными книгами")

[Сортировка](https://github.com/Avopihra/BooksKeeper/blob/master/Screenshots/Sorting.png "Сортировка")

[Окно редактирования](https://github.com/Avopihra/BooksKeeper/blob/master/Screenshots/EditInfo.png "Окно редактирования")

[Окно добавления](https://github.com/Avopihra/BooksKeeper/blob/master/Screenshots/AddNewBook.png "Окно добавления")

