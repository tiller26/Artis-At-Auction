using Project_Backup.ServiceReference;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_Backup
{
    public partial class Payment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Pay(object sender, EventArgs e)
        {
            string description = Session["Description"].ToString();
            System.Diagnostics.Debug.WriteLine(description);
            string business = Session["Business"].ToString();
            System.Diagnostics.Debug.WriteLine(business);
            int id = int.Parse(Session["Id"].ToString());
            System.Diagnostics.Debug.WriteLine(id);
            string Filepath = Session["FilePath"].ToString();
            System.Diagnostics.Debug.WriteLine(Filepath);
            Service1Client client = new Service1Client();
            if (client.RegisterSeller(id, description, business, Filepath))
            {
                Session["Role"] = "Customer,Seller";
                
                Response.Redirect("Shop.aspx");
            }
            else
            {
                string script = "alert('An error occured');";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", script, true);
            }
        }



    }
}