using Project_Backup.ServiceReference;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_Backup
{
	public partial class Checkout : System.Web.UI.Page
	{
		Service1Client client;
		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["Id"] == null)
			{
				Response.Redirect("Home.aspx");
			}

			int userId = int.Parse(Session["Id"].ToString());
			client = new Service1Client();
			var user = client.GetUser(userId);
			name.Value = user.Name + " " +user.Surname;
			street.Value = user.StreetAddress;
			city.Value = user.City;
			province.Value = user.Province;
			contact.Value = user.ContactNumber;
			email.Value = user.Email;

			var cart = client.GetCart(userId);
			decimal calcVat = (decimal)cart.Total * (decimal)0.15;
			decimal grandT = calcVat + (decimal)cart.Total;
			cartTotal.InnerText = $"R {cart.Total}";
			vat.InnerText = $"R {calcVat.ToString("f2")}";
			grandTotal.InnerText = $"R {grandT.ToString("f2")}";
		}
	}
}