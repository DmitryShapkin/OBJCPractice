# Чек-лист Objective-C
*by Alexander Cherushnikov

### Список правил:

- неправильное использование компонентов с MRC в коде, не обнуление ссылок и т.д.
- вызов блока без проверки на существование
- delegate с неправильными атрибутами
- обращение к ivar внутри блоков
- объявление свойств простых типов с атрибутом отличным от assign
- использование NSNotificationCenter addObserver без removeObserver
- retain cycle в блоках
- добавление nil в коллекции

- обращение к propety в init, dealloc, getter, setter
- объявление ivar в интерфейсе
- отсутствие проверки вызова optional метода делегата
- обработка ошибок if (![self trySomethingWithError:&error])

- использование performSelector
- объявление мутабельных типов без copy атрибута, включая блоки (NSString, ...)
- литеральный синтаксис
- использование констант вместо #define
- использование NS_ENUM вместо enum
- ипосльзование - (id)init вместо - (instancetype)init
- использования блочного синтаксиса создания объектов = ({
- naming свойств, методов, локальных переменных
- использование ((NSIndexPath*) вместо объявления NSIndexPath *indexPath = ...
- использование Core Data без performBlock/performBlockAndWait
- использование updateConstraints, prepareForReuse, viewDidLoad, viewWillAppear, viewDidAppear и т.д без вызова super
- инициализация NSTimer без реализации selector
- case fallthrough

- пробелы, переносы {}, опечатки
- обращение к свойствам через вызов getter, а не через . array.count
- использование внутри if больше 2 условий if(bool1 && bool2 && bool3)
- использование int внутри for вместо NSUInteger
- использование внутри if вызовов методов, if ([someObj someMethod])
- использование CGRectMake(0,0,0,0), вместо CGRectZero
- использование UIEdgeInsetsMake(0, 0, 0, 0), вместо UIEdgeInsetsZero
- использование frame.size.width, вместо CGRectGetWidth и т.д
- закомментированный код
- пустые методы
- неправильный порядок объявления свойств
- длина строк == 120 символов
- исключить избыточную проверку BOOL ( if (bool1 == YES), if (object != nil) )
- обязательные скобки для блоков if/else