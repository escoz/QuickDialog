//
//  Created by escoz on 7/12/11.


#import <UIKit/UIKit.h>
#import "LoginController.h"
#import "../quickdialog/QDecimalElement.h"

@implementation DummyDataBuilder

+ (QRootElement *)createWithInitDefault {
	
    QRootElement *subForm = [[QRootElement alloc] init];
    subForm.grouped = YES;
    subForm.title = @"Default Initialization";
	QSection *subsection = [[QSection alloc] initWithTitle:@"SubSection"];
    [subForm addSection:subsection];
	
	[subsection addElement:[[QLabelElement alloc] init]];
	[subsection	addElement:[[QBadgeElement alloc] init]];
	[subsection	addElement:[[QBooleanElement alloc] init]];
	[subsection	addElement:[[QButtonElement alloc] init]];
	[subsection	addElement:[[QDateTimeInlineElement alloc] init]];
	[subsection	addElement:[[QFloatElement alloc] init]];
	[subsection	addElement:[[QMapElement alloc] init]];
	[subsection	addElement:[[QRadioElement alloc] init]];
	[subsection	addElement:[[QRadioItemElement alloc] init]];
	[subsection	addElement:[[QTextElement alloc] init]];
	[subsection	addElement:[[QWebElement alloc] init]];
	
	return subForm;
}


+ (QRootElement *)createWithInitAndKey {
	
    QRootElement *subForm = [[QRootElement alloc] init];
    subForm.grouped = YES;
    subForm.title = @"Initialization With Key";
	QSection *subsection = [[QSection alloc] initWithTitle:@"SubSection"];
    [subForm addSection:subsection];
	
	[subsection addElement:[[QLabelElement alloc] initWithKey:@"Key1"]];
	[subsection	addElement:[[QBadgeElement alloc] initWithKey:@"Key1"]];
	[subsection	addElement:[[QBooleanElement alloc] initWithKey:@"Key1"]];
	[subsection	addElement:[[QButtonElement alloc] initWithKey:@"Key1"]];
	[subsection	addElement:[[QDateTimeInlineElement alloc] initWithKey:@"Key1"]];
	[subsection	addElement:[[QFloatElement alloc] initWithKey:@"Key1"]];
	[subsection	addElement:[[QMapElement alloc] initWithKey:@"Key1"]];
	[subsection	addElement:[[QRadioElement alloc] initWithKey:@"Key1"]];
	[subsection	addElement:[[QRadioItemElement alloc] initWithKey:@"Key1"]];
	[subsection	addElement:[[QTextElement alloc] initWithKey:@"Key1"]];
	[subsection	addElement:[[QWebElement alloc] initWithKey:@"Key1"]];
	
	return subForm;
}


+ (QRootElement *)createSubForm1Root {
    QRootElement *subForm = [[QRootElement alloc] init];
    QSection *subsection = [[QSection alloc] initWithTitle:@"SubSection"];
    subForm.grouped = YES;
    subForm.title = @"Subform";

    [subsection addElement:[[QLabelElement alloc] initWithTitle:@"Some title" Value:@"Some value"]];
    [subsection addElement:[[QEntryElement alloc] initWithTitle:@"Entry" Value:nil Placeholder:@"type here"]];
    [subsection addElement:[[QBooleanElement alloc] initWithTitle:@"boolean" BoolValue:YES]];
    [subsection addElement:[[QEntryElement alloc] initWithTitle:@"Entry 2" Value:@"Some value" Placeholder:@"type here two"]];
    [subForm addSection:subsection];

    QSection *subsection2 = [[QSection alloc] init];
    [subsection2 addElement:[[QButtonElement alloc] initWithTitle:@"My Button"]];
    [subForm addSection:subsection2];

    QSection *subsection3 = [[QSection alloc] init];
    QBooleanElement *bool1 = [[QBooleanElement alloc] initWithTitle:@"First option" BoolValue:YES];
    bool1.onImage = [UIImage imageNamed:@"imgOn"];
    bool1.offImage = [UIImage imageNamed:@"imgOff"];
    [subsection3 addElement:bool1];
    QBooleanElement *bool2 = [[QBooleanElement alloc] initWithTitle:@"Second option" BoolValue:NO];
    bool2.onImage = [UIImage imageNamed:@"imgOn"];
    bool2.offImage = [UIImage imageNamed:@"imgOff"];
    [subsection3 addElement:bool2];

    QTextElement *element2 = [[QTextElement alloc] initWithText:@"You get all kinds of notifications on your iOS device: new email, texts, friend requests, and more. With Notification Center, you can keep track of them all in one convenient location. Just swipe down from the top of any screen to enter Notification Center. Choose which notifications you want to see. Even see a stock ticker and the current weather. New notifications appear briefly at the top of your screen, without interrupting what you’re doing. And the Lock screen displays notifications so you can act on them with just a swipe. Notification Center is the best way to stay on top of your life’s breaking news."];
    element2.font = [UIFont boldSystemFontOfSize:12];
    QSection *subsection4 = [[QSection alloc] init];
    [subsection4 addElement:element2];


    [subForm addSection:subsection3];
    [subForm addSection:subsection4];
    return subForm;
}

