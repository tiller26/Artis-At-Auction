using Project_Backup.ServiceReference;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_Backup
{
	public partial class OrderSummary : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["Id"] == null)
			{
				Response.Redirect("Home.aspx");
			}
			Service1Client client = new Service1Client();
			int userId = int.Parse(Session["Id"].ToString());
			var cart = client.GetCart(userId);
			if (cart.Total == 0)
			{
				Response.Redirect("Home.aspx");
			}
			else
			{
				// display invoice info
				InvoiceDT invoice = client.MakeInvoice(userId);
				total.InnerText = $"R {invoice.Total.ToString("f2")}";
				vat.InnerText = $"R {invoice.VAT.ToString("f2")}";
				grandTotal.InnerText = $"R {invoice.GrandTotal.ToString("f2")}";

				// address info
				var user = client.GetUser(userId);
				street.InnerText = user.StreetAddress;
				city.InnerText = user.City;
				province.InnerText = user.Province;
				contact.InnerText = user.ContactNumber;

				// display invoice items
				string htmlString = "";
				foreach (var item in invoice.Items)
				{
					htmlString += $@"
					<div class='common-right pt-80 d-flex justify-content-between mb-70'>
						<div class='slub-shirt'>
							<h5>{item.ProductName}</h5>
						</div>
						<div class='price'>
							<h5>R {item.Price}</h5>
						</div>
					</div>";
				}
				items.InnerHtml = htmlString;
			}
		}
	}
}