using Project_Backup.ServiceReference;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_Backup
{
	public partial class EditProduct : System.Web.UI.Page
	{
		Service1Client client;
		int prodId;
		protected void Page_Load(object sender, EventArgs e)
		{
			if (Request.QueryString["id"] == null)
			{
				Response.Redirect("Shop.aspx");
			}

			client = new Service1Client();
			prodId = int.Parse(Request.QueryString["id"].ToString());
			var product = client.GetProduct(prodId);
			if (!IsPostBack)
			{
				iName.Value = product.Name;
				iDescription.Value = product.Description;
				iPrice.Value = product.Price.ToString("f0");
			}
		}

		protected void Edit(object sender, EventArgs e)
		{
			var edit = new ProductEdit
			{
				Id = prodId,
				Name = iName.Value,
				Description = iDescription.Value,
				Price = decimal.Parse(iPrice.Value)
			};

			if (client.EditProduct(edit))
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