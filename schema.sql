
GO

SET QUOTED_IDENTIFIER ON
GO

/**
	The TOUR table contains each individual tour or collection of places that is associated with an ORGANIZATION. 
	For example, each DWNTWN Muncie ArtsWalk is a separate TOUR. If we're talking about a tour company, each 
	one of their self-guided or guide-led tours throughout the city would be entered as a separate entry in 
	the TOUR table.
**/
CREATE TABLE [dbo].[TOUR](
	[TOUR_ID] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[TOUR_GUID] [uniqueidentifier] NOT NULL,
	[CATEGORY_GUID] [uniqueidentifier] NULL,
	[TOUR_NAME] [nvarchar](max) NULL,
	[TOUR_SUMMARY] [nvarchar](max) NULL,
	[TOUR_DESC] [nvarchar](max) NULL,
	[START_DATE] [datetime] NULL,
	[END_DATE] [datetime] NULL,
	[URL] [nvarchar](max) NULL,
	[BOOK_NOW_URL] [nvarchar](max) NULL,
	[TOUR_IS_PUBLIC] [bit] NULL,
	[DURATION] [nvarchar](50) NULL,
	[COST] [nvarchar](200) NULL,
	[GROUP_SIZE] [nvarchar](200) NULL,
	[ADDITIONAL_INFO] [nvarchar](max) NULL,
	[ENTERED_BY] [uniqueidentifier] NOT NULL,
	[ENTERED_DATE_TIME] [datetime] NOT NULL,
	[UPDATED_BY] [uniqueidentifier] NULL,
	[UPDATED_DATE_TIME] [datetime] NULL,
	[DELETED_BY] [uniqueidentifier] NULL,
	[DELETED_DATE_TIME] [datetime] NULL,
 CONSTRAINT [PK_TOUR] PRIMARY KEY CLUSTERED 
(
	[TOUR_ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TOUR_PERSON_TO_ORGANIZATION] (
    [PERSON_TO_ORGANIZATION_ID]   NUMERIC (8)      IDENTITY (1, 1) NOT NULL,
    [PERSON_TO_ORGANIZATION_GUID] UNIQUEIDENTIFIER CONSTRAINT [DF_TOUR_PERSON_TO_ORGANIZATION_PERSON_TO_ORGANIZATION_GUID] DEFAULT (newid()) NOT NULL,
    [ORGANIZATION_GUIDGO
]           UNIQUEIDENTIFIER NOT NULL,
    [PERSON_GUID]                 UNIQUEIDENTIFIER NOT NULL,
    [ENTERED_BY]                  UNIQUEIDENTIFIER NOT NULL,
    [ENTERED_DATE_TIME]           DATETIME         CONSTRAINT [DF_TOUR_PERSON_TO_ORGANIZATION_ENTERED_DATE_TIME] DEFAULT (getdate()) NOT NULL,
    [UPDATED_BY]                  UNIQUEIDENTIFIER NULL,
    [UPDATED_DATE_TIME]           DATETIME         NULL,
    [DELETED_BY]                  UNIQUEIDENTIFIER NULL,
    [DELETED_DATE_TIME]           DATETIME         NULL,
    CONSTRAINT [PK_TOUR_PERSON_TO_ORGANIZATION] PRIMARY KEY CLUSTERED ([PERSON_TO_ORGANIZATION_ID] ASC)
);
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TOUR_PERSON] (
    [PERSON_GUID] UNIQUEIDENTIFIER CONSTRAINT [DF_TOUR_PERSON_PERSON_GUID] DEFAULT (newid()) NOT NULL,
    [PERSON_NAME] NVARCHAR (MAX)   NULL
);

GO

/**
	The TOUR_CATEGORY table is a lookup table. Each category contains a TYPE_GUID which refers to the TOUR_TYPE
	table. Sample types include: DWNTWN Events, Tours, Places, and other organization-specific values. One of our 
	potential clients has several specific category collections, including "On a budget?", "Lodging", and "Food & Drink".
**/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TOUR_CATEGORY](
	[CATEGORY_ID] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[CATEGORY_GUID] [uniqueidentifier] NOT NULL,
	[TYPE_GUID] [uniqueidentifier] NULL,
	[CATEGORY_NAME] [nvarchar](max) NULL,
	[CATEGORY_DESC] [nvarchar](max) NULL,
	[COLOR_CODE] [varchar](10) NULL,
	[ORDER_BY] [numeric](8, 0) NULL,
	[ENTERED_BY] [uniqueidentifier] NOT NULL,
	[ENTERED_DATE_TIME] [datetime] NOT NULL,
	[UPDATED_BY] [uniqueidentifier] NULL,
	[UPDATED_DATE_TIME] [datetime] NULL,
	[DELETED_BY] [uniqueidentifier] NULL,
	[DELETED_DATE_TIME] [datetime] NULL,
	[OWNER_ORGANIZATION_GUID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_TOUR_CATEGORY] PRIMARY KEY CLUSTERED 
(
	[CATEGORY_ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)
GO

/**
	The TOUR_EVENT table contains the details for an event. The TYPE_GUID is consistent and 
	relates to the parent organization. For example, DWNTWN Muncie events all have a TYPE_GUID of 
	DWNTWN Events.
**/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TOUR_EVENT](
	[EVENT_ID] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[EVENT_GUID] [uniqueidentifier] NOT NULL,
	[TYPE_GUID] [uniqueidentifier] NULL,
	[PLACE_GUID] [uniqueidentifier] NULL,
	[CATEGORY_GUID] [uniqueidentifier] NULL,
	[EVENT_TITLE] [nvarchar](max) NULL,
	[EVENT_DESC] [nvarchar](max) NULL,
	[START_DATE] [datetime] NULL,
	[END_DATE] [datetime] NULL,
	[DATE_TIME] [nvarchar](max) NULL,
	[VENUE] [nvarchar](max) NULL,
	[LATITUDE] [float] NULL,
	[LONGITUDE] [float] NULL,
	[WEBSITE] [nvarchar](max) NULL,
	[AGE_RESTRICTION] [varchar](max) NULL,
	[COST] [varchar](max) NULL,
	[CONTACT_NAME] [nvarchar](max) NULL,
	[CONTACT_EMAIL] [nvarchar](200) NULL,
	[CONTACT_PHONE] [nvarchar](50) NULL,
	[EXTERNAL_EVENT_ID] [nvarchar](200) NULL,
	[ENTERED_BY] [uniqueidentifier] NOT NULL,
	[ENTERED_DATE_TIME] [datetime] NOT NULL,
	[UPDATED_BY] [uniqueidentifier] NULL,
	[UPDATED_DATE_TIME] [datetime] NULL,
	[DELETED_BY] [uniqueidentifier] NULL,
	[DELETED_DATE_TIME] [datetime] NULL,
 CONSTRAINT [PK_TOUR_EVENT] PRIMARY KEY CLUSTERED 
(
	[EVENT_ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)
GO

/**
	The TOUR_MEDIA table contains all of the media related to events, tours, places, and other items within this section 
	of the app. At this point, all MEDIA_TYPE_GUIDs are either PHOTO or LOCATION MARKER. In theory other media types 
	would include videos, audio clips, documents, etc.
**/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TOUR_MEDIA](
	[MEDIA_ID] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[MEDIA_GUID] [uniqueidentifier] NOT NULL,
	[MEDIA_TYPE_GUID] [uniqueidentifier] NULL,
	[MEDIA_TITLE] [nvarchar](max) NULL,
	[URL] [nvarchar](max) NULL,
	[PALETTE_BACKGROUND] [numeric](10, 0) NULL,
	[PALETTE_TEXT] [numeric](10, 0) NULL,
	[ENTERED_BY] [uniqueidentifier] NOT NULL,
	[ENTERED_DATE_TIME] [datetime] NOT NULL,
	[UPDATED_BY] [uniqueidentifier] NULL,
	[UPDATED_DATE_TIME] [datetime] NULL,
	[DELETED_BY] [uniqueidentifier] NULL,
	[DELETED_DATE_TIME] [datetime] NULL,
 CONSTRAINT [PK_TOUR_MEDIA] PRIMARY KEY CLUSTERED 
(
	[MEDIA_ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)
GO

/**
	The TOUR_MEDIA_TO_ITEM table is a relationship table that allows one media item to be associated with 
	multiple places or other ITEM_TYPE_GUID entries. For example, the standard photo for Vera Mae's in 
	downtown Muncie may be used for an event, a place, or a tour cover image. The ITEM_TYPE_GUID entries 
	in this table refer to Tours, Events, Partners, Places, and a variety of other values.
**/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TOUR_MEDIA_TO_ITEM](
	[MEDIA_TO_ITEM_ID] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[MEDIA_TO_ITEM_GUID] [uniqueidentifier] NOT NULL,
	[MEDIA_GUID] [uniqueidentifier] NOT NULL,
	[ITEM_GUID] [uniqueidentifier] NOT NULL,
	[ITEM_TYPE_GUID] [uniqueidentifier] NOT NULL,
	[ORDER_BY] [numeric](8, 0) NOT NULL,
	[ENTERED_BY] [uniqueidentifier] NOT NULL,
	[ENTERED_DATE_TIME] [datetime] NOT NULL,
	[UPDATED_BY] [uniqueidentifier] NULL,
	[UPDATED_DATE_TIME] [datetime] NULL,
	[DELETED_BY] [uniqueidentifier] NULL,
	[DELETED_DATE_TIME] [datetime] NULL,
 CONSTRAINT [PK_TOUR_MEDIA_TO_ITEM] PRIMARY KEY CLUSTERED 
(
	[MEDIA_TO_ITEM_ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)
GO

/**
	The TOUR_ORGANIZATION table is the parent table of all data in this portion of the app. Every tour, place, event, 
	and media item is ultimately associated with an organization. The organizations are the top-level unit and include 
	items such as DWNTWN Muncie, the individual conventions for the Horizon Convention Center, and our tour guide companies.
	If the FILTER_BY_LOCATION bit flag is set to "false" the organization appears regardless of the user's location. 
	Organizations like this would include state-level tourism agencies. Organizations with a "true" value would include DWNTWN
	Muncie - people in California are probably not going to care about a arts walk in Muncie, IN. Some organizations may be 
	private and only visible to certain users - this is handled by the ORGANIZATION_IS_PUBLIC flag.
**/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TOUR_ORGANIZATION](
	[ORGANIZATION_ID] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[ORGANIZATION_GUID] [uniqueidentifier] NOT NULL,
	[ORGANIZATION_NAME] [varchar](200) NULL,
	[ORGANIZATION_DESC] [varchar](max) NULL,
	[FILTER_BY_LOCATION] [bit] NULL,
	[LOCATION] [varchar](200) NULL,
	[LATITUDE] [float] NULL,
	[LONGITUDE] [float] NULL,
	[URL] [varchar](max) NULL,
	[JOIN_CODE] [varchar](50) NULL,
	[ORGANIZATION_IS_PUBLIC] [bit] NULL,
	[CONTACT_NAME] [nvarchar](200) NULL,
	[CONTACT_EMAIL] [varchar](200) NULL,
	[CONTACT_PHONE] [varchar](50) NULL,
	[ENTERED_BY] [uniqueidentifier] NOT NULL,
	[ENTERED_DATE_TIME] [datetime] NOT NULL,
	[UPDATED_BY] [uniqueidentifier] NULL,
	[UPDATED_DATE_TIME] [datetime] NULL,
	[DELETED_BY] [uniqueidentifier] NULL,
	[DELETED_DATE_TIME] [datetime] NULL,
 CONSTRAINT [PK_TOUR_ORGANIZATION] PRIMARY KEY CLUSTERED 
(
	[ORGANIZATION_ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)
GO

/**
	The TOUR_ORGANIZATION_TO_ITEM table contains all of the relationships for the top-level organizations. 
	This table includes references to Tours, Events, Places, Partners, Tabs that appear within the app, 
	Feature elements, and a variety of other entries.
**/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TOUR_ORGANIZATION_TO_ITEM](
	[ORGANIZATION_TO_ITEM_ID] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[ORGANIZATION_TO_ITEM_GUID] [uniqueidentifier] NOT NULL,
	[ORGANIZATION_GUID] [uniqueidentifier] NOT NULL,
	[ITEM_GUID] [uniqueidentifier] NOT NULL,
	[ITEM_TYPE_GUID] [uniqueidentifier] NULL,
	[ORDER_BY] [numeric](8, 0) NULL,
	[ENTERED_BY] [uniqueidentifier] NOT NULL,
	[ENTERED_DATE_TIME] [datetime] NOT NULL,
	[UPDATED_BY] [uniqueidentifier] NULL,
	[UPDATED_DATE_TIME] [datetime] NULL,
	[DELETED_BY] [uniqueidentifier] NULL,
	[DELETED_DATE_TIME] [datetime] NULL,
 CONSTRAINT [PK_TOUR_ORGANIZATION_TO_ITEM] PRIMARY KEY CLUSTERED 
(
	[ORGANIZATION_TO_ITEM_ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)
GO

/**
	The TOUR_PATH table ties to the TOUR table. Each tour has one path. The path dictates both the lines drawn on 
	the map (in the case of a self-guided tour) as well as the visible window to frame the location (MIN and MAX 
	LONGITUDE and LATITUDE). When a new tour is created, a corresponding path is also created. The GEOJSON_URL
	refers to the file on the Azure blob storage that contains the geojson data to draw the path on the map. 
	For tours that do not have an actual path on the map, the GEOJSON_URL is null and this table simply 
	provides a way to define the boundaries of the region to display on the mobile app.
**/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TOUR_PATH](
	[PATH_ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[PATH_GUID] [uniqueidentifier] NOT NULL,
	[TOUR_GUID] [uniqueidentifier] NULL,
	[PATH_NAME] [nvarchar](max) NULL,
	[PATH_DESC] [nvarchar](max) NULL,
	[TOTAL_DISTANCE] [float] NULL,
	[MIN_LATITUDE] [float] NULL,
	[MAX_LATITUDE] [float] NULL,
	[MIN_LONGITUDE] [float] NULL,
	[MAX_LONGITUDE] [float] NULL,
	[GEOJSON_URL] [varchar](200) NULL,
	[ORDER_BY] [numeric](8, 0) NOT NULL,
	[ENTERED_BY] [uniqueidentifier] NULL,
	[ENTERED_DATE_TIME] [datetime] NOT NULL,
	[UPDATED_BY] [uniqueidentifier] NULL,
	[UPDATED_DATE_TIME] [datetime] NULL,
	[DELETED_BY] [uniqueidentifier] NULL,
	[DELETED_DATE_TIME] [datetime] NULL,
 CONSTRAINT [PK_TOUR_PATH] PRIMARY KEY CLUSTERED 
(
	[PATH_ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)
GO

/**
	The TOUR_PLACE table contains all of the places associated with an organization. The IS_DEFAULT_PLACE flag determines 
	whether the place contains the basic data about that location - it is not related to special events or other one-off
	descriptions of the location. For example, for DWNTWN Muncie, all places listed in the place directory are set to "true".
	Every place for the ArtsWalk is set to "false" because that place is unique to the ArtsWalk and not considered the 
	default entry. When creating a place for special occasions (like the ArtsWalk) all information for the place is duplicated.
	This was set up to provide a place to have a temporary location for a special event. A restaurant may have a booth set up during 
	a street fair or an art gallery may have a temporary space in a retail location. While it is a duplication of data, it provides 
	and opportunity to be flexible with the place for a specific use case.
**/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TOUR_PLACE](
	[PLACE_ID] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[PLACE_GUID] [uniqueidentifier] NOT NULL,
	[GOOGLE_PLACE_ID] [varchar](max) NULL,
	[IS_DEFAULT_PLACE] [bit] NOT NULL,
	[PLACE_NAME] [nvarchar](max) NULL,
	[PLACE_SUMMARY] [nvarchar](max) NULL,
	[PLACE_DESC] [nvarchar](max) NULL,
	[ADDRESS] [nvarchar](max) NULL,
	[PHONE] [varchar](50) NULL,
	[WEBSITE] [nvarchar](max) NULL,
	[LATITUDE] [float] NULL,
	[LONGITUDE] [float] NULL,
	[ENTERED_BY] [uniqueidentifier] NOT NULL,
	[ENTERED_DATE_TIME] [datetime] NOT NULL,
	[UPDATED_BY] [uniqueidentifier] NULL,
	[UPDATED_DATE_TIME] [datetime] NULL,
	[DELETED_BY] [uniqueidentifier] NULL,
	[DELETED_DATE_TIME] [datetime] NULL,
 CONSTRAINT [PK_TOUR_PLACE] PRIMARY KEY CLUSTERED 
(
	[PLACE_ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)
GO

/**
	The TOUR_PLACE_TO_CATEGORY table defines the relationship between a place and a category.
**/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TOUR_PLACE_TO_CATEGORY](
	[PLACE_TO_CATEGORY_ID] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[PLACE_TO_CATEGORY_GUID] [uniqueidentifier] NOT NULL,
	[PLACE_GUID] [uniqueidentifier] NOT NULL,
	[CATEGORY_GUID] [uniqueidentifier] NOT NULL,
	[ENTERED_BY] [uniqueidentifier] NOT NULL,
	[ENTERED_DATE_TIME] [datetime] NOT NULL,
	[UPDATED_BY] [uniqueidentifier] NULL,
	[UPDATED_DATE_TIME] [datetime] NULL,
	[DELETED_BY] [uniqueidentifier] NULL,
	[DELETED_DATE_TIME] [datetime] NULL,
 CONSTRAINT [PK_TOUR_PLACE_TO_CATEGORY] PRIMARY KEY CLUSTERED 
(
	[PLACE_TO_CATEGORY_ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)
GO

/**
	The TOUR_PLACE_TO_TOUR table defines the relationship between a place and tour. Each place is 
	assigned a specific tour.
**/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TOUR_PLACE_TO_TOUR](
	[PLACE_TO_TOUR_ID] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[PLACE_TO_TOUR_GUID] [uniqueidentifier] NOT NULL,
	[TOUR_GUID] [uniqueidentifier] NOT NULL,
	[PLACE_GUID] [uniqueidentifier] NOT NULL,
	[ORDER_BY] [numeric](8, 0) NULL,
	[ENTERED_BY] [uniqueidentifier] NOT NULL,
	[ENTERED_DATE_TIME] [datetime] NOT NULL,
	[UPDATED_BY] [uniqueidentifier] NULL,
	[UPDATED_DATE_TIME] [datetime] NULL,
	[DELETED_BY] [uniqueidentifier] NULL,
	[DELETED_DATE_TIME] [datetime] NULL,
	[PLACE_SUMMARY_OVERRIDE] [nvarchar](max) NULL,
	[PLACE_DESC_OVERRIDE] [nvarchar](max) NULL,
 CONSTRAINT [PK_TOUR_PLACE_TO_TOUR] PRIMARY KEY CLUSTERED 
(
	[PLACE_TO_TOUR_ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)
GO

/**
	The TOUR_TO_CATEGORY table defines the relationship between a tour and a category.
**/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TOUR_TO_CATEGORY](
	[TOUR_TO_CATEGORY_ID] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[TOUR_TO_CATEGORY_GUID] [uniqueidentifier] NOT NULL,
	[TOUR_GUID] [uniqueidentifier] NOT NULL,
	[CATEGORY_GUID] [uniqueidentifier] NOT NULL,
	[ENTERED_BY] [uniqueidentifier] NOT NULL,
	[ENTERED_DATE_TIME] [datetime] NOT NULL,
	[UPDATED_BY] [uniqueidentifier] NULL,
	[UPDATED_DATE_TIME] [datetime] NULL,
	[DELETED_BY] [uniqueidentifier] NULL,
	[DELETED_DATE_TIME] [datetime] NULL,
 CONSTRAINT [PK_TOUR_TO_CATEGORY] PRIMARY KEY CLUSTERED 
(
	[TOUR_TO_CATEGORY_ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)
GO

/**
	The TOUR_TYPE table defines all of the various types that are permitted throughout the tables. This 
	tables is not related to any specific table, but serves as a generic repository for all types.
**/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TOUR_TYPE](
	[TYPE_ID] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[TYPE_GUID] [uniqueidentifier] NOT NULL,
	[PARENT_TYPE_GUID] [uniqueidentifier] NULL,
	[TYPE_NAME] [varchar](255) NULL,
	[GROUP_ID] [numeric](8, 0) NULL,
	[ORDER_BY] [numeric](8, 0) NULL,
	[ENTERED_BY] [uniqueidentifier] NOT NULL,
	[ENTERED_DATE_TIME] [datetime] NOT NULL,
	[UPDATED_BY] [uniqueidentifier] NULL,
	[UPDATED_DATE_TIME] [datetime] NULL,
	[DELETED_BY] [uniqueidentifier] NULL,
	[DELETED_DATE_TIME] [datetime] NULL,
 CONSTRAINT [PK_TOUR_TYPE] PRIMARY KEY CLUSTERED 
(
	[TYPE_ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)
GO

ALTER TABLE [dbo].[TOUR] ADD  CONSTRAINT [DF_TOUR_TOUR_GUID]  DEFAULT (newid()) FOR [TOUR_GUID]
GO

ALTER TABLE [dbo].[TOUR] ADD  CONSTRAINT [DF_TOUR_ENTERED_DATE_TIME]  DEFAULT (getdate()) FOR [ENTERED_DATE_TIME]
GO

ALTER TABLE [dbo].[TOUR_CATEGORY] ADD  CONSTRAINT [DF_TOUR_CATEGORY_CATEGORY_GUID]  DEFAULT (newid()) FOR [CATEGORY_GUID]
GO

ALTER TABLE [dbo].[TOUR_CATEGORY] ADD  CONSTRAINT [DF_TOUR_CATEGORY_ENTERED_DATE_TIME]  DEFAULT (getdate()) FOR [ENTERED_DATE_TIME]
GO

ALTER TABLE [dbo].[TOUR_EVENT] ADD  CONSTRAINT [DF_TOUR_EVENT_ENTERED_DATE_TIME]  DEFAULT (getdate()) FOR [ENTERED_DATE_TIME]
GO

ALTER TABLE [dbo].[TOUR_FAVORITE] ADD  CONSTRAINT [DF_TOUR_FAVORITE_ENTERED_DATE_TIME]  DEFAULT (getdate()) FOR [ENTERED_DATE_TIME]
GO

ALTER TABLE [dbo].[TOUR_MEDIA] ADD  CONSTRAINT [DF_TOUR_MEDIA_MEDIA_GUID]  DEFAULT (newid()) FOR [MEDIA_GUID]
GO

ALTER TABLE [dbo].[TOUR_MEDIA] ADD  CONSTRAINT [DF_TOUR_MEDIA_ENTERED_DATE_TIME]  DEFAULT (getdate()) FOR [ENTERED_DATE_TIME]
GO

ALTER TABLE [dbo].[TOUR_MEDIA_TO_ITEM] ADD  CONSTRAINT [DF_TOUR_MEDIA_TO_ITEM_MEDIA_TO_ITEM_GUID]  DEFAULT (newid()) FOR [MEDIA_TO_ITEM_GUID]
GO

ALTER TABLE [dbo].[TOUR_MEDIA_TO_ITEM] ADD  CONSTRAINT [DF_TOUR_MEDIA_TO_ITEM_ORDER_BY]  DEFAULT ((1)) FOR [ORDER_BY]
GO

ALTER TABLE [dbo].[TOUR_MEDIA_TO_ITEM] ADD  CONSTRAINT [DF_TOUR_MEDIA_TO_ITEM_ENTERED_DATE_TIME]  DEFAULT (getdate()) FOR [ENTERED_DATE_TIME]
GO

ALTER TABLE [dbo].[TOUR_ORGANIZATION] ADD  CONSTRAINT [DF_TOUR_ORGANIZATION_ORGANIZATION_GUID]  DEFAULT (newid()) FOR [ORGANIZATION_GUID]
GO

ALTER TABLE [dbo].[TOUR_ORGANIZATION] ADD  CONSTRAINT [DF_TOUR_ORGANIZATION_ENTERED_DATE_TIME]  DEFAULT (getdate()) FOR [ENTERED_DATE_TIME]
GO

ALTER TABLE [dbo].[TOUR_ORGANIZATION_TO_ITEM] ADD  CONSTRAINT [DF_TOUR_ORGANIZATION_TO_ITEM_ORGANIZATION_TO_ITEM_GUID]  DEFAULT (newid()) FOR [ORGANIZATION_TO_ITEM_GUID]
GO

ALTER TABLE [dbo].[TOUR_ORGANIZATION_TO_ITEM] ADD  CONSTRAINT [DF_TOUR_ORGANIZATION_TO_ITEM_ENTERED_DATE_TIME]  DEFAULT (getdate()) FOR [ENTERED_DATE_TIME]
GO

ALTER TABLE [dbo].[TOUR_PATH] ADD  CONSTRAINT [DF_TOUR_PATH_PATH_GUID]  DEFAULT (newid()) FOR [PATH_GUID]
GO

ALTER TABLE [dbo].[TOUR_PATH] ADD  CONSTRAINT [DF_TOUR_PATH_ORDER_BY]  DEFAULT ((1)) FOR [ORDER_BY]
GO

ALTER TABLE [dbo].[TOUR_PATH] ADD  CONSTRAINT [DF_TOUR_PATH_ENTERED_DATE_TIME]  DEFAULT (getdate()) FOR [ENTERED_DATE_TIME]
GO

ALTER TABLE [dbo].[TOUR_PLACE] ADD  CONSTRAINT [DF_TOUR_PLACE_PLACE_GUID]  DEFAULT (newid()) FOR [PLACE_GUID]
GO

ALTER TABLE [dbo].[TOUR_PLACE] ADD  CONSTRAINT [DF_TOUR_PLACE_IS_DEFAULT_PLACE]  DEFAULT ((1)) FOR [IS_DEFAULT_PLACE]
GO

ALTER TABLE [dbo].[TOUR_PLACE] ADD  CONSTRAINT [DF_TOUR_PLACE_ENTERED_DATE_TIME]  DEFAULT (getdate()) FOR [ENTERED_DATE_TIME]
GO

ALTER TABLE [dbo].[TOUR_PLACE_TO_CATEGORY] ADD  CONSTRAINT [DF_TOUR_PLACE_TO_CATEGORY_PLACE_TO_CATEGORY_GUID]  DEFAULT (newid()) FOR [PLACE_TO_CATEGORY_GUID]
GO

ALTER TABLE [dbo].[TOUR_PLACE_TO_CATEGORY] ADD  CONSTRAINT [DF_TOUR_PLACE_TO_CATEGORY_ENTERED_DATE_TIME]  DEFAULT (getdate()) FOR [ENTERED_DATE_TIME]
GO

ALTER TABLE [dbo].[TOUR_PLACE_TO_TOUR] ADD  CONSTRAINT [DF_TOUR_PLACE_TO_TOUR_PLACE_TO_TOUR_GUID]  DEFAULT (newid()) FOR [PLACE_TO_TOUR_GUID]
GO

ALTER TABLE [dbo].[TOUR_PLACE_TO_TOUR] ADD  CONSTRAINT [DF_TOUR_PLACE_TO_TOUR_ENTERED_DATE_TIME]  DEFAULT (getdate()) FOR [ENTERED_DATE_TIME]
GO

ALTER TABLE [dbo].[TOUR_TO_CATEGORY] ADD  CONSTRAINT [DF_TOUR_TO_CATEGORY_TOUR_TO_CATEGORY_GUID]  DEFAULT (newid()) FOR [TOUR_TO_CATEGORY_GUID]
GO

ALTER TABLE [dbo].[TOUR_TO_CATEGORY] ADD  CONSTRAINT [DF_TOUR_TO_CATEGORY_ENTERED_DATE_TIME]  DEFAULT (getdate()) FOR [ENTERED_DATE_TIME]
GO

ALTER TABLE [dbo].[TOUR_TYPE] ADD  CONSTRAINT [DF_TOUR_TYPE_TYPE_GUID]  DEFAULT (newid()) FOR [TYPE_GUID]
GO

ALTER TABLE [dbo].[TOUR_TYPE] ADD  CONSTRAINT [DF_TOUR_TYPE_ENTERED_DATE_TIME]  DEFAULT (getdate()) FOR [ENTERED_DATE_TIME]
GO


