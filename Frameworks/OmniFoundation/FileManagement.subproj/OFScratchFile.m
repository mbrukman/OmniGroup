// Copyright 1997-2005, 2007-2008, 2011, 2013 Omni Development, Inc. All rights reserved.
//
// This software may only be used and reproduced according to the
// terms in the file OmniSourceLicense.html, which should be
// distributed with this project and can also be found at
// <http://www.omnigroup.com/developer/sourcecode/sourcelicense/>.

#import <OmniFoundation/OFScratchFile.h>

#import <OmniFoundation/NSFileManager-OFExtensions.h>

RCS_ID("$Id$")

@implementation OFScratchFile
{
    NSString *filename;
    NSData *contentData;
    NSString *contentString;
    NSMutableArray *retainedObjects;
}

+ (OFScratchFile *)scratchFileNamed:(NSString *)aName error:(NSError **)outError;
{
    NSString *fileName = [[NSFileManager defaultManager] scratchFilenameNamed:aName error:outError];
    if (!fileName)
        return nil;
    return [[[self alloc] initWithFilename:fileName] autorelease];
}

+ (OFScratchFile *)scratchDirectoryNamed:(NSString *)aName error:(NSError **)outError;
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *scratchFilename = [fileManager scratchFilenameNamed:aName error:outError];
    if (!scratchFilename)
        return nil;
    
    [fileManager removeItemAtPath:scratchFilename error:NULL];
    if (![fileManager createDirectoryAtPath:scratchFilename withIntermediateDirectories:YES attributes:nil error:outError])
        return nil;
    
    return [[[self alloc] initWithFilename:scratchFilename] autorelease];
}

- initWithFilename:(NSString *)aFilename;
{
    if (!(self = [super init]))
        return nil;

    filename = [aFilename retain];
    retainedObjects = [[NSMutableArray alloc] init];

    return self;
}

- (void)dealloc;
{
    [[NSFileManager defaultManager] removeItemAtPath:filename error:NULL];
    [filename release];
    [contentData release];
    [contentString release];
    [retainedObjects release];
    [super dealloc];
}

- (NSString *)filename;
{
    return filename;
}

- (NSData *)contentData;
{
    if (contentData)
	return contentData;
    contentData = [[NSData alloc] initWithContentsOfMappedFile:filename];
    return contentData;
}

- (NSString *)contentString;
{
    if (contentString)
	return contentString;
    contentString = [[NSString alloc] initWithData:[self contentData] encoding:NSISOLatin1StringEncoding];
    return contentString;
}

- (NSMutableDictionary *)debugDictionary;
{
    NSMutableDictionary *dict = [super debugDictionary];

    if (filename)
        dict[@"filename"] = filename;

    return dict;
}

@end
