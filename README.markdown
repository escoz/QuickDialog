# QuickDialog

**Quick and simple dialogs for iOS developers.**

QuickDialog allows you to create HIG-compliant iOS forms for your apps  without having to directly deal with UITableViews, delegates and data sources. Fast and efficient, you can create forms with multiple text fields, or with thousands of items with no sweat!

![Sample](https://github.com/escoz/QuickDialog/raw/master/other/quickdialog2.png "Sample")


Download the project and run the demo app, I'm sure you'll like how simple it is to create powerful dialogs!

----------

*QuickDialog is inspired by the brilliant MonoTouch.Dialog library created by Miguel de Icaza, which can be found at https://github.com/migueldeicaza/MonoTouch.Dialog.*

----------

OBS: You'll need to use the XCode 4.2 beta to run this code, as the library depends on ARC for memory management. If you're interested in helping with development, please contact me! I would appreciate any help!

## Features

QuickDialog support many different built-in types of elements for your forms, like Entry elements, on/off elements, sliders and even simple web addresses that automatically open browsers and adress elements to open map views. For a complete list of elements, look below! The framework also is very extensible, making it simple for you to create your custom elements an cells.  

And if you don't like the basic look of controls, simply override one method and you'll have full control of the cells being displayed. Can't get much simpler than that!

## How to use it

In order to use the QuickDialog library on your project, you'll have to first import the code or link the project to your own. 

There's three different class types you need to know in order to use QuickDialog:

- **QuickDialogController** - subclass of a UITableViewController that is responsible for actually displaying the dialog. For your application, you'll very likely be creating subclasses of this class, one for each dialog you own. You'll never really have to create objects of this type directly with alloc/init. The framework takes care of this for you.
- **QRootElement** - think of a root element as a dialog: a collection of sections and cells that can be used to display some useful data to the user. Every QuickDialogController can only display one RootElement at a time, although that RootElement can contain other root elements inside, which causes a new controller to automatically be displayed. Elements are always grouped in sections in the root element, as you can see below.
- **QElement** - an element object maps one-to-one map to a UITableViewCell, although it includes more functionality, like being able to read values from the cells and having multiple types. QuickDialog provides many different built-in element types, like the ButtonElement and the EntryElement, but you can also create your custom one.  

####Hello World:

Here's how you can create and display your first dialog from inside another UIViewController:
	
    QRootElement *root = [[QRootElement alloc] init];
    root.title = @"Hello World";
	root.grouped = YES;
    QSection *section = [[QSection alloc] init];
    QLabelElement *label = [[QLabelElement alloc] initWithTitle:@"Hello" Value:@"world!"];
    
    [root addSection:section];
    [section addElement:label];
    
    UINavigationController *navigation = [QuickDialogController controllerWithNavigationForRoot:root];
    [self presentModalViewController:navigation animated:YES];

The code above will create the form below:

![Hello World](https://github.com/escoz/QuickDialog/raw/master/other/quickdialog1small.png "Hello World by QuickForm")

Pretty simple, right?!

## Elements

Out of the box, QuickDialog provides you many different elements you can use on your app:

* **QLabelElement**: simple inline label + value cell
* **QBadgeElement**: like the label cell, but the value is displayed with a badge, like the Mail app.
* **QBooleanElement**: shows a on/off switch
* **QButtonElement**: centered title that looks like a button. 
* **QDateTimeElement**: allows you to edit dates, time, or date+time values. Editing occurs in a new controller that is pushed automatically.
* **QEntryElement**: input field to allow you to collect values from the user. Automatically resizes so that all entries in the same sections look alike.
* **QDecimalElement**: very much like an entry field, but allows only numbers to be typed. Automatically limits numbers to a predefined number of decimal places.
* **QFloatElement**: shows an slider control.
* **QMapElement**: when selected, shows a fullscreen map with the location selected. Requires a lat/long value.
* **QRadioElement**: allows user to select one of multiple options available. Automatically pushes a new table with the item to be selected.
* **QTextElement**: freeform text, which is rendered with the font provided.
* **QWebElement**: pushes a simple browser that opens the URL defined in the element.

All those elements contain a few parameters that can be used:

* **key**: used to set the name of every cell, so that you can find them automatically. This field is also used to read values back from each cell.
* **controllerAction**: string that represents the controller method that will be called when the cell is selected. Many elements automatically display a disclosure indicator if this property is set.
* **onSelected**: block that is executed the moment the cell is selected. Many elements automatically display a disclosure indicator if this property is set.

## Sections

Sections are simple groupings of elements. Sections by default have a few properties:

* **title/footer**: simple strings displayed as header and footer of the section
* **headerView/footerView**: in case these are set, the views passed are displayed instead of the titles. Very useful to display images or custom views in tables.

Besides those properties, a few custom section types can be used:

* **QRadioSection**: display multiple choice elements inline, instead of pushing another view controller with the options.
* **QSortingSection**: automatically enables sorting of the cells inside the section. 

## Styling

Styling the cells in your dialogs is easy with QuickDialog. To be able to change the background, fonts and colors of your cells, simply implement the QuickDialogStyleProvider protocol, and set the proper delegate class you your table view. You can see an example of that on the LoginController of the demo app: https://github.com/escoz/QuickDialog/blob/master/sample/LoginController.m.

There's only one method you need to implement for that protocol: ```-cell:willAppearForElement:element atIndexPath:```, which will be called for every cell displayed, and allows you to change the cells as much as you would like.

![Styling QuickDialog](https://github.com/escoz/QuickDialog/raw/master/other/quickdialog3.png "Styling cells with QuickDialog")

## Custom Dialog Controllers

Using custom dialog controllers are a very simple and effective way of having full control on how your dialog is displayed. To do this, simple create a subclass of the QuickDialogController class. You can use this subclass to do things like change the looks and behavior of the tableview, implement styling, and implement actions that get called when elements are executed. 

Instead of directly creating your custom controller objects, though, RootElement objects can be told which controller they use, and they'll automatically create controllers of that type as needed. So, for example, if you have a new class of type ```MyDialogController``` that is a subclass of the ```QuickDialogController```, you can define the root as follow:

	QRootElement *root = [[QRootElement alloc] init];
    root.title = @"Hello World";
	root.controllerName = @"MyDialogController";
	
    // ... define your root element content here
    
    MyDialogController *myDialogController = [QuickDialogController controllerForRoot:root];
    [self presentModalViewController:navigation animated:YES];

The controller, and all the controllers necessary to display that root element will automatically be of the type you defined!

