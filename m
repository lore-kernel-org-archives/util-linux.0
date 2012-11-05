Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:12422 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754507Ab2KEQxs (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 5 Nov 2012 11:53:48 -0500
Date: Mon, 5 Nov 2012 17:53:39 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 09/13] ipcs: make individual shared memory id printing to
 use /proc
Message-ID: <20121105165339.GD3799@x2.net.home>
References: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
 <1350246145-10600-10-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350246145-10600-10-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Oct 14, 2012 at 09:22:21PM +0100, Sami Kerola wrote:
> And reindent the print_shm() function.
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  sys-utils/ipcs.c | 49 ++++++++++++++++++++++++++++---------------------
>  1 file changed, 28 insertions(+), 21 deletions(-)
> 
> diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
> index 960039e..cd3d14d 100644
> --- a/sys-utils/ipcs.c
> +++ b/sys-utils/ipcs.c
> @@ -308,6 +308,10 @@ static int shmctl_info_wrapper(int maxid, int id, struct shm_data **shmds,
>  			       &(shmdsp->shm_rss),
>  			       &(shmdsp->shm_swp)
>  			    );
> +			if (-1 < id && id != shmdsp->shm_perm.id) {
> +				i--;
> +				continue;
> +			}

 And what action is expected when id == shmdsp->shm_perm.id ?

 What about

    if (id == shmdsp->shm_perm.id)
        break;

 otherwise  ipcs -m -i <id> will return another entry.

 BTW,

    ./ipcs <something> &> new
    ipcs <something>   &> old
    diff -u old new

 is nice way how found bugs...

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
