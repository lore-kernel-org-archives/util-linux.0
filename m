Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45149 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751925AbaELMh6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 12 May 2014 08:37:58 -0400
Date: Mon, 12 May 2014 14:37:53 +0200
From: Karel Zak <kzak@redhat.com>
To: Shakur Shams Mullick <shakursmullick@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 4/8] libsmartcols/src/cell.c: add two functions to
 compare number and string cells
Message-ID: <20140512123753.GJ8951@x2.net.home>
References: <1399796438-5495-1-git-send-email-shakursmullick@gmail.com>
 <1399796438-5495-4-git-send-email-shakursmullick@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399796438-5495-4-git-send-email-shakursmullick@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 11, 2014 at 02:20:34PM +0600, Shakur Shams Mullick wrote:
> +int scols_cmpstr_cells(struct libscols_cell *a, struct libscols_cell *b, void *data)
> +{
> +	int n, m;
> +	const char *adata, *bdata;
> +
> +	adata = scols_cell_get_data(a);
> +	bdata = scols_cell_get_data(b);
> +	
> +	n = strlen(adata);
> +	m = strlen(bdata);
> +	
> +	return strncmp(adata, bdata, (n>=m ? n : m));
> +}

 This looks good.

> +int scols_cmpnum_cells(struct libscols_cell *a, struct libscols_cell *b, void *data)
> +{
> +	uint64_t n, m;
> +	const char *adata, *bdata;
> +
> +	adata = scols_cell_get_data(a);
> +	bdata = scols_cell_get_data(b);
> +	
> +	strtosize(adata, &n);
> +	strtosize(bdata, &m);

 I have doubts that we can scols_cmpnum_cells() to the library API.
 (Sorry for the suggestion.)
 
 The size strings are composed by applications and no by the library,
 the size_to_human_string() is private util-linux function, so rely on
 strtosize() seems strange. The cmpnum_cells() have to be within
 lsblk.c.

 It would be better to provide scols_cmpstr_cells() only.

 Note that you don't have to send v3, I'm going to fix/improve it
 before merge. Thanks!

    Karel





> +	if (n >= m)
> +		return 1;
> +	return -1;
> +}
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
