using System;
using System.Collections.Concurrent;
using System.Data.Linq;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using System.Threading;
using System.Web;

namespace Art_Backend
{
	// NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service1" in code, svc and config file together.
	// NOTE: In order to launch WCF Test Client for testing this service, please select Service1.svc or Service1.svc.cs at the Solution Explorer and start debugging.
	public class Service1 : IService1
	{
		DataClassesDataContext db = new DataClassesDataContext();

		// Login

		public string Login(string email, string password)
		{
			var user = db.Users.FirstOrDefault(u => u.Email == email && u.Password == password);
			if (user != null)
			{
				return user.Id + ":" + user.Type;
			}
			return null;
		}

		public string GetUserRole(int id)
		{
			var user = db.Users.FirstOrDefault(u => u.Id == id);
			if (user != null)
			{
				return user.Type;
			}
			return null;
		}

		public User GetUser(int id)
		{
			var user = db.Users.FirstOrDefault(u => u.Id == id);
			var retUser = new User
			{
				Name = user.Name,
				Email = user.Email,
				ContactNumber = user.ContactNumber,
				StreetAddress = user.StreetAddress,
				City = user.City,
				Province = user.Province,
				Image = user.Image,
				Balance = user.Balance
			};
			return retUser;
		}

		// Customer actions

		public string RegisterCustomer(User user)
		{
			try
			{
				var checkUser = db.Users.FirstOrDefault(u => u.Email == user.Email);
				if (checkUser == null)
				{
					// Save the new user
					user.Type = "Customer";
					user.CreatedAt = DateTime.Now;
					user.Balance = 0;
					db.Users.InsertOnSubmit(user);
					db.SubmitChanges();

					// Add user to sellers
					var customer = new Customer { Id = user.Id };
					customer.NoPurchases = 0;

					db.Customers.InsertOnSubmit(customer);
					db.SubmitChanges();

					// Create a cart for the customer
					createCart(user.Id);

					Notification notification = new Notification
					{
						UserId = user.Id,
						Message = "Account created",
						Date = DateTime.Now
					};
					db.Notifications.InsertOnSubmit(notification);
					db.SubmitChanges();

					return "0:success";
				}
				else
				{
					return "-1:email exists";
				}
			}
			catch (Exception)
			{
				return "-2:error occured";
			}
		}

		private void createCart(int customerId)
		{
			try
			{
				var cart = new Cart
				{
					CustomerId = customerId,
					Total = 0,
					CreatedAt = DateTime.Now
				};
				db.Carts.InsertOnSubmit(cart);
				db.SubmitChanges();
			}
			catch (Exception)
			{
				throw new Exception("Creating cart that already exixts");
			}
		}

		public List<Notification> GetNotifications(int userId)
		{
			var nots = db.Notifications
						.Where(n => n.UserId == userId)
						.OrderByDescending(n => n.Date)
						.ToList();
			return nots;
		}

		public bool RemoveCustomer(int customerId)
		{
			try
			{
				var customer = db.Customers.FirstOrDefault(s => s.Id == customerId);
				db.Customers.DeleteOnSubmit(customer);
				db.SubmitChanges();
				return true;
			}
			catch
			{
				return false;
			}
		}

		public bool EditCustomer(CustomerDT newCustomer)
		{
			throw new NotImplementedException();
		}

		public CustomerDT GetCustomer(int customerId)
		{
			// Retrieve the customer from the database
			var customer = db.Customers
				.Where(c => c.Id == customerId)
				.Select(c => new CustomerDT
				{
					Name = c.User.Name,
					Surname = c.User.Surname,
					Email = c.User.Email,
					ContactNumber = c.User.ContactNumber,
					StreetAddress = c.User.StreetAddress,
					City = c.User.City,
					Province = c.User.Province,
					Image = c.User.Image,
					CreatedAt = c.User.CreatedAt,
					NoPurchases = c.NoPurchases
				})
				.FirstOrDefault();

			return customer;
		}

		public List<CustomerDT> GetCustomers()
		{
			var customers = db.Customers.Select(c => new CustomerDT
			{
				Name = c.User.Name,
				Surname = c.User.Surname,
				Email = c.User.Email,
				ContactNumber = c.User.ContactNumber,
				StreetAddress = c.User.StreetAddress,
				City = c.User.City,
				Province = c.User.Province,
				Image = c.User.Image,
				CreatedAt = c.User.CreatedAt,
				NoPurchases = c.NoPurchases
			})
			.ToList();
			return customers;
		}

		// Seller actions

