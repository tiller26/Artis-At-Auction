using Project_Backup.ServiceReference;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_Backup
{
	public partial class AddFunds : System.Web.UI.Page
	{
        Service1Client client = new Service1Client();
        protected void Page_Load(object sender, EventArgs e)
		{

		}
        protected void Pay(object sender, EventArgs e)
        {
            int id = int.Parse(Session["Id"].ToString());
            string fund = payola.Value;
            decimal funds = decimal.Parse(fund);

            if (client.credit(funds, id))
            {
                string script = "alert('Funds Deposited');";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", script, true);
                Response.Redirect("Profile.aspx");
            }
            else
            {
                string script = "alert('Could not add funds');";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", script, true);
            }
        }
    }
}