#import "DRDefaults.h"
#import "DRLog.h"
#import <Foundation/Foundation.h>
#import <dlfcn.h>
#import <initializer_list>
#import <objc/runtime.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

namespace {

auto _DRSolariumEnabled(id /*self*/, SEL /*_cmd*/) -> BOOL
{
	return [DRDefaults isSolariumEnabled];
}

__attribute__((constructor(101))) void DRDisableSolarium()
{
	DRLog(@"Darkroom: has entered the building :3");

	Class _NSSolarium = NSClassFromString(@"_NSSolarium");
	if (_NSSolarium == nullptr) {
		DRLog(@"Darkroom: _NSSolarium is missing, bailing");
		return;
	}

	Class metaclass = object_getClass(_NSSolarium);
	for (auto* selector : { @selector(isEnabled), @selector(isEnabledIgnoringCompatibility) }) {
		Method method = class_getInstanceMethod(metaclass, selector);
		if (method != nullptr) {
			method_setImplementation(method, reinterpret_cast<IMP>(_DRSolariumEnabled));
		} else {
			DRLog(@"Darkroom: +[_NSSolarium %@] is missing", NSStringFromSelector(selector));
		}
	}
}

} // namespace