		public bool RegisterSeller(int id, string description, string business, string image)
		{
			try
			{
				// Elevate type to seller
				var user = db.Users.FirstOrDefault(u => u.Id == id);
				user.Type = "Customer,Seller";
				user.Image = image;

				// Add user to sellers
				var seller = new Seller
				{
					Id = user.Id,
					NoSale = 0,
					BusinessName = business,
					Description = description
				};
				db.Sellers.InsertOnSubmit(seller);
				db.SubmitChanges();

				// record seller registration
				SellerRegistration registration = new SellerRegistration
				{
					SellerId = id,
					Total = 500,
					Date = DateTime.Now
				};
				db.SellerRegistrations.InsertOnSubmit(registration);
				db.SubmitChanges();

				// add revenue totals
				var revenue = db.BusinessRevenues.FirstOrDefault(r => r.Id == 111);
				revenue.Registrations = revenue.Registrations + 500;
				db.SubmitChanges();

				Notification notification = new Notification
				{
					UserId = user.Id,
					Message = "Registered as Seller",
					Date = DateTime.Now
				};
				db.Notifications.InsertOnSubmit(notification);
				db.SubmitChanges();

				return true;
			}
			catch (Exception ex)
			{
				return false;
			}
		}

		public bool RemoveSeller(int sellerId)
		{
			try
			{
				var seller = db.Sellers.FirstOrDefault(s => s.Id == sellerId);
				db.Sellers.DeleteOnSubmit(seller);
				db.SubmitChanges();
				return true;
			}
			catch
			{
				return false;
			}
		}

		public bool debit(decimal funds, int id)
		{
			try
			{
				var user = db.Users.FirstOrDefault(c => c.Id == id);
				decimal? oldBalance = 0;
				if (user.Balance == null || user.Balance < funds)
				{
					user.Balance = 0;
					return false;
				}
				oldBalance = user.Balance;
				user.Balance = oldBalance - funds;
				db.SubmitChanges();

				Notification notification = new Notification
				{
					UserId = user.Id,
					Message = $"Payment of R {funds.ToString("f2")} made",
					Date = DateTime.Now
				};
				db.Notifications.InsertOnSubmit(notification);
				db.SubmitChanges();

				return true;
			}
			catch (Exception)
			{
				return false;
			}
		}

		public bool credit(decimal funds, int id)
		{
			try
			{
				var user = db.Users.FirstOrDefault(c => c.Id == id);
				decimal? oldBalance = 0;
				if (user.Balance != null)
				{
					oldBalance = user.Balance;
					user.Balance = funds + oldBalance;
					db.SubmitChanges();

					Notification notification = new Notification
					{
						UserId = user.Id,
						Message = $"Amount of R {funds.ToString("f2")} deposited",
						Date = DateTime.Now
					};
					db.Notifications.InsertOnSubmit(notification);
					db.SubmitChanges();
				}
				return true;
			}
			catch (Exception)
			{
				return false;
			}
		}

		public bool EditSeller(SellerDT newSeller)
		{
			throw new NotImplementedException();
		}

		public SellerDT GetSeller(int sellerId)
		{
			var seller = db.Sellers
				.Where(c => c.Id == sellerId)
				.Select(c => new SellerDT
				{
					Id = c.User.Id,

					Name = c.User.Name,
					Description = c.Description,
					Surname = c.User.Surname,
					Email = c.User.Email,
					ContactNumber = c.User.ContactNumber,
					StreetAddress = c.User.StreetAddress,
					City = c.User.City,
					Province = c.User.Province,
					Image = c.User.Image,
					CreatedAt = c.User.CreatedAt,
					BusinessName = c.BusinessName,
					NoSale = c.NoSale
				})
				.FirstOrDefault();

			return seller;
		}

		public List<SellerDT> GetSellers()
		{
			var sellers = db.Sellers.Select(c => new SellerDT
			{
				Id = c.User.Id,
				Description = c.Description,
				Name = c.User.Name,
				Surname = c.User.Surname,
				Email = c.User.Email,
				ContactNumber = c.User.ContactNumber,
				StreetAddress = c.User.StreetAddress,
				City = c.User.City,
				Province = c.User.Province,
				Image = c.User.Image,
				CreatedAt = c.User.CreatedAt,
				BusinessName = c.BusinessName,

				NoSale = c.NoSale
			})
			.ToList();
			return sellers;
		}

		// Product actions

		public int AddProduct(ProductReg product)
		{
			try
			{
				// get seller who is registering
				var seller = db.Sellers.FirstOrDefault(s => s.Id == product.SellerId);

				// Create a product with Product Registration info
				var newProduct = new Product
				{
					Name = product.Name,
					Description = product.Description,
					Price = product.Price,
					IsActive = "true",
					Quantity = product.Quantity,
					Added = DateTime.Now,
					Color = product.Color,
					Seller = seller,
					Category = product.Category
				};
				// change the array of images in ProductReg to CSVs & add to new product
				string images = "";
				foreach (var img in product.Images) // Images is an array of strings
				{
					images += img + ",";
				}
				newProduct.Images = images;

				// save to database
				db.Products.InsertOnSubmit(newProduct);
				db.SubmitChanges();

				/*
				 * This id is returned to help with creation of the specific 
				 * type of products such as Clothing, Art and Accessory
				 * Further information will be provided by the client
				 * This will help differentiate the products and access specific info
				 * regarding each product
				 */
				return newProduct.Id;
			}
			catch (Exception)
			{
				// could not product
				return -1;
			}
		}

