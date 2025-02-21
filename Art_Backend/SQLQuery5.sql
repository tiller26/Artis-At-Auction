CREATE TABLE [dbo].[User] (
    [Id]            INT             IDENTITY (101, 1) NOT NULL,
    [Name]          VARCHAR (255)   NULL,
    [Surname]       VARCHAR (255)   NULL,
    [Type]          VARCHAR (50)    NOT NULL,
    [Email]         VARCHAR (255)   NOT NULL,
    [Password]      VARCHAR (MAX)   NOT NULL,
    [ContactNumber] VARCHAR (255)   NULL,
    [StreetAddress] VARCHAR (255)   NULL,
    [City]          VARCHAR (255)   NULL,
    [Province]      VARCHAR (255)   NULL,
    [Image]         VARCHAR (255)   NULL,
    [CreatedAt]     DATETIME2 (7)   DEFAULT (getdate()) NOT NULL,
    [Balance]       DECIMAL (18, 2) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    UNIQUE NONCLUSTERED ([Email] ASC)
);


CREATE TABLE [dbo].[Seller] (
    [Id]           INT           NOT NULL,
    [BusinessName] VARCHAR (255) NULL,
    [NoSale]       INT           NULL,
    [Description]  VARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    FOREIGN KEY ([Id]) REFERENCES [dbo].[User] ([Id]) ON DELETE CASCADE
);



CREATE TABLE [dbo].[Customer] (
    [Id]          INT NOT NULL,
    [NoPurchases] INT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    FOREIGN KEY ([Id]) REFERENCES [dbo].[User] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [dbo].[Payment] (
    [Id]          INT             IDENTITY (161, 1) NOT NULL,
    [Amount]      DECIMAL (18, 2) NOT NULL,
    [Status]      VARCHAR (50)    NULL,
    [PaymentDate] DATETIME2 (7)   DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);



CREATE TABLE [dbo].[Invoice] (
    [Id]         INT             IDENTITY (181, 1) NOT NULL,
    [CustomerId] INT             NULL,
    [Total]      DECIMAL (18, 2) NULL,
    [GrandTotal] DECIMAL (18, 2) NULL,
    [PaymentId]  INT             NULL,
    [Status]     VARCHAR (50)    NULL,
    [CreatedAt]  DATETIME2 (7)   DEFAULT (getdate()) NOT NULL,
    [PaidAt]     DATETIME2 (7)   NULL,
    [VAT]        DECIMAL (18, 2) NULL,
    [Shipping]   DECIMAL (18, 2) NULL,
    [Discount]   DECIMAL (18, 2) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([Id]),
    FOREIGN KEY ([PaymentId]) REFERENCES [dbo].[Payment] ([Id])
);
CREATE TABLE [dbo].[Product] (
    [Id]          INT             IDENTITY (201, 1) NOT NULL,
    [Name]        VARCHAR (255)   NOT NULL,
    [Description] VARCHAR (MAX)   NULL,
    [Price]       DECIMAL (18, 2) NOT NULL,
    [IsActive]    VARCHAR (6)     NULL,
    [Quantity]    INT             NULL,
    [Added]       DATETIME2 (7)   DEFAULT (getdate()) NULL,
	Category varchar(50),
    [Color]       VARCHAR (50)    NULL,
    [SellerId]    INT             NOT NULL,
    [SoldAt]      DATETIME2 (7)   NULL,
    [Images]      VARCHAR (MAX)   NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    FOREIGN KEY ([SellerId]) REFERENCES [dbo].[Seller] ([Id])
);


CREATE TABLE [dbo].[InvoiceItem] (
    [Id]        INT             IDENTITY (191, 1) NOT NULL,
    [Price]     DECIMAL (18, 2) NULL,
    [ProductId] INT             NULL,
    [InvoiceId] INT             NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    FOREIGN KEY ([InvoiceId]) REFERENCES [dbo].[Invoice] ([Id]),
    FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Product] ([Id])
);




CREATE TABLE [dbo].[Bid] (
    [Id]           INT             IDENTITY (131, 1) NOT NULL,
    [CustomerId]   INT             NULL,
    [ProductId]    INT             NULL,
    [CurrentPrice] DECIMAL (18, 2) NULL,
    [CreatedAt]    DATETIME2 (7)   DEFAULT (getdate()) NULL,
    [ExpiresAt]    DATETIME2 (7)   NULL,
    [Expired]      VARCHAR (5)     DEFAULT ('No') NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Product] ([Id]),
    FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([Id])
);

CREATE TABLE [dbo].[Review] (
    [Id]         INT           IDENTITY (1, 1) NOT NULL,
    [ProductId]  INT           NULL,
    [CustomerId] INT           NULL,
    [Stars]      INT           NULL,
    [Comment]    VARCHAR (MAX) NULL,
    [CreatedAt]  DATETIME2 (7) DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Product] ([Id]),
    FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([Id]),
    CHECK ([Stars]>=(1) AND [Stars]<=(5))
);

CREATE TABLE [dbo].[Cart] (
    [Id]         INT             IDENTITY (141, 1) NOT NULL,
    [CustomerId] INT             NULL,
    [Total]      DECIMAL (18, 2) NULL,
    [CreatedAt]  DATETIME2 (7)   DEFAULT (getdate()) NULL,
    [ModifiedAt] DATETIME2 (7)   NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    UNIQUE NONCLUSTERED ([CustomerId] ASC),
    FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([Id]) ON DELETE CASCADE
);
CREATE TABLE [dbo].[CartItem] (
    [Id]        INT             IDENTITY (151, 1) NOT NULL,
    [CartId]    INT             NULL,
    [ProductId] INT             NULL,
    [Price]     DECIMAL (18, 2) NULL,
    [CreatedAt] DATETIME2 (7)   DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Product] ([Id]),
    FOREIGN KEY ([CartId]) REFERENCES [dbo].[Cart] ([Id])
);


