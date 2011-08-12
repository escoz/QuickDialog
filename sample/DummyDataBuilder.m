//
//  Created by escoz on 7/12/11.


#import <UIKit/UIKit.h>
#import "LoginController.h"
#import "DecimalElement.h"

@implementation DummyDataBuilder

+ (RootElement *)createWithInitDefault {
	
    RootElement *subForm = [[RootElement alloc] init];
    subForm.grouped = YES;
    subForm.title = @"Default Initialization";
	Section *subsection = [[Section alloc] initWithTitle:@"SubSection"];
    [subForm addSection:subsection];
	
	[subsection addElement:[[LabelElement alloc] init]];
	[subsection	addElement:[[BadgeElement alloc] init]];
	[subsection	addElement:[[BooleanElement alloc] init]];
	[subsection	addElement:[[ButtonElement alloc] init]];
	[subsection	addElement:[[DateTimeInlineElement alloc] init]];
	[subsection	addElement:[[FloatElement alloc] init]];
	[subsection	addElement:[[MapElement alloc] init]];
	[subsection	addElement:[[RadioElement alloc] init]];
	[subsection	addElement:[[RadioItemElement alloc] init]];
	[subsection	addElement:[[TextElement alloc] init]];
	[subsection	addElement:[[WebElement alloc] init]];
	
	return subForm;
}


+ (RootElement *)createWithInitAndKey {
	
    RootElement *subForm = [[RootElement alloc] init];
    subForm.grouped = YES;
    subForm.title = @"Initialization With Key";
	Section *subsection = [[Section alloc] initWithTitle:@"SubSection"];
    [subForm addSection:subsection];
	
	[subsection addElement:[[LabelElement alloc] initWithKey:@"Key1"]];
	[subsection	addElement:[[BadgeElement alloc] initWithKey:@"Key1"]];
	[subsection	addElement:[[BooleanElement alloc] initWithKey:@"Key1"]];
	[subsection	addElement:[[ButtonElement alloc] initWithKey:@"Key1"]];
	[subsection	addElement:[[DateTimeInlineElement alloc] initWithKey:@"Key1"]];
	[subsection	addElement:[[FloatElement alloc] initWithKey:@"Key1"]];
	[subsection	addElement:[[MapElement alloc] initWithKey:@"Key1"]];
	[subsection	addElement:[[RadioElement alloc] initWithKey:@"Key1"]];
	[subsection	addElement:[[RadioItemElement alloc] initWithKey:@"Key1"]];
	[subsection	addElement:[[TextElement alloc] initWithKey:@"Key1"]];
	[subsection	addElement:[[WebElement alloc] initWithKey:@"Key1"]];
	
	return subForm;
}


+ (RootElement *)createSubForm1Root {
    RootElement *subForm = [[RootElement alloc] init];
    Section *subsection = [[Section alloc] initWithTitle:@"SubSection"];
    subForm.grouped = YES;
    subForm.title = @"Subform";

    [subsection addElement:[[LabelElement alloc] initWithTitle:@"Some title" Value:@"Some value"]];
    [subsection addElement:[[EntryElement alloc] initWithTitle:@"Entry" Value:nil Placeholder:@"type here"]];
    [subsection addElement:[[BooleanElement alloc] initWithTitle:@"boolean" BoolValue:YES]];
    [subsection addElement:[[EntryElement alloc] initWithTitle:@"Entry 2" Value:@"Some value" Placeholder:@"type here two"]];
    [subForm addSection:subsection];

    Section *subsection2 = [[Section alloc] init];
    [subsection2 addElement:[[ButtonElement alloc] initWithTitle:@"My Button"]];
    [subForm addSection:subsection2];

    Section *subsection3 = [[Section alloc] init];
    BooleanElement *bool1 = [[BooleanElement alloc] initWithTitle:@"First option" BoolValue:YES];
    bool1.onImage = [UIImage imageNamed:@"imgOn"];
    bool1.offImage = [UIImage imageNamed:@"imgOff"];
    [subsection3 addElement:bool1];
    BooleanElement *bool2 = [[BooleanElement alloc] initWithTitle:@"Second option" BoolValue:NO];
    bool2.onImage = [UIImage imageNamed:@"imgOn"];
    bool2.offImage = [UIImage imageNamed:@"imgOff"];
    [subsection3 addElement:bool2];

    TextElement *element2 = [[TextElement alloc] initWithText:@"You get all kinds of notifications on your iOS device: new email, texts, friend requests, and more. With Notification Center, you can keep track of them all in one convenient location. Just swipe down from the top of any screen to enter Notification Center. Choose which notifications you want to see. Even see a stock ticker and the current weather. New notifications appear briefly at the top of your screen, without interrupting what you’re doing. And the Lock screen displays notifications so you can act on them with just a swipe. Notification Center is the best way to stay on top of your life’s breaking news."];
    element2.font = [UIFont boldSystemFontOfSize:12];
    Section *subsection4 = [[Section alloc] init];
    [subsection4 addElement:element2];


    [subForm addSection:subsection3];
    [subForm addSection:subsection4];
    return subForm;
}

