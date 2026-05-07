#pragma once

#import "DRDefaults.h"
#import <Foundation/Foundation.h>

#define DRLog(...)             \
	if (![DRDefaults isQuiet]) { \
		NSLog(__VA_ARGS__);        \
	}
