 using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

namespace Art_Backend
{

    [DataContract]
    public class ProductDT
    {
        [DataMember]
		public int Id { get; set; }

		[DataMember]
        public string Name { get; set; }

        [DataMember]
        public string Description { get; set; }

        [DataMember]
        public decimal Price { get; set; }

        [DataMember]
        public string IsActive { get; set; }

        [DataMember]
        public int? Quantity { get; set; }

        [DataMember]
        public DateTime? Added { get; set; }

        [DataMember]
        public string Color { get; set; }

        [DataMember]
        public DateTime? SoldAt { get; set; }

        [DataMember]
        public int SellerId { get; set; }

        [DataMember]
        public string Images { get; set; }

        [DataMember]
		public List<string> ExtraAttributes { get; set; }
	}
} 