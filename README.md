# Artis-At-Auction

An online auction marketplace where sellers list products (art, clothing, accessories) and customers place bids, with a cart, checkout and reporting.

<!-- Add 2-3 screenshots (e.g. in /docs) here -->

## Features
- Seller and customer accounts
- Product listing, editing and deletion for sellers
- Auction bidding: place bids, view active bids, end a bid
- Shopping cart, checkout, payment and order summary
- Invoices and finance / product reports
- Investors portal

## Architecture
```
Art_Backend/    WCF service (C#, .NET Framework 4.7.2) with LINQ to SQL data classes
Art_Frontend/   ASP.NET Web Forms site (aspx, C#, JavaScript, CSS) that consumes the service
```
`Art_Backend/SQLQuery5.sql` contains the table definitions for the SQL Server database.

## Tech stack
C#, ASP.NET Web Forms, WCF, LINQ to SQL, SQL Server (LocalDB), JavaScript, CSS

## Getting started
1. Open `Art_Backend/Art_Backend.sln` and `Art_Frontend/Project_Backup.sln` in Visual Studio 2019 or later.
2. Create a SQL Server / LocalDB database using the table definitions in `Art_Backend/SQLQuery5.sql`, then update the connection string in `Art_Backend/Art_Backend/Web.config`.
3. Run the backend (`Service1.svc`) first, then the frontend.
