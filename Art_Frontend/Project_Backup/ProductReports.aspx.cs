using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Project_Backup.ServiceReference;
namespace Project_Backup
{
	public partial class ProductReports : System.Web.UI.Page
	{
		Service1Client client;

		protected int activeProductCount;
		protected int inactiveProductCount;
		protected int soldProductCount;
		protected int unsoldProductCount;
		protected int soldAccProductCount;
		protected int unsoldAccProductCount;
		protected int soldArtProductCount;
		protected int unsoldArtProductCount;

		protected string monthLabels; // Declare as a string
		protected string ProvinceLabels;
		protected string ProvinceCounts;
		protected string userCounts; // Declare as a string
		protected decimal sales;
		protected decimal registrations;
		protected void Page_Load(object sender, EventArgs e)
		{
			GetClothing();
			GetAccessories();
			GetArt();

		}
		//CLOTHING PLOT PIE CHART FTN
		private void GetClothing()
		{
			client = new Service1Client();
			var productCounts = client.GetClothingSoldUnsoldCounts();

			if (productCounts != null)
			{
				soldProductCount = productCounts["Sold"];
				unsoldProductCount = productCounts["Not Sold"];
			}
		}

		//ACCESSORIES PLOT PIE CHART FTN
		private void GetAccessories()
		{
			client = new Service1Client();
			var productCounts = client.GetAccessoriesSoldUnsoldCounts();

			if (productCounts != null)
			{
				soldAccProductCount = productCounts["Sold"];
				unsoldAccProductCount = productCounts["Not Sold"];
			}
		}

		//ART PLOT PIE CHART FTN
		private void GetArt()
		{
			client = new Service1Client();
			var productCounts = client.GetArtSoldUnsoldCounts();

			if (productCounts != null)
			{
				soldArtProductCount = productCounts["Sold"];
				unsoldArtProductCount = productCounts["Not Sold"];
			}
		}
	}
}