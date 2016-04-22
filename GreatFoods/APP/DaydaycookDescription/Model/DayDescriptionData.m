//
//  DayDescriptionData.m
//
//  Created by 浩文 夏 on 16/4/19
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "DayDescriptionData.h"


NSString *const kDayDescriptionDataClickCount = @"clickCount";
NSString *const kDayDescriptionDataDetailsUrl = @"detailsUrl";
NSString *const kDayDescriptionDataDifficulty = @"difficulty";
NSString *const kDayDescriptionDataId = @"id";
NSString *const kDayDescriptionDataImageUrlFlow = @"imageUrlFlow";
NSString *const kDayDescriptionDataCategory = @"category";
NSString *const kDayDescriptionDataCategoryID = @"categoryID";
NSString *const kDayDescriptionDataLable = @"lable";
NSString *const kDayDescriptionDataTaste = @"taste";
NSString *const kDayDescriptionDataDeleteStatus = @"deleteStatus";
NSString *const kDayDescriptionDataScreList = @"screList";
NSString *const kDayDescriptionDataDescription = @"description";
NSString *const kDayDescriptionDataTechnology = @"technology";
NSString *const kDayDescriptionDataType = @"type";
NSString *const kDayDescriptionDataReleaseDate = @"releaseDate";
NSString *const kDayDescriptionDataPeopleEat = @"peopleEat";
NSString *const kDayDescriptionDataLoadContent = @"loadContent";
NSString *const kDayDescriptionDataScreeningId = @"screeningId";
NSString *const kDayDescriptionDataArea = @"area";
NSString *const kDayDescriptionDataIndexUrl = @"indexUrl";
NSString *const kDayDescriptionDataImageHeight = @"imageHeight";
NSString *const kDayDescriptionDataParentCategoryId = @"parentCategoryId";
NSString *const kDayDescriptionDataShareUrl = @"shareUrl";
NSString *const kDayDescriptionDataMaketime = @"maketime";
NSString *const kDayDescriptionDataPageInfo = @"pageInfo";
NSString *const kDayDescriptionDataName = @"name";
NSString *const kDayDescriptionDataShareCount = @"shareCount";
NSString *const kDayDescriptionDataFavorite = @"favorite";
NSString *const kDayDescriptionDataReleasePlat = @"releasePlat";
NSString *const kDayDescriptionDataCreateDate = @"createDate";
NSString *const kDayDescriptionDataContent = @"content";
NSString *const kDayDescriptionDataModifyDate = @"modifyDate";
NSString *const kDayDescriptionDataImageWidth = @"imageWidth";
NSString *const kDayDescriptionDataImageUrl = @"imageUrl";
NSString *const kDayDescriptionDataTitle = @"title";
NSString *const kDayDescriptionDataDisplayState = @"displayState";


@interface DayDescriptionData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation DayDescriptionData

