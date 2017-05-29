Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750898AbdE2KJS (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 29 May 2017 06:09:18 -0400
Date: Mon, 29 May 2017 12:09:13 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 4/4] lib/sysfs: fix format overflow
Message-ID: <20170529100913.er6mwukht5pq4ixc@ws.net.home>
References: <20170527182409.13985-1-kerolasa@iki.fi>
 <20170527182409.13985-4-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170527182409.13985-4-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, May 27, 2017 at 07:24:09PM +0100, Sami Kerola wrote:
> lib/sysfs.c:343:31: warning: '/start' directive output may be truncated
> writing 6 bytes into a region of size between 1 and 256
> [-Wformat-truncation=]
> 
> lib/sysfs.c:372:32: warning: '/partition' directive output may be truncated
> writing 10 bytes into a region of size between 1 and 256
> [-Wformat-truncation=]
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  lib/sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/sysfs.c b/lib/sysfs.c
> index cc290faac..6272b80b4 100644
> --- a/lib/sysfs.c
> +++ b/lib/sysfs.c
> @@ -307,7 +307,7 @@ static struct dirent *xreaddir(DIR *dp)
>  
>  int sysfs_is_partition_dirent(DIR *dir, struct dirent *d, const char *parent_name)
>  {
> -	char path[256];
> +	char path[strlen(d->d_name) + sizeof("/start") + 1];
>  
>  #ifdef _DIRENT_HAVE_D_TYPE
>  	if (d->d_type != DT_DIR &&
> @@ -356,7 +356,6 @@ dev_t sysfs_partno_to_devno(struct sysfs_cxt *cxt, int partno)
>  {
>  	DIR *dir;
>  	struct dirent *d;
> -	char path[256];
>  	dev_t devno = 0;
>  
>  	dir = sysfs_opendir(cxt, NULL);
> @@ -365,6 +364,7 @@ dev_t sysfs_partno_to_devno(struct sysfs_cxt *cxt, int partno)
>  
>  	while ((d = xreaddir(dir))) {
>  		int n, maj, min;
> +		char path[strlen(d->d_name) + sizeof("/partition") + 1];

why strlen() here? Maybe we can add to c.h macro 

 #define ul_dname_sizeof(x)
    (sizeof(((struct dirent *)0)->d_dname) + sizeof(x) + 1)

or use PATH_MAX ...

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
