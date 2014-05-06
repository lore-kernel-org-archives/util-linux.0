Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:13685 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752050AbaEFKde (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 6 May 2014 06:33:34 -0400
Date: Tue, 6 May 2014 12:33:28 +0200
From: Karel Zak <kzak@redhat.com>
To: Shakur Shams Mullick <shakursmullick@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/8] libsmartcols/src/libsmartcols.h.in: add function name
Message-ID: <20140506103328.GL5962@x2.net.home>
References: <1399138888-7554-1-git-send-email-shakursmullick@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399138888-7554-1-git-send-email-shakursmullick@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, May 03, 2014 at 11:41:21PM +0600, Shakur Shams Mullick wrote:
>  libsmartcols/src/libsmartcols.h.in | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Thanks Shakur,

> +extern int scols_table_is_namesort(struct libscols_table *tb);
> +extern int scols_table_is_sizesort(struct libscols_table *tb);

unfortunately it seems more like a hack to have sorted output from
lsblk(8) than a real extension to the API.

It's shared library, we should not force developers to use our
hardcoded point of view. It would be better to have API to specify
custom compare function.

 scols_column_set_sortcmp(struct libscols_column *cl,
                          int (*compar)(struct libscols_cell *, struct libscols_cell *, void *),
                          void *data)

it means function to compare two cells. This function should be called
from struct list_head compare function.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
