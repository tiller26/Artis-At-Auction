using Project_Backup.ServiceReference;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_Backup
{
    public partial class RemoveProductCart : System.Web.UI.Page
    {
        static Service1Client client = new Service1Client();
        decimal pricecharged;
        protected void Page_Load(object sender, EventArgs e)
        {
            int itemId = int.Parse(Request.QueryString["id"]);
            decimal price = decimal.Parse(Request.QueryString["price"]);
            //var bid = client.GetBid(productId);
            //string display = ToHtml(bid);
            pricecharged = price * (decimal)0.3;
            amount.InnerText = "R" + pricecharged.ToString("f2"); ;
        }

        protected void Remove(object sender, EventArgs e)
        {
            int Id = int.Parse(Session["Id"].ToString());
            int productId = int.Parse(Request.QueryString["id"]);
            if (client.RemoveCartItem(Id, productId))
            {
                client.debit(pricecharged, int.Parse(Session["Id"].ToString()));
                Response.Redirect("Cart.aspx");
            }
        }

        //protected string ToHtml(BidDT product)
        //{
            
        //    string display = $@"
        //            <div class='row mb-5'>
        //             < h6 > You are about to cancel the product you won in a bid. You will be charged {pricecharged}
        //                the 30 % of the item.</ h6 >
        //             </ div >
        //            <a runat='server' class='template-btn2 on1' onserverclick='Remove'>Remove</a>";
        //    return display;
        //}
    }
}