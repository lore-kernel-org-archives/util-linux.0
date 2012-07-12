Return-Path: util-linux-owner@vger.kernel.org
Received: from damascus.uab.es ([158.109.168.135]:12865 "EHLO damascus.uab.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933639Ab2GLKlc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 12 Jul 2012 06:41:32 -0400
Received: from damascus.uab.es ([127.0.0.1])
 by damascus.uab.es (Sun Java System Messaging Server 6.1 HotFix 0.10 (built
 Jan  6 2005)) with ESMTP id <0M7100BEWN167270@damascus.uab.es> for
 util-linux@vger.kernel.org; Thu, 12 Jul 2012 12:41:30 +0200 (CEST)
Received: from aomail.uab.es ([158.109.65.1])
 by damascus.uab.es (Sun Java	System Messaging Server 6.1 HotFix 0.10 (builtJan
 6 2005)) with ESMTP id	<0M71005MJN15AUA0@damascus.uab.es>
 forutil-linux@vger.kernel.org; Thu, 12 Jul 2012 12:41:30 +0200 (CEST)
Date: Thu, 12 Jul 2012 12:40:57 +0200
From: Davidlohr Bueso <dave@gnu.org>
Subject: Re: [PATCH 2/2] fdisk: rename label probing functions
In-reply-to: <1342086439-21462-2-git-send-email-petr.uzel@suse.cz>
To: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Message-id: <1342089657.20502.0.camel@offworld>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
References: <1342086439-21462-1-git-send-email-petr.uzel@suse.cz>
 <"1342086439 -21462-2-git-send-email-petr.uzel"@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, 2012-07-12 at 11:47 +0200, Petr Uzel wrote:
> Rename check_$foo_label() to $foo_probe_label():
> 
> 1/ 'probe' is more appropriate verb than 'check' for these functions
> 2/ making label name first part of the funciton name is IMO more
>    friendly for tags completion (e.g. vim + cscope/ctags).
> 

acked on both patches. The write, new, delete, etc. label operations will also
need to be renamed.

I think we should also comment these functions thoroughly. For example,
$foo_probe_labels() specifying the return values (1 is always used when
detected, 0 otherwise).

I'll send some patches shortly.	

> Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
> ---
>  fdisks/fdiskaixlabel.c |    4 ++--
>  fdisks/fdiskbsdlabel.c |    4 ++--
>  fdisks/fdiskdoslabel.c |    4 ++--
>  fdisks/fdiskmaclabel.c |    4 ++--
>  fdisks/fdisksgilabel.c |    4 ++--
>  fdisks/fdisksunlabel.c |    4 ++--
>  6 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/fdisks/fdiskaixlabel.c b/fdisks/fdiskaixlabel.c
> index f908abc..ebf9365 100644
> --- a/fdisks/fdiskaixlabel.c
> +++ b/fdisks/fdiskaixlabel.c
> @@ -49,7 +49,7 @@ aix_nolabel(struct fdisk_context *cxt)
>      return;
>  }
>  
> -static int check_aix_label(struct fdisk_context *cxt)
> +static int aix_probe_label(struct fdisk_context *cxt)
>  {
>      if (aixlabel->magic != AIX_LABEL_MAGIC &&
>  	aixlabel->magic != AIX_LABEL_MAGIC_SWAPPED) {
> @@ -68,5 +68,5 @@ static int check_aix_label(struct fdisk_context *cxt)
>  const struct fdisk_label aix_label =
>  {
>  	.name = "aix",
> -	.probe = check_aix_label
> +	.probe = aix_probe_label,
>  };
> diff --git a/fdisks/fdiskbsdlabel.c b/fdisks/fdiskbsdlabel.c
> index 9ede3ef..548a86d 100644
> --- a/fdisks/fdiskbsdlabel.c
> +++ b/fdisks/fdiskbsdlabel.c
> @@ -110,7 +110,7 @@ static struct xbsd_disklabel xbsd_dlabel;
>   * so this does not mean that there is a BSD disk label.
>   */
>  static int
> -check_osf_label(struct fdisk_context *cxt) {
> +osf_probe_label(struct fdisk_context *cxt) {
>  	if (xbsd_readlabel (cxt, NULL, &xbsd_dlabel) == 0)
>  		return 0;
>  	return 1;
> @@ -849,5 +849,5 @@ alpha_bootblock_checksum (char *boot)
>  const struct fdisk_label bsd_label =
>  {
>  	.name = "bsd",
> -	.probe = check_osf_label
> +	.probe = osf_probe_label,
>  };
> diff --git a/fdisks/fdiskdoslabel.c b/fdisks/fdiskdoslabel.c
> index 27536da..a115e66 100644
> --- a/fdisks/fdiskdoslabel.c
> +++ b/fdisks/fdiskdoslabel.c
> @@ -316,7 +316,7 @@ void dos_delete_partition(int i)
>  	}
>  }
>  
> -static int check_dos_label(struct fdisk_context *cxt)
> +static int dos_probe_label(struct fdisk_context *cxt)
>  {
>  	int i;
>  
> @@ -684,5 +684,5 @@ void dos_write_table(struct fdisk_context *cxt)
>  const struct fdisk_label dos_label =
>  {
>  	.name = "dos",
> -	.probe = check_dos_label,
> +	.probe = dos_probe_label,
>  };
> diff --git a/fdisks/fdiskmaclabel.c b/fdisks/fdiskmaclabel.c
> index cbdf592..555245d 100644
> --- a/fdisks/fdiskmaclabel.c
> +++ b/fdisks/fdiskmaclabel.c
> @@ -48,7 +48,7 @@ mac_nolabel(struct fdisk_context *cxt)
>  }
>  
>  static int
> -check_mac_label(struct fdisk_context *cxt)
> +mac_probe_label(struct fdisk_context *cxt)
>  {
>  	/*
>  	Conversion: only 16 bit should compared
> @@ -83,5 +83,5 @@ IS_MAC:
>  const struct fdisk_label mac_label =
>  {
>  	.name = "mac",
> -	.probe = check_mac_label
> +	.probe = mac_probe_label,
>  };
> diff --git a/fdisks/fdisksgilabel.c b/fdisks/fdisksgilabel.c
> index c0b346a..071a84e 100644
> --- a/fdisks/fdisksgilabel.c
> +++ b/fdisks/fdisksgilabel.c
> @@ -128,7 +128,7 @@ two_s_complement_32bit_sum(unsigned int *base, int size /* in bytes */) {
>  }
>  
>  static int
> -check_sgi_label(struct fdisk_context *cxt) {
> +sgi_probe_label(struct fdisk_context *cxt) {
>  	if (sizeof(sgilabel) > 512) {
>  		fprintf(stderr,
>  			_("According to MIPS Computer Systems, Inc the "
> @@ -880,5 +880,5 @@ fill_sgiinfo(void)
>  const struct fdisk_label sgi_label =
>  {
>  	.name = "sgi",
> -	.probe = check_sgi_label
> +	.probe = sgi_probe_label,
>  };
> diff --git a/fdisks/fdisksunlabel.c b/fdisks/fdisksunlabel.c
> index d1f6054..909f159 100644
> --- a/fdisks/fdisksunlabel.c
> +++ b/fdisks/fdisksunlabel.c
> @@ -78,7 +78,7 @@ static void init(void)
>  	partitions = SUN_NUM_PARTITIONS;
>  }
>  
> -static int check_sun_label(struct fdisk_context *cxt)
> +static int sun_probe_label(struct fdisk_context *cxt)
>  {
>  	unsigned short *ush;
>  	int csum;
> @@ -646,5 +646,5 @@ int sun_get_sysid(struct fdisk_context *cxt, int i)
>  const struct fdisk_label sun_label =
>  {
>  	.name = "sun",
> -	.probe = check_sun_label,
> +	.probe = sun_probe_label,
>  };



