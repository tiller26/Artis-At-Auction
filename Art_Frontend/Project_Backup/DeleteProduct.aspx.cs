using Project_Backup.ServiceReference;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_Backup
{
	public partial class DeleteProduct : System.Web.UI.Page
	{
		Service1Client client;
		int prodId;
		protected void Page_Load(object sender, EventArgs e)
		{
			if (Request.QueryString["Id"] == null)
			{
				Response.Redirect("Home.aspx");
			}

			prodId = int.Parse(Request.QueryString["Id"].ToString());
			client = new Service1Client();
			var product = client.GetProduct(prodId);
			prompt.InnerText = $"You are about to delete";
			name.InnerText = product.Name;
		}

		protected void Delete(object sender, EventArgs e)
		{
			if (client.RemoveProduct(prodId))
			{
				Response.Redirect($"SellerDetails.aspx?id={Session["Id"]}");
			}
			else
			{
				string script = "alert('An error occured. Try  again later');";
				ScriptManager.RegisterStartupScript(this, this.GetType(), "", script, true);
			}
		}
		protected void Back(object sender, EventArgs e)
		{
			Response.Redirect($"SellerDetails.aspx?id={Session["Id"]}");
		}
	}
}