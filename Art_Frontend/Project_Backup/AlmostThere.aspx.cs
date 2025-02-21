using Project_Backup.ServiceReference;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_Backup
{
	public partial class AlmostThere : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (Request.QueryString["id"] == null)
			{
				Response.Redirect("Shop.aspx");
			}
			Service1Client client = new Service1Client();
			int productId = Convert.ToInt32(Request.QueryString["Id"].ToString());
			var product = client.GetProduct(productId);

			var bid = client.GetBid(productId);
			hidden.Value = bid.Created?.ToString("yyyy-MM-ddTHH:mm:ss");
		}
	}
}