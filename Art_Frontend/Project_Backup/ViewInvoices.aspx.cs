using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Project_Backup.ServiceReference;

namespace Project_Backup
{

	public partial class ViewInvoices : System.Web.UI.Page
	{
		Service1Client client = new Service1Client();
		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["Id"] != null)
			{
				string cusId = Session["Id"].ToString();

				// Get all invoices by the customer Id
				var allInvoices = client.GetInvoices(int.Parse(cusId));

				if (allInvoices != null && allInvoices.Any())
				{
					string display = "<div class='invoice-list'>";
					int counter = 0;
					// Loop through each invoice and generate HTML content
					foreach (var singleInvoice in allInvoices)
					{
						display += "<div class='single-item'>";
						display += "<span class='cross-icon'><i class='fa fa-check-circle'></i></span>";
						display += "<div class='item-bg item3'></div>"; // Add styling class if needed
						display += "<div class='plus'>";
						counter += 1;
						Session["InvoiceId"] = singleInvoice.Id;
						// Invoice details dynamically displayed
						display += "<h6>Invoice Number: " + counter + "</h6>";
						display += "<h6>Total: " + singleInvoice.Total + "</h6>";
						display += "<h6>Grand Total: " + singleInvoice.GrandTotal + "</h6>";
						display += "<h6><a class='template-btn2 off1 mb-5' href='SingleInvoice.aspx?id='" + cusId + "'>  " + "See more " + "</a></h6>";
						//display += "<h6>VAT: " + singleInvoice.VAT + "</h6>";

						display += "</div>"; // close the 'plus' div
						display += "</div>"; // close the 'single-item' div
					}

					display += "</div>"; // close the invoice-list div

					// Bind the HTML content to the control
					InvoiceHtml.InnerHtml = display;
				}
			}

		}
	}
}