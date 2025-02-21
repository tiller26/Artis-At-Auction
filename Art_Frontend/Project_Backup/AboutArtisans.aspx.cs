using Project_Backup.ServiceReference;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Project_Backup
{
	public partial class AboutArtisans : System.Web.UI.Page
	{
		static Service1Client client;
		protected void Page_Load(object sender, EventArgs e)
		{
			if (true)
			{
				client = new Service1Client();
				var sellers = client.GetSellers();
				string display = "";

				foreach (var seller in sellers)
				{
					var user = client.GetUser(seller.Id);
					string img = user.Image;
					int totalItems = 0;
					foreach (var item in client.GetProducts())
					{
						if (item.SellerId == seller.Id)
						{
							totalItems += 1;
						}
					}

					display += $@"
                            <div class='col-lg-4 col-md-6'>
                                <div class='single-cart-item active'>
                                    <div class='single-cart-image'>
                                        <a href='SellerDetails.aspx?Id={seller.Id}'><img class='image-item-01 item-active' src='{img}' alt=''></a>
                                    </div>
                                    <div class='single-cart-content'>
                                        <div class='cart-content-left'>
                                            <a href='SellerDetails.aspx?Id={seller.Id}'><h5>{user.Name}</h5></a>
                                            <span>{totalItems} Items / {seller.NoSale} Sold</span>
                                        </div>
                                    </div>
                                </div>
                            </div>";
				}
				productItem.InnerHtml = display;
			}
			// *********************************************
		}


		private String AddSeller(SellerDT seller)
		{
			string display = "";

			display += $@"
                <div class='single-item text-center'>
                    <div class='item-image'>
                        <a href=SellerDetails.aspx?id={seller.Id}&name={seller.Name}><img src='{seller.Image}' alt=''></a>
                    </div>
                    <div class='item-content text-center'>
                        <h6>Joined {seller.CreatedAt}</h6>
                        <ahref=SellerDetails.aspx?id={seller.Id}&name={seller.Name}><h5>{seller.Name} {seller.Surname}</h5></a>
                    </div>
                    <div >
                        <a href=SellerDetails.aspx?id={seller.Id}&name={seller.Name}'{seller.Image}'><i class='fa fa-arrows-alt'></i></a>
                    </div>
                </div>
                ";
			return display;
		}

		private List<String> returnArtists(SellerDT[] sellers, int num)
		{
			List<String> Artis = new List<string>();
			string member = "";
			for (int r = 0; r < num; r++)
			{
				var item = sellers[r];
				member += AddSeller(item);
				Artis.Add(member);
			}
			return Artis;
		}
	}
}
