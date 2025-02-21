using Project_Backup.ServiceReference;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_Backup
{
	public partial class PlaceBid : System.Web.UI.Page
	{
		static Service1Client client;
		static int customerID;
		static int productId;
		static BidDT bid;
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				if (Session["Id"] == null)
				{
					string referrerUrl = Request.UrlReferrer.ToString() + "?from=bid";
					Response.Redirect(referrerUrl);
				}
				else
				{
					if (Request.QueryString["Id"] != null)
					{
						client = new Service1Client();
						productId = Convert.ToInt32(Request.QueryString["Id"].ToString());
						customerID = Convert.ToInt32(Session["Id"].ToString());
						var product = client.GetProduct(productId);

						bid = client.GetBid(productId);
						// check if item is in bid
						if (bid.CustomerId != null)
						{
							if (bid.CustomerId == customerID)
							{
								placeBid.Visible = false;
							}
							// show current bid
							price.InnerText = "Current Bid: R " + bid.Amount;
							decimal minBid = (decimal)bid.Amount + (decimal)0.1 * (decimal)bid.Amount;
							min.InnerText = $"R {minBid.ToString("f2")}";

							var expiry = bid.ExpiresAt;

							// Calculate the target time in milliseconds since the Unix epoch
							long targetTime = ((DateTimeOffset)expiry).ToUnixTimeMilliseconds();

							// Set the hidden field value to the target time
							HiddenFieldTargetTime.InnerText = targetTime.ToString();
						}
						else
						{
							bidCountdown.Visible = false;
							price.InnerText = "Starting Bid: R " + bid.Amount;
							decimal minBid = (decimal)bid.Amount + (decimal)0.1 * (decimal)bid.Amount;
							min.InnerText = $"R {minBid.ToString("f2")}";
						}
					}
					else
					{
						Response.Redirect("Shop.aspx");
					}
				}
			}
		}

		protected void PlaceBid_Click(object sender, EventArgs e)
		{
			if (bid != null)
			{
				BidEditDT bidEdit = new BidEditDT
				{
					CustomerId = customerID,
					ProductId = productId,
					Amount = Convert.ToDecimal(bidAmount.Value)
				};
				var user = client.GetUser(int.Parse(Session["Id"].ToString()));
				if (user.Balance > decimal.Parse(bidAmount.Value))
				{
					var editedBid = client.EditBid(bidEdit);
					if (editedBid != null)
					{
						Response.Redirect($"PlaceBid.aspx?id={productId}");
					}
					else
					{
						string script = "alert('An error occured. Try again later')";
						ScriptManager.RegisterStartupScript(this, GetType(), "", script, true);
					}
				}
				else
				{
					string script = "alert('Balance Low !!')";
					ScriptManager.RegisterStartupScript(this, GetType(), "", script, true);
				}
			}
			else
			{
				BidNewDT bidNew = new BidNewDT
				{
					CustomerId = customerID,
					ProductId = productId,
					Amount = Convert.ToDecimal(bidAmount.Value)
				};
				var user = client.GetUser(int.Parse(Session["Id"].ToString()));
				if (user.Balance > decimal.Parse(bidAmount.Value))
				{
					var newBid = client.AddBid(bidNew);
					if (newBid != null)
					{
						Response.Redirect($"PlaceBid.aspx?id={productId}");
					}
					else
					{
						string script = "alert('An error occured. Try again later')";
						ScriptManager.RegisterStartupScript(this, GetType(), "", script, true);
					}
				}
				else
				{
					string script = "alert('Balance Low !!')";
					ScriptManager.RegisterStartupScript(this, GetType(), "", script, true);
				}



			}
		}
	}
}	