+ (QRootElement *)createSlidersRoot {
    QRootElement *sliders = [[QRootElement alloc] init];
    sliders.grouped = YES;
    sliders.title = @"sliders";
    QSection *detailsSection = [[QSection alloc] initWithTitle:@"Change some things"];

    [sliders addSection:detailsSection];

    [detailsSection addElement:[[QFloatElement alloc] initWithValue:0.5]];
    [detailsSection addElement:[[QFloatElement alloc] initWithTitle:@"Short" value:0.7]];
    [detailsSection addElement:[[QFloatElement alloc] initWithTitle:@"Really really long title" value:1]];

    return sliders;
}

+ (QElement *)createGeneralControlsRoot {
    QRootElement *root = [[QRootElement alloc] init];
    root.grouped = YES;
    root.title = @"Sample Controls";
    QSection *controls = [[QSection alloc] initWithTitle:@"Change something"];

    QLabelElement *element1 = [[QLabelElement alloc] initWithTitle:@"Label" Value:@"element"];
    
    QRadioElement *radioElement = [[QRadioElement alloc] initWithItems:[[NSArray alloc] initWithObjects:@"Option 1", @"Option 2", @"Option 3", nil] selected:0 title:@"Radio"];
	radioElement.key = @"radio1";

    QBooleanElement *boolElement = [[QBooleanElement alloc] initWithTitle:@"Boolean Element" BoolValue:YES];
	boolElement.key = @"bool1";
	
    QEntryElement *entryElement = [[QEntryElement alloc] initWithTitle:@"Entry Element" Value:nil Placeholder:@"type here"];
	entryElement.key = @"entry1";
	
    controls.footer = @"More controls will be added.";
    [controls addElement:element1];

    [controls addElement:radioElement];
    [controls addElement:entryElement];
	
    [controls addElement:boolElement];
	QDateTimeInlineElement *dateElement = [[QDateTimeInlineElement alloc] initWithTitle:@"DateTime" date:[NSDate date]];
	dateElement.key = @"date1";
    [controls addElement:dateElement];

    QFloatElement *slider = [[QFloatElement alloc] initWithTitle:@"Float Element" value:0.5];
	slider.key = @"slider1";
    [controls addElement:slider];
    
    QDecimalElement *decimal = [[QDecimalElement alloc] initWithTitle:@"Decimal Element" value:0.5];
    decimal.key = @"decimal1";
    decimal.fractionDigits = 3;
    [controls addElement:decimal];

    QSection *btnSection = [[QSection alloc] init];
	QButtonElement *button = [[QButtonElement alloc] initWithTitle:@"Show form values"];
	button.onSelected = ^{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hello"
            message:[NSString stringWithFormat:@"1: %d\n2: %@\n3: %d\n4:%@\n5:%f\n6:%f",
                radioElement.selected ,
                entryElement.textValue,
                boolElement.boolValue,
                dateElement.dateValue ,
                slider.floatValue,
                decimal.floatValue]
           delegate:self 
           cancelButtonTitle:@"OK" 
           otherButtonTitles:nil];
		[alert show];

	};
    [btnSection addElement:button];

    QSection *btnSection2 = [[QSection alloc] init];
	QButtonElement *button2 = [[QButtonElement alloc] initWithTitle:@"Fetch into dictionary"];
	button2.onSelected = ^{
		
		NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [root fetchValueIntoObject:dict];
		
        NSString *msg = @"Values:";
		for (NSString *aKey in dict){
            msg = [msg stringByAppendingFormat:@"\n- %@: %@", aKey, [dict valueForKey:aKey]];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hello"
            message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];

	};
    [btnSection2 addElement:button2];

    [root addSection:controls];
    [root addSection:btnSection];
    [root addSection:btnSection2];
    return root;
}

+ (QElement *)createRadioSectionsRoot {
    QRootElement *root = [[QRootElement alloc] init];
    root.title = @"Radio elements";
    root.grouped = YES;

    QSection *section1 = [[QSection alloc] initWithTitle:@"Radio element with push"];
    [section1 addElement:[[QRadioElement alloc] initWithItems:[NSArray arrayWithObjects:@"Football", @"Soccer", @"Formula 1", nil] selected:0]];
    [section1 addElement:[[QRadioElement alloc] initWithItems:[NSArray arrayWithObjects:@"Football", @"Soccer", @"Formula 1", nil] selected:0 title:@"Sport"]];
    [root addSection:section1];


    QSection *section2 = [[QRadioSection alloc] initWithItems:[NSArray arrayWithObjects:@"Football", @"Soccer", @"Formula 1", nil] selected:0 title:@"Sport"];
    [root addSection:section2];


    return root;
}

