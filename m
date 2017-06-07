Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40110 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751483AbdFGJoz (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 7 Jun 2017 05:44:55 -0400
Date: Wed, 7 Jun 2017 11:44:51 +0200
From: Karel Zak <kzak@redhat.com>
To: NeilBrown <neilb@suse.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [util-linux PATCH] umount: never 'stat' the path when "-c" is
 given.
Message-ID: <20170607094451.vcesromvdygstjmw@ws.net.home>
References: <8760gbduzp.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8760gbduzp.fsf@notabene.neil.brown.name>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 05, 2017 at 12:32:58PM +1000, NeilBrown wrote:
> diff --git a/libmount/src/context_umount.c b/libmount/src/context_umount.c
> index e663a703cca0..693891def0e1 100644
> --- a/libmount/src/context_umount.c
> +++ b/libmount/src/context_umount.c
> @@ -77,6 +77,7 @@ int mnt_context_find_umount_fs(struct libmnt_context *cxt,
>  	 * it's usable only for canonicalized stuff (e.g. kernel mountinfo).
>  	 */
>  	if (!mnt_context_mtab_writable(cxt) && *tgt == '/' &&
> +	    !mnt_context_is_nocanonicalize(cxt) &&
>  	    !mnt_context_is_force(cxt) && !mnt_context_is_lazy(cxt))
>  		rc = mnt_context_get_mtab_for_target(cxt, &mtab, tgt);

I've changed the code to be the mount table filter also usable for
--no-canonicalize. It seems better to avoid mnt_resolve_path() than
avoid all the filter.

It seems we can do more optimizations for huge mount tables (=autofs
issues) and canonicalizations (=NFS issues). I'll try to do it for
v2.30.1.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
