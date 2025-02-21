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
	public partial class AddArt : System.Web.UI.Page
	{
		Service1Client client;
        int userId;
		protected void Page_Load(object sender, EventArgs e)
		{
            if (Session["Id"] == null)
			{
                Response.Redirect("Home.aspx");
			}
			
		}
		protected void AddItem(object sender, EventArgs e)
		{
            client = new Service1Client();
            userId = int.Parse(Session["Id"].ToString());
            var user = client.GetUser(userId);

            string name = pName.Value;
			string description = pDescription.Value;
			string type = pType.Value;
			decimal weight = decimal.Parse(pWeight.Value);
            decimal price = decimal.Parse(pPrice.Value);
			string dim = pDimensions.Value;
            string images = GetFilePaths();

            ProductReg product = new ProductReg
            {
                Name = name,
                Description = description,
                Price = price,
                Quantity = 1,
                SellerId = userId,
                Images = images.Split(','),
                Category = "Art"
            };
            int prodId;
            if ((prodId = client.AddProduct(product)) != -1)
			{
                Art art = new Art
                {
                    Type = type,
                    Dimensions = dim,
                    Weight = weight
                };
                if (client.AddArt(prodId, art))
				{
                    // start bid
                    BidNewDT bidNew = new BidNewDT
                    {
                        Amount = product.Price,
                        ProductId = prodId
                    };
                    client.AddBid(bidNew);
                    Response.Redirect($"SellerDetails.aspx?id={userId}");
				}
                else
				{
                    string script = "alert('An error occured');";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", script, true);
                }
			}
            else
			{
                string script = "alert('An error occured');";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", script, true);
            }
		}

        private string GetFilePaths()
        {
            // Define the directory path where the files should be moved
            string targetFolder = Server.MapPath("~/assets/img/products");

            // Ensure the target folder exists
            if (!Directory.Exists(targetFolder))
            {
                Directory.CreateDirectory(targetFolder);
            }

            // Initialize a list to store the paths of the saved files
            List<string> filePaths = new List<string>();

            // Access the uploaded files
            HttpFileCollection uploadedFiles = Request.Files;

            // Iterate through the uploaded files
            for (int i = 0; i < uploadedFiles.Count; i++)
            {
                // Get each file
                HttpPostedFile file = uploadedFiles[i];

                if (file != null && file.ContentLength > 0)
                {
                    // Get the original file name and construct the new path
                    string originalFileName = Path.GetFileName(file.FileName);
                    string newFilePath = Path.Combine(targetFolder, originalFileName);

                    // Save the file to the new location
                    file.SaveAs(newFilePath);

                    // Add the relative path to the list
                    filePaths.Add($"/assets/img/products/{originalFileName}");
                }
            }

            // Return a comma-separated string of the file paths
            return string.Join(",", filePaths);
        }

    }
}