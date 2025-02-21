using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

namespace Art_Backend
{
	[DataContract]
	public class CartDT
	{
		[DataMember]
		public decimal? Total { get; set; }

		[DataMember]
		public List<CartItemDT> Items { get; set; }

		[DataMember]
		public DateTime? CreatedAt { get; set; }

		[DataMember]
		public DateTime? ModifiedAt { get; set; }
	}
}