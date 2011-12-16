Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:62464 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751363Ab1LPLmV (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 16 Dec 2011 06:42:21 -0500
Date: Fri, 16 Dec 2011 12:42:18 +0100
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] lists: add list sorting routine
Message-ID: <20111216114218.GA25969@nb.net.home>
References: <1323730346.2536.3.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323730346.2536.3.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Dec 12, 2011 at 11:52:26PM +0100, Davidlohr Bueso wrote:
>  include/c.h    |    8 +++
>  include/list.h |  132 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 140 insertions(+), 0 deletions(-)

 Applied, thanks.

> +	struct list_head *part[MAX_LIST_LENGTH_BITS+1]; /* sorted partial lists
> +							   -- last slot is a sentinel */
> +	int lev;  /* index into part[] */
> +	int max_lev = 0;

 size_t

> +	struct list_head *list;
> +
> +	if (list_empty(head))
> +		return;
> +
> +	memset(part, 0, sizeof(part));
> +
> +	head->prev->next = NULL;
> +	list = head->next;
> +
> +	while (list) {
> +		struct list_head *cur = list;
> +		list = list->next;
> +		cur->next = NULL;
> +
> +		for (lev = 0; part[lev]; lev++) {
> +			cur = merge(cmp, part[lev], cur);
> +			part[lev] = NULL;
> +		}
> +		if (lev > max_lev) {
> +			/* list passed to list_sort() too long for efficiency */
> +			if (lev >= ARRAY_SIZE(part)-1)

 use -Wsign-compare to get more fun :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
