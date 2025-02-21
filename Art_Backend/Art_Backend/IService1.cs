using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using System.Threading.Tasks;

namespace Art_Backend
{
	// NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IService1" in both code and config file together.
	[ServiceContract]
	public interface IService1
	{
		// Login action

		[OperationContract]
		string Login(string username, string password); // Returns success:{customerId}
		[OperationContract]
		string GetUserRole(int id); // Returns user role by id
		[OperationContract]
		User GetUser(int id);

		// Customer actions

		[OperationContract]
		bool credit(decimal funds, int id);
		[OperationContract]
		bool debit(decimal funds, int id);

		[OperationContract]
		string RegisterCustomer(User user);
		[OperationContract]
		bool RemoveCustomer(int customerId);
		[OperationContract]
		bool EditCustomer(CustomerDT newCustomer);
		[OperationContract]
		CustomerDT GetCustomer(int customerId);
		[OperationContract]
		List<CustomerDT> GetCustomers();
		[OperationContract]
		List<Notification> GetNotifications(int userId);

		// Seller actions

		[OperationContract]
		bool RegisterSeller(int id, string description, string business, string image);
		[OperationContract]
		bool RemoveSeller(int sellerId);
		[OperationContract]
		bool EditSeller(SellerDT newSeller);
		[OperationContract]
		SellerDT GetSeller(int sellerId);
		[OperationContract]
		List<SellerDT> GetSellers();
		

		// Product Actions

		[OperationContract]
		int AddProduct(ProductReg product);
		[OperationContract]
		bool RemoveProduct(int productId);
		[OperationContract]
		bool EditProduct(ProductEdit product);
		[OperationContract]
		ProductDT GetProduct(int productId);
		[OperationContract]
		List<ProductDT> GetProducts();
		[OperationContract]
		bool MakeActive(int productId);
		[OperationContract]
		bool MakeInactive(int productId);

		// Extra product actions***

		[OperationContract]
		bool AddAccessory(int productId, Accessory accessory);
		[OperationContract]
		bool AddArt(int productId, Art art);
		[OperationContract]
		bool AddClothing(int productId, Clothing clothing);


		// Cart actions
		/*
		 * 1. On creation of a user, a cart is created and every user has 1 cart
		 * If we have the customer id we have the cart
		 * 2. Addding a product to a cart creates a cart item that points to a cart
		 * 3. To remove an item from a cart, the cart item is simply deleted
		 * 4. How to see items in the cart that was returned? Using the list of cart items pointing to that cart
		 *		client
		 *		e.g foreach(var cartItem in cart.CartItems)
		 *			{ 
		 *				prodId = cartItem.productId;
		 *				var product = db.CartItems.FirstOrDefault(p => p.Id == prodId);
		 *				// Display product info
		 *			}
		 * 5. The total of the cart is automatically updated upon addition/removal of product
		 */
		[OperationContract]
		bool AddToCart(int? customerId, int productId);
		[OperationContract]
		bool RemoveCartItem(int customerId, int itemId);
		[OperationContract]
		CartDT GetCart(int customerId);
		[OperationContract]
		bool ClearCart(int customerId);
		[OperationContract]
		bool isInBid(int productId);

		// Bid actions
		/*
		 * 1. To check if an item is currently in any bid:
		 *		var product = client.GetProduct(id);
		 *		//Once we have product, check bids 
		 *		if(product.Bids.Length > 0)
		 *		{
		 *			var bid = product.Bids[0]; // Now there is access to a bid
		 *		}
		 *		else 
		 *		{ 
		 *			// Make a new bid using the customer id product id and price set ny customer
		 *			// then call AddBid(Bid bid)
		 *		}
		 *	2. To edit the bid, the customerId and the amount they place on the bid is used
		 *	3. To show the countdown there are javascript methods available. To expiry is included in Bid
		 */
		[OperationContract]
		BidDT AddBid(BidNewDT bid);
		[OperationContract]
		BidDT EditBid(BidEditDT bidEdit);
		[OperationContract]
		BidDT GetBid(int productId);

		//******* New Item *******
		[OperationContract]
		bool CloseBid(int bidId);
		[OperationContract]
		bool IsOpen(int productId);
		[OperationContract]
		bool IsExpired(int productId);
		[OperationContract]
		List<BidDT> GetBids();

		// Invoice actions & Order Summary
		/*
		 * This invloves the final steps before the customer place an order
		 * 1. Set the address of customer when placing order not on registration
		 * 2. Invoice which includes VAT, Discount and shipping cost and different totals(with/without vat) is created
		 * 3. Client gets Invoice with all the details and displays it
		 */
		// NEW: Set address of the customer for checkout & delivery
		[OperationContract]
		void setAddress(int customerId, string streetAddress, string city, string province);
		[OperationContract]
		InvoiceDT MakeInvoice(int customerId); // Using items in cart & address
		[OperationContract]
		List<InvoiceDT> GetInvoices(int customerId);   
		[OperationContract]
		InvoiceDT GetInvoice(int invoiceId);

		// Add functionality for filter.
		[OperationContract]
		List<ProductDT> GetClothing();

		[OperationContract]
		List<ProductDT> GetAccessories();

		[OperationContract]
		List<ProductDT> GetArts();

		[OperationContract]
		List<BidDT> GetBasedPrice(string type, decimal min, decimal max);
		[OperationContract]
		List<BidDT> Search(string query);

		//Analytics 
		//[OperationContract]  
		//  List<Accessory> graphAccessories(int productId);

		[OperationContract]
		Dictionary<string, decimal> GetRevenue();
		[OperationContract]
		Dictionary<string, int> GetActiveInactiveProductCounts();

		[OperationContract]
		Dictionary<string, int> GetUserRegistrationsByMonth();

		[OperationContract]
		Dictionary<string, int> GetUserLocationsByProvince();

		[OperationContract]
		Dictionary<string, int> GetArtSoldUnsoldCounts();

		[OperationContract]
		Dictionary<string, int> GetAccessoriesSoldUnsoldCounts();

		[OperationContract]
		Dictionary<string, int> GetClothingSoldUnsoldCounts();
	}
}
