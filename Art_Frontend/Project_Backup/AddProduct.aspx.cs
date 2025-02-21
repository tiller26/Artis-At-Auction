using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_Backup
{
	public partial class AddProduct : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

		}
		protected void Art(object sender, EventArgs e)
		{
			Response.Redirect("AddArt.aspx");
		}
		protected void Clothing(object sender, EventArgs e)
		{
			Response.Redirect("AddClothing.aspx");
		}
		protected void Accessory(object sender, EventArgs e)
		{
			Response.Redirect("Addaccessory.aspx");
		}
	}
}