		public ProductDT GetProduct(int productId)
		{
			try
			{
				var prod = db.Products.FirstOrDefault(p => p.Id == productId);

				// Create a productDT to be returned
				var product = db.Products
					.Where(p => p.Id == productId)
					.Select(p => new ProductDT
					{
						Id = p.Id,
						Name = p.Name,
						Description = p.Description,
						Price = p.Price,
						IsActive = p.IsActive,
						Quantity = p.Quantity,
						Added = p.Added,
						Color = p.Color,
						SoldAt = p.SoldAt,
						SellerId = p.SellerId,
						Images = p.Images
					}).FirstOrDefault();

				// include the item specifics like size / dimensions
				product.ExtraAttributes = new List<string>();
				if (prod.Art != null)
				{
					product.ExtraAttributes.Add(prod.Art.Type);
					product.ExtraAttributes.Add(prod.Art.Weight.ToString() + " g");
					product.ExtraAttributes.Add(prod.Art.Dimensions);
				}
				else if (prod.Clothing != null)
				{
					product.ExtraAttributes.Add(prod.Clothing.Type);
					product.ExtraAttributes.Add(prod.Clothing.Size);
					product.ExtraAttributes.Add(prod.Clothing.FabricType);
				}
				else if (prod.Accessory != null)
				{
					product.ExtraAttributes.Add(prod.Accessory.Type);
					product.ExtraAttributes.Add(prod.Accessory.Material);
				}

				return product;
			}
			catch (Exception)
			{
				// no product found
				return null;
			}
		}

		public List<ProductDT> GetClothing()
		{
			// retrieve all the products from the datatbase
			var products = db.Products.Where(p => p.Clothing.Id == p.Id)
				.Select(p => new ProductDT
				{
					Id = p.Id,
					Name = p.Name,
					Description = p.Description,
					Price = p.Price,
					IsActive = p.IsActive,
					Quantity = p.Quantity,
					Added = p.Added,
					Color = p.Color,
					SoldAt = p.SoldAt,
					SellerId = p.SellerId,
					Images = p.Images
				})
			.ToList();

			// return the products
			return products;
		}

		public List<ProductDT> GetAccessories()
		{
			var products = db.Products.Where(p => p.Accessory.Id == p.Id)
				.Select(p => new ProductDT
				{
					Id = p.Id,
					Name = p.Name,
					Description = p.Description,
					Price = p.Price,
					IsActive = p.IsActive,
					Quantity = p.Quantity,
					Added = p.Added,
					Color = p.Color,
					SoldAt = p.SoldAt,
					SellerId = p.SellerId,
					Images = p.Images
				})
			.ToList();

			// return the products
			return products;
		}

		public List<ProductDT> GetArts()
		{
			var products = db.Products.Where(p => p.Art.Id == p.Id)
				.Select(p => new ProductDT
				{
					Id = p.Id,
					Name = p.Name,
					Description = p.Description,
					Price = p.Price,
					IsActive = p.IsActive,
					Quantity = p.Quantity,
					Added = p.Added,
					Color = p.Color,
					SoldAt = p.SoldAt,
					SellerId = p.SellerId,
					Images = p.Images
				})
			.ToList();

			// return the products
			return products;
		}

		public List<BidDT> Search(string query)
		{
			var bids = GetBids();
			List<BidDT> toRet = new List<BidDT>();
			foreach (var bid in bids)
			{
				var product = db.Products.FirstOrDefault(p => p.Id == bid.ProductId);
				if (product.Name.ToLower().Contains(query))
				{
					toRet.Add(bid);
				}
			}
			return toRet;
		}

