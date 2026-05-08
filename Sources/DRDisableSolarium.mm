#import "DRDefaults.h"
#import "DRLog.h"
#import <Foundation/Foundation.h>
#import <array>
#import <dlfcn.h>
#import <objc/runtime.h>

// we are patching SPI
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

namespace {

BOOL _DRSolariumEnabled(id /*self*/, SEL /*_cmd*/)
{
	return [DRDefaults isSolariumEnabled];
}

__attribute__((constructor(101))) void DRDisableSolarium()
{
	DRLog(@"Darkroom: has entered the building :3");

	Class _NSSolarium { NSClassFromString(@"_NSSolarium") };
	if (_NSSolarium == nullptr) {
		DRLog(@"Darkroom: _NSSolarium is missing, bailing");
		return;
	}

	Class metaclass { object_getClass(_NSSolarium) };
	auto selectors = std::array { @selector(isEnabled), @selector(isEnabledIgnoringCompatibility) };
	for (SEL selector : selectors) {
		Method method { class_getInstanceMethod(metaclass, selector) };
		if (method != nullptr) {
			method_setImplementation(method, reinterpret_cast<IMP>(_DRSolariumEnabled));
		} else {
			DRLog(@"Darkroom: +[_NSSolarium %@] is missing", NSStringFromSelector(selector));
		}
	}
}

} // namespace
