using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Project_Backup.ServiceReference;
namespace Project_Backup
{
	public partial class SingleInvoice : System.Web.UI.Page
	{
		Service1Client client = new Service1Client();
		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["Id"] != null)
			{
				string userId = Session["Id"].ToString();

				// Get all invoices by the customer Id
				string invoiceId = Request.QueryString["id"].ToString();

				var invoice = client.GetInvoice(int.Parse(invoiceId));

				if (invoice != null)
				{

					total.InnerText = $"R {invoice.Total.ToString("f2")}";
					vat.InnerText = $"R {invoice.VAT.ToString("f2")}";
					grandTotal.InnerText = $"R {invoice.GrandTotal.ToString("f2")}";
					date.InnerText = $"{invoice.Date.ToString("dd/MMMM/yyyy")}";

					// address info
					var user = client.GetUser(int.Parse(userId));
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
}