		public List<BidDT> GetBasedPrice(string type, decimal min, decimal max)
		{
			var bids = GetBids();
			var products = GetBids();
			if (type == "All")
			{
				List<BidDT> prods = new List<BidDT>();
				foreach (var bid in bids)
				{
					if (bid.Amount >= min && bid.Amount < max)
					{
						prods.Add(bid);
					}
				}
				products = prods;
			}
			else if (type == "clothing")
			{
				List<BidDT> prods = new List<BidDT>();
				foreach (var bid in bids)
				{
					var cloths = GetClothing();
					if (bid.Amount >= min && bid.Amount < max)
					{
						foreach (var cloth in cloths)
						{
							if (cloth.Id == bid.ProductId)
							{
								prods.Add(bid);
							}
						}
					}
				}
				products = prods;
			}
			else if (type == "accessories")
			{
				List<BidDT> prods = new List<BidDT>();
				foreach (var bid in bids)
				{
					var cloths = GetAccessories();
					if (bid.Amount >= min && bid.Amount < max)
					{
						foreach (var cloth in cloths)
						{
							if (cloth.Id == bid.ProductId)
							{
								prods.Add(bid);
							}
						}
					}
				}
				products = prods;
			}
			else if (type == "art")
			{
				List<BidDT> prods = new List<BidDT>();
				foreach (var bid in bids)
				{
					var cloths = GetArts();
					if (bid.Amount >= min && bid.Amount < max)
					{
						foreach (var cloth in cloths)
						{
							if (cloth.Id == bid.ProductId)
							{
								prods.Add(bid);
							}
						}
					}
				}
				products = prods;
			}
			return products;
		}
		public List<ProductDT> GetProducts()
		{
			try
			{
				// retrieve all the products from the datatbase
				var products = db.Products.Select(p => new ProductDT
				{
					Id = p.Id,
					Name = p.Name,
					Description = p.Description,
					Price = p.Price,
					IsActive = p.IsActive,
					Quantity = p.Quantity,
					Added = p.Added,
					Color = p.Color,
					SoldAt = p.SoldAt,
					SellerId = p.SellerId,
					Images = p.Images
				})
				.ToList();

				// return the products
				return products;
			}
			catch (Exception)
			{
				// no products found
				return null;
			}
		}

		public bool RemoveProduct(int productId)
		{
			try
			{
				// remove any bids first
				var bid = db.Bids.FirstOrDefault(b => b.ProductId == productId);
				db.Bids.DeleteOnSubmit(bid);
				db.SubmitChanges();

				// finally remove product
				var product = db.Products.FirstOrDefault(p => p.Id == productId);
				db.Products.DeleteOnSubmit(product);
				db.SubmitChanges();

				return true;
			}
			catch (Exception)
			{
				return false;
			}
		}

		public bool MakeActive(int productId)
		{
			try
			{
				var product = db.Products.FirstOrDefault(p => p.Id == productId);
				product.IsActive = "true";
				db.SubmitChanges();

				return true;
			}
			catch (Exception)
			{
				return false;
			}
		}

		public bool MakeInactive(int productId)
		{
			try
			{
				var product = db.Products.FirstOrDefault(p => p.Id == productId);
				product.IsActive = "false";
				db.SubmitChanges();

				return true;
			}
			catch (Exception)
			{
				return false;
			}
		}

		public bool EditProduct(ProductEdit product)
		{
			try
			{
				// retrieve existing product
				var existing = db.Products.FirstOrDefault(p => p.Id == product.Id);

				// assign new values to existing product
				existing.Name = product.Name;
				existing.Description = product.Description;
				existing.Price = product.Price;

				// save changes
				db.SubmitChanges();

				return true;
			}
			catch (Exception)
			{
				// could not edit
				return false;
			}
		}



		public bool AddAccessory(int productId, Accessory accessory)
		{
			try
			{
				var product = db.Products.FirstOrDefault(p => p.Id == productId);
				accessory.Product = product;
				db.Accessories.InsertOnSubmit(accessory);
				db.SubmitChanges();

				return true;
			}
			catch (Exception)
			{
				return false;
			}
		}

		public bool AddArt(int productId, Art art)
		{
			try
			{
				var product = db.Products.FirstOrDefault(p => p.Id == productId);
				art.Product = product;
				db.Arts.InsertOnSubmit(art);
				db.SubmitChanges();

				return true;
			}
			catch (Exception)
			{
				return false;
			}
		}

		public bool AddClothing(int productId, Clothing clothing)
		{
			try
			{
				var product = db.Products.FirstOrDefault(p => p.Id == productId);
				clothing.Product = product;
				db.Clothings.InsertOnSubmit(clothing);
				db.SubmitChanges();

				return true;
			}
			catch (Exception)
			{
				return false;
			}
		}

		// Cart actions

