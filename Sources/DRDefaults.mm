#import "DRDefaults.h"

namespace {

NSString* const quietKey = @"DRQuiet";
NSString* const solariumEnabledKey = @"DRSolariumEnabled";

NSUserDefaults* _DRDefaults()
{
	// (not using another suite for now)
	return [NSUserDefaults standardUserDefaults];
}

void _DRRegisterDefaults()
{
	[_DRDefaults() registerDefaults:@{
		quietKey : @NO,
		solariumEnabledKey : @NO,
	}];
}

} // namespace

@implementation DRDefaults

+ (void)load
{
	if (self != [DRDefaults class])
		return;
	_DRRegisterDefaults();
}

+ (BOOL)isQuiet
{
	return [_DRDefaults() boolForKey:quietKey];
}

+ (BOOL)isSolariumEnabled
{
	return [_DRDefaults() boolForKey:solariumEnabledKey];
}

@end
