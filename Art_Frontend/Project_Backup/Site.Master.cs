using HashPass;
using Project_Backup.ServiceReference;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Project_Backup
{
	public partial class Site : System.Web.UI.MasterPage
	{
		static Service1Client client;
		protected void Page_Load(object sender, EventArgs e)
		{
			// toggle navigation view
			cartIcon.Visible = false;
			profileLogged.Visible = false;
			if(Session["Id"] != null)
			{
				cartIcon.Visible = true;
				profileLogged.Visible = true;
				profileGuest.Visible = false;

				// this is where we display the cart items
				var customerId = Convert.ToInt32(Session["Id"].ToString()); // customer id stored 
				var cart = client.GetCart(customerId); // cart with items and total
				var cartItems = cart.Items; // list of cart items
				var total = cart.Total; // cart total
				var totalItems = cart.Items.Length; // total cart items

				string htmlString = "";

				// loop over all the items in cart
				foreach (var item in cartItems)
				{
					var img = item.Images;
					htmlString += $@"
					<div class='single-item-function-1'>
						<div class='single-item d-flex justify-content-between mb-4'>
							<div class='item-left d-flex'>
								<a href='Product.aspx?id={item.ProductId}'><div class='item-image' style='background-image: url(""{img}"")'></div></a>
								<div class='item-name align-self-center'>
									<a href='Product.aspx?id={item.ProductId}'><h6 runat='server' id='productName'>{item.Name}</h6></a>
								</div>
							</div>
							<div class='item-right d-flex align-items-center'>
								<div class='item-price'>
									<h6 runat='server' id='productPrice'>R {item.Price}</h6>
								</div>
							</div>
						</div>
					</div>";
				}
				cartContents.InnerHtml = htmlString;
				itemsCount.InnerText = $"{totalItems} items";
				cartTotal.InnerText = $"R {total}";
				cartCount.InnerText = $"{totalItems}";
				vat.InnerText = $"R {((double)total * 0.15).ToString("f2")}";
			}

			// This will display the images of the works by artisans
			client = new Service1Client();
			var sellers = client.GetSellers();
			var products = client.GetProducts();

			string content = "";
			foreach (var product in products)
			{
				var bid = client.GetBid(product.Id);
				// loop through the products to see closed bids
				if (client.isInBid(product.Id))
				{
					// if bid is expired; 
					// deactivate the product and add it to cart of highest bidder
					if (client.IsExpired(product.Id))
					{
						client.CloseBid(bid.Id);
						client.AddToCart(bid.CustomerId, product.Id);
						continue;
					}
				}

				string[] prodImgs = product.Images.Split(',');
				var img = prodImgs[0];
				if (img == "")
				{
					continue;
				}
				content += $"<div class='single-slide'><img height='100%' src='{img}'/></div>\r\n";
			}
			sllrs.InnerHtml = content;

		}
		protected void btnLogin_OnClick(object sender, EventArgs e)
		{
			string username = loginUsername.Value;
			string password = Secrecy.HashPassword(loginPassword.Value);
			string response = client.Login(username, password);
			
			if(response != null)
			{
				var userId = Convert.ToInt32(response.Split(':')[0]);
				var userRole = response.Split(':')[1];

				Session["Id"] = userId;
				Session["Role"] = userRole;

				// removes all queries; from was added when user made action that needed them to be logged
				// so the login pop up was displayed. this ensures it gets hidden upon login
				string urlWithoutQuery = Request.Url.ToString();
				if (Request.QueryString["from"] != null)
				{
					urlWithoutQuery = Request.Url.GetLeftPart(UriPartial.Path);
				}
				Response.Redirect(urlWithoutQuery);
			}
			else
			{
				string script = "alert('Incorrect username or password');";
				ScriptManager.RegisterStartupScript(this, this.GetType(), "", script, true);
				//Response.Redirect("Home.aspx");
			}
		}

		protected void btnRegister_OnClick(object sender, EventArgs e)
		{
			string username = uName.Value;
			string password = Secrecy.HashPassword(uPassowrd.Value);
			string email = uEmail.Value;
			string contact = uContact.Value;

			User user = new User
			{
				Name = username,
				Password = password,
				Email = email,
				ContactNumber = contact
			};

			string response = client.RegisterCustomer(user);
			if (response.StartsWith("0"))
			{
				string[] loginDetails = client.Login(email, password).Split(':');
				var userId = Convert.ToInt32(loginDetails[0]);
				var userRole = loginDetails[1];

				Session["Id"] = userId;
				Session["Role"] = userRole;
				Response.Redirect(Request.Url.ToString());
			}
			else if(response.StartsWith("-1"))
			{
				string script = "alert('Account already exists');";
				ScriptManager.RegisterStartupScript(this, this.GetType(), "", script, true);
			}
			else
			{
				string script = "alert('Problem occured. Try again later');";
				ScriptManager.RegisterStartupScript(this, this.GetType(), "", script, true);
			}
		}
		protected void SellOnSite(object sender, EventArgs e)
		{
			if (Session["Id"] == null)
			{
				string script = "alert('You need to be logged in')";
				ScriptManager.RegisterStartupScript(this, GetType(), "", script, true);
			}
			else
			{
				Response.Redirect("SellerRegistration.aspx");
			}
		}
	}
} 