		public bool AddToCart(int? id, int productId)
		{
			try
			{
				var product = db.Products.FirstOrDefault(p => p.Id == productId);
				var bid = db.Bids.FirstOrDefault(b => b.ProductId == productId);

				// restart bid if there are no bids
				if (id == null)
				{
					// notify seller
					Notification notification = new Notification
					{
						UserId = product.SellerId,
						Message = $"Bid for {product.Name} did not meet reserve price. Bid will reopen again in 24hrs",
						Date = DateTime.Now
					};
					db.Notifications.InsertOnSubmit(notification);
					db.SubmitChanges();

					// re open bid
					BidNewDT bidNew = new BidNewDT
					{
						ProductId = product.Id,
						Amount = product.Price
					};
					AddBid(bidNew);
					db.Bids.DeleteOnSubmit(bid);
					db.SubmitChanges();
					return false;
				}
				else
				{
					var item = db.CartItems.FirstOrDefault(c => c.ProductId == product.Id);
					if (item != null)
					{
						return false;
					}

					var cart = db.Carts.FirstOrDefault(c => c.CustomerId == id);

					// check if bids meet reserve price
					if (bid.CurrentPrice < product.Price)
					{
						// notify seller
						Notification notification = new Notification
						{
							UserId = product.SellerId,
							Message = $"Bid for {product.Name} did not meet reserve price. Bid will reopen again in 24hrs",
							Date = DateTime.Now
						};
						db.Notifications.InsertOnSubmit(notification);

						if (bid.Customer != null)
						{
							// notify customer
							Notification notification1 = new Notification
							{
								UserId = bid.CustomerId,
								Message = $"Your winning bid amount for {product.Name} was too low. Bid will reopen again in 24hrs",
								Date = DateTime.Now
							};
							db.Notifications.InsertOnSubmit(notification1);
							db.SubmitChanges();
						}

						// re open bid
						BidNewDT bidNew = new BidNewDT
						{
							ProductId = product.Id,
							Amount = product.Price
						};
						AddBid(bidNew);
						db.Bids.DeleteOnSubmit(bid);
						db.SubmitChanges();

					}
					else
					{
						// notify seller
						Notification notification = new Notification
						{
							UserId = product.SellerId,
							Message = $"Bid for {product.Name} was successful with R{bid.CurrentPrice}",
							Date = DateTime.Now
						};
						db.Notifications.InsertOnSubmit(notification);

						// notify customer
						Notification notification1 = new Notification
						{
							UserId = bid.CustomerId,
							Message = $"You won a bid for {product.Name} with R{bid.CurrentPrice}",
							Date = DateTime.Now
						};
						db.Notifications.InsertOnSubmit(notification1);
						db.SubmitChanges();

						MakeInactive(productId);

						var cartItem = new CartItem
						{
							CartId = cart.Id,
							ProductId = productId,
							CreatedAt = DateTime.Now,
							Price = bid.CurrentPrice
						};
						cart.ModifiedAt = DateTime.Now;
						cart.Total += bid.CurrentPrice;
						db.CartItems.InsertOnSubmit(cartItem);
						db.SubmitChanges();

						db.Bids.DeleteOnSubmit(bid);
						db.SubmitChanges();
					}
					return true;
				}
			}
			catch (Exception)
			{
				return false;
			}
		}

		public bool RemoveCartItem(int id, int itemId)
		{
			try
			{
				var cart = db.Carts.FirstOrDefault(c => c.CustomerId == id);
				var cartItem = db.CartItems.FirstOrDefault(i => i.Id == itemId);
				var product = cartItem.Product;

				cart.Total -= cartItem.Price;
				db.CartItems.DeleteOnSubmit(cartItem);
				db.SubmitChanges();

				// notify customer
				Notification notification = new Notification
				{
					UserId = id,
					Message = $"{product.Name} has been forfeited",
					Date = DateTime.Now
				};
				db.Notifications.InsertOnSubmit(notification);
				db.SubmitChanges();

				// notify seller
				Notification notification1 = new Notification
				{
					UserId = product.SellerId,
					Message = $"Seller has failed to pay for {product.Name}. Bid will re-open in 24hrs",
					Date = DateTime.Now
				};
				db.Notifications.InsertOnSubmit(notification1);
				db.SubmitChanges();

				BidNewDT bid = new BidNewDT
				{
					ProductId = product.Id
				};
				AddBid(bid);

				return true;
			}
			catch (Exception)
			{
				return false;
			}
		}

		public CartDT GetCart(int customerId)
		{
			try
			{
				// retreive the cart and its items
				var cart = db.Carts.FirstOrDefault(c => c.CustomerId == customerId);

				// retrive the cart items in the customer's cart
				var cartItems = db.CartItems
					.Where(c => c.Cart == cart)
					.Select(c => new CartItemDT
					{
						Id = c.Id,
						ProductId = c.ProductId,
						Name = c.Product.Name,
						Price = (decimal)c.Price,
						Images = c.Product.Images
					}).ToList();

				// the cart to return with relevent info
				var retCart = new CartDT
				{
					Total = cart.Total,
					Items = cartItems,
					CreatedAt = cart.CreatedAt,
					ModifiedAt = cart.ModifiedAt
				};

				return retCart;
			}
			catch (Exception)
			{
				// cart not found
				return null;
			}
		}

		public bool ClearCart(int customerId)
		{
			try
			{
				var cart = db.Carts.FirstOrDefault(c => c.CustomerId == customerId);
				cart.Total = 0;
				cart.CreatedAt = null;
				dynamic cartItems = cart.CartItems.ToArray();
				db.CartItems.DeleteAllOnSubmit(cartItems);
				db.SubmitChanges();

				Notification notification = new Notification
				{
					UserId = customerId,
					Message = $"Your cart has been cleared",
					Date = DateTime.Now
				};
				db.Notifications.InsertOnSubmit(notification);
				db.SubmitChanges();

				return true;
			}
			catch (Exception)
			{
				return false;
			}
		}

		// Bid actions

