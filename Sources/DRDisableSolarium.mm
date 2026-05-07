#import <Foundation/Foundation.h>
#include <dlfcn.h>
#include <initializer_list>
#include <objc/runtime.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

namespace {

auto DRAbsolutelyNot(id /*self*/, SEL /*_cmd*/) -> BOOL
{
	return NO;
}

__attribute__((constructor(101))) void DRDisableSolarium()
{
	NSLog(@"Darkroom: has entered the building :3");

	Class _NSSolarium = NSClassFromString(@"_NSSolarium");
	if (_NSSolarium == nullptr) {
		NSLog(@"Darkroom: _NSSolarium is missing, bailing");
		return;
	}

	Class metaclass = object_getClass(_NSSolarium);
	for (auto* selector : { @selector(isEnabled), @selector(isEnabledIgnoringCompatibility) }) {
		Method method = class_getInstanceMethod(metaclass, selector);
		if (method != nullptr) {
			method_setImplementation(method, reinterpret_cast<IMP>(DRAbsolutelyNot));
		} else {
			NSLog(@"Darkroom: +[_NSSolarium %@] is missing", NSStringFromSelector(selector));
		}
	}
}

} // namespace
