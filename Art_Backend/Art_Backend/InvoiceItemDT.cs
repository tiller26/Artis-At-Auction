using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

namespace Art_Backend
{
	[DataContract]
	public class InvoiceItemDT
	{
		[DataMember]
		public string ProductName { get; set; }
		
		[DataMember]
		public decimal? Price { get; set; }
	}
}