CREATE TABLE [dbo].[Art] (
    [Id]         INT             NOT NULL,
    [Type]       VARCHAR (50)    NULL,
    [Weight]     DECIMAL (10, 2) NULL,
    [Dimensions] VARCHAR (255)   NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    FOREIGN KEY ([Id]) REFERENCES [dbo].[Product] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [dbo].[Clothing] (
    [Id]         INT           NOT NULL,
    [FabricType] VARCHAR (255) NULL,
    [Size]       VARCHAR (50)  NULL,
    [Type]       VARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    FOREIGN KEY ([Id]) REFERENCES [dbo].[Product] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [dbo].[Accessories] (
    [Id]       INT           NOT NULL,
    [Type]     VARCHAR (50)  NULL,
    [Material] VARCHAR (255) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    FOREIGN KEY ([Id]) REFERENCES [dbo].[Product] ([Id]) ON DELETE CASCADE
);
CREATE TABLE [dbo].[BusinessRevenue] (
    [Id]            INT             NOT NULL,
    [Registrations] DECIMAL (18, 2) NULL,
    [Sales]         DECIMAL (18, 2) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);
CREATE TABLE [dbo].[Notification] (
    [Id]      INT           IDENTITY (1040, 1) NOT NULL,
    [UserId]  INT           NULL,
    [Message] VARCHAR (MAX) NULL,
    [Date]    DATETIME2 (7) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

CREATE TABLE [dbo].SaleManagement
(
	[Id] INT identity(2041, 1) NOT NULL PRIMARY KEY,
	SellerId int,
	ProductId int,
	PurchaseAmount decimal(18,2),
	SellerShare decimal(18, 2),
	BusinessShare decimal(18,2),
	IsProfitSplit int
);

CREATE TABLE [dbo].[SellerRegistration] (
    [Id]       INT             IDENTITY (171, 1) NOT NULL,
    [SellerId] INT             NULL,
    [Total]    DECIMAL (18, 2) NULL,
    [Date]     DATETIME2 (7)   DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    FOREIGN KEY ([SellerId]) REFERENCES [dbo].[Seller] ([Id])
);

SET IDENTITY_INSERT [dbo].[User] ON
INSERT INTO [dbo].[User] ([Id], [Name], [Surname], [Type], [Email], [Password], [ContactNumber], [StreetAddress], [City], [Province], [Image], [CreatedAt], [Balance]) VALUES (101, N'Robert Hodgins', NULL, N'Admin', N'roberth@gmail.com', N'40bd001563085fc35165329ea1ff5c5ecbdbbeef', N'0780987645', N'', N'Johannesburg', N'Gauteng', N'/assets/img/sellers/Screenshot 2024-10-11 201640.png', N'2024-10-11 20:15:15', CAST(0.00 AS Decimal(18, 2)))
INSERT INTO [dbo].[User] ([Id], [Name], [Surname], [Type], [Email], [Password], [ContactNumber], [StreetAddress], [City], [Province], [Image], [CreatedAt], [Balance]) VALUES (103, N'Sipho Ndlovu', NULL, N'Customer,Seller', N'siphon@gmail.com', N'40bd001563085fc35165329ea1ff5c5ecbdbbeef', N'0837363567', N'', N'Cape Town', N'Western Cape', N'/assets/img/sellers/Screenshot 2024-10-11 224809.png', N'2024-10-11 22:47:39', CAST(0.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[User] OFF

INSERT INTO [dbo].[Customer] ([Id], [NoPurchases]) VALUES (101, 0)
INSERT INTO [dbo].[Customer] ([Id], [NoPurchases]) VALUES (103, 0)

SET IDENTITY_INSERT [dbo].[Cart] ON
INSERT INTO [dbo].[Cart] ([Id], [CustomerId], [Total], [CreatedAt], [ModifiedAt]) VALUES (141, 101, CAST(0.00 AS Decimal(18, 2)), N'2024-10-11 20:15:15', NULL)
INSERT INTO [dbo].[Cart] ([Id], [CustomerId], [Total], [CreatedAt], [ModifiedAt]) VALUES (143, 103, CAST(0.00 AS Decimal(18, 2)), N'2024-10-11 22:47:39', NULL)
SET IDENTITY_INSERT [dbo].[Cart] OFF

INSERT INTO [dbo].[Seller] ([Id], [BusinessName], [NoSale], [Description]) VALUES (101, N'Robert Hodgins', 0, N'London-born Robert Hodgins immigrated to South Africa in 1938 and served in the Union Defence Force during WWII. After the war he studied art and education at Goldsmiths College, University of London, before returning to South Africa in 1954 to teach, first at the Pretoria Technical College School of Art, and then for nearly twenty years at the University of the Witwatersrand. He only became a full-time artist in the early 1980s when he was in his sixties. Hodgins mentored generations of artists, many of whom have achieved international recognition.

Prior to his death in 2010, he donated his collection of over 400 original prints from his extensive print-making oeuvre, produced during a lengthy artistic career, to the Wits Art Museum. The exhibition of these works in 2013 was accompanied by the publication of A Lasting Impression: The Robert Hodgins Print Archive (WAM). The Goodman Gallery retrospective show in 2013, Looking Back, presented a full range of his diverse oeuvre and included pencil drawings, prints, watercolours, tapestries, monoprints, ceramic sculpture, and oil paintings. In 2013, Hodgins’ Three Figures and a Crowd was sold by Strauss & Co, Johannesburg, at the ‘WAM Endowment Auction’ for a record price of R 1 300 000.')
INSERT INTO [dbo].[Seller] ([Id], [BusinessName], [NoSale], [Description]) VALUES (103, N'Sipho Ndlovu', 0, N'Self-taught artist Sipho Ndlovu, was born in Alexandra township, Johannesburg in 1968. His mother was a domestic worker and he was encouraged to paint and draw while passing the hours of boredom waiting for his mother to finish work.

During the 1980s, he exhibited in the street outside the Johannesburg Sun Hotel in Smal Street. Bridgette Read spotted his talent and this led to his first exhibition at the Sanderling Gallery in 1988. A year later he had his first solo exhibition at the Shell House Art Gallery.

In 1990 Ndlovu moved to Cape Town where he developed his unique technique of painting boxes in a free flow organic style. The boxes remind him of wooden crates from bygone days and he says, “I am a collector of memories and moments”. His depiction and love of cattle comes from his ancestors and the Zulu tradition of measuring wealth in cattle.

He has participated in many exhibitions and his work is found in international collections. He is currently most interested in the world around him, painting landscapes and people that capture his imagination')

INSERT INTO [dbo].[BusinessRevenue] ([Id], [Registrations], [Sales]) VALUES (111, CAST(1000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))

SET IDENTITY_INSERT [dbo].[Product] ON
INSERT INTO [dbo].[Product] ([Id], [Name], [Description], [Price], [IsActive], [Quantity], [Added], [Category], [Color], [SellerId], [SoldAt], [Images]) VALUES (205, N'Afternoon in Istanbul', N'signed, dated 89/90, numbered 2/15, inscribed with the title in pencil and embossed with The Caversham Press chopmark in the margin', CAST(18000.00 AS Decimal(18, 2)), N'true', 1, N'2024-10-11 21:19:43', NULL, NULL, 101, NULL, N'/assets/img/products/Screenshot 2024-10-11 211559.png,')
INSERT INTO [dbo].[Product] ([Id], [Name], [Description], [Price], [IsActive], [Quantity], [Added], [Category], [Color], [SellerId], [SoldAt], [Images]) VALUES (206, N'Miss Priss', N'signed, dated ''09, numbered IV/VIII, inscribed with the title in pencil and embossed with The Artists'' Press and Editions ArtThrob chopmarks in the margin', CAST(20000.00 AS Decimal(18, 2)), N'true', 1, N'2024-10-11 21:25:59', NULL, NULL, 101, NULL, N'/assets/img/products/Screenshot 2024-10-11 212523.png,')
INSERT INTO [dbo].[Product] ([Id], [Name], [Description], [Price], [IsActive], [Quantity], [Added], [Category], [Color], [SellerId], [SoldAt], [Images]) VALUES (207, N'Head', N'signed, dated 2004 and inscribed with the title and the medium on the reverse; inscribed with the artist''s name, the date, title and medium on a Bell-Roberts Gallery label adhered to the reverse', CAST(200000.00 AS Decimal(18, 2)), N'true', 1, N'2024-10-11 21:31:06', NULL, NULL, 101, NULL, N'/assets/img/products/Screenshot 2024-10-11 212853.png,/assets/img/products/Screenshot 2024-10-11 212933.png,')
INSERT INTO [dbo].[Product] ([Id], [Name], [Description], [Price], [IsActive], [Quantity], [Added], [Category], [Color], [SellerId], [SoldAt], [Images]) VALUES (208, N'Old Actor Resting', N'signed, dated 2008/9, inscribed with the artist''s name, the title and medium on the reverse', CAST(90000.00 AS Decimal(18, 2)), N'true', 1, N'2024-10-11 21:34:38', NULL, NULL, 101, NULL, N'/assets/img/products/Screenshot 2024-10-11 213334.png,')
INSERT INTO [dbo].[Product] ([Id], [Name], [Description], [Price], [IsActive], [Quantity], [Added], [Category], [Color], [SellerId], [SoldAt], [Images]) VALUES (209, N'Chairman', N'signed, dated ''07, numbered 18/20, inscribed with the title in pencil in the margin and embossed with the Timothy Foulds Print studio chopmark', CAST(28750.00 AS Decimal(18, 2)), N'true', 1, N'2024-10-11 21:38:38', NULL, NULL, 101, NULL, N'/assets/img/products/Screenshot 2024-10-11 213625.png,')
INSERT INTO [dbo].[Product] ([Id], [Name], [Description], [Price], [IsActive], [Quantity], [Added], [Category], [Color], [SellerId], [SoldAt], [Images]) VALUES (210, N'In a Mexican Court', N'signed, dated 2000 and inscribed with the title in the image; signed, dated, inscribed with the title and medium on a João Ferreira and Goodman Gallery labels adhered to the reverse', CAST(23000.00 AS Decimal(18, 2)), N'true', 1, N'2024-10-11 21:41:54', NULL, NULL, 101, NULL, N'/assets/img/products/Screenshot 2024-10-11 214037.png,')
INSERT INTO [dbo].[Product] ([Id], [Name], [Description], [Price], [IsActive], [Quantity], [Added], [Category], [Color], [SellerId], [SoldAt], [Images]) VALUES (211, N'Sophie', N'signed, dated ''08, numbered 17/20, inscribed with the title in pencil and embossed with the Timothy Foulds Print Studio chopmark in the margin', CAST(18750.00 AS Decimal(18, 2)), N'true', 1, N'2024-10-11 21:45:46', NULL, NULL, 101, NULL, N'/assets/img/products/Screenshot 2024-10-11 214435.png,')
INSERT INTO [dbo].[Product] ([Id], [Name], [Description], [Price], [IsActive], [Quantity], [Added], [Category], [Color], [SellerId], [SoldAt], [Images]) VALUES (212, N'Seated Woman', N'signed, dated 2001 and inscribed with the title in pencil in the margin', CAST(11139.00 AS Decimal(18, 2)), N'true', 1, N'2024-10-11 21:47:44', NULL, NULL, 101, NULL, N'/assets/img/products/Screenshot 2024-10-11 214639.png,')
INSERT INTO [dbo].[Product] ([Id], [Name], [Description], [Price], [IsActive], [Quantity], [Added], [Category], [Color], [SellerId], [SoldAt], [Images]) VALUES (213, N'English Knight', N'signed, dated 89 in pencil in the margin and inscribed with the title in the print', CAST(6449.00 AS Decimal(18, 2)), N'true', 1, N'2024-10-11 21:49:14', NULL, NULL, 101, NULL, N'/assets/img/products/Screenshot 2024-10-11 214821.png,')
INSERT INTO [dbo].[Product] ([Id], [Name], [Description], [Price], [IsActive], [Quantity], [Added], [Category], [Color], [SellerId], [SoldAt], [Images]) VALUES (214, N'Untitled (Seated Nude)', N'inscribed with the title and medium on a label adhered to the reverse', CAST(7200.00 AS Decimal(18, 2)), N'true', 1, N'2024-10-11 21:51:24', NULL, NULL, 101, NULL, N'/assets/img/products/Screenshot 2024-10-11 215027.png,')
INSERT INTO [dbo].[Product] ([Id], [Name], [Description], [Price], [IsActive], [Quantity], [Added], [Category], [Color], [SellerId], [SoldAt], [Images]) VALUES (215, N'On a Train', N'signed, dated ''08, numbered 10/20 in pencil in the margin and embossed with the Timothy Foulds Print Studio chopmark', CAST(19933.00 AS Decimal(18, 2)), N'true', 1, N'2024-10-11 21:53:41', NULL, NULL, 101, NULL, N'/assets/img/products/Screenshot 2024-10-11 215243.png,')
INSERT INTO [dbo].[Product] ([Id], [Name], [Description], [Price], [IsActive], [Quantity], [Added], [Category], [Color], [SellerId], [SoldAt], [Images]) VALUES (216, N'Your Case Is?', N'signed, dated ''08, numbered 17/20, inscribed with the title in pencil and embossed with the Timothy Foulds Print Studio chopmark in the margin', CAST(7035.00 AS Decimal(18, 2)), N'true', 1, N'2024-10-11 21:55:09', NULL, NULL, 101, NULL, N'/assets/img/products/Screenshot 2024-10-11 215419.png,')
INSERT INTO [dbo].[Product] ([Id], [Name], [Description], [Price], [IsActive], [Quantity], [Added], [Category], [Color], [SellerId], [SoldAt], [Images]) VALUES (217, N'Back', N'signed, dated ''05, numbered 16/20, inscribed with the title in pencil and embossed with the Timothy Foulds Print Studio chopmark in the margin', CAST(5750.00 AS Decimal(18, 2)), N'true', 1, N'2024-10-11 21:57:03', NULL, NULL, 101, NULL, N'/assets/img/products/Screenshot 2024-10-11 215611.png,')
INSERT INTO [dbo].[Product] ([Id], [Name], [Description], [Price], [IsActive], [Quantity], [Added], [Category], [Color], [SellerId], [SoldAt], [Images]) VALUES (218, N'American Beauty', N'signed, dated ''07, numbered AP 3/4, inscribed with the title in pencil and embossed with The Artists'' Press chopmark in the margin', CAST(18750.00 AS Decimal(18, 2)), N'true', 1, N'2024-10-11 21:58:49', NULL, NULL, 101, NULL, N'/assets/img/products/Screenshot 2024-10-11 215759.png,')
INSERT INTO [dbo].[Product] ([Id], [Name], [Description], [Price], [IsActive], [Quantity], [Added], [Category], [Color], [SellerId], [SoldAt], [Images]) VALUES (219, N'Figure', N'signed, dated ''09, numbered 1/1 and inscribed with the title in pencil in the margin', CAST(25600.00 AS Decimal(18, 2)), N'true', 1, N'2024-10-11 22:00:35', NULL, NULL, 101, NULL, N'/assets/img/products/Screenshot 2024-10-11 215938.png,')
INSERT INTO [dbo].[Product] ([Id], [Name], [Description], [Price], [IsActive], [Quantity], [Added], [Category], [Color], [SellerId], [SoldAt], [Images]) VALUES (220, N'Kikuyu Lawn', N'signed and dated 21; inscribed with the title on the reverse', CAST(8208.00 AS Decimal(18, 2)), N'true', 1, N'2024-10-11 22:50:41', NULL, NULL, 103, NULL, N'/assets/img/products/Screenshot 2024-10-11 224944.png,')
INSERT INTO [dbo].[Product] ([Id], [Name], [Description], [Price], [IsActive], [Quantity], [Added], [Category], [Color], [SellerId], [SoldAt], [Images]) VALUES (221, N'Farmer''s Weekly', N'signed and dated 23', CAST(8208.00 AS Decimal(18, 2)), N'true', 1, N'2024-10-11 22:52:29', NULL, NULL, 103, NULL, N'/assets/img/products/Screenshot 2024-10-11 225130.png,')
INSERT INTO [dbo].[Product] ([Id], [Name], [Description], [Price], [IsActive], [Quantity], [Added], [Category], [Color], [SellerId], [SoldAt], [Images]) VALUES (222, N'From Grinding Maize to Meal', N'signed and dated 22; inscribed with the title on the reverse', CAST(16415.00 AS Decimal(18, 2)), N'true', 1, N'2024-10-11 22:54:09', NULL, NULL, 103, NULL, N'/assets/img/products/Screenshot 2024-10-11 225317.png,')
INSERT INTO [dbo].[Product] ([Id], [Name], [Description], [Price], [IsActive], [Quantity], [Added], [Category], [Color], [SellerId], [SoldAt], [Images]) VALUES (223, N'Imfuyo (Livestock)', N'signed and dated 20; inscribed with the title on the reverse', CAST(11725.00 AS Decimal(18, 2)), N'true', 1, N'2024-10-11 22:55:41', NULL, NULL, 103, NULL, N'/assets/img/products/Screenshot 2024-10-11 225455.png,')
INSERT INTO [dbo].[Product] ([Id], [Name], [Description], [Price], [IsActive], [Quantity], [Added], [Category], [Color], [SellerId], [SoldAt], [Images]) VALUES (224, N'Crossing to Sasolburg', N'signed and dated 21; inscribed with the title on the reverse', CAST(7035.00 AS Decimal(18, 2)), N'true', 1, N'2024-10-11 22:57:27', NULL, NULL, 103, NULL, N'/assets/img/products/Screenshot 2024-10-11 225632.png,')
INSERT INTO [dbo].[Product] ([Id], [Name], [Description], [Price], [IsActive], [Quantity], [Added], [Category], [Color], [SellerId], [SoldAt], [Images]) VALUES (225, N'Ibhuloho - Bridge', N'signed and dated 21; inscribed with the title on the reverse', CAST(8000.00 AS Decimal(18, 2)), N'true', 1, N'2024-10-11 22:59:12', NULL, NULL, 103, NULL, N'/assets/img/products/Screenshot 2024-10-11 225812.png,')
INSERT INTO [dbo].[Product] ([Id], [Name], [Description], [Price], [IsActive], [Quantity], [Added], [Category], [Color], [SellerId], [SoldAt], [Images]) VALUES (226, N'Weekend Driver Eastern Free State', N'signed and dated 20', CAST(6449.00 AS Decimal(18, 2)), N'true', 1, N'2024-10-11 23:00:38', NULL, NULL, 103, NULL, N'/assets/img/products/Screenshot 2024-10-11 225953.png,')
INSERT INTO [dbo].[Product] ([Id], [Name], [Description], [Price], [IsActive], [Quantity], [Added], [Category], [Color], [SellerId], [SoldAt], [Images]) VALUES (227, N'Irene Farm in Pretoria', N'signed and dated 20; inscribed with the title on the reverse', CAST(5863.00 AS Decimal(18, 2)), N'true', 1, N'2024-10-11 23:01:59', NULL, NULL, 103, NULL, N'/assets/img/products/Screenshot 2024-10-11 230117.png,')
INSERT INTO [dbo].[Product] ([Id], [Name], [Description], [Price], [IsActive], [Quantity], [Added], [Category], [Color], [SellerId], [SoldAt], [Images]) VALUES (229, N'JM, Umlaza', N'signed and dated 19; inscribed with the title on the reverse', CAST(8208.00 AS Decimal(18, 2)), N'true', 1, N'2024-10-11 23:04:28', NULL, NULL, 103, NULL, N'/assets/img/products/Screenshot 2024-10-11 230323.png,')
INSERT INTO [dbo].[Product] ([Id], [Name], [Description], [Price], [IsActive], [Quantity], [Added], [Category], [Color], [SellerId], [SoldAt], [Images]) VALUES (230, N'Esibayeni (Cattle Kraal)', N'signed and dated 19; inscribed with the title on the reverse', CAST(1876.00 AS Decimal(18, 2)), N'true', 1, N'2024-10-11 23:06:38', NULL, NULL, 103, NULL, N'/assets/img/products/Screenshot 2024-10-11 230557.png,')
INSERT INTO [dbo].[Product] ([Id], [Name], [Description], [Price], [IsActive], [Quantity], [Added], [Category], [Color], [SellerId], [SoldAt], [Images]) VALUES (231, N'Milk', N'signed and dated 19; inscribed with the title on the reverse', CAST(3752.00 AS Decimal(18, 2)), N'true', 1, N'2024-10-11 23:07:47', NULL, NULL, 103, NULL, N'/assets/img/products/Screenshot 2024-10-11 230711.png,')
INSERT INTO [dbo].[Product] ([Id], [Name], [Description], [Price], [IsActive], [Quantity], [Added], [Category], [Color], [SellerId], [SoldAt], [Images]) VALUES (232, N'Sold Three', N'signed and dated 22; inscribed with the title on the reverse', CAST(23450.00 AS Decimal(18, 2)), N'true', 1, N'2024-10-11 23:09:05', NULL, NULL, 103, NULL, N'/assets/img/products/Screenshot 2024-10-11 230822.png,')
INSERT INTO [dbo].[Product] ([Id], [Name], [Description], [Price], [IsActive], [Quantity], [Added], [Category], [Color], [SellerId], [SoldAt], [Images]) VALUES (233, N'Searching for a Missing Bull', N'signed and dated 21', CAST(16415.00 AS Decimal(18, 2)), N'true', 1, N'2024-10-11 23:10:22', NULL, NULL, 103, NULL, N'/assets/img/products/Screenshot 2024-10-11 230939.png,')
INSERT INTO [dbo].[Product] ([Id], [Name], [Description], [Price], [IsActive], [Quantity], [Added], [Category], [Color], [SellerId], [SoldAt], [Images]) VALUES (235, N'John Deere 8400', N'signed and dated 22; inscribed with the title on the reverse', CAST(25795.00 AS Decimal(18, 2)), N'true', 1, N'2024-10-11 23:11:49', NULL, NULL, 103, NULL, N'/assets/img/products/Screenshot 2024-10-11 231109.png,')
INSERT INTO [dbo].[Product] ([Id], [Name], [Description], [Price], [IsActive], [Quantity], [Added], [Category], [Color], [SellerId], [SoldAt], [Images]) VALUES (236, N'Cattle Man in Vrede', N'signed and dated 21; inscribed with the title on the reverse', CAST(10350.00 AS Decimal(18, 2)), N'true', 1, N'2024-10-11 23:13:24', NULL, NULL, 103, NULL, N'/assets/img/products/Screenshot 2024-10-11 231230.png,')
SET IDENTITY_INSERT [dbo].[Product] OFF

INSERT INTO [dbo].[Art] ([Id], [Type], [Weight], [Dimensions]) VALUES (205, N'Colour etching on paper', CAST(30.00 AS Decimal(10, 2)), N'87 x 70 x 1,5cm')
INSERT INTO [dbo].[Art] ([Id], [Type], [Weight], [Dimensions]) VALUES (206, N'five colour lithograph on paper', CAST(44.00 AS Decimal(10, 2)), N'70,5 x 89,5 x 3,5cm')
INSERT INTO [dbo].[Art] ([Id], [Type], [Weight], [Dimensions]) VALUES (207, N'oil on canvas', CAST(51.00 AS Decimal(10, 2)), N'53,5 x 53,5 x 5cm')
INSERT INTO [dbo].[Art] ([Id], [Type], [Weight], [Dimensions]) VALUES (208, N'oil on canvas', CAST(26.00 AS Decimal(10, 2)), N'60 x 45 x 3cm')
INSERT INTO [dbo].[Art] ([Id], [Type], [Weight], [Dimensions]) VALUES (209, N'colour etching on paper', CAST(29.00 AS Decimal(10, 2)), N'34 x 28cm')
INSERT INTO [dbo].[Art] ([Id], [Type], [Weight], [Dimensions]) VALUES (210, N'monotype print on paper', CAST(19.00 AS Decimal(10, 2)), N'77,5 x  96 x 3cm ')
INSERT INTO [dbo].[Art] ([Id], [Type], [Weight], [Dimensions]) VALUES (211, N'colour etching and aquatint on paper', CAST(21.00 AS Decimal(10, 2)), N'39 x 31cm')
INSERT INTO [dbo].[Art] ([Id], [Type], [Weight], [Dimensions]) VALUES (212, N'pencil on paper', CAST(10.00 AS Decimal(10, 2)), N'45 x 37,5 x 4cm ')
INSERT INTO [dbo].[Art] ([Id], [Type], [Weight], [Dimensions]) VALUES (213, N'colour screenprint on paper', CAST(23.00 AS Decimal(10, 2)), N'34 x 31,5 x 2cm ')
INSERT INTO [dbo].[Art] ([Id], [Type], [Weight], [Dimensions]) VALUES (214, N'ink on sketchbook paper', CAST(35.00 AS Decimal(10, 2)), N'30 x 24 x 3cm')
INSERT INTO [dbo].[Art] ([Id], [Type], [Weight], [Dimensions]) VALUES (215, N'colour etching on paper', CAST(45.00 AS Decimal(10, 2)), N'51 x 39 x 4,5cm')
INSERT INTO [dbo].[Art] ([Id], [Type], [Weight], [Dimensions]) VALUES (216, N'etching on paper', CAST(56.00 AS Decimal(10, 2)), N'39,5 x 28,5cm')
INSERT INTO [dbo].[Art] ([Id], [Type], [Weight], [Dimensions]) VALUES (217, N'etching on paper', CAST(31.00 AS Decimal(10, 2)), N'33 x 25cm')
INSERT INTO [dbo].[Art] ([Id], [Type], [Weight], [Dimensions]) VALUES (218, N'lithograph on paper', CAST(26.00 AS Decimal(10, 2)), N'88 x 68 x 3cm')
INSERT INTO [dbo].[Art] ([Id], [Type], [Weight], [Dimensions]) VALUES (219, N'monotype on paper', CAST(43.00 AS Decimal(10, 2)), N'90,5 x 71 x 3,5cm')
INSERT INTO [dbo].[Art] ([Id], [Type], [Weight], [Dimensions]) VALUES (220, N'oil on canvas', CAST(14.00 AS Decimal(10, 2)), N'43 x 62 x 3,5cm')
INSERT INTO [dbo].[Art] ([Id], [Type], [Weight], [Dimensions]) VALUES (221, N'oil on canvas', CAST(21.00 AS Decimal(10, 2)), N'61 x 73 x 3,5cm')
INSERT INTO [dbo].[Art] ([Id], [Type], [Weight], [Dimensions]) VALUES (222, N'oil on canvas', CAST(23.00 AS Decimal(10, 2)), N'57 x 80,5 x 3cm')
INSERT INTO [dbo].[Art] ([Id], [Type], [Weight], [Dimensions]) VALUES (223, N'oil on canvas', CAST(32.00 AS Decimal(10, 2)), N'31,5 x 45 x 3cm')
INSERT INTO [dbo].[Art] ([Id], [Type], [Weight], [Dimensions]) VALUES (224, N'oil on canvas', CAST(12.00 AS Decimal(10, 2)), N'53 x 80 x 3,5cm')
INSERT INTO [dbo].[Art] ([Id], [Type], [Weight], [Dimensions]) VALUES (225, N'oil on canvas', CAST(20.00 AS Decimal(10, 2)), N'53 x 80 x 3,5cm')
INSERT INTO [dbo].[Art] ([Id], [Type], [Weight], [Dimensions]) VALUES (226, N'oil on canvas', CAST(18.00 AS Decimal(10, 2)), N'41 x 60 x 3,5cm')
INSERT INTO [dbo].[Art] ([Id], [Type], [Weight], [Dimensions]) VALUES (227, N'oil on canvas', CAST(14.00 AS Decimal(10, 2)), N'37,5 x  49,5 x 4cm')
INSERT INTO [dbo].[Art] ([Id], [Type], [Weight], [Dimensions]) VALUES (229, N'oil on canvas', CAST(26.00 AS Decimal(10, 2)), N'40 x 45 x 3,5cm')
INSERT INTO [dbo].[Art] ([Id], [Type], [Weight], [Dimensions]) VALUES (230, N'oil on canvas', CAST(12.00 AS Decimal(10, 2)), N'31 x 38 x 3,5cm')
INSERT INTO [dbo].[Art] ([Id], [Type], [Weight], [Dimensions]) VALUES (231, N'oil on canvas', CAST(16.00 AS Decimal(10, 2)), N'27 x  31 x 3,5cm')
INSERT INTO [dbo].[Art] ([Id], [Type], [Weight], [Dimensions]) VALUES (232, N'oil on canvas', CAST(18.00 AS Decimal(10, 2)), N'57 x 80 x 3,5cm')
INSERT INTO [dbo].[Art] ([Id], [Type], [Weight], [Dimensions]) VALUES (233, N'oil on canvas', CAST(15.00 AS Decimal(10, 2)), N'57 x 80 x 3,5cm')
INSERT INTO [dbo].[Art] ([Id], [Type], [Weight], [Dimensions]) VALUES (235, N'oil on canvas', CAST(13.00 AS Decimal(10, 2)), N'53 x 80 x 3,5cm')
INSERT INTO [dbo].[Art] ([Id], [Type], [Weight], [Dimensions]) VALUES (236, N'oil on canvas', CAST(16.00 AS Decimal(10, 2)), N'62 x 35 x 4cm')


SET IDENTITY_INSERT [dbo].[Bid] ON
INSERT INTO [dbo].[Bid] ([Id], [CustomerId], [ProductId], [CurrentPrice], [CreatedAt], [ExpiresAt], [Expired]) VALUES (135, NULL, 205, CAST(7200.00 AS Decimal(18, 2)), N'2024-10-12 21:19:43', N'2024-10-14 21:19:43', N'No')
INSERT INTO [dbo].[Bid] ([Id], [CustomerId], [ProductId], [CurrentPrice], [CreatedAt], [ExpiresAt], [Expired]) VALUES (136, NULL, 206, CAST(8000.00 AS Decimal(18, 2)), N'2024-10-12 21:25:59', N'2024-10-14 21:25:59', N'No')
INSERT INTO [dbo].[Bid] ([Id], [CustomerId], [ProductId], [CurrentPrice], [CreatedAt], [ExpiresAt], [Expired]) VALUES (137, NULL, 207, CAST(80000.00 AS Decimal(18, 2)), N'2024-10-12 21:31:06', N'2024-10-14 21:31:06', N'No')
INSERT INTO [dbo].[Bid] ([Id], [CustomerId], [ProductId], [CurrentPrice], [CreatedAt], [ExpiresAt], [Expired]) VALUES (138, NULL, 208, CAST(36000.00 AS Decimal(18, 2)), N'2024-10-12 21:34:38', N'2024-10-14 21:34:38', N'No')
INSERT INTO [dbo].[Bid] ([Id], [CustomerId], [ProductId], [CurrentPrice], [CreatedAt], [ExpiresAt], [Expired]) VALUES (139, NULL, 209, CAST(2400.00 AS Decimal(18, 2)), N'2024-10-12 21:38:38', N'2024-10-14 21:38:38', N'No')
INSERT INTO [dbo].[Bid] ([Id], [CustomerId], [ProductId], [CurrentPrice], [CreatedAt], [ExpiresAt], [Expired]) VALUES (140, NULL, 210, CAST(9200.00 AS Decimal(18, 2)), N'2024-10-12 21:41:54', N'2024-10-14 21:41:54', N'No')
INSERT INTO [dbo].[Bid] ([Id], [CustomerId], [ProductId], [CurrentPrice], [CreatedAt], [ExpiresAt], [Expired]) VALUES (141, NULL, 211, CAST(7500.00 AS Decimal(18, 2)), N'2024-10-12 21:45:46', N'2024-10-14 21:45:46', N'No')
INSERT INTO [dbo].[Bid] ([Id], [CustomerId], [ProductId], [CurrentPrice], [CreatedAt], [ExpiresAt], [Expired]) VALUES (142, NULL, 212, CAST(4455.60 AS Decimal(18, 2)), N'2024-10-12 21:47:44', N'2024-10-14 21:47:44', N'No')
INSERT INTO [dbo].[Bid] ([Id], [CustomerId], [ProductId], [CurrentPrice], [CreatedAt], [ExpiresAt], [Expired]) VALUES (143, NULL, 213, CAST(2579.60 AS Decimal(18, 2)), N'2024-10-12 21:49:14', N'2024-10-14 21:49:14', N'No')
INSERT INTO [dbo].[Bid] ([Id], [CustomerId], [ProductId], [CurrentPrice], [CreatedAt], [ExpiresAt], [Expired]) VALUES (144, NULL, 214, CAST(2880.00 AS Decimal(18, 2)), N'2024-10-12 21:51:24', N'2024-10-14 21:51:24', N'No')
INSERT INTO [dbo].[Bid] ([Id], [CustomerId], [ProductId], [CurrentPrice], [CreatedAt], [ExpiresAt], [Expired]) VALUES (145, NULL, 215, CAST(7973.20 AS Decimal(18, 2)), N'2024-10-12 21:53:41', N'2024-10-14 21:53:41', N'No')
INSERT INTO [dbo].[Bid] ([Id], [CustomerId], [ProductId], [CurrentPrice], [CreatedAt], [ExpiresAt], [Expired]) VALUES (146, NULL, 216, CAST(2814.00 AS Decimal(18, 2)), N'2024-10-12 21:55:09', N'2024-10-14 21:55:09', N'No')
INSERT INTO [dbo].[Bid] ([Id], [CustomerId], [ProductId], [CurrentPrice], [CreatedAt], [ExpiresAt], [Expired]) VALUES (147, NULL, 217, CAST(2300.00 AS Decimal(18, 2)), N'2024-10-12 21:57:03', N'2024-10-14 21:57:03', N'No')
INSERT INTO [dbo].[Bid] ([Id], [CustomerId], [ProductId], [CurrentPrice], [CreatedAt], [ExpiresAt], [Expired]) VALUES (148, NULL, 218, CAST(7500.00 AS Decimal(18, 2)), N'2024-10-12 21:58:49', N'2024-10-14 21:58:49', N'No')
INSERT INTO [dbo].[Bid] ([Id], [CustomerId], [ProductId], [CurrentPrice], [CreatedAt], [ExpiresAt], [Expired]) VALUES (149, NULL, 219, CAST(10240.00 AS Decimal(18, 2)), N'2024-10-12 22:00:35', N'2024-10-14 22:00:35', N'No')
INSERT INTO [dbo].[Bid] ([Id], [CustomerId], [ProductId], [CurrentPrice], [CreatedAt], [ExpiresAt], [Expired]) VALUES (150, NULL, 220, CAST(3283.20 AS Decimal(18, 2)), N'2024-10-12 22:50:41', N'2024-10-14 22:50:41', N'No')
INSERT INTO [dbo].[Bid] ([Id], [CustomerId], [ProductId], [CurrentPrice], [CreatedAt], [ExpiresAt], [Expired]) VALUES (151, NULL, 221, CAST(3283.20 AS Decimal(18, 2)), N'2024-10-12 22:52:29', N'2024-10-14 22:52:29', N'No')
INSERT INTO [dbo].[Bid] ([Id], [CustomerId], [ProductId], [CurrentPrice], [CreatedAt], [ExpiresAt], [Expired]) VALUES (152, NULL, 222, CAST(6566.00 AS Decimal(18, 2)), N'2024-10-12 22:54:09', N'2024-10-14 22:54:09', N'No')
INSERT INTO [dbo].[Bid] ([Id], [CustomerId], [ProductId], [CurrentPrice], [CreatedAt], [ExpiresAt], [Expired]) VALUES (153, NULL, 223, CAST(4690.00 AS Decimal(18, 2)), N'2024-10-12 22:55:41', N'2024-10-14 22:55:41', N'No')
INSERT INTO [dbo].[Bid] ([Id], [CustomerId], [ProductId], [CurrentPrice], [CreatedAt], [ExpiresAt], [Expired]) VALUES (154, NULL, 224, CAST(2814.00 AS Decimal(18, 2)), N'2024-10-12 22:57:27', N'2024-10-14 22:57:27', N'No')
INSERT INTO [dbo].[Bid] ([Id], [CustomerId], [ProductId], [CurrentPrice], [CreatedAt], [ExpiresAt], [Expired]) VALUES (155, NULL, 225, CAST(3200.00 AS Decimal(18, 2)), N'2024-10-12 22:59:12', N'2024-10-14 22:59:12', N'No')
INSERT INTO [dbo].[Bid] ([Id], [CustomerId], [ProductId], [CurrentPrice], [CreatedAt], [ExpiresAt], [Expired]) VALUES (156, NULL, 226, CAST(2579.60 AS Decimal(18, 2)), N'2024-10-12 23:00:38', N'2024-10-14 23:00:38', N'No')
INSERT INTO [dbo].[Bid] ([Id], [CustomerId], [ProductId], [CurrentPrice], [CreatedAt], [ExpiresAt], [Expired]) VALUES (157, NULL, 227, CAST(2345.20 AS Decimal(18, 2)), N'2024-10-12 23:01:59', N'2024-10-14 23:01:59', N'No')
INSERT INTO [dbo].[Bid] ([Id], [CustomerId], [ProductId], [CurrentPrice], [CreatedAt], [ExpiresAt], [Expired]) VALUES (159, NULL, 229, CAST(3283.20 AS Decimal(18, 2)), N'2024-10-12 23:04:28', N'2024-10-14 23:04:28', N'No')
INSERT INTO [dbo].[Bid] ([Id], [CustomerId], [ProductId], [CurrentPrice], [CreatedAt], [ExpiresAt], [Expired]) VALUES (160, NULL, 230, CAST(750.40 AS Decimal(18, 2)), N'2024-10-12 23:06:38', N'2024-10-14 23:06:38', N'No')
INSERT INTO [dbo].[Bid] ([Id], [CustomerId], [ProductId], [CurrentPrice], [CreatedAt], [ExpiresAt], [Expired]) VALUES (161, NULL, 231, CAST(1500.80 AS Decimal(18, 2)), N'2024-10-12 23:07:47', N'2024-10-14 23:07:47', N'No')
INSERT INTO [dbo].[Bid] ([Id], [CustomerId], [ProductId], [CurrentPrice], [CreatedAt], [ExpiresAt], [Expired]) VALUES (162, NULL, 232, CAST(9380.00 AS Decimal(18, 2)), N'2024-10-12 23:09:05', N'2024-10-14 23:09:05', N'No')
INSERT INTO [dbo].[Bid] ([Id], [CustomerId], [ProductId], [CurrentPrice], [CreatedAt], [ExpiresAt], [Expired]) VALUES (163, NULL, 233, CAST(6566.00 AS Decimal(18, 2)), N'2024-10-12 23:10:22', N'2024-10-14 23:10:22', N'No')
INSERT INTO [dbo].[Bid] ([Id], [CustomerId], [ProductId], [CurrentPrice], [CreatedAt], [ExpiresAt], [Expired]) VALUES (165, NULL, 235, CAST(10318.00 AS Decimal(18, 2)), N'2024-10-12 23:11:49', N'2024-10-14 23:11:49', N'No')
INSERT INTO [dbo].[Bid] ([Id], [CustomerId], [ProductId], [CurrentPrice], [CreatedAt], [ExpiresAt], [Expired]) VALUES (166, NULL, 236, CAST(4140.00 AS Decimal(18, 2)), N'2024-10-12 23:13:24', N'2024-10-14 23:13:24', N'No')
SET IDENTITY_INSERT [dbo].[Bid] OFF

SET IDENTITY_INSERT [dbo].[Notification] ON
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1040, 101, N'Account created', N'2024-10-11 20:15:15')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1041, 101, N'Registered as Seller', N'2024-10-11 20:34:22')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1042, 101, N'Afternoon in Istanbul item awaiting bid opening', N'2024-10-11 20:42:34')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1043, 101, N'Afternoon in Istanbul item awaiting bid opening', N'2024-10-11 21:00:36')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1044, 101, N'Afternoon in Istanbul item awaiting bid opening', N'2024-10-11 21:13:07')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1045, 101, N'Afternoon in Istanbul item awaiting bid opening', N'2024-10-11 21:16:24')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1046, 101, N'Afternoon in Istanbul item awaiting bid opening', N'2024-10-11 21:19:43')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1047, 101, N'Miss Priss item awaiting bid opening', N'2024-10-11 21:25:59')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1048, 101, N'Head item awaiting bid opening', N'2024-10-11 21:31:06')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1049, 101, N'Old Actor Resting item awaiting bid opening', N'2024-10-11 21:34:38')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1050, 101, N'Chairman item awaiting bid opening', N'2024-10-11 21:38:38')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1051, 101, N'In a Mexican Court item awaiting bid opening', N'2024-10-11 21:41:54')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1052, 101, N'Sophie item awaiting bid opening', N'2024-10-11 21:45:46')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1053, 101, N'Seated Woman item awaiting bid opening', N'2024-10-11 21:47:44')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1054, 101, N'English Knight item awaiting bid opening', N'2024-10-11 21:49:14')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1055, 101, N'Untitled (Seated Nude) item awaiting bid opening', N'2024-10-11 21:51:24')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1056, 101, N'On a Train item awaiting bid opening', N'2024-10-11 21:53:41')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1057, 101, N'Your Case Is? item awaiting bid opening', N'2024-10-11 21:55:09')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1058, 101, N'Back item awaiting bid opening', N'2024-10-11 21:57:03')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1059, 101, N'American Beauty item awaiting bid opening', N'2024-10-11 21:58:49')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1060, 101, N'Figure item awaiting bid opening', N'2024-10-11 22:00:35')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1063, 103, N'Account created', N'2024-10-11 22:47:39')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1064, 103, N'Registered as Seller', N'2024-10-11 22:48:19')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1065, 103, N'Kikuyu Lawn item awaiting bid opening', N'2024-10-11 22:50:41')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1066, 103, N'Farmer''s Weekly item awaiting bid opening', N'2024-10-11 22:52:29')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1067, 103, N'From Grinding Maize to Meal item awaiting bid opening', N'2024-10-11 22:54:09')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1068, 103, N'Imfuyo (Livestock) item awaiting bid opening', N'2024-10-11 22:55:41')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1069, 103, N'Crossing to Sasolburg item awaiting bid opening', N'2024-10-11 22:57:27')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1070, 103, N'Ibhuloho - Bridge item awaiting bid opening', N'2024-10-11 22:59:12')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1071, 103, N'Weekend Driver Eastern Free State item awaiting bid opening', N'2024-10-11 23:00:38')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1072, 103, N'Irene Farm in Pretoria item awaiting bid opening', N'2024-10-11 23:01:59')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1073, 103, N'Frankfort – Free State item awaiting bid opening', N'2024-10-11 23:02:56')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1074, 103, N'JM, Umlaza item awaiting bid opening', N'2024-10-11 23:04:28')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1075, 103, N'Esibayeni (Cattle Kraal) item awaiting bid opening', N'2024-10-11 23:06:38')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1076, 103, N'Milk item awaiting bid opening', N'2024-10-11 23:07:47')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1077, 103, N'Sold Three item awaiting bid opening', N'2024-10-11 23:09:05')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1078, 103, N'Searching for a Missing Bull item awaiting bid opening', N'2024-10-11 23:10:22')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1079, 103, N'Searching for a Missing Bull item awaiting bid opening', N'2024-10-11 23:10:22')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1080, 103, N'John Deere 8400 item awaiting bid opening', N'2024-10-11 23:11:49')
INSERT INTO [dbo].[Notification] ([Id], [UserId], [Message], [Date]) VALUES (1081, 103, N'Cattle Man in Vrede item awaiting bid opening', N'2024-10-11 23:13:24')
SET IDENTITY_INSERT [dbo].[Notification] OFF
