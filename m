Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:9676 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757485AbaGAJCA (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 1 Jul 2014 05:02:00 -0400
Date: Tue, 1 Jul 2014 11:01:56 +0200
From: Karel Zak <kzak@redhat.com>
To: Eric Rannaud <e@nanocritical.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/4] libmount: mnt_resolve_target: tiptoe around active
 mount points
Message-ID: <20140701090156.GD24337@x2.net.home>
References: <747e9f8de90dc1e906d2f84f3952a801e70ef3d0.1403845374.git.e@nanocritical.com>
 <7e7cf36d4dfbcd8785972819445df77c5da98bb9.1403845374.git.e@nanocritical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7e7cf36d4dfbcd8785972819445df77c5da98bb9.1403845374.git.e@nanocritical.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 26, 2014 at 10:17:18PM -0700, Eric Rannaud wrote:
>  libmount/src/cache.c       | 124 ++++++++++++++++++++++++++++++++++++++-------
>  libmount/src/fs.c          |   6 ++-
>  libmount/src/libmount.h.in |   4 ++
>  libmount/src/libmount.sym  |   2 +
>  libmount/src/tab.c         |   8 +--
>  5 files changed, 121 insertions(+), 23 deletions(-)

 Applied with small changes, thanks.

> +int mnt_cache_set_targets(struct libmnt_cache *cache,
> +				struct libmnt_table *mtab)

 added docs.

 [...]

> +char *mnt_resolve_target(const char *path, struct libmnt_cache *cache)
> +{
> +	char *p = NULL;
> +	struct libmnt_iter *itr = NULL;
> +	struct libmnt_fs *fs = NULL;

 added fallback to mnt_reolve_path() if no cache or cache->mtab no
 specified.

> +	if (!path)
> +		return NULL;
> +	if (cache)
> +		p = (char *) cache_find_path(cache, path);
> +
> +	if (cache && cache->mtab) {
> +		itr = mnt_new_iter(MNT_ITER_FORWARD);
> +		if (!itr)
> +			goto skip_mtab;

 within libmount we don't allocate iterators, just use "struct
 libmnt_iter" (no pointer) and mnt_reset_iter().

 [...]

> +> diff --git a/libmount/src/fs.c b/libmount/src/fs.c
> index 21ef0f7479fd..82541083a792 100644
> --- a/libmount/src/fs.c
> +++ b/libmount/src/fs.c
> @@ -1413,7 +1413,9 @@ int mnt_fs_append_comment(struct libmnt_fs *fs, const char *comm)
>   *	1) compare @target with @fs->target
>   *	2) realpath(@target) with @fs->target
>   *	3) realpath(@target) with realpath(@fs->target) if @fs is not from
> - *	   /proc/self/mountinfo.
> + *	   /proc/self/mountinfo. However, if mnt_cache_set_targets(cache,
> + *	   mtab) was called, and the path @fs->target is found in @mtab,
> + *	   this comparison is not performed (see mnt_resolve_target()).
>   *
>   * The 2nd and 3rd attempts are not performed when @cache is NULL.
>   *

 I did small change here, it seems that we can use  mnt_resolve_target() also
 for 2nd attempt to avoid canonicalization of the requested path. It
 means that for example:

     findmnt --fstab --target /mnt/nfs

 where "/mnt/nfs" is mounted NFS mounpoint will not canonicalize the
 path from fstab (@fs->target) as well as from command line (@target).

 I have added a debug message to canonicalize_path_and_cache(), so
 from

    LIBMOUNT_DEBUG=0xffff ./findmnt ...

 it's pretty obvious when we call realpath().

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
