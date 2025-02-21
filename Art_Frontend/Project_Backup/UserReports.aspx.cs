using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Project_Backup.ServiceReference;
namespace Project_Backup
{

	public partial class UserReports : System.Web.UI.Page
	{
		Service1Client client;
		protected string monthLabels; // Declare as a string
		protected string ProvinceLabels;
		protected string ProvinceCounts;
		protected string userCounts; // Declare as a string
		protected decimal sales;
		protected decimal registrations;
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				GetUserRegistrationCountsByMonth();
				GetUserLocationCountsByProvince();
			}
		}

		private void GetUserRegistrationCountsByMonth()
		{
			client = new Service1Client();
			var registrationCounts = client.GetUserRegistrationsByMonth(); // Call the updated WCF method

			if (registrationCounts != null)
			{
				// Pass the month names and counts to the front-end
				monthLabels = string.Join(",", registrationCounts.Keys.Select(k => $"'{k}'")); // E.g., 'January','February'
				userCounts = string.Join(",", registrationCounts.Values);  // E.g., 10, 25
			}
		}

		private void GetUserLocationCountsByProvince()
		{
			client = new Service1Client();
			var provinceCounts = client.GetUserLocationsByProvince(); // Call the updated WCF method

			if (provinceCounts != null)
			{
				// Pass the province names and counts to the front-end
				ProvinceLabels = string.Join(",", provinceCounts.Keys.Select(k => $"'{k}'")); // E.g., 'Gauteng','Mpumalangs'
				ProvinceCounts = string.Join(",", provinceCounts.Values);  // E.g., 10, 25
			}
		}


	}
}