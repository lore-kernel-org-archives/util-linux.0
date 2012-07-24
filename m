Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:6314 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753866Ab2GXMtu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Jul 2012 08:49:50 -0400
Date: Tue, 24 Jul 2012 14:49:45 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 2/2] fdisk: API: comment labels array
Message-ID: <20120724124945.GM736@x2.net.home>
References: <1343133630.2686.16.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343133630.2686.16.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 24, 2012 at 02:40:30PM +0200, Davidlohr Bueso wrote:
> From: Davidlohr Bueso <dave@gnu.org>
> 
> Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> ---
>  fdisks/utils.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/fdisks/utils.c b/fdisks/utils.c
> index 8de64c2..c4ffe04 100644
> --- a/fdisks/utils.c
> +++ b/fdisks/utils.c
> @@ -35,7 +35,9 @@
>  int fdisk_debug_mask;
>  
>  /*
> - * label probing functions
> + * Label probing functions.
> + * Must have the same order as fdisk_labeltype as the index
> + * depends on it.

This (rely on comment) is bad way.

>   */
>  static const struct fdisk_label *labels[] =
>  {

Use:

 static const struct fdisk_label[] =
 {
    [XXX_LABEL] = &xxx_label,
    [YYY_LABEL] = &yyy_label
 }

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
