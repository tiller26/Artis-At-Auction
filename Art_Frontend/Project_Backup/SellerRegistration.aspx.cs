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
	public partial class SellerRegistration : System.Web.UI.Page
	{

		protected void Page_Load(object sender, EventArgs e)
		{

		}
		protected void AddSeller(object sender, EventArgs e)
		{
			if (Session["Id"] != null)
			{
				// Proceed with the registration process
				Session["Description"] = sDescription.Value;
				Session["Business"] = sBusiness.Value;
				Session["FilePath"] = getFilePath();
				Response.Redirect("Payment.aspx");
			}
			else
			{
				string script = "alert('Login To Register');";
				ScriptManager.RegisterStartupScript(this, this.GetType(), "", script, true);
			}

		}


		private string getFilePath()
		{
			// Define the directory path where the file should be moved
			string targetFolder = Server.MapPath("~/assets/img/sellers");

			// Ensure the target folder exists
			if (!Directory.Exists(targetFolder))
			{
				Directory.CreateDirectory(targetFolder);
			}

			// Get the original file name and construct the new path

			string originalFileName = Path.GetFileName(sImage.PostedFile.FileName).ToString();
			string newFilePath = Path.Combine(targetFolder, originalFileName);

			if (originalFileName == "")
			{
				return "/assets/img/avatar.png";
			}

			// Save the file to the new location
			sImage.PostedFile.SaveAs(newFilePath);

			return $"/assets/img/sellers/{originalFileName}";
		}


	}
}