using Project_Backup.ServiceReference;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_Backup
{
	public partial class Product : System.Web.UI.Page
	{
		static Service1Client client;
		protected void Page_Load(object sender, EventArgs e)
		{
			// get product from client
			client = new Service1Client();
			var prodId = Convert.ToInt32(Request.QueryString["Id"].ToString());
			var customerId = 0;
			if(Session["Id"] != null)
			{
				customerId = Convert.ToInt32(Session["Id"].ToString());
			}
			var product = client.GetProduct(prodId);
			var bid = client.GetBid(prodId);

			// fill in the text dynamically
			name.InnerText = product.Name;
			var sellerId = product.SellerId;
			var seller = client.GetSeller(sellerId);
			sellerName.InnerText = $"By {seller.Name} {seller.Surname}";
			if (bid == null)
			{
				price.InnerText = $"R {product.Price}";
			}
			else
			{
				price.InnerText = $"R {bid.Amount}";
			}
			sellerLink.HRef = $"SellerDetails.aspx?id={sellerId}";

			// show the images
			string[] prodImgs = product.Images.Split(',');
			string display = "";
			foreach(var img in prodImgs)
			{
				if(img == "") { break; }
				display += $@"
				<div class='image mr-4' style='background-image: url(""{img}"")'>
					<div class='hover-state'>
						<a href='{img}'><i class='fa fa-search'></i></a>
					</div>
				</div>";
			}
			images.InnerHtml = display;

			// show banner image for product
			string html = $@"<div class='cart-page-banner-bg' style='background-image: url(""{prodImgs[0]}"")'></div>";
			bannerImg.InnerHtml = html;
			description.InnerHtml = $@"<h6> Description </h6>
										<p class='mt-4'>
											{product.Description}
										</p>";
			showAdditional(product);

			// hide place bid icon if admin is logged in
			if (Session["Role"] != null)
			{
				if (bid != null && bid.CustomerId == customerId)
				{
					button.InnerHtml = $"<a href='AlmostThere.aspx?Id={prodId}' class='template-btn2 on2'>View Bid <span>&rharu;</span></a>";
				}
				else if (sellerId != customerId)
				{
					button.InnerHtml = $"<a href='PlaceBid.aspx?Id={prodId}' class='template-btn2 on2'>Place Bid <span>&rharu;</span></a>";
				}
				if (bid == null)
				{
					button.InnerHtml = "<h4>This Item is already sold</h4>";
				}
			}
			else
			{
				if (bid == null)
				{
					button.InnerHtml = "<h4>This Item is already sold</h4>";
				}
				else
				{
					button.InnerHtml = "<h4>Login to make offer</h4>";
				}
			}
		}

		private void showAdditional(ProductDT product)
		{
			int numDetails = product.ExtraAttributes.Length;
			string content = @"<h6 class='mt-3'> Additional Information: </h6>
							   <ul>";
			foreach (var detail in product.ExtraAttributes)
			{
				content += $"<li class='ml-3' style='list-style-type: square;'>{detail}</li>";
			}
			content += @"</ul>";
			description.InnerHtml += content;
		}
	}
}