+ (QRootElement *)createHtmlRoot {
    QRootElement *root = [[QRootElement alloc] init];
    root.title = @"Web and map elements";

    QWebElement *element1 = [[QWebElement alloc] initWithTitle:@"ESCOZ Inc" url:@"http://escoz.com"];
    QWebElement *element2 = [[QWebElement alloc] initWithTitle:@"Quicklytics" url:@"http://escoz.com/quicklytics"];
    QMapElement *element4 = [[QMapElement alloc] initWithTitle:@"Florianopolis, Brazil" coordinate:CLLocationCoordinate2DMake(-27.59, -48.55)];

    QSection *section1 = [[QSection alloc] init];
    [section1 addElement:element1];
    [section1 addElement:element2];
    [section1 addElement:element4];

    [root addSection:section1];
    return root;
}

+ (QRootElement *)createTextElementsRoot {
    QRootElement *root = [[QRootElement alloc] init];
    root.title = @"Text elements";

    QTextElement *element1 = [[QTextElement alloc] initWithText:
            @"Preparing for her flight\n"
            "I held with all my might\n"
            "Fearing my deepest fright\n"
            "She walked into the night\n"
            "She turned for one last look\n"
            "She looked me in the eye\n"
            "I said, \"I Love You...\n"
            "Good-bye\""];

    QTextElement *element2 = [[QTextElement alloc] initWithText:@"You get all kinds of notifications on your iOS device: new email, texts, friend requests, and more. With Notification Center, you can keep track of them all in one convenient location. Just swipe down from the top of any screen to enter Notification Center. Choose which notifications you want to see. Even see a stock ticker and the current weather. New notifications appear briefly at the top of your screen, without interrupting what you’re doing. And the Lock screen displays notifications so you can act on them with just a swipe. Notification Center is the best way to stay on top of your life’s breaking news."];
    element2.font = [UIFont boldSystemFontOfSize:12];

    QTextElement *element3 = [[QTextElement alloc] initWithText:@"Quicklytics App!"];
    element3.font = [UIFont fontWithName:@"Cochin-BoldItalic" size:24];
    element3.color = [UIColor blueColor];

    QSection *section1 = [[QSection alloc] init];
    [section1 addElement:element3];
    [section1 addElement:element1];
    [section1 addElement:element2];
    [root addSection:section1];
    return root;
}

+ (QRootElement *)createLabelsRoot {
    QRootElement *root = [[QRootElement alloc] init];
    root.title = @"Labels";
    root.grouped = YES;
    QSection *s1 = [[QSection alloc] initWithTitle:@"LabelElement"];
    [s1 addElement:[[QLabelElement alloc] initWithTitle:@"With no value" Value:nil]];
    [s1 addElement:[[QLabelElement alloc] initWithTitle:@"With a value" Value:@"Value"]];
    [s1 addElement:[[QLabelElement alloc] initWithTitle:@"Or a simple number" Value:@"123"]];

    QSection *s2 = [[QSection alloc] initWithTitle:@"BadgeElement"];
    QBadgeElement *badge1 = [[QBadgeElement alloc] initWithTitle:@"With a badge" Value:@"1"];
    [s2 addElement:badge1];
    QBadgeElement *badge2 = [[QBadgeElement alloc] initWithTitle:@"With a pink badge" Value:@"123"];
    badge2.badgeColor = [UIColor colorWithRed:0.9518 green:0.3862 blue:0.4113 alpha:1.0000];
    [s2 addElement:badge2];

    QSection *secImg = [[QSection alloc] initWithTitle:@"Images"];
    QLabelElement *b1 = [[QLabelElement alloc] initWithTitle:@"Processor" Value:@"OK"];
    b1.image = [UIImage imageNamed:@"intel"];
    [secImg addElement:b1];

    QLabelElement *b2 = [[QLabelElement alloc] initWithTitle:@"iPhone" Value:@"OK"];
    b2.image = [UIImage imageNamed:@"iPhone"];
    [secImg addElement:b2];

    QBadgeElement *b3 = [[QBadgeElement alloc] initWithTitle:@"Keyboard" Value:@"ERROR"];
    b3.image = [UIImage imageNamed:@"keyboard"];
    b3.badgeColor = [UIColor redColor];
    [secImg addElement:b3];

    QBadgeElement *badge3 = [[QBadgeElement alloc] initWithTitle:@"With some action" Value:@"123"];
    badge3.badgeColor = [UIColor purpleColor];
    QSection *sec = [[QSection alloc] initWithTitle:@"Jazzin.."];
    [badge3 addSection:sec];
    [s2 addElement:badge3];
    [sec addElement:[[QBadgeElement alloc] initWithTitle:@"Test" Value:@"0"]];
    [sec addElement:[[QBadgeElement alloc] initWithTitle:@"Test 2" Value:@"10"]];
    [sec addElement:[[QBadgeElement alloc] initWithTitle:@"Test 3" Value:@"200"]];
    [sec addElement:[[QBadgeElement alloc] initWithTitle:@"Test 4" Value:@"1000"]];
    [sec addElement:[[QBadgeElement alloc] initWithTitle:@"Test 5" Value:@"TEST"]];

    [root addSection:s1];
    [root addSection:s2];
    [root addSection:secImg];
    return root;
}

