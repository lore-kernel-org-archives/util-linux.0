Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35715 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756049Ab1JCNxT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 3 Oct 2011 09:53:19 -0400
Date: Mon, 3 Oct 2011 15:52:55 +0200
From: Karel Zak <kzak@redhat.com>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 2/2] losetup: new -D option to delete all used loop
	devices
Message-ID: <20111003135255.GI1982@nb.net.home>
References: <1317377126-13302-1-git-send-email-petr.uzel@suse.cz> <1317377126-13302-2-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1317377126-13302-2-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Sep 30, 2011 at 12:05:26PM +0200, Petr Uzel wrote:
> 
> Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
> ---
>  mount/lomount.c |   45 +++++++++++++++++++++++++++++++++++++++++----
>  mount/losetup.8 |    6 ++++++
>  2 files changed, 47 insertions(+), 4 deletions(-)
> 
> diff --git a/mount/lomount.c b/mount/lomount.c
> index 441860b..ae49157 100644
> --- a/mount/lomount.c
> +++ b/mount/lomount.c
> @@ -938,6 +938,32 @@ set_loop(const char *device, const char *file, unsigned long long offset,
>  	return 0;
>  }
>  
> +static int
> +delete_all_devices (void)
> +{
> +	struct looplist ll;
> +	int fd;
> +	int ok;

 int ok = 0;   :-)

> +	if (looplist_open(&ll, LLFLG_USEDONLY) == -1) {
> +		error(_("%s: /dev directory does not exist."), progname);
> +		return 1;
> +	}
> +
> +	while((fd = looplist_next(&ll)) != -1) {
> +		close(fd);
> +		ok |= del_loop(ll.name);
> +	}

 [...]

 Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
