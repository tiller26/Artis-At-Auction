using Project_Backup.ServiceReference;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_Backup
{
	public partial class FinanceReports : System.Web.UI.Page
	{
		Service1Client client;

		protected decimal sales;
		protected decimal registrations;
		protected void Page_Load(object sender, EventArgs e)
		{
			GetRevenue();
		}
		private void GetRevenue()
		{
			client = new Service1Client();
			var productCounts = client.GetRevenue();

			if (productCounts != null)
			{
				sales = productCounts["Sales"];
				registrations = productCounts["Registrations"];
			}
		}
	}
}