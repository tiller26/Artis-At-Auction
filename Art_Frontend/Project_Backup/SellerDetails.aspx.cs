using Project_Backup.ServiceReference;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_Backup
{
	public partial class Seller : System.Web.UI.Page
	{
		static Service1Client client;
		protected void Page_Load(object sender, EventArgs e)
		{
			// This will display the images of the works by artisans
			client = new Service1Client();
            if (Request.QueryString["id"] == null)
			{
                Response.Redirect("Home.aspx");
			}

			// Seller Functionality.

			// Get the Id for the Seller
			string id = Request.QueryString["id"];
			int idToCheck = int.Parse(id);

			// Displaying the Seller at the side bar.
			if (client.GetSeller(idToCheck) != null)
			{
				var sellerA = client.GetSeller(int.Parse(id));
				string aSeller = AddSeller(sellerA);
				sellerSide.InnerHtml = aSeller;
				// Set the header Name for the catalogue
				string displayName = "";
				displayName += $@"
                    <div class='section-title text-center'>
                        <h2> about {sellerA.Name} </h2>
                    </div>
                    <div class='mb-5'>
                        <div class='categories'>
                            <table class='table' style='border: 2px solid black; border-collapse: collapse;'>
                                <tr>
                                    <td style='border: 2px solid black;width:150px'>Business Name</td>
                                    <td style='border: 2px solid black;'>{sellerA.BusinessName}</td>
                                </tr>
                                <tr>
                                    <td style='border: 2px solid black;'>Sales</td>
                                    <td style='border: 2px solid black;'>{sellerA.NoSale}</td>
                                </tr>
                                <tr>
                                    <td style='border: 2px solid black;'>City</td>
                                    <td style='border: 2px solid black;'>{sellerA.City}</td>
                                </tr>
                                <tr>
                                    <td style='border: 2px solid black;'>Email</td>
                                    <td style='border: 2px solid black;'>{sellerA.Email}</td>
                                </tr>
                                <tr>
                                    <td style='border: 2px solid black;'>Description</td>
                                    <td style='border: 2px solid black;'>{sellerA.Description}</td>
                                </tr>
                            </table>
                        </div>
                    </div>

                    <div class='section-title text-center mb-5'>
                        <h2> {sellerA.BusinessName} Catalogue </h2>
                    </div>
                    ";
				nameSeller.InnerHtml = displayName;
			}

			// The Products Functionality.

			var products = client.GetProducts();
			var customerId = 0;
			var role = "";

			if (Session["Id"] != null)
			{
				customerId = Convert.ToInt32(Session["Id"].ToString());
				role = Session["Role"].ToString();
			}
			//totalItems.InnerText = $"{products.Length} Items";
            if (idToCheck == customerId)
			{
                addItem.Visible = true;
                //sellerSide.Visible = false;
                //nameSeller.Visible = false;
            }

			string display = "";

			for (int i = 0; i < products.Length; i++)
			{
				// get images
				var product = products[i];
				string[] prodImgs = product.Images.Split(',');
				var img = prodImgs[0];

                if (role.Contains("Admin"))
				{
                    nameSeller.InnerHtml = @"<div class='section-title text-center'>
                        <h2> Admin Products Page </h2>
                    </div>";
                    addItem.Visible = false;
                    display += $@"
                            <section class='col-lg-4 col-md-6'>
                              <div class='single-cart-item active'>
                                <div class='single-cart-image'>
                                    <a href='Product.aspx?Id={product.Id}'><img class='image-item-01 item-active' src='{img}' alt=''>
                                </div>
                                <div class='single-cart-content'>
                                    <div class='cart-content-left'>
                                        <h5>{product.Name}</h5>
                                    </div>
                                </div>
                                <div class='single-cart-button'>
                                    <a href='DeleteProduct.aspx?Id={product.Id}' class='compare-button'>Delete Item</a>
                                </div>
                            </div>
                        </section>
                        ";
                    continue;
                }

				if (product.SellerId != int.Parse(id))
				{
                    continue;
				}

				// display appropriate buttons; if seller is logged in they can edit their products
				if (idToCheck == customerId)
				{
                    
                    display += $@"
                            <section class='col-lg-4 col-md-6'>
                              <div class='single-cart-item active'>
                                <div class='single-cart-image'>
                                    <a href='Product.aspx?Id={product.Id}'><img class='image-item-01 item-active' src='{img}' alt=''>
                                </div>
                                <div class='single-cart-content'>
                                    <div class='cart-content-left'>
                                        <h5>{product.Name}</h5>
                                    </div>
                                </div>
                                <div class='single-cart-button'>
                                    <a href='EditProduct.aspx?Id={product.Id}' class='cart-button'>Edit Item</a>
                                    <a href='DeleteProduct.aspx?Id={product.Id}' class='compare-button'>Delete Item</a>
                                </div>
                            </div>
                        </section>
                        ";
				}
				else
				{
                    if (!client.isInBid(product.Id))
					{
                        display += $@"
                        <div class='col-lg-4 col-md-6'>
                            <div class='single-cart-item active'>
                                <div class='single-cart-image'>
                                    <a href='Product.aspx?Id={product.Id}'><img class='image-item-01 item-active' src='{img}' alt=''></a>
                                </div>
                                <div class='single-cart-content'>
                                    <div class='cart-content-left'>
                                        <a href='Product.aspx?Id={product.Id}'><h5>{product.Name}</h5></a>
                                    </div>
                                    <div class='cart-content-right'>
                                        <span class='current-price'>R {product.Price}</span>
                                        <div class='font-weight-bold mt-3' style='color: green;'>SOLD</div>
                                    </div>
                                </div>
                                <div class='single-cart-button'>
                                    <a href='Product.aspx?Id={product.Id}' class='compare-button'>see more</a>
                                </div>
                            </div>
                        </div>";
					}
                    else
					{
                        // get the bid and show the countdown
                        var bid = client.GetBid(product.Id);

                        // if the customer is leading the bid
                        if (client.IsOpen(product.Id))
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
                        else
                        {
                            // showing new items with bid to win
                            display += $@"
                            <div class='col-lg-4 col-md-6'>
                                <div class='single-cart-item active'>
                                    <div class='single-cart-image'>
                                        <a href='Product.aspx?Id={product.Id}'><img class='image-item-01 item-active' src='{img}' alt=''></a>
                                    </div>
                                    <div class='single-cart-content'>
                                        <div class='cart-content-left'>
                                            <a href='Product.aspx?Id={product.Id}'><h5>{product.Name}</h5></a>
                                            <span>Opens in</span>
                                        </div>
                                        <div class='cart-content-right'>
                                            <span class='current-price'>R {bid.Amount}</span>
                                            <div id='countdown-{product.Id}' class='font-weight-bold mt-3' style='color: blue;'></div>
                                            <input type='hidden' id='opens-{product.Id}' value='{bid.Created?.ToString("yyyy-MM-ddTHH:mm:ss")}' />
                                        </div>
                                    </div>
                                    <div class='single-cart-button'>
                                        <a href='AlmostThere.aspx?Id={product.Id}' onserverclick='PlaceBid' class='cart-button'>place bid</a>
                                        <a href='Product.aspx?Id={product.Id}' class='compare-button'>see more</a>
                                    </div>
                                </div>
                            </div>";
                        }
                    }
                }
			}
			productItem.InnerHtml = display;
		}

		private String AddSeller(SellerDT seller)
		{
			string display = "";

			display += $@"
            <section>
                <div class='single-item text-center mt-5 pt-3'>
                    <div class='item-image'>
                        <img class='mt-5' height='320' src='{seller.Image}' alt=''>
                    </div>
               </div> 
             </section>";
			return display;
		}
	}
}

