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
	public partial class ActiveBids : System.Web.UI.Page
	{
		static Service1Client client;

		protected BidDT[] allBids;
		static BidDT[] bids;
		protected void Page_Load(object sender, EventArgs e)
		{
			if (true)
			{
				if (Session["Id"] == null)
				{
					Response.Redirect("Home.aspx");
				}

				// customer id
				int customerId = int.Parse(Session["Id"].ToString());

				// This will display the images of the works by artisans
				client = new Service1Client();
				 
				// get bids
				bids = client.GetBids();
				allBids = client.GetBids();

				string display = "";
				if (Request.QueryString["q"] != null)
				{
					bids = client.Search(Request.QueryString["q"].ToString().ToLower());
				}

				foreach (var bid in bids)
				{
					// get images
					var product = client.GetProduct((int)bid.ProductId);
					string[] prodImgs = product.Images.Split(',');
					var img = prodImgs[0];

					// if the customer is leading the bid
					if (client.IsOpen(product.Id) && bid.CustomerId == customerId)
					{
						// showing items with bid and user has bid
						display += $@"
                            <div class='col-lg-4 col-md-6'>
                                <div class='single-cart-item active'>
                                    <div class='single-cart-image'>
                                        <a href='Product.aspx?Id={product.Id}'><img class='image-item-01 item-active' src='{img}' alt=''></a>
                                    </div>
                                    <div class='single-cart-content'>
                                        <div class='cart-content-left'>
                                            <a href='Product.aspx?Id={product.Id}'><h5>{product.Name}</h5></a>
                                            <span>Closes in</span>
                                        </div>
                                        <div class='cart-content-right'>
                                            <span class='current-price'>R {bid.Amount}</span>
                                            <div id='countdown-{product.Id}' class='font-weight-bold mt-3' style='color: red;'></div>
                                            <input type='hidden' id='expiry-{product.Id}' value='{bid.ExpiresAt?.ToString("yyyy-MM-ddTHH:mm:ss")}' />
                                        </div>
                                    </div>
                                    <div class='single-cart-button'>
                                        <a href='PlaceBid.aspx?Id={product.Id}' onserverclick='PlaceBid' class='cart-button'>place bid</a>
                                        <a href='Product.aspx?Id={product.Id}' class='compare-button'>see more</a>
                                    </div>
                                </div>
                            </div>";
					}
					//else
					//{
					//	display += $@"
     //                       <div class='col-lg-4 col-md-6'>
     //                           <div class='single-cart-item active'>
     //                               <div class='single-cart-image'>
     //                                   <a href='Product.aspx?Id={product.Id}'><img class='image-item-01 item-active' src='{img}' alt=''></a>
     //                               </div>
     //                               <div class='single-cart-content'>
     //                                   <div class='cart-content-left'>
     //                                       <a href='Product.aspx?Id={product.Id}'><h5>{product.Name}</h5></a>
     //                                       <span>Opens in</span>
     //                                   </div>
     //                                   <div class='cart-content-right'>
     //                                       <span class='current-price'>R {bid.Amount}</span>
     //                                       <div id='countdown-{product.Id}' class='font-weight-bold mt-3' style='color: blue;'></div>
     //                                       <input type='hidden' id='opens-{product.Id}' value='{bid.Created?.ToString("yyyy-MM-ddTHH:mm:ss")}' />
     //                                   </div>
     //                               </div>
     //                               <div class='single-cart-button'>
     //                                   <a href='PlaceBid.aspx?Id={product.Id}' onserverclick='PlaceBid' class='cart-button'>place bid</a>
     //                                   <a href='Product.aspx?Id={product.Id}' class='compare-button'>see more</a>
     //                               </div>
     //                           </div>
     //                       </div>";
					//}

				}
				productItem.InnerHtml = display;


				// if user attempted to place bid and not logged in
				if (Request.QueryString["from"] != null && !IsPostBack)
				{
					HtmlGenericControl popUp = (HtmlGenericControl)this.Master.FindControl("loginPopup");
					if (popUp != null)
					{
						popUp.Attributes["class"] = popUp.Attributes["class"] + " active";
					}
				}
			}
		}
	}
}