@synthesize clickCount = _clickCount;
@synthesize detailsUrl = _detailsUrl;
@synthesize difficulty = _difficulty;
@synthesize dataIdentifier = _dataIdentifier;
@synthesize imageUrlFlow = _imageUrlFlow;
@synthesize category = _category;
@synthesize categoryID = _categoryID;
@synthesize lable = _lable;
@synthesize taste = _taste;
@synthesize deleteStatus = _deleteStatus;
@synthesize screList = _screList;
@synthesize dataDescription = _dataDescription;
@synthesize technology = _technology;
@synthesize type = _type;
@synthesize releaseDate = _releaseDate;
@synthesize peopleEat = _peopleEat;
@synthesize loadContent = _loadContent;
@synthesize screeningId = _screeningId;
@synthesize area = _area;
@synthesize indexUrl = _indexUrl;
@synthesize imageHeight = _imageHeight;
@synthesize parentCategoryId = _parentCategoryId;
@synthesize shareUrl = _shareUrl;
@synthesize maketime = _maketime;
@synthesize pageInfo = _pageInfo;
@synthesize name = _name;
@synthesize shareCount = _shareCount;
@synthesize favorite = _favorite;
@synthesize releasePlat = _releasePlat;
@synthesize createDate = _createDate;
@synthesize content = _content;
@synthesize modifyDate = _modifyDate;
@synthesize imageWidth = _imageWidth;
@synthesize imageUrl = _imageUrl;
@synthesize title = _title;
@synthesize displayState = _displayState;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.clickCount = [[self objectOrNilForKey:kDayDescriptionDataClickCount fromDictionary:dict] doubleValue];
            self.detailsUrl = [self objectOrNilForKey:kDayDescriptionDataDetailsUrl fromDictionary:dict];
            self.difficulty = [self objectOrNilForKey:kDayDescriptionDataDifficulty fromDictionary:dict];
            self.dataIdentifier = [[self objectOrNilForKey:kDayDescriptionDataId fromDictionary:dict] doubleValue];
            self.imageUrlFlow = [self objectOrNilForKey:kDayDescriptionDataImageUrlFlow fromDictionary:dict];
            self.category = [self objectOrNilForKey:kDayDescriptionDataCategory fromDictionary:dict];
            self.categoryID = [self objectOrNilForKey:kDayDescriptionDataCategoryID fromDictionary:dict];
            self.lable = [self objectOrNilForKey:kDayDescriptionDataLable fromDictionary:dict];
            self.taste = [self objectOrNilForKey:kDayDescriptionDataTaste fromDictionary:dict];
            self.deleteStatus = [[self objectOrNilForKey:kDayDescriptionDataDeleteStatus fromDictionary:dict] doubleValue];
            self.screList = [self objectOrNilForKey:kDayDescriptionDataScreList fromDictionary:dict];
            self.dataDescription = [self objectOrNilForKey:kDayDescriptionDataDescription fromDictionary:dict];
            self.technology = [self objectOrNilForKey:kDayDescriptionDataTechnology fromDictionary:dict];
            self.type = [self objectOrNilForKey:kDayDescriptionDataType fromDictionary:dict];
            self.releaseDate = [self objectOrNilForKey:kDayDescriptionDataReleaseDate fromDictionary:dict];
            self.peopleEat = [self objectOrNilForKey:kDayDescriptionDataPeopleEat fromDictionary:dict];
            self.loadContent = [self objectOrNilForKey:kDayDescriptionDataLoadContent fromDictionary:dict];
            self.screeningId = [self objectOrNilForKey:kDayDescriptionDataScreeningId fromDictionary:dict];
            self.area = [self objectOrNilForKey:kDayDescriptionDataArea fromDictionary:dict];
            self.indexUrl = [self objectOrNilForKey:kDayDescriptionDataIndexUrl fromDictionary:dict];
            self.imageHeight = [self objectOrNilForKey:kDayDescriptionDataImageHeight fromDictionary:dict];
            self.parentCategoryId = [self objectOrNilForKey:kDayDescriptionDataParentCategoryId fromDictionary:dict];
            self.shareUrl = [self objectOrNilForKey:kDayDescriptionDataShareUrl fromDictionary:dict];
            self.maketime = [self objectOrNilForKey:kDayDescriptionDataMaketime fromDictionary:dict];
            self.pageInfo = [self objectOrNilForKey:kDayDescriptionDataPageInfo fromDictionary:dict];
            self.name = [self objectOrNilForKey:kDayDescriptionDataName fromDictionary:dict];
            self.shareCount = [[self objectOrNilForKey:kDayDescriptionDataShareCount fromDictionary:dict] doubleValue];
            self.favorite = [[self objectOrNilForKey:kDayDescriptionDataFavorite fromDictionary:dict] boolValue];
            self.releasePlat = [self objectOrNilForKey:kDayDescriptionDataReleasePlat fromDictionary:dict];
            self.createDate = [[self objectOrNilForKey:kDayDescriptionDataCreateDate fromDictionary:dict] doubleValue];
            self.content = [self objectOrNilForKey:kDayDescriptionDataContent fromDictionary:dict];
            self.modifyDate = [[self objectOrNilForKey:kDayDescriptionDataModifyDate fromDictionary:dict] doubleValue];
            self.imageWidth = [self objectOrNilForKey:kDayDescriptionDataImageWidth fromDictionary:dict];
            self.imageUrl = [self objectOrNilForKey:kDayDescriptionDataImageUrl fromDictionary:dict];
            self.title = [self objectOrNilForKey:kDayDescriptionDataTitle fromDictionary:dict];
            self.displayState = [self objectOrNilForKey:kDayDescriptionDataDisplayState fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.clickCount] forKey:kDayDescriptionDataClickCount];
    [mutableDict setValue:self.detailsUrl forKey:kDayDescriptionDataDetailsUrl];
    [mutableDict setValue:self.difficulty forKey:kDayDescriptionDataDifficulty];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dataIdentifier] forKey:kDayDescriptionDataId];
    [mutableDict setValue:self.imageUrlFlow forKey:kDayDescriptionDataImageUrlFlow];
    [mutableDict setValue:self.category forKey:kDayDescriptionDataCategory];
    [mutableDict setValue:self.categoryID forKey:kDayDescriptionDataCategoryID];
    [mutableDict setValue:self.lable forKey:kDayDescriptionDataLable];
    [mutableDict setValue:self.taste forKey:kDayDescriptionDataTaste];
    [mutableDict setValue:[NSNumber numberWithDouble:self.deleteStatus] forKey:kDayDescriptionDataDeleteStatus];
    NSMutableArray *tempArrayForScreList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.screList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForScreList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForScreList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForScreList] forKey:kDayDescriptionDataScreList];
    [mutableDict setValue:self.dataDescription forKey:kDayDescriptionDataDescription];
    [mutableDict setValue:self.technology forKey:kDayDescriptionDataTechnology];
    [mutableDict setValue:self.type forKey:kDayDescriptionDataType];
    [mutableDict setValue:self.releaseDate forKey:kDayDescriptionDataReleaseDate];
    [mutableDict setValue:self.peopleEat forKey:kDayDescriptionDataPeopleEat];
    [mutableDict setValue:self.loadContent forKey:kDayDescriptionDataLoadContent];
    [mutableDict setValue:self.screeningId forKey:kDayDescriptionDataScreeningId];
    [mutableDict setValue:self.area forKey:kDayDescriptionDataArea];
    [mutableDict setValue:self.indexUrl forKey:kDayDescriptionDataIndexUrl];
    [mutableDict setValue:self.imageHeight forKey:kDayDescriptionDataImageHeight];
    [mutableDict setValue:self.parentCategoryId forKey:kDayDescriptionDataParentCategoryId];
    [mutableDict setValue:self.shareUrl forKey:kDayDescriptionDataShareUrl];
    [mutableDict setValue:self.maketime forKey:kDayDescriptionDataMaketime];
    [mutableDict setValue:self.pageInfo forKey:kDayDescriptionDataPageInfo];
    [mutableDict setValue:self.name forKey:kDayDescriptionDataName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.shareCount] forKey:kDayDescriptionDataShareCount];
    [mutableDict setValue:[NSNumber numberWithBool:self.favorite] forKey:kDayDescriptionDataFavorite];
    [mutableDict setValue:self.releasePlat forKey:kDayDescriptionDataReleasePlat];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createDate] forKey:kDayDescriptionDataCreateDate];
    [mutableDict setValue:self.content forKey:kDayDescriptionDataContent];
    [mutableDict setValue:[NSNumber numberWithDouble:self.modifyDate] forKey:kDayDescriptionDataModifyDate];
    [mutableDict setValue:self.imageWidth forKey:kDayDescriptionDataImageWidth];
    [mutableDict setValue:self.imageUrl forKey:kDayDescriptionDataImageUrl];
    [mutableDict setValue:self.title forKey:kDayDescriptionDataTitle];
    [mutableDict setValue:self.displayState forKey:kDayDescriptionDataDisplayState];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.clickCount = [aDecoder decodeDoubleForKey:kDayDescriptionDataClickCount];
    self.detailsUrl = [aDecoder decodeObjectForKey:kDayDescriptionDataDetailsUrl];
    self.difficulty = [aDecoder decodeObjectForKey:kDayDescriptionDataDifficulty];
    self.dataIdentifier = [aDecoder decodeDoubleForKey:kDayDescriptionDataId];
    self.imageUrlFlow = [aDecoder decodeObjectForKey:kDayDescriptionDataImageUrlFlow];
    self.category = [aDecoder decodeObjectForKey:kDayDescriptionDataCategory];
    self.categoryID = [aDecoder decodeObjectForKey:kDayDescriptionDataCategoryID];
    self.lable = [aDecoder decodeObjectForKey:kDayDescriptionDataLable];
    self.taste = [aDecoder decodeObjectForKey:kDayDescriptionDataTaste];
    self.deleteStatus = [aDecoder decodeDoubleForKey:kDayDescriptionDataDeleteStatus];
    self.screList = [aDecoder decodeObjectForKey:kDayDescriptionDataScreList];
    self.dataDescription = [aDecoder decodeObjectForKey:kDayDescriptionDataDescription];
    self.technology = [aDecoder decodeObjectForKey:kDayDescriptionDataTechnology];
    self.type = [aDecoder decodeObjectForKey:kDayDescriptionDataType];
    self.releaseDate = [aDecoder decodeObjectForKey:kDayDescriptionDataReleaseDate];
    self.peopleEat = [aDecoder decodeObjectForKey:kDayDescriptionDataPeopleEat];
    self.loadContent = [aDecoder decodeObjectForKey:kDayDescriptionDataLoadContent];
    self.screeningId = [aDecoder decodeObjectForKey:kDayDescriptionDataScreeningId];
    self.area = [aDecoder decodeObjectForKey:kDayDescriptionDataArea];
    self.indexUrl = [aDecoder decodeObjectForKey:kDayDescriptionDataIndexUrl];
    self.imageHeight = [aDecoder decodeObjectForKey:kDayDescriptionDataImageHeight];
    self.parentCategoryId = [aDecoder decodeObjectForKey:kDayDescriptionDataParentCategoryId];
    self.shareUrl = [aDecoder decodeObjectForKey:kDayDescriptionDataShareUrl];
    self.maketime = [aDecoder decodeObjectForKey:kDayDescriptionDataMaketime];
    self.pageInfo = [aDecoder decodeObjectForKey:kDayDescriptionDataPageInfo];
    self.name = [aDecoder decodeObjectForKey:kDayDescriptionDataName];
    self.shareCount = [aDecoder decodeDoubleForKey:kDayDescriptionDataShareCount];
    self.favorite = [aDecoder decodeBoolForKey:kDayDescriptionDataFavorite];
    self.releasePlat = [aDecoder decodeObjectForKey:kDayDescriptionDataReleasePlat];
    self.createDate = [aDecoder decodeDoubleForKey:kDayDescriptionDataCreateDate];
    self.content = [aDecoder decodeObjectForKey:kDayDescriptionDataContent];
    self.modifyDate = [aDecoder decodeDoubleForKey:kDayDescriptionDataModifyDate];
    self.imageWidth = [aDecoder decodeObjectForKey:kDayDescriptionDataImageWidth];
    self.imageUrl = [aDecoder decodeObjectForKey:kDayDescriptionDataImageUrl];
    self.title = [aDecoder decodeObjectForKey:kDayDescriptionDataTitle];
    self.displayState = [aDecoder decodeObjectForKey:kDayDescriptionDataDisplayState];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_clickCount forKey:kDayDescriptionDataClickCount];
    [aCoder encodeObject:_detailsUrl forKey:kDayDescriptionDataDetailsUrl];
    [aCoder encodeObject:_difficulty forKey:kDayDescriptionDataDifficulty];
    [aCoder encodeDouble:_dataIdentifier forKey:kDayDescriptionDataId];
    [aCoder encodeObject:_imageUrlFlow forKey:kDayDescriptionDataImageUrlFlow];
    [aCoder encodeObject:_category forKey:kDayDescriptionDataCategory];
    [aCoder encodeObject:_categoryID forKey:kDayDescriptionDataCategoryID];
    [aCoder encodeObject:_lable forKey:kDayDescriptionDataLable];
    [aCoder encodeObject:_taste forKey:kDayDescriptionDataTaste];
    [aCoder encodeDouble:_deleteStatus forKey:kDayDescriptionDataDeleteStatus];
    [aCoder encodeObject:_screList forKey:kDayDescriptionDataScreList];
    [aCoder encodeObject:_dataDescription forKey:kDayDescriptionDataDescription];
    [aCoder encodeObject:_technology forKey:kDayDescriptionDataTechnology];
    [aCoder encodeObject:_type forKey:kDayDescriptionDataType];
    [aCoder encodeObject:_releaseDate forKey:kDayDescriptionDataReleaseDate];
    [aCoder encodeObject:_peopleEat forKey:kDayDescriptionDataPeopleEat];
    [aCoder encodeObject:_loadContent forKey:kDayDescriptionDataLoadContent];
    [aCoder encodeObject:_screeningId forKey:kDayDescriptionDataScreeningId];
    [aCoder encodeObject:_area forKey:kDayDescriptionDataArea];
    [aCoder encodeObject:_indexUrl forKey:kDayDescriptionDataIndexUrl];
    [aCoder encodeObject:_imageHeight forKey:kDayDescriptionDataImageHeight];
    [aCoder encodeObject:_parentCategoryId forKey:kDayDescriptionDataParentCategoryId];
    [aCoder encodeObject:_shareUrl forKey:kDayDescriptionDataShareUrl];
    [aCoder encodeObject:_maketime forKey:kDayDescriptionDataMaketime];
    [aCoder encodeObject:_pageInfo forKey:kDayDescriptionDataPageInfo];
    [aCoder encodeObject:_name forKey:kDayDescriptionDataName];
    [aCoder encodeDouble:_shareCount forKey:kDayDescriptionDataShareCount];
    [aCoder encodeBool:_favorite forKey:kDayDescriptionDataFavorite];
    [aCoder encodeObject:_releasePlat forKey:kDayDescriptionDataReleasePlat];
    [aCoder encodeDouble:_createDate forKey:kDayDescriptionDataCreateDate];
    [aCoder encodeObject:_content forKey:kDayDescriptionDataContent];
    [aCoder encodeDouble:_modifyDate forKey:kDayDescriptionDataModifyDate];
    [aCoder encodeObject:_imageWidth forKey:kDayDescriptionDataImageWidth];
    [aCoder encodeObject:_imageUrl forKey:kDayDescriptionDataImageUrl];
    [aCoder encodeObject:_title forKey:kDayDescriptionDataTitle];
    [aCoder encodeObject:_displayState forKey:kDayDescriptionDataDisplayState];
}

