//
//  SearchData.m
//
//  Created by 浩文 夏 on 16/4/22
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "SearchData.h"


NSString *const kSearchDataClickCount = @"clickCount";
NSString *const kSearchDataDetailsUrl = @"detailsUrl";
NSString *const kSearchDataDifficulty = @"difficulty";
NSString *const kSearchDataId = @"id";
NSString *const kSearchDataImageUrlFlow = @"imageUrlFlow";
NSString *const kSearchDataCategory = @"category";
NSString *const kSearchDataNivoRelId = @"nivoRelId";
NSString *const kSearchDataLable = @"lable";
NSString *const kSearchDataCategoryID = @"categoryID";
NSString *const kSearchDataTaste = @"taste";
NSString *const kSearchDataDeleteStatus = @"deleteStatus";
NSString *const kSearchDataScreList = @"screList";
NSString *const kSearchDataDescription = @"description";
NSString *const kSearchDataTechnology = @"technology";
NSString *const kSearchDataType = @"type";
NSString *const kSearchDataReleaseDate = @"releaseDate";
NSString *const kSearchDataPeopleEat = @"peopleEat";
NSString *const kSearchDataLoadContent = @"loadContent";
NSString *const kSearchDataScreeningId = @"screeningId";
NSString *const kSearchDataArea = @"area";
NSString *const kSearchDataIndexUrl = @"indexUrl";
NSString *const kSearchDataImageHeight = @"imageHeight";
NSString *const kSearchDataParentCategoryId = @"parentCategoryId";
NSString *const kSearchDataShareUrl = @"shareUrl";
NSString *const kSearchDataMaketime = @"maketime";
NSString *const kSearchDataPageInfo = @"pageInfo";
NSString *const kSearchDataName = @"name";
NSString *const kSearchDataShareCount = @"shareCount";
NSString *const kSearchDataFavorite = @"favorite";
NSString *const kSearchDataReleasePlat = @"releasePlat";
NSString *const kSearchDataCreateDate = @"createDate";
NSString *const kSearchDataContent = @"content";
NSString *const kSearchDataModifyDate = @"modifyDate";
NSString *const kSearchDataImageWidth = @"imageWidth";
NSString *const kSearchDataImageUrl = @"imageUrl";
NSString *const kSearchDataTitle = @"title";
NSString *const kSearchDataVideoRelId = @"videoRelId";
NSString *const kSearchDataDisplayState = @"displayState";


@interface SearchData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SearchData

