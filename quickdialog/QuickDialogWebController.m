#import "QuickDialogWebController.h"
#import "QuickDialog.h"

@implementation QuickDialogWebController {

}

@synthesize url;

- (NSURLRequest *)createRequestForUrl {
    return [[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:self.url]];
}

- (void)presentError:(NSError *)error {
    [self.root bindToObject:[NSDictionary dictionary]];
    [self.quickDialogTableView reloadData];
    [[[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    [self loading:NO];
}

- (void)presentResult:(NSData *)data {
    NSError *jsonError;
    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

    if (jsonError==nil){
        [self.root bindToObject:responseDict];
        [self.quickDialogTableView reloadData];
    }

    [self loading:NO];
}

- (void)reload {
    NSURLRequest *request = [self createRequestForUrl];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *err) {
                                if (err){
                                   [self presentError:err];
                                   return;
                                }
                               [self presentResult:data];

                           }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.url==nil && [self.root.object isKindOfClass:[NSString class]])
        self.url = (NSString *) self.root.object;

    if (self.url!=nil){
        [self loading:YES];
        [self reload];
    }

}


@end
