using Project_Backup.ServiceReference;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_Backup
{
	public partial class Home : System.Web.UI.Page
	{
        static Service1Client client;
		protected void Page_Load(object sender, EventArgs e)
		{
            // This will display the images of the works by artisans
            client = new Service1Client();
            var sellers = client.GetSellers();
            var products = client.GetProducts();

   //        string display = "";

   //         for(int i = 0; i < 4; i++)
			//{
   //             // get images
   //             var product = products[i];
   //             string[] prodImgs = product.Images.Split(',');
   //             var img = prodImgs[0];

   //             // showing new items without any bids
   //             display += $@"
   //             <div class='col-lg-3 col-md-6'>
   //                 <div class='single-cart-item'>
   //                     <div class='single-cart-image'>
   //                         <img class='image-item-01 item-active' src='{img}' alt=''>
   //                     </div>
   //                     <div class='single-cart-content'>
   //                         <div class='cart-content-left'>
   //                             <h5>{product.Name}</h5>
   //                         </div>
   //                         <div class='cart-content-right'>
   //                             <span class='current-price'>R {product.Price}</span>
   //                         </div>
   //                     </div>
   //                     <div class='single-cart-button'>
   //                         <a href='#' class='cart-button floating-icon-1'>place bid</a>
   //                         <a href='Product.aspx?Id={product.Id}' class='compare-button'>see more</a>
   //                     </div>
   //                 </div>
   //             </div>";
   //         }
   //         newArrivals.InnerHtml = display;
        }

        protected void SellOnSite(object sender, EventArgs e)
		{
            if (Session["Id"] == null)
			{
                string script = "alert('You need to be logged in')";
                ScriptManager.RegisterStartupScript(this, GetType(), "", script, true);
			}
            else
			{
                Response.Redirect("SellerRegistration.aspx");
			}
		}

        private String AddSeller(SellerDT seller)
        {
            string display = "";

            display += $@"
                <div class='single-item text-center'>
                    <div class='item-image'>
                        <a href=Seller.aspx?id={seller.Id}&name={seller.Name}><img src='{seller.Image}' alt=''></a>
                    </div>
                    <div class='item-content text-center'>
                        <h6>Joined {seller.CreatedAt}</h6>
                        <ahref=Seller.aspx?id={seller.Id}&name={seller.Name}><h5>{seller.Name} {seller.Surname}</h5></a>
                    </div>
                    <div >
                        <a href=Seller.aspx?id={seller.Id}&name={seller.Name}'{seller.Image}'><i class='fa fa-arrows-alt'></i></a>
                    </div>
                </div>
                ";
            return display;
        }

        private List<String> returnArtists(SellerDT[] sellers, int num)
        {
            List<String> Artis  = new List<string>();
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