+ (QRootElement *)createSortingRoot {

    QRootElement *root = [[QRootElement alloc] init];
    root.title = @"Sorting";
    root.grouped = YES;

    QSortingSection *sortingSection = [[QSortingSection alloc] init];
    sortingSection.key = @"sortedSection";
    [sortingSection addElement:[[QLabelElement alloc] initWithTitle:@"First" Value:@"1"]];
    [sortingSection addElement:[[QLabelElement alloc] initWithTitle:@"Second" Value:@"2"]];
    [sortingSection addElement:[[QLabelElement alloc] initWithTitle:@"Third" Value:@"3"]];
    [sortingSection addElement:[[QLabelElement alloc] initWithTitle:@"Forth" Value:@"4"]];
    [sortingSection addElement:[[QLabelElement alloc] initWithTitle:@"Fifth" Value:@"5"]];

    int i = 1;
    for (QElement * el in sortingSection.elements){
        el.key = [NSString stringWithFormat:@"item %d", i++];
    }

    [root addSection:sortingSection];

    QSection *action = [[QSection alloc] init];
    QButtonElement *button = [[QButtonElement alloc] initWithTitle:@"Read Order"];
    button.onSelected =  ^{
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

        [sortingSection fetchValueIntoObject:dict];

		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hello"
            message:[NSString stringWithFormat:@"Order: %@", dict ]
           delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];

	};

    [action addElement:button];
    [root addSection:action];
    return root;
}

+ (QRootElement *)createDateTimeRoot {
    QRootElement *root = [[QRootElement alloc] init];
    root.title = @"Date Time";
    root.grouped = YES;

    QSection *section = [[QSection alloc] init];

    QDateTimeInlineElement *el2 = [[QDateTimeInlineElement alloc] initWithTitle:@"Today" date:[NSDate date]];
    [section addElement:el2];

    QDateTimeInlineElement *el3 = [[QDateTimeInlineElement alloc] initWithTitle:@"Date only" date:[NSDate date]];
    el3.mode = UIDatePickerModeDate;
    [section addElement:el3];

    QDateTimeInlineElement *el4 = [[QDateTimeInlineElement alloc] initWithTitle:@"Time only" date:[NSDate date]];
    el3.mode = UIDatePickerModeTime;
    [section addElement:el4];

    QSection *section2 = [[QSection alloc] init];


    QDateTimeElement *el5 = [[QDateTimeElement alloc] initWithTitle:@"Time only" date:[NSDate date]];
    el5.mode = UIDatePickerModeTime;
    [section2 addElement:el5];

    QDateTimeElement *el6 = [[QDateTimeElement alloc] initWithTitle:@"Date only" date:[NSDate date]];
    el6.mode = UIDatePickerModeDate;
    [section2 addElement:el6];

    QDateTimeElement *el7 = [[QDateTimeElement alloc] initWithTitle:@"Full Date" date:[NSDate date]];
    el7.mode = UIDatePickerModeDateAndTime;
    [section2 addElement:el7];

    [root addSection:section];
    [root addSection:section2];
    return root;
}

+ (QRootElement *)create {
    QRootElement *root = [[QRootElement alloc] init];
    root.grouped = YES;
    root.title = @"QuickForms!";
	QSection *section0 = [[QSection alloc] init];
    section0.headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"quickdialog"]];
    [section0 addElement:[LoginController createLoginForm]];
    [section0 addElement:[self createGeneralControlsRoot]];

    QSection *section1 = [[QSection alloc] initWithTitle:@"Usage examples"];

    [section1 addElement:[self createLabelsRoot]];
    [section1 addElement:[self createSlidersRoot]];
    [section1 addElement:[self createRadioSectionsRoot]];
    [section1 addElement:[self createHtmlRoot]];
    [section1 addElement:[self createTextElementsRoot]];
    [section1 addElement:[self createDateTimeRoot]];
    [section1 addElement:[self createSortingRoot]];

    [section1 addElement:[self createSubForm1Root]];
	
	[section1 addElement:[self createWithInitDefault]];
	[section1 addElement:[self createWithInitAndKey]];

	[root addSection:section0];
    [root addSection:section1];


    return root;
}
@end