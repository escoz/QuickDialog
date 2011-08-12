//
//  Created by escoz on 7/26/11.
//

#import "LoginController.h"
#import "LoginInfo.h"
#import "../quickdialog/QuickDialogTableView.h"


@interface LoginController ()
- (void)onLogin:(ButtonElement *)buttonElement;
- (void)onAbout;

@end

@implementation LoginController

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor colorWithHue:0.1174 saturation:0.7131 brightness:0.8618 alpha:1.0000];
    self.tableView.bounces = NO;
    ((QuickDialogTableView *)self.tableView).styleProvider = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"About" style:UIBarButtonItemStylePlain target:self action:@selector(onAbout)];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.tintColor = nil;
}

- (void)loginCompleted:(LoginInfo *)info {
    [self loading:NO];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome" message:[NSString stringWithFormat: @"Hi %@, you're loving QuickForms!", info.login] delegate:self cancelButtonTitle:@"YES!" otherButtonTitles:nil];
    [alert show];
}


- (void)onLogin:(ButtonElement *)buttonElement {
    [self loading:YES];
    LoginInfo *info = [[LoginInfo alloc] init];
    [self.root fetchValueIntoObject:info];

    [self performSelector:@selector(loginCompleted:) withObject:info afterDelay:2];
}

- (void)onAbout {
    RootElement *details = [LoginController createDetailsForm];

    QuickDialogController *quickform = [QuickDialogController controllerForRoot:details];
    [self presentModalViewController:[[UINavigationController alloc] initWithRootViewController:quickform] animated:YES];
}

-(void) cell:(UITableViewCell *)cell willAppearForElement:(Element *)element atIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = [UIColor colorWithRed:0.9582 green:0.9104 blue:0.7991 alpha:1.0000];
    
    if ([element isKindOfClass:[EntryElement class]] || [element isKindOfClass:[ButtonElement class]]){
        cell.textLabel.textColor = [UIColor colorWithRed:0.6033 green:0.2323 blue:0.0000 alpha:1.0000];
    }   
}


+ (RootElement *)createDetailsForm {
    RootElement *details = [[RootElement alloc] init];
    details.title = @"Details";
    details.controllerName = @"AboutController";
    details.grouped = YES;
    Section *section = [[Section alloc] initWithTitle:@"Information"];
    [section addElement:[[TextElement alloc] initWithText:@"Here's some more info about this app."]];
    [details addSection:section];
    return details;
}

+ (RootElement *)createLoginForm {
    RootElement *root = [[RootElement alloc] init];
    root.controllerName = @"LoginController";
    root.grouped = YES;
    root.title = @"Login";

    Section *main = [[Section alloc] init];
    main.headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];

    EntryElement *login = [[EntryElement alloc] init];
    login.title = @"Username";
    login.key = @"login";
    login.hiddenToolbar = YES;
    login.placeholder = @"johndoe@me.com";
    [main addElement:login];

    EntryElement *password = [[EntryElement alloc] init];
    password.title = @"Password";
    password.key = @"password";
    password.isPassword = YES;
    password.hiddenToolbar = YES;
    password.placeholder = @"your password";
    [main addElement:password];

    [root addSection:main];

    Section *btSection = [[Section alloc] init];
    ButtonElement *btLogin = [[ButtonElement alloc] init];
    btLogin.title = @"Login";
    btLogin.controllerAction = @"onLogin:";
    [btSection addElement:btLogin];

    [root addSection:btSection];

    btSection.footerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"footer"]];

    return root;
}



@end