@synthesize clickCount = _clickCount;
@synthesize detailsUrl = _detailsUrl;
@synthesize difficulty = _difficulty;
@synthesize dataIdentifier = _dataIdentifier;
@synthesize imageUrlFlow = _imageUrlFlow;
@synthesize category = _category;
@synthesize nivoRelId = _nivoRelId;
@synthesize lable = _lable;
@synthesize categoryID = _categoryID;
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
@synthesize videoRelId = _videoRelId;
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
            self.clickCount = [[self objectOrNilForKey:kSearchDataClickCount fromDictionary:dict] doubleValue];
            self.detailsUrl = [self objectOrNilForKey:kSearchDataDetailsUrl fromDictionary:dict];
            self.difficulty = [self objectOrNilForKey:kSearchDataDifficulty fromDictionary:dict];
            self.dataIdentifier = [[self objectOrNilForKey:kSearchDataId fromDictionary:dict] doubleValue];
            self.imageUrlFlow = [self objectOrNilForKey:kSearchDataImageUrlFlow fromDictionary:dict];
            self.category = [self objectOrNilForKey:kSearchDataCategory fromDictionary:dict];
            self.nivoRelId = [self objectOrNilForKey:kSearchDataNivoRelId fromDictionary:dict];
            self.lable = [self objectOrNilForKey:kSearchDataLable fromDictionary:dict];
            self.categoryID = [self objectOrNilForKey:kSearchDataCategoryID fromDictionary:dict];
            self.taste = [self objectOrNilForKey:kSearchDataTaste fromDictionary:dict];
            self.deleteStatus = [[self objectOrNilForKey:kSearchDataDeleteStatus fromDictionary:dict] doubleValue];
            self.screList = [self objectOrNilForKey:kSearchDataScreList fromDictionary:dict];
            self.dataDescription = [self objectOrNilForKey:kSearchDataDescription fromDictionary:dict];
            self.technology = [self objectOrNilForKey:kSearchDataTechnology fromDictionary:dict];
            self.type = [self objectOrNilForKey:kSearchDataType fromDictionary:dict];
            self.releaseDate = [self objectOrNilForKey:kSearchDataReleaseDate fromDictionary:dict];
            self.peopleEat = [self objectOrNilForKey:kSearchDataPeopleEat fromDictionary:dict];
            self.loadContent = [self objectOrNilForKey:kSearchDataLoadContent fromDictionary:dict];
            self.screeningId = [self objectOrNilForKey:kSearchDataScreeningId fromDictionary:dict];
            self.area = [self objectOrNilForKey:kSearchDataArea fromDictionary:dict];
            self.indexUrl = [self objectOrNilForKey:kSearchDataIndexUrl fromDictionary:dict];
            self.imageHeight = [self objectOrNilForKey:kSearchDataImageHeight fromDictionary:dict];
            self.parentCategoryId = [self objectOrNilForKey:kSearchDataParentCategoryId fromDictionary:dict];
            self.shareUrl = [self objectOrNilForKey:kSearchDataShareUrl fromDictionary:dict];
            self.maketime = [self objectOrNilForKey:kSearchDataMaketime fromDictionary:dict];
            self.pageInfo = [self objectOrNilForKey:kSearchDataPageInfo fromDictionary:dict];
            self.name = [self objectOrNilForKey:kSearchDataName fromDictionary:dict];
            self.shareCount = [[self objectOrNilForKey:kSearchDataShareCount fromDictionary:dict] doubleValue];
            self.favorite = [[self objectOrNilForKey:kSearchDataFavorite fromDictionary:dict] boolValue];
            self.releasePlat = [self objectOrNilForKey:kSearchDataReleasePlat fromDictionary:dict];
            self.createDate = [[self objectOrNilForKey:kSearchDataCreateDate fromDictionary:dict] doubleValue];
            self.content = [self objectOrNilForKey:kSearchDataContent fromDictionary:dict];
            self.modifyDate = [[self objectOrNilForKey:kSearchDataModifyDate fromDictionary:dict] doubleValue];
            self.imageWidth = [self objectOrNilForKey:kSearchDataImageWidth fromDictionary:dict];
            self.imageUrl = [self objectOrNilForKey:kSearchDataImageUrl fromDictionary:dict];
            self.title = [self objectOrNilForKey:kSearchDataTitle fromDictionary:dict];
            self.videoRelId = [self objectOrNilForKey:kSearchDataVideoRelId fromDictionary:dict];
            self.displayState = [self objectOrNilForKey:kSearchDataDisplayState fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.clickCount] forKey:kSearchDataClickCount];
    [mutableDict setValue:self.detailsUrl forKey:kSearchDataDetailsUrl];
    [mutableDict setValue:self.difficulty forKey:kSearchDataDifficulty];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dataIdentifier] forKey:kSearchDataId];
    [mutableDict setValue:self.imageUrlFlow forKey:kSearchDataImageUrlFlow];
    [mutableDict setValue:self.category forKey:kSearchDataCategory];
    [mutableDict setValue:self.nivoRelId forKey:kSearchDataNivoRelId];
    [mutableDict setValue:self.lable forKey:kSearchDataLable];
    [mutableDict setValue:self.categoryID forKey:kSearchDataCategoryID];
    [mutableDict setValue:self.taste forKey:kSearchDataTaste];
    [mutableDict setValue:[NSNumber numberWithDouble:self.deleteStatus] forKey:kSearchDataDeleteStatus];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForScreList] forKey:kSearchDataScreList];
    [mutableDict setValue:self.dataDescription forKey:kSearchDataDescription];
    [mutableDict setValue:self.technology forKey:kSearchDataTechnology];
    [mutableDict setValue:self.type forKey:kSearchDataType];
    [mutableDict setValue:self.releaseDate forKey:kSearchDataReleaseDate];
    [mutableDict setValue:self.peopleEat forKey:kSearchDataPeopleEat];
    [mutableDict setValue:self.loadContent forKey:kSearchDataLoadContent];
    [mutableDict setValue:self.screeningId forKey:kSearchDataScreeningId];
    [mutableDict setValue:self.area forKey:kSearchDataArea];
    [mutableDict setValue:self.indexUrl forKey:kSearchDataIndexUrl];
    [mutableDict setValue:self.imageHeight forKey:kSearchDataImageHeight];
    [mutableDict setValue:self.parentCategoryId forKey:kSearchDataParentCategoryId];
    [mutableDict setValue:self.shareUrl forKey:kSearchDataShareUrl];
    [mutableDict setValue:self.maketime forKey:kSearchDataMaketime];
    [mutableDict setValue:self.pageInfo forKey:kSearchDataPageInfo];
    [mutableDict setValue:self.name forKey:kSearchDataName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.shareCount] forKey:kSearchDataShareCount];
    [mutableDict setValue:[NSNumber numberWithBool:self.favorite] forKey:kSearchDataFavorite];
    [mutableDict setValue:self.releasePlat forKey:kSearchDataReleasePlat];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createDate] forKey:kSearchDataCreateDate];
    [mutableDict setValue:self.content forKey:kSearchDataContent];
    [mutableDict setValue:[NSNumber numberWithDouble:self.modifyDate] forKey:kSearchDataModifyDate];
    [mutableDict setValue:self.imageWidth forKey:kSearchDataImageWidth];
    [mutableDict setValue:self.imageUrl forKey:kSearchDataImageUrl];
    [mutableDict setValue:self.title forKey:kSearchDataTitle];
    [mutableDict setValue:self.videoRelId forKey:kSearchDataVideoRelId];
    [mutableDict setValue:self.displayState forKey:kSearchDataDisplayState];

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

    self.clickCount = [aDecoder decodeDoubleForKey:kSearchDataClickCount];
    self.detailsUrl = [aDecoder decodeObjectForKey:kSearchDataDetailsUrl];
    self.difficulty = [aDecoder decodeObjectForKey:kSearchDataDifficulty];
    self.dataIdentifier = [aDecoder decodeDoubleForKey:kSearchDataId];
    self.imageUrlFlow = [aDecoder decodeObjectForKey:kSearchDataImageUrlFlow];
    self.category = [aDecoder decodeObjectForKey:kSearchDataCategory];
    self.nivoRelId = [aDecoder decodeObjectForKey:kSearchDataNivoRelId];
    self.lable = [aDecoder decodeObjectForKey:kSearchDataLable];
    self.categoryID = [aDecoder decodeObjectForKey:kSearchDataCategoryID];
    self.taste = [aDecoder decodeObjectForKey:kSearchDataTaste];
    self.deleteStatus = [aDecoder decodeDoubleForKey:kSearchDataDeleteStatus];
    self.screList = [aDecoder decodeObjectForKey:kSearchDataScreList];
    self.dataDescription = [aDecoder decodeObjectForKey:kSearchDataDescription];
    self.technology = [aDecoder decodeObjectForKey:kSearchDataTechnology];
    self.type = [aDecoder decodeObjectForKey:kSearchDataType];
    self.releaseDate = [aDecoder decodeObjectForKey:kSearchDataReleaseDate];
    self.peopleEat = [aDecoder decodeObjectForKey:kSearchDataPeopleEat];
    self.loadContent = [aDecoder decodeObjectForKey:kSearchDataLoadContent];
    self.screeningId = [aDecoder decodeObjectForKey:kSearchDataScreeningId];
    self.area = [aDecoder decodeObjectForKey:kSearchDataArea];
    self.indexUrl = [aDecoder decodeObjectForKey:kSearchDataIndexUrl];
    self.imageHeight = [aDecoder decodeObjectForKey:kSearchDataImageHeight];
    self.parentCategoryId = [aDecoder decodeObjectForKey:kSearchDataParentCategoryId];
    self.shareUrl = [aDecoder decodeObjectForKey:kSearchDataShareUrl];
    self.maketime = [aDecoder decodeObjectForKey:kSearchDataMaketime];
    self.pageInfo = [aDecoder decodeObjectForKey:kSearchDataPageInfo];
    self.name = [aDecoder decodeObjectForKey:kSearchDataName];
    self.shareCount = [aDecoder decodeDoubleForKey:kSearchDataShareCount];
    self.favorite = [aDecoder decodeBoolForKey:kSearchDataFavorite];
    self.releasePlat = [aDecoder decodeObjectForKey:kSearchDataReleasePlat];
    self.createDate = [aDecoder decodeDoubleForKey:kSearchDataCreateDate];
    self.content = [aDecoder decodeObjectForKey:kSearchDataContent];
    self.modifyDate = [aDecoder decodeDoubleForKey:kSearchDataModifyDate];
    self.imageWidth = [aDecoder decodeObjectForKey:kSearchDataImageWidth];
    self.imageUrl = [aDecoder decodeObjectForKey:kSearchDataImageUrl];
    self.title = [aDecoder decodeObjectForKey:kSearchDataTitle];
    self.videoRelId = [aDecoder decodeObjectForKey:kSearchDataVideoRelId];
    self.displayState = [aDecoder decodeObjectForKey:kSearchDataDisplayState];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_clickCount forKey:kSearchDataClickCount];
    [aCoder encodeObject:_detailsUrl forKey:kSearchDataDetailsUrl];
    [aCoder encodeObject:_difficulty forKey:kSearchDataDifficulty];
    [aCoder encodeDouble:_dataIdentifier forKey:kSearchDataId];
    [aCoder encodeObject:_imageUrlFlow forKey:kSearchDataImageUrlFlow];
    [aCoder encodeObject:_category forKey:kSearchDataCategory];
    [aCoder encodeObject:_nivoRelId forKey:kSearchDataNivoRelId];
    [aCoder encodeObject:_lable forKey:kSearchDataLable];
    [aCoder encodeObject:_categoryID forKey:kSearchDataCategoryID];
    [aCoder encodeObject:_taste forKey:kSearchDataTaste];
    [aCoder encodeDouble:_deleteStatus forKey:kSearchDataDeleteStatus];
    [aCoder encodeObject:_screList forKey:kSearchDataScreList];
    [aCoder encodeObject:_dataDescription forKey:kSearchDataDescription];
    [aCoder encodeObject:_technology forKey:kSearchDataTechnology];
    [aCoder encodeObject:_type forKey:kSearchDataType];
    [aCoder encodeObject:_releaseDate forKey:kSearchDataReleaseDate];
    [aCoder encodeObject:_peopleEat forKey:kSearchDataPeopleEat];
    [aCoder encodeObject:_loadContent forKey:kSearchDataLoadContent];
    [aCoder encodeObject:_screeningId forKey:kSearchDataScreeningId];
    [aCoder encodeObject:_area forKey:kSearchDataArea];
    [aCoder encodeObject:_indexUrl forKey:kSearchDataIndexUrl];
    [aCoder encodeObject:_imageHeight forKey:kSearchDataImageHeight];
    [aCoder encodeObject:_parentCategoryId forKey:kSearchDataParentCategoryId];
    [aCoder encodeObject:_shareUrl forKey:kSearchDataShareUrl];
    [aCoder encodeObject:_maketime forKey:kSearchDataMaketime];
    [aCoder encodeObject:_pageInfo forKey:kSearchDataPageInfo];
    [aCoder encodeObject:_name forKey:kSearchDataName];
    [aCoder encodeDouble:_shareCount forKey:kSearchDataShareCount];
    [aCoder encodeBool:_favorite forKey:kSearchDataFavorite];
    [aCoder encodeObject:_releasePlat forKey:kSearchDataReleasePlat];
    [aCoder encodeDouble:_createDate forKey:kSearchDataCreateDate];
    [aCoder encodeObject:_content forKey:kSearchDataContent];
    [aCoder encodeDouble:_modifyDate forKey:kSearchDataModifyDate];
    [aCoder encodeObject:_imageWidth forKey:kSearchDataImageWidth];
    [aCoder encodeObject:_imageUrl forKey:kSearchDataImageUrl];
    [aCoder encodeObject:_title forKey:kSearchDataTitle];
    [aCoder encodeObject:_videoRelId forKey:kSearchDataVideoRelId];
    [aCoder encodeObject:_displayState forKey:kSearchDataDisplayState];
}

- (id)copyWithZone:(NSZone *)zone
{
    SearchData *copy = [[SearchData alloc] init];
    
    if (copy) {

        copy.clickCount = self.clickCount;
        copy.detailsUrl = [self.detailsUrl copyWithZone:zone];
        copy.difficulty = [self.difficulty copyWithZone:zone];
        copy.dataIdentifier = self.dataIdentifier;
        copy.imageUrlFlow = [self.imageUrlFlow copyWithZone:zone];
        copy.category = [self.category copyWithZone:zone];
        copy.nivoRelId = [self.nivoRelId copyWithZone:zone];
        copy.lable = [self.lable copyWithZone:zone];
        copy.categoryID = [self.categoryID copyWithZone:zone];
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
        copy.videoRelId = [self.videoRelId copyWithZone:zone];
        copy.displayState = [self.displayState copyWithZone:zone];
    }
    
    return copy;
}


@end
