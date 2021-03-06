// Copyright 2018 Omni Development, Inc. All rights reserved.
//
// This software may only be used and reproduced according to the
// terms in the file OmniSourceLicense.html, which should be
// distributed with this project and can also be found at
// <http://www.omnigroup.com/developer/sourcecode/sourcelicense/>.
//
// $Id$

public extension NSView {
    public func enclosingView<T: NSView>(of type: T.Type) -> T? {
        return __enclosingView(of: type) as? T
    }
}
