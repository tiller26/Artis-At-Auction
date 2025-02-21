using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

namespace Art_Backend
{
	[DataContract]
	public class InvoiceDT
	{
		[DataMember]
		public int Id { get; set; }

		[DataMember]
		public DateTime Date { get; set; }

		[DataMember]
		public decimal Total { get; set; }
		 
		[DataMember]
		public decimal GrandTotal { get; set; }

		[DataMember]
		public decimal VAT { get; set; }

		[DataMember]  
		public decimal Shipping { get; set; }

		[DataMember]
		public List<InvoiceItemDT> Items { get; set; }
	}
}