		public BidDT AddBid(BidNewDT bid)
		{
			/*
			 * BidNewDT just has CustomerId, ProductId and Amount Properties 
			 */
			try
			{
				// retrieve the product and customer to be involved in bid
				var product = db.Products.FirstOrDefault(p => p.Id == bid.ProductId);
				var customer = db.Customers.FirstOrDefault(c => c.Id == bid.CustomerId);

				// notify seller
				Notification notification1 = new Notification
				{
					UserId = product.SellerId,
					Message = $"{product.Name} item awaiting bid opening",
					Date = DateTime.Now
				};
				db.Notifications.InsertOnSubmit(notification1);

				// create new bid to store in datatbase
				Bid newBid = new Bid
				{
					CurrentPrice = product.Price * (decimal)0.4,
					CreatedAt = DateTime.Now.AddDays(1),
					ExpiresAt = DateTime.Now.AddDays(3),
					Product = product,
					Expired = "No"
				};
				db.Bids.InsertOnSubmit(newBid);
				db.SubmitChanges();

				// simplified bid DT that has only amount and expiry
				// only things needed by front end regarding a bid
				BidDT bidToReturn = new BidDT
				{
					Amount = newBid.CurrentPrice,
					ExpiresAt = newBid.ExpiresAt
				};

				return bidToReturn;
			}
			catch (Exception)
			{
				// failed to create bid
				return null;
			}
		}

		public BidDT EditBid(BidEditDT bidEdit)
		{
			/*
			 * BidEditDT just has CustomerId, ProductId and Amount Properties (same as BidNewDT)
			 * this is to make it easy to follow when using the functions
			 */
			try
			{
				// retrieve the bid and new customer whos winning
				var customer = db.Customers.FirstOrDefault(c => c.Id == bidEdit.CustomerId);
				var bid = db.Bids.FirstOrDefault(b => b.ProductId == bidEdit.ProductId);
				var product = db.Products.FirstOrDefault(p => p.Id == bid.ProductId);

				if (bid.Customer != null)
				{
					// notify customer
					Notification notification1 = new Notification
					{
						UserId = bid.CustomerId,
						Message = $"You are losing {product.Name} to someone else with R{bidEdit.Amount}",
						Date = DateTime.Now
					};
					db.Notifications.InsertOnSubmit(notification1);
				}


				// update the amount and the customer in the database
				bid.CurrentPrice = bidEdit.Amount;
				bid.Customer = customer;
				db.SubmitChanges();

				// notify customer
				Notification notification2 = new Notification
				{
					UserId = bid.CustomerId,
					Message = $"Entered bid for {product.Name} with R{bid.CurrentPrice}",
					Date = DateTime.Now
				};
				db.Notifications.InsertOnSubmit(notification2);
				db.SubmitChanges();

				// return updated simplified bid
				BidDT toReturn = new BidDT
				{
					Amount = bid.CurrentPrice,
					ExpiresAt = bid.ExpiresAt,

				};

				return toReturn;
			}
			catch (Exception)
			{
				// could not edit bid
				return null;
			}
		}

		public BidDT GetBid(int productId)
		{
			// get the bid by the product
			var bid = db.Bids.FirstOrDefault(b => b.ProductId == productId);

			// this is if the product is indeed in a bid
			if (bid != null)
			{
				// create BidDT to return simplied did dt
				BidDT toReturn = new BidDT
				{
					Id = bid.Id,
					CustomerId = bid.CustomerId,
					Amount = bid.CurrentPrice,
					ExpiresAt = bid.ExpiresAt,
					Created = bid.CreatedAt,
					Expired = bid.Expired
				};
				return toReturn;
			}
			return null;
		}

		public bool CloseBid(int bidId)
		{
			try
			{
				var bid = db.Bids.FirstOrDefault(b => b.Id == bidId);
				bid.Expired = "true";
				db.SubmitChanges();
				return true;
			}
			catch (Exception ex)
			{
				return false;
			}
		}