- (id)copyWithZone:(NSZone *)zone
{
    DayDescriptionData *copy = [[DayDescriptionData alloc] init];
    
    if (copy) {

        copy.clickCount = self.clickCount;
        copy.detailsUrl = [self.detailsUrl copyWithZone:zone];
        copy.difficulty = [self.difficulty copyWithZone:zone];
        copy.dataIdentifier = self.dataIdentifier;
        copy.imageUrlFlow = [self.imageUrlFlow copyWithZone:zone];
        copy.category = [self.category copyWithZone:zone];
        copy.categoryID = [self.categoryID copyWithZone:zone];
        copy.lable = [self.lable copyWithZone:zone];
        copy.taste = [self.taste copyWithZone:zone];
        copy.deleteStatus = self.deleteStatus;
        copy.screList = [self.screList copyWithZone:zone];
        copy.dataDescription = [self.dataDescription copyWithZone:zone];
        copy.technology = [self.technology copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.releaseDate = [self.releaseDate copyWithZone:zone];
        copy.peopleEat = [self.peopleEat copyWithZone:zone];
        copy.loadContent = [self.loadContent copyWithZone:zone];
        copy.screeningId = [self.screeningId copyWithZone:zone];
        copy.area = [self.area copyWithZone:zone];
        copy.indexUrl = [self.indexUrl copyWithZone:zone];
        copy.imageHeight = [self.imageHeight copyWithZone:zone];
        copy.parentCategoryId = [self.parentCategoryId copyWithZone:zone];
        copy.shareUrl = [self.shareUrl copyWithZone:zone];
        copy.maketime = [self.maketime copyWithZone:zone];
        copy.pageInfo = [self.pageInfo copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.shareCount = self.shareCount;
        copy.favorite = self.favorite;
        copy.releasePlat = [self.releasePlat copyWithZone:zone];
        copy.createDate = self.createDate;
        copy.content = [self.content copyWithZone:zone];
        copy.modifyDate = self.modifyDate;
        copy.imageWidth = [self.imageWidth copyWithZone:zone];
        copy.imageUrl = [self.imageUrl copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.displayState = [self.displayState copyWithZone:zone];
    }
    
    return copy;
}


@end