+ (RootElement *)createSlidersRoot {
    RootElement *sliders = [[RootElement alloc] init];
    sliders.grouped = YES;
    sliders.title = @"sliders";
    Section *detailsSection = [[Section alloc] initWithTitle:@"Change some things"];

    [sliders addSection:detailsSection];

    [detailsSection addElement:[[FloatElement alloc] initWithValue:0.5]];
    [detailsSection addElement:[[FloatElement alloc] initWithTitle:@"Short" value:0.7]];
    [detailsSection addElement:[[FloatElement alloc] initWithTitle:@"Really really long title" value:1]];

    return sliders;
}

+ (Element *)createGeneralControlsRoot {
    RootElement *root = [[RootElement alloc] init];
    root.grouped = YES;
    root.title = @"Sample Controls";
    Section *controls = [[Section alloc] initWithTitle:@"Change something"];

    LabelElement *element1 = [[LabelElement alloc] initWithTitle:@"Label" Value:@"element"];
    
    RadioElement *radioElement = [[RadioElement alloc] initWithItems:[[NSArray alloc] initWithObjects:@"Option 1", @"Option 2", @"Option 3", nil] selected:0 title:@"Radio"];
	radioElement.key = @"radio1";

    BooleanElement *boolElement = [[BooleanElement alloc] initWithTitle:@"Boolean Element" BoolValue:YES];
	boolElement.key = @"bool1";
	
    EntryElement *entryElement = [[EntryElement alloc] initWithTitle:@"Entry Element" Value:nil Placeholder:@"type here"];
	entryElement.key = @"entry1";
	
    controls.footer = @"More controls will be added.";
    [controls addElement:element1];

    [controls addElement:radioElement];
    [controls addElement:entryElement];
	
    [controls addElement:boolElement];
	DateTimeInlineElement *dateElement = [[DateTimeInlineElement alloc] initWithTitle:@"DateTime" date:[NSDate date]];
	dateElement.key = @"date1";
    [controls addElement:dateElement];

    FloatElement *slider = [[FloatElement alloc] initWithTitle:@"Float Element" value:0.5];
	slider.key = @"slider1";
    [controls addElement:slider];
    
    DecimalElement *decimal = [[DecimalElement alloc] initWithTitle:@"Decimal Element" value:0.5];
    decimal.key = @"decimal1";
    decimal.fractionDigits = 3;
    [controls addElement:decimal];

    Section *btnSection = [[Section alloc] init];
	ButtonElement *button = [[ButtonElement alloc] initWithTitle:@"Show form values"];
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

    Section *btnSection2 = [[Section alloc] init];
	ButtonElement *button2 = [[ButtonElement alloc] initWithTitle:@"Fetch into dictionary"];
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

+ (Element *)createRadioSectionsRoot {
    RootElement *root = [[RootElement alloc] init];
    root.title = @"Radio elements";
    root.grouped = YES;

    Section *section1 = [[Section alloc] initWithTitle:@"Radio element with push"];
    [section1 addElement:[[RadioElement alloc] initWithItems:[NSArray arrayWithObjects:@"Football", @"Soccer", @"Formula 1", nil] selected:0]];
    [section1 addElement:[[RadioElement alloc] initWithItems:[NSArray arrayWithObjects:@"Football", @"Soccer", @"Formula 1", nil] selected:0 title:@"Sport"]];
    [root addSection:section1];


    Section *section2 = [[RadioSection alloc] initWithItems:[NSArray arrayWithObjects:@"Football", @"Soccer", @"Formula 1", nil] selected:0 title:@"Sport"];
    [root addSection:section2];


    return root;
}

+ (RootElement *)createHtmlRoot {
    RootElement *root = [[RootElement alloc] init];
    root.title = @"Web and map elements";

    WebElement *element1 = [[WebElement alloc] initWithTitle:@"ESCOZ Inc" url:@"http://escoz.com"];
    WebElement *element2 = [[WebElement alloc] initWithTitle:@"Quicklytics" url:@"http://escoz.com/quicklytics"];
    MapElement *element4 = [[MapElement alloc] initWithTitle:@"Florianopolis, Brazil" coordinate:CLLocationCoordinate2DMake(-27.59, -48.55)];

    Section *section1 = [[Section alloc] init];
    [section1 addElement:element1];
    [section1 addElement:element2];
    [section1 addElement:element4];

    [root addSection:section1];
    return root;
}

+ (RootElement *)createTextElementsRoot {
    RootElement *root = [[RootElement alloc] init];
    root.title = @"Text elements";

    TextElement *element1 = [[TextElement alloc] initWithText:
            @"Preparing for her flight\n"
            "I held with all my might\n"
            "Fearing my deepest fright\n"
            "She walked into the night\n"
            "She turned for one last look\n"
            "She looked me in the eye\n"
            "I said, \"I Love You...\n"
            "Good-bye\""];

    TextElement *element2 = [[TextElement alloc] initWithText:@"You get all kinds of notifications on your iOS device: new email, texts, friend requests, and more. With Notification Center, you can keep track of them all in one convenient location. Just swipe down from the top of any screen to enter Notification Center. Choose which notifications you want to see. Even see a stock ticker and the current weather. New notifications appear briefly at the top of your screen, without interrupting what you’re doing. And the Lock screen displays notifications so you can act on them with just a swipe. Notification Center is the best way to stay on top of your life’s breaking news."];
    element2.font = [UIFont boldSystemFontOfSize:12];

    TextElement *element3 = [[TextElement alloc] initWithText:@"Quicklytics App!"];
    element3.font = [UIFont fontWithName:@"Cochin-BoldItalic" size:24];
    element3.color = [UIColor blueColor];

    Section *section1 = [[Section alloc] init];
    [section1 addElement:element3];
    [section1 addElement:element1];
    [section1 addElement:element2];
    [root addSection:section1];
    return root;
}

+ (RootElement *)createLabelsRoot {
    RootElement *root = [[RootElement alloc] init];
    root.title = @"Labels";
    root.grouped = YES;
    Section *s1 = [[Section alloc] initWithTitle:@"LabelElement"];
    [s1 addElement:[[LabelElement alloc] initWithTitle:@"With no value" Value:nil]];
    [s1 addElement:[[LabelElement alloc] initWithTitle:@"With a value" Value:@"Value"]];
    [s1 addElement:[[LabelElement alloc] initWithTitle:@"Or a simple number" Value:@"123"]];

    Section *s2 = [[Section alloc] initWithTitle:@"BadgeElement"];
    BadgeElement *badge1 = [[BadgeElement alloc] initWithTitle:@"With a badge" Value:@"1"];
    [s2 addElement:badge1];
    BadgeElement *badge2 = [[BadgeElement alloc] initWithTitle:@"With a pink badge" Value:@"123"];
    badge2.badgeColor = [UIColor colorWithRed:0.9518 green:0.3862 blue:0.4113 alpha:1.0000];
    [s2 addElement:badge2];

    Section *secImg = [[Section alloc] initWithTitle:@"Images"];
    LabelElement *b1 = [[LabelElement alloc] initWithTitle:@"Processor" Value:@"OK"];
    b1.image = [UIImage imageNamed:@"intel"];
    [secImg addElement:b1];

    LabelElement *b2 = [[LabelElement alloc] initWithTitle:@"iPhone" Value:@"OK"];
    b2.image = [UIImage imageNamed:@"iPhone"];
    [secImg addElement:b2];

    BadgeElement *b3 = [[BadgeElement alloc] initWithTitle:@"Keyboard" Value:@"ERROR"];
    b3.image = [UIImage imageNamed:@"keyboard"];
    b3.badgeColor = [UIColor redColor];
    [secImg addElement:b3];

    BadgeElement *badge3 = [[BadgeElement alloc] initWithTitle:@"With some action" Value:@"123"];
    badge3.badgeColor = [UIColor purpleColor];
    Section *sec = [[Section alloc] initWithTitle:@"Jazzin.."];
    [badge3 addSection:sec];
    [s2 addElement:badge3];
    [sec addElement:[[BadgeElement alloc] initWithTitle:@"Test" Value:@"0"]];
    [sec addElement:[[BadgeElement alloc] initWithTitle:@"Test 2" Value:@"10"]];
    [sec addElement:[[BadgeElement alloc] initWithTitle:@"Test 3" Value:@"200"]];
    [sec addElement:[[BadgeElement alloc] initWithTitle:@"Test 4" Value:@"1000"]];
    [sec addElement:[[BadgeElement alloc] initWithTitle:@"Test 5" Value:@"TEST"]];

    [root addSection:s1];
    [root addSection:s2];
    [root addSection:secImg];
    return root;
}

+ (RootElement *)createSortingRoot {

    RootElement *root = [[RootElement alloc] init];
    root.title = @"Sorting";
    root.grouped = YES;

    SortingSection *sortingSection = [[SortingSection alloc] init];
    sortingSection.key = @"sortedSection";
    [sortingSection addElement:[[LabelElement alloc] initWithTitle:@"First" Value:@"1"]];
    [sortingSection addElement:[[LabelElement alloc] initWithTitle:@"Second" Value:@"2"]];
    [sortingSection addElement:[[LabelElement alloc] initWithTitle:@"Third" Value:@"3"]];
    [sortingSection addElement:[[LabelElement alloc] initWithTitle:@"Forth" Value:@"4"]];
    [sortingSection addElement:[[LabelElement alloc] initWithTitle:@"Fifth" Value:@"5"]];

    int i = 1;
    for (Element* el in sortingSection.elements){
        el.key = [NSString stringWithFormat:@"item %d", i++];
    }

    [root addSection:sortingSection];

    Section *action = [[Section alloc] init];
    ButtonElement *button = [[ButtonElement alloc] initWithTitle:@"Read Order"];
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

+ (RootElement *)createDateTimeRoot {
    RootElement *root = [[RootElement alloc] init];
    root.title = @"Date Time";
    root.grouped = YES;

    Section *section = [[Section alloc] init];

    DateTimeInlineElement *el2 = [[DateTimeInlineElement alloc] initWithTitle:@"Today" date:[NSDate date]];
    [section addElement:el2];

    DateTimeInlineElement *el3 = [[DateTimeInlineElement alloc] initWithTitle:@"Date only" date:[NSDate date]];
    el3.mode = UIDatePickerModeDate;
    [section addElement:el3];

    DateTimeInlineElement *el4 = [[DateTimeInlineElement alloc] initWithTitle:@"Time only" date:[NSDate date]];
    el3.mode = UIDatePickerModeTime;
    [section addElement:el4];

    Section *section2 = [[Section alloc] init];


    DateTimeElement *el5 = [[DateTimeElement alloc] initWithTitle:@"Time only" date:[NSDate date]];
    el5.mode = UIDatePickerModeTime;
    [section2 addElement:el5];

    DateTimeElement *el6 = [[DateTimeElement alloc] initWithTitle:@"Date only" date:[NSDate date]];
    el6.mode = UIDatePickerModeDate;
    [section2 addElement:el6];

    DateTimeElement *el7 = [[DateTimeElement alloc] initWithTitle:@"Full Date" date:[NSDate date]];
    el7.mode = UIDatePickerModeDateAndTime;
    [section2 addElement:el7];

    [root addSection:section];
    [root addSection:section2];
    return root;
}

+ (RootElement *)create {
    RootElement *root = [[RootElement alloc] init];
    root.grouped = YES;
    root.title = @"QuickForms!";
	Section *section0 = [[Section alloc] init];
    section0.headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"quickdialog"]];
    [section0 addElement:[LoginController createLoginForm]];
    [section0 addElement:[self createGeneralControlsRoot]];

    Section *section1 = [[Section alloc] initWithTitle:@"Usage examples"];

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