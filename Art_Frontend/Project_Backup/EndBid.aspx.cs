using Project_Backup.ServiceReference;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_Backup
{
	public partial class EndBid : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			Service1Client client = new Service1Client();
			var bids = client.GetBids();
			var productId = (int)bids[0].ProductId;
			var customerId = (int)bids[0].CustomerId;

			// change bid to expired
			if (client.IsExpired(productId))
			{
				client.AddToCart(customerId, productId);
				client.MakeInactive(productId);
			}
			Response.Redirect("Shop.aspx");
		}
	}
}