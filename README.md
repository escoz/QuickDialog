# QuickDialog

**Quick and simple dialogs for iOS developers.**

## For more information and documentation, please go to [the project official website](http://escoz.com/open-source/quickdialog).

QuickDialog allows you to create HIG-compliant iOS forms for your apps  without having to directly deal with UITableViews, delegates and data sources. Fast and efficient, you can create forms with multiple text fields, or with thousands of items with no sweat!

![Sample](https://github.com/escoz/QuickDialog/raw/master/other/quickdialog.png "Sample")

# Instalation

The best way of using the library is to use CocoaPods. Simply add the dependency and install the pod, like this:

```
  pod "QuickDialog"
```

QuickDialog is broken into three different pods by default:

* Core: basic data structure and functionality to display sections and elements
* Forms: user input controls, such as numbers, selectors, etc.
* Extras: useful controls that have dependencies on external frameworks, like MapKit, etc.

By default, the QuickDialog pod includes Core+Forms, but not Extras. If you would like to have more control, you can define which pods you would like to use:

```
  pod "QuickDialog/Core"
  pod "QuickDialog/Forms"
  pod "QuickDialog/Extras"
```

The project also comes with a sample app that covers the majority of the elements, and is a great example of how things work.

Download the project and run the demo app, I'm sure you'll like how simple it is to create powerful dialogs!