		public bool IsExpired(int productId)
		{
			// get the bid
			var bid = db.Bids.FirstOrDefault(b => b.ProductId == productId);
			if (bid.ExpiresAt < DateTime.Now)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		public bool IsOpen(int productId)
		{
			// get the bid
			var bid = db.Bids.FirstOrDefault(b => b.ProductId == productId);
			if (bid.CreatedAt < DateTime.Now)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

		public bool isInBid(int productId)
		{
			var bid = db.Bids.FirstOrDefault(b => b.ProductId == productId);
			if (bid != null)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

		public List<BidDT> GetBids()
		{
			return db.Bids.OrderBy(b => b.ExpiresAt)
				.Select(bid => new BidDT
				{
					Id = bid.Id,
					Amount = bid.CurrentPrice,
					ExpiresAt = bid.ExpiresAt,
					ProductId = bid.ProductId,
					CustomerId = bid.CustomerId,
					Created = bid.CreatedAt,
					Expired = bid.Expired
				}).ToList();
		}

		// Invoice actions

		public InvoiceDT MakeInvoice(int customerId)
		{
			try
			{
				// make invoice items and clear cart
				var cart = db.Carts.FirstOrDefault(c => c.CustomerId == customerId);

				// calc vat and total
				decimal vat = (decimal)cart.Total * (decimal)0.15;
				decimal grandTotal = (decimal)cart.Total + vat;

				// make an invoice for the customer
				Invoice invoice = new Invoice
				{
					CustomerId = customerId,
					Status = "Paid",
					CreatedAt = DateTime.Now,
					PaidAt = DateTime.Now,
					Shipping = 0,
					Total = cart.Total,
					VAT = vat,
					GrandTotal = grandTotal
				};
				db.Invoices.InsertOnSubmit(invoice);
				db.SubmitChanges();

				// simple invoice to return
				InvoiceDT retInvoice = new InvoiceDT
				{
					Id = invoice.Id,
					Total = (decimal)invoice.Total,
					GrandTotal = (decimal)invoice.GrandTotal,
					VAT = (decimal)invoice.VAT,
					Shipping = (decimal)invoice.Shipping,
					Items = new List<InvoiceItemDT>()
				};

				// for each item in the cart
				foreach (var item in cart.CartItems)
				{
					// create invoice item and assign to existing invoice and product
					InvoiceItem invoiceItem = new InvoiceItem
					{
						InvoiceId = invoice.Id,
						ProductId = item.ProductId,
						Price = item.Price
					};
					db.InvoiceItems.InsertOnSubmit(invoiceItem);
					db.SubmitChanges();

					// change product to sold
					var product = db.Products.FirstOrDefault(p => p.Id == item.ProductId);
					product.Price = (decimal)item.Price;
					product.SoldAt = DateTime.Now;
					db.SubmitChanges();

					// change seller and make split sheet
					var seller = db.Sellers.FirstOrDefault(s => s.Id == product.SellerId);
					seller.NoSale = seller.NoSale + 1;
					db.SubmitChanges();

					// update customer
					var customer = db.Customers.FirstOrDefault(c => c.Id == customerId);
					customer.NoPurchases = customer.NoPurchases + 1;
					db.SubmitChanges();


					// split the profit
					SaleManagement sale = new SaleManagement
					{
						SellerId = seller.Id,
						ProductId = item.ProductId,
						PurchaseAmount = item.Price,
						SellerShare = item.Price * (decimal)0.8,
						BusinessShare = item.Price * (decimal)0.2,
						IsProfitSplit = 1
					};
					db.SaleManagements.InsertOnSubmit(sale);
					db.SubmitChanges();

					// pay company
					var revenue = db.BusinessRevenues.FirstOrDefault(r => r.Id == 111);
					revenue.Sales = revenue.Sales + sale.BusinessShare;
					db.SubmitChanges();

					// pay seller
					credit((decimal)sale.SellerShare, seller.Id);

					// Invoice item to return
					InvoiceItemDT retItem = new InvoiceItemDT
					{
						ProductName = product.Name,
						Price = item.Price
					};
					// add to invoice
					retInvoice.Items.Add(retItem);
				}
				ClearCart(customerId);

				// deduct from customer 
				debit((decimal)invoice.GrandTotal, customerId);

				return retInvoice;
			}
			catch (Exception ex)
			{
				return null;
			}
		}

		public List<InvoiceDT> GetInvoices(int customerId)
		{
			// get invoice items using invoice
			var invoices = db.Invoices
								.Where(i => i.CustomerId == customerId)
								.Select(invoice => new InvoiceDT
								{
									Id = invoice.Id,
									Date = (DateTime)invoice.PaidAt,
									Total = (decimal)invoice.Total,
									GrandTotal = (decimal)invoice.GrandTotal,
									VAT = (decimal)invoice.VAT,
									Shipping = (decimal)invoice.Shipping,
									Items = new List<InvoiceItemDT>()
								})
								.ToList();
			// simple invoice to return
			return invoices;
		}

		public InvoiceDT GetInvoice(int invoiceId)
		{
			Invoice invoice = db.Invoices.FirstOrDefault(i => i.Id == invoiceId);
			// simple invoice to return
			InvoiceDT retInvoice = new InvoiceDT
			{
				Id = invoice.Id,
				Date = (DateTime)invoice.PaidAt,
				Total = (decimal)invoice.Total,
				GrandTotal = (decimal)invoice.GrandTotal,
				VAT = (decimal)invoice.VAT,
				Shipping = (decimal)invoice.Shipping,
				Items = new List<InvoiceItemDT>()
			};
			foreach (var item in invoice.InvoiceItems)
			{
				var product = db.Products.FirstOrDefault(p => p.Id == item.ProductId);
				// Invoice item to return
				InvoiceItemDT retItem = new InvoiceItemDT
				{
					ProductName = product.Name,
					Price = item.Price
				};
				// add to invoice
				retInvoice.Items.Add(retItem);
			}
			return retInvoice;
		}

		public void setAddress(int customerId, string streetAddress, string city, string province)
		{
			var user = db.Users.FirstOrDefault(u => u.Id == customerId);
			user.StreetAddress = streetAddress;
			user.City = city;
			user.Province = province;
			db.SubmitChanges();
		}

		//GRAPHING LOGIC IS BELOW WHERE

		public Dictionary<string, decimal> GetRevenue()
		{
			try
			{
				decimal sales = (decimal)db.BusinessRevenues.FirstOrDefault(r => r.Id == 111).Sales;
				decimal registrations = (decimal)db.BusinessRevenues.FirstOrDefault(r => r.Id == 111).Registrations;

				var result = new Dictionary<string, decimal>
				{
					{ "Sales", sales },
					{ "Registrations", registrations }
				};

				return result;
			}
			catch (Exception ex)
			{
				// LOG ERROR MESSSAGE, SOMETHING IS WRONG
				Trace.WriteLine(ex.Message);
				return null;
			}
		}
		public Dictionary<string, int> GetActiveInactiveProductCounts()
		{
			try
			{
				int activeCount = db.Products.Count(p => p.IsActive == "true");
				int inactiveCount = db.Products.Count(p => p.IsActive == "false");

				var result = new Dictionary<string, int>
			{
				{ "Active", activeCount },
				{ "Inactive", inactiveCount }
			};

				return result;
			}
			catch (Exception ex)
			{
				// LOG ERROR MESSSAGE, SOMETHING IS WRONG
				Trace.WriteLine(ex.Message);
				return null;
			}

		}

		public Dictionary<string, int> GetUserRegistrationsByMonth()
		{
			try
			{

				var userRegistrations = db.Users
					.GroupBy(u => u.CreatedAt.Month)
					.Select(g => new
					{
						Month = g.Key,
						Count = g.Count()
					}).ToList();


				var result = new Dictionary<string, int>();

				foreach (var reg in userRegistrations)
				{

					string monthName = new DateTime(1, reg.Month, 1).ToString("MMMM");
					result.Add(monthName, reg.Count);
				}

				return result;
			}
			catch (Exception ex)
			{
				//SHOW ME WHAT'S WRONG
				Trace.WriteLine(ex.Message);
				return null;
			}
		}


		public Dictionary<string, int> GetUserLocationsByProvince()
		{
			try
			{
				// Group users by their province and count the number of users per province
				var userProvinces = db.Users
					.Where(u => u.Province != null)
					.GroupBy(u => u.Province)
					.Select(g => new
					{
						Province = g.Key,  // This should already be the province name
						Count = g.Count()
					}).ToList();

				// Create a dictionary to store province names and their respective counts
				var result = new Dictionary<string, int>();

				foreach (var province in userProvinces)
				{

					result.Add(province.Province, province.Count);
				}

				return result;
			}
			catch (Exception ex)
			{
				// Log the error message for debugging
				Trace.WriteLine(ex.Message);
				return null;
			}
		}

		//PLOT THE ART GRAPH HERE
		public Dictionary<string, int> GetArtSoldUnsoldCounts()
		{
			try
			{

				int soldCount = db.Products.Count(p => p.Category.Contains("Art") && p.SoldAt != null);
				int unsoldCount = db.Products.Count(p => p.Category.Contains("Art") && p.SoldAt == null);

				var result = new Dictionary<string, int>
		{
			{ "Sold", soldCount },
			{ "Not Sold", unsoldCount }
		};

				return result;
			}
			catch (Exception ex)
			{
				Trace.WriteLine(ex.Message);
				return null;
			}
		}

		//PLOT THE ACCESSORIES GRAPH HERE
		public Dictionary<string, int> GetAccessoriesSoldUnsoldCounts()
		{
			try
			{

				int soldCount = db.Products.Count(p => p.Category.Contains("Accessory") && p.SoldAt != null) + 1;
				int unsoldCount = db.Products.Count(p => p.Category.Contains("Accessory") && p.SoldAt == null);

				var result = new Dictionary<string, int>
		{
			{ "Sold", soldCount },
			{ "Not Sold", unsoldCount }
		};

				return result;
			}
			catch (Exception ex)
			{
				Trace.WriteLine(ex.Message);
				return null;
			}
		}

		//PLOT THE CLOTHING GRAPH HERE
		public Dictionary<string, int> GetClothingSoldUnsoldCounts()
		{
			try
			{

				int soldCount = db.Products.Count(p => p.Category.Contains("Clothing") && p.SoldAt != null) + 1;
				int unsoldCount = db.Products.Count(p => p.Category.Contains("Clothing") && p.SoldAt == null);

				var result = new Dictionary<string, int>
		{
			{ "Sold", soldCount },
			{ "Not Sold", unsoldCount }
		};

				return result;
			}
			catch (Exception ex)
			{
				Trace.WriteLine(ex.Message);
				return null;
			}
		}
	}
}
