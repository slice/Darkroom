#import "DRDefaults.h"

namespace {

auto constexpr quietKey = @"DRQuiet";
auto constexpr solariumEnabledKey = @"DRSolariumEnabled";

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

+ (void)initialize
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
