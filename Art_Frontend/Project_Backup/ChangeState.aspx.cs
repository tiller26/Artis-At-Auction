using Project_Backup.ServiceReference;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_Backup
{
	public partial class ChangeState : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			Service1Client client = new Service1Client();
			// get the product
			var prodId = Convert.ToInt32(Request.QueryString["Id"].ToString());
			var product = client.GetProduct(prodId);

			// change state from active to inactive VV
			if(product.IsActive == "true")
			{
				client.MakeInactive(prodId);
			}
			else if(product.IsActive == "false")
			{
				client.MakeActive(prodId);
			}

			Response.Redirect("Shop.aspx");
		}
	}
}