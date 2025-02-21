using Project_Backup.ServiceReference;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_Backup
{
	public partial class CartRemove : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			var productId = Convert.ToInt32(Request.QueryString["Id"].ToString());
			var customerID = Convert.ToInt32(Session["Id"].ToString());

			Service1Client client = new Service1Client();

			bool response = client.RemoveCartItem(customerID, productId);

			Response.Redirect("Shop.aspx");
		}
	}
}