//
//  Created by escoz on 7/9/11.


#import "QEntryTableViewCell.h"
#import "QElement.h"
#import "QLabelElement.h"
#import "QEntryElement.h"
#import "QSection.h"
#import "QuickDialogTableView.h"


@interface QEntryTableViewCell ()
- (void)previousNextDelegate:(UISegmentedControl *)control;
- (QEntryElement *)findNextElementToFocusOn;

@end

@implementation QEntryTableViewCell

-(void)createActionBar {
    if (_actionBar == nil) {
        _actionBar = [[UIToolbar alloc] init];
        _actionBar.translucent = YES;
        [_actionBar sizeToFit];
        _actionBar.barStyle = UIBarStyleBlackTranslucent;

        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                       style:UIBarButtonItemStyleDone target:self
                                                                      action:@selector(textFieldMustReturn:)];

        UISegmentedControl *prevNext = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Previous", @"Next", nil]];
        prevNext.momentary = YES;
        prevNext.segmentedControlStyle = UISegmentedControlStyleBar;
        prevNext.tintColor = [UIColor darkGrayColor];
        [prevNext addTarget:self action:@selector(previousNextDelegate:) forControlEvents:UIControlEventValueChanged];
        UIBarButtonItem *prevNextWrapper = [[UIBarButtonItem alloc] initWithCustomView:prevNext];
        UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [_actionBar setItems:[NSArray arrayWithObjects:prevNextWrapper, flexible, doneButton, nil]];
	}
	_textField.inputAccessoryView = _actionBar;
}

- (void)createSubviews {
    _textField = [[UITextField alloc] init];
    [_textField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    _textField.borderStyle = UITextBorderStyleNone;
    _textField.delegate = self;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.contentView addSubview:_textField];

    [self setNeedsLayout];
}

- (QEntryTableViewCell *)init {
    self = [self initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"QuickformEntryElement"];
    if (self!=nil){
        [self createSubviews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (CGRect)calculateFrameForEntryElement {
    if (_entryElement.title == NULL) {
        return CGRectMake(10,11,self.contentView.frame.size.width-30, 24);
    }
    CGFloat totalWidth = self.contentView.frame.size.width;
    CGFloat titleWidth = 0;

    if (CGRectEqualToRect(CGRectZero, _entryElement.parentSection.entryPosition)) {

        for (QElement *el in _entryElement.parentSection.elements){
            if ([el isKindOfClass:[QEntryElement class]]){
                CGFloat fontSize = self.textLabel.font.lineHeight == 0? 18 : self.textLabel.font.lineHeight;
                CGSize size = [((QEntryElement *)el).title sizeWithFont:[UIFont systemFontOfSize:fontSize] forWidth:CGFLOAT_MAX lineBreakMode:UILineBreakModeWordWrap] ;
                if (size.width>titleWidth)
                    titleWidth = size.width;
            }
        }

        CGFloat separator = titleWidth > 0 ? 20 : 0;
        _entryElement.parentSection.entryPosition = CGRectMake(titleWidth+separator,11,totalWidth-titleWidth-22-separator,24);
    }

    return _entryElement.parentSection.entryPosition;
}

- (void)prepareForElement:(QEntryElement *)element inTableView:(QuickDialogTableView *)tableView{
    self.textLabel.text = element.title;
    
    _quickformTableView = tableView;
    _entryElement = element;
    [self recalculatePositioning];
    _textField.text = _entryElement.textValue;
    _textField.placeholder = _entryElement.placeholder;
    _textField.secureTextEntry = _entryElement.isPassword;
    if (_entryElement.hiddenToolbar){
        _textField.inputAccessoryView = nil;
    } else {
        [self createActionBar];
    }
}

-(void)recalculatePositioning {
    _entryElement.parentSection.entryPosition = CGRectZero;
   _textField.frame = [self calculateFrameForEntryElement];
}

- (void)prepareForReuse {
    _quickformTableView = nil;
    _entryElement = nil;
}

- (void)textFieldEditingChanged:(UITextField *)textFieldEditingChanged {
   _entryElement.textValue = _textField.text;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    UIReturnKeyType returnType = ([self findNextElementToFocusOn]!=nil) ? UIReturnKeyNext : UIReturnKeyDone;
    _textField.returnKeyType = returnType;
    _quickformTableView.selectedCell = self;
}


- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected==YES){
        [_textField becomeFirstResponder];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    _entryElement.textValue = _textField.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_textField resignFirstResponder];

    QEntryElement *element = [self findNextElementToFocusOn];
    if (element!=nil){
        UITableViewCell *cell = [_quickformTableView cellForElement:element];
        if (cell!=nil){
            [cell becomeFirstResponder];
        }
    }
    return YES;
}

- (void) previousNextDelegate:(UISegmentedControl *)control {
	QEntryElement *element; 
	if (control.selectedSegmentIndex == 1){
		element = [self findNextElementToFocusOn];
		
	} else {
		element = [self findPreviousElementToFocusOn];
	}
	if (element!=nil){
		UITableViewCell *cell = [_quickformTableView cellForElement:element];
		if (cell!=nil){
			[cell becomeFirstResponder];
		}
	}
	
}


- (BOOL)textFieldMustReturn:(UITextField *)textField {
    [_textField resignFirstResponder];
    return NO;
}

- (BOOL)becomeFirstResponder {
    [_textField becomeFirstResponder];
	return YES;
}

- (BOOL)resignFirstResponder {
    [_textField resignFirstResponder];
	return YES;
}

- (QEntryElement *)findPreviousElementToFocusOn {
    QEntryElement *previousElement = nil;
    for (QElement * e in _entryElement.parentSection.elements){
        if (e == _entryElement) {
			return previousElement;
        }
        else if ([e isKindOfClass:[QEntryElement class]]){
            previousElement = (QEntryElement *)e;
        }
    }
    return nil;
}

- (QEntryElement *)findNextElementToFocusOn {
    BOOL foundSelf = NO;
    for (QElement * e in _entryElement.parentSection.elements){
        if (e == _entryElement) {
           foundSelf = YES;
        }
        else if (foundSelf && [e isKindOfClass:[QEntryElement class]]){
            return (QEntryElement *) e;
        }
    }
    return nil;
}


@end