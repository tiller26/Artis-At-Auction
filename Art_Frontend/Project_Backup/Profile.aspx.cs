using Project_Backup.ServiceReference;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_Backup
{
	public partial class Profile : System.Web.UI.Page
	{
		Service1Client client;
		int userId;
		User user;

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
			client = new Service1Client();
			if (Session["Id"] == null)
			{
				Response.Redirect("Home.aspx");
			}
			else
			{
				userId = Convert.ToInt32(Session["Id"]);
				user = client.GetUser(userId);
				string role = Session["Role"].ToString();
				if (!role.Contains("Admin"))
				{
					reportsTab.Visible = false;
				}
				if (!IsPostBack)
				{
					showUserDetails();
					GetProductCounts();
					GetUserRegistrationCountsByMonth();
					GetUserLocationCountsByProvince();
					GetArt();
					GetAccessories();
					GetClothing();
				}

				if (Session["Role"].ToString().Contains("Seller"))
				{
					uImage.Style.Add("background", $"url('{user.Image}') no-repeat top / cover");
					manageProds.Visible = true;
					linkToAbout.HRef = $"SellerDetails.aspx?id={userId}";
				}
				else
				{
					uImage.Style.Add("background", $"url('assets/img/avatar.png') no-repeat top / cover");
				}

				if (Session["Role"].ToString().Contains("Admin"))
				{
					manageProds.Visible = true;
					linkToAbout.HRef = $"SellerDetails.aspx?id={userId}";
				}

				// Get all invoices by the customer Id
				var allInvoices = client.GetInvoices(userId);

				if (allInvoices != null && allInvoices.Any())
				{
					string display = "<div class='invoice-list'>";
					int counter = 0;
					// Loop through each invoice and generate HTML content
					foreach (var singleInvoice in allInvoices)
					{
						counter++;
						display += $@"
						<hr />
						<div class='row  single-item'>
							<div class='col-6'>
								<h6>Invoice Number: {singleInvoice.Id}</h6>
								<h6>Total: R {singleInvoice.GrandTotal}</h6>
								<h6>{singleInvoice.Date.ToString("dd/MMMM/yyyy")}</h6>
							</div>
							<div class='col-6'>
								<h6 class='mt-3'><a class='template-btn2 off1' href='SingleInvoice.aspx?id={singleInvoice.Id}'>View Invoice</a></h6>
							</div>
						</div>";
					}
					display += "</div>"; // close the invoice-list div

					// Bind the HTML content to the control
					InvoiceHtml.InnerHtml = display;
				}

				// show the notifications
				string displayNots = "<div class='invoice-list'>";
				var nots = client.GetNotifications(userId);
				foreach (var not in nots)
				{
					displayNots += $@"
					<hr />
					<div class='row single-item'>
						<div class='col-4'>
							<h6>{not.Date}</h6>
						</div>
						<div class='col-8'>
							<h6>{not.Message}</h6>
						</div>
					</div>";
				}
				notifications.InnerHtml = displayNots;
			}

		}
		protected void Logout_OnClick(object sender, EventArgs e)
		{
			Session.Clear();
			Response.Redirect("Home.aspx");
		}

		//protected void btnFinances(object sender, EventArgs e)
		//{
		//	GetRevenue();
		//	percentage.Visible = true;
		//	users.Visible = false;
		//	regusers.Visible = false;
		//	clothing.Visible = false;
		//	accessories.Visible = false;
		//	products.Visible = false;
		//}
		//protected void btnReports(object sender, EventArgs e)
		//{
		//	percentage.Visible = false;
		//	users.Visible = true;
		//	regusers.Visible = false;
		//	clothing.Visible = false;
		//	accessories.Visible = false;
		//	products.Visible = false;

		//}
		//protected void btnProducts(object sender, EventArgs e)
		//{
		//	percentage.Visible = false;
		//	users.Visible = false ;
		//	regusers.Visible = false;
		//	clothing.Visible = true;
		//	accessories.Visible = true;
		//	products.Visible = true;

		//}
		protected void SaveAddress_OnClick(object sender, EventArgs e)
		{
			client.setAddress(userId, uStreet.Value, uCity.Value, uProvince.Value);
			Response.Redirect("Profile.aspx");
		}
		private void GetRevenue()
		{

			var productCounts = client.GetRevenue();

			if (productCounts != null)
			{
				sales = productCounts["Sales"];
				registrations = productCounts["Registrations"];
			}
		}

		private void showUserDetails()
		{
			uName.InnerText = $"Hello, {user.Name}";
			balance.InnerText = $"R {user.Balance}";
			uEmail.Value = user.Email;
			uContact.Value = user.ContactNumber;
			uStreet.Value = user.StreetAddress;
			uCity.Value = user.City;
			uProvince.Value = user.Province;
		}
		private void GetProductCounts()
		{
			client = new Service1Client();
			var productCounts = client.GetActiveInactiveProductCounts();

			if (productCounts != null)
			{
				activeProductCount = productCounts["Active"];
				inactiveProductCount = productCounts["Inactive"];
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