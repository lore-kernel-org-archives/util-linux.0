Return-Path: util-linux-owner@vger.kernel.org
Received: from g4t3426.houston.hp.com ([15.201.208.54]:25152 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbaGZEWG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 26 Jul 2014 00:22:06 -0400
Message-ID: <1406348523.25428.1.camel@buesod1.americas.hpqcorp.net>
Subject: Re: [PATCH 12/13] sfdisk: fix --unhide segfault
From: Davidlohr Bueso <davidlohr@hp.com>
To: kzak@redhat.com
Cc: aswin@hp.com, util-linux@vger.kernel.org
Date: Fri, 25 Jul 2014 21:22:03 -0700
In-Reply-To: <1406072697-20912-13-git-send-email-davidlohr@hp.com>
References: <1406072697-20912-1-git-send-email-davidlohr@hp.com>
	 <1406072697-20912-13-git-send-email-davidlohr@hp.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, 2014-07-22 at 16:44 -0700, Davidlohr Bueso wrote:
> There's currently a NULL ptr dereference bug when calling asc_to_index()
> via set_unhidden(). Fix this bug by checking the optarg value for null.
> This is similar to how other options handle such calls.
> 
> Before:
> Segmentation fault (core dumped)
> 
> After:
> sfdisk: Done: Success
> 
> Signed-off-by: Davidlohr Bueso <davidlohr@hp.com>
> ---
>  disk-utils/sfdisk.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
> index 86ed112..f730504 100644
> --- a/disk-utils/sfdisk.c
> +++ b/disk-utils/sfdisk.c
> @@ -2909,12 +2909,13 @@ static int do_activate(char **av, int ac, char *arg)
>  	return ret;
>  }
>  
> -static void
> -set_unhidden(struct disk_desc *z, char *pnam) {
> +static void set_unhidden(struct disk_desc *z, char *pnam)
> +{
>  	int pno;
>  	unsigned char id;
>  
>  	pno = asc_to_index(pnam, z);
> +	printf("\t%s\n", pnam);

err, sorry... forgot to delete that one.

