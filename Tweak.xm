#import "Tweak.h"

%group tweak
%hook UIWindow

-(id)initWithFrame:(CGRect)arg1 {

    return %orig;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
				selector:@selector(showAlert:)
				name:@"CustomLowBatteryinfoChanged"
				object:nil];

}

-(void)showAlert:(NSNotification *)notification {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert"
                                message:@"This is an alert."
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
    handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self.rootViewController presentViewController:alert animated:YES completion:nil];
}

%end

%hook BCBatteryDevice

-(void)setPercentCharge:(NSInteger)arg1 {

    if(arg1!=0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CustomLowBatteryinfoChanged" object:nil userInfo:nil];
    }
    %orig;
}

-(void)setBatterySaverModeActive:(BOOL)arg1 {

    [[NSNotificationCenter defaultCenter] postNotificationName:@"CustomLowBatteryinfoChanged" object:nil userInfo:nil];
    %orig;
}

%end
%end

%ctor {
    %init(tweak);
}