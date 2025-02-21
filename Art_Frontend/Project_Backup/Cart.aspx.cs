using Project_Backup.ServiceReference;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_Backup
{
	public partial class Cart : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["Id"] == null)
			{
				Response.Redirect("Home.aspx");
			}

            // retrieve id
			int userId = int.Parse(Session["Id"].ToString());
			Service1Client client = new Service1Client();

            // get cart and cart items
            var cart = client.GetCart(userId);
            if (cart.Total == 0)
			{
                proceed.Visible = false;
			}
			string displayItems = "";
			foreach (var item in cart.Items)
			{
                var product = client.GetProduct((int)item.ProductId);
                var img = product.Images.Split(',')[0];

                displayItems += $@"
                <div class='single-cart d-flex justify-content-between mb-5'>
                    <div class='cart-left d-flex'>
                        <a href='Product.aspx?id={item.ProductId}'>
                            <div style='background-image:url(""{img}"");' class='cart-image image1'></div>
                        </a>
                        <div class='cart-text'>
                            <a href='Product.aspx?id={item.ProductId}'>
                                <h4 style='margin-top:50px'>{product.Name}</h4>
                            </a>
                        </div>
                    </div>
                    <div class='cart-right d-flex align-self-center'>
                        <div class='cart-price'>
                            <h4>R {item.Price}</h4>
                        </div>
                        <div class='cart-icon mr-120'>
                            <a href='RemoveProductCart.aspx?id={item.Id}&price={item.Price}'><img src='assets/img/cart-tab-page/icon-1.png' alt=''></a>
                        </div>
                    </div>
                </div>";

            }
            decimal calcVat = (decimal)cart.Total * (decimal)0.15;
            decimal grandT = calcVat + (decimal)cart.Total;
            cartItems.InnerHtml = displayItems;
            cartTotal.InnerText = $"R {cart.Total}";
            vat.InnerText = $"R {calcVat.ToString("f2")}";
            grandTotal.InnerText = $"R {grandT.ToString("f2")}";
		}
	}
}