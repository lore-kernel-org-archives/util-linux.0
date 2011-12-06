Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcaid.dreamhost.com ([208.97.132.83]:59171 "EHLO
	homiemail-a62.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751320Ab1LFSzL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 6 Dec 2011 13:55:11 -0500
Subject: Re: [PATCH 2/4] partx: add BLKPG_RES_PARTITION support
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: util-linux@vger.kernel.org
In-Reply-To: <1323115372-3983-2-git-send-email-psusi@cfl.rr.com>
References: <1323115372-3983-2-git-send-email-psusi@cfl.rr.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 06 Dec 2011 19:55:06 +0100
Message-ID: <1323197706.3283.1.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, 2011-12-05 at 15:02 -0500, Phillip Susi wrote:
> Add new respart shell command and enhance partx update command to use
> BLKPG_RES_PARTITION to resize an existing partition while it is in use.
> 
> Signed-off-by: Phillip Susi <psusi@cfl.rr.com>
> ---
>  partx/Makefile.am |    4 ++--
>  partx/partx.c     |    9 +++++++++
>  partx/partx.h     |   19 +++++++++++++++++++
>  partx/respart.8   |   46 ++++++++++++++++++++++++++++++++++++++++++++++
>  partx/respart.c   |   31 +++++++++++++++++++++++++++++++
>  5 files changed, 107 insertions(+), 2 deletions(-)
>  create mode 100644 partx/respart.8
>  create mode 100644 partx/respart.c
> 
> diff --git a/partx/Makefile.am b/partx/Makefile.am
> index 080bc47..ce6fd5a 100644
> --- a/partx/Makefile.am
> +++ b/partx/Makefile.am
> @@ -1,7 +1,7 @@
>  include $(top_srcdir)/config/include-Makefile.am
>  
> -usrsbin_exec_PROGRAMS = addpart delpart
> -dist_man_MANS = addpart.8 delpart.8
> +usrsbin_exec_PROGRAMS = addpart delpart respart
> +dist_man_MANS = addpart.8 delpart.8 respart.8
>  
>  usrsbin_exec_PROGRAMS += partx
>  partx_SOURCES = partx.c partx.h \
> diff --git a/partx/partx.c b/partx/partx.c
> index 87443c4..2510ffb 100644
> --- a/partx/partx.c
> +++ b/partx/partx.c
> @@ -467,6 +467,15 @@ static int upd_parts(int fd, const char *device, dev_t devno,
>  		{
>  			if (i < nparts)
>  				i++;
> +			if (err == -1 && errno == EBUSY)
> +			{
> +				/* try to resize */
> +				err = partx_res_partition(fd, n, start, size);
> +				if (verbose)
> +					printf(_("%s: partition #%d resized\n"), device, n);
> +				if (err == 0)
> +					continue;
> +			}
>  			if (err == 0 && partx_add_partition(fd, n, start, size) == 0) {
>  				if (verbose)
>  					printf(_("%s: partition #%d added\n"), device, n);
> diff --git a/partx/partx.h b/partx/partx.h
> index b40fa8f..f85f75b 100644
> --- a/partx/partx.h
> +++ b/partx/partx.h
> @@ -41,4 +41,23 @@ static inline int partx_add_partition(int fd, int partno,
>  	return ioctl(fd, BLKPG, &a);
>  }
>  
> +static inline int partx_res_partition(int fd, int partno,
> +			unsigned long start, unsigned long size)
> +{
> +	struct blkpg_ioctl_arg a;
> +	struct blkpg_partition p;
> +
> +	p.pno = partno;
> +	p.start = start << 9;
> +	p.length = size << 9;
> +	p.devname[0] = 0;
> +	p.volname[0] = 0;
> +	a.op = BLKPG_RES_PARTITION;

I like the idea, but we should wait until your BLKPG resize patches are
accepted in mainline before applying here. Also, assuming they make it
into the kernel, this patch would break partx compilation on older
kernels.

- Davidlohr

