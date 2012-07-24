Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60946 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753305Ab2GXLkB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Jul 2012 07:40:01 -0400
Date: Tue, 24 Jul 2012 13:39:57 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 08/10] fdisk: API: add create disklabel to label
 operations
Message-ID: <20120724113957.GE736@x2.net.home>
References: <1342976743.2863.18.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1342976743.2863.18.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jul 22, 2012 at 07:05:43PM +0200, Davidlohr Bueso wrote:
>  12 files changed, 78 insertions(+), 50 deletions(-)

 Applied witch changes, thanks.

> diff --git a/fdisks/fdisk.c b/fdisks/fdisk.c
> index ab2cf5b..034df15 100644
> --- a/fdisks/fdisk.c
> +++ b/fdisks/fdisk.c
> @@ -505,11 +505,7 @@ static int get_boot(struct fdisk_context *cxt, int try_only) {
>  
>  		fprintf(stderr,
>  			_("Device does not contain a recognized partition table\n"));
> -#ifdef __sparc__
> -		create_sunlabel(cxt);
> -#else
> -		create_doslabel(cxt);
> -#endif
> +		fdisk_label_create(cxt, NULL);
>  	}

 I have removed get_boot() :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
