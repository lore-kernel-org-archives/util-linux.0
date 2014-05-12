Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:20594 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758098AbaELMnu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 12 May 2014 08:43:50 -0400
Date: Mon, 12 May 2014 14:43:47 +0200
From: Karel Zak <kzak@redhat.com>
To: Shakur Shams Mullick <shakursmullick@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2 7/8] libsmartcols/src/table_print.c: sort the list
 before printing
Message-ID: <20140512124347.GK8951@x2.net.home>
References: <1399796438-5495-1-git-send-email-shakursmullick@gmail.com>
 <1399796438-5495-7-git-send-email-shakursmullick@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399796438-5495-7-git-send-email-shakursmullick@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 11, 2014 at 02:20:37PM +0600, Shakur Shams Mullick wrote:
> +int comparison_func(struct list_head *a, struct list_head *b, void *data)
> +{
> +	struct libscols_column *cl;
> +	struct libscols_line *ra, *rb;
> +	struct libscols_cell *ca, *cb;
> +	
> +	cl = (struct libscols_column *)(data);
> +	
> +	ra = list_entry(a, struct libscols_line, ln_lines);
> +	rb = list_entry(b, struct libscols_line, ln_lines);
> +	
> +	ca = scols_line_get_cell(ra, cl->seqnum);
> +	cb = scols_line_get_cell(rb, cl->seqnum);
> +
> +	return cl->compar(ca, cb, NULL);
                             ^^^^^

 I guess that we need something like cl->compare_data.


> +		cl = scols_table_get_key_column(tb);

 Do we really need table->cl_key? Maybe it would be better to add

   scols_sort_table(tb, cl)

 and keep control of the sort column in the applications. It will 
 also allow to sort table by more columns.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
