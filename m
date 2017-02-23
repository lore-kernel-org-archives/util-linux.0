Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39422 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751107AbdBWPMR (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 23 Feb 2017 10:12:17 -0500
Date: Thu, 23 Feb 2017 16:12:14 +0100
From: Karel Zak <kzak@redhat.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] libmount: add mnt_fs_is_btrfs()
Message-ID: <20170223151214.y4wh2azmfab3wqra@ws.net.home>
References: <20170223140444.17916-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170223140444.17916-1-pvorel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Feb 23, 2017 at 03:04:43PM +0100, Petr Vorel wrote:
>  libmount/docs/libmount-sections.txt |  1 +
>  libmount/src/fs.c                   | 11 +++++++++++
>  libmount/src/libmount.h.in          |  1 +
>  libmount/src/libmount.sym           |  7 ++++++-
>  4 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/libmount/docs/libmount-sections.txt b/libmount/docs/libmount-sections.txt
> index 78d89cae7..65f774c2c 100644
> --- a/libmount/docs/libmount-sections.txt
> +++ b/libmount/docs/libmount-sections.txt
> @@ -209,6 +209,7 @@ mnt_fs_get_usedsize
>  mnt_fs_get_userdata
>  mnt_fs_get_user_options
>  mnt_fs_get_vfs_options
> +mnt_fs_is_btrfs
>  mnt_fs_is_kernel
>  mnt_fs_is_netfs
>  mnt_fs_is_pseudofs
> diff --git a/libmount/src/fs.c b/libmount/src/fs.c
> index 1c4ba1aab..e1bb9cde4 100644
> --- a/libmount/src/fs.c
> +++ b/libmount/src/fs.c
> @@ -616,6 +616,17 @@ int mnt_fs_is_netfs(struct libmnt_fs *fs)
>  }
>  
>  /**
> + * mnt_fs_is_btrfs:
> + * @fs: filesystem
> + *
> + * Returns: 1 if the filesystem is a btrfs fs type
> + */
> +int mnt_fs_is_btrfs(struct libmnt_fs *fs)
> +{
> +	return !strcmp(fs->fstype, "btrfs");
> +}

 ???

 What's wrong with 

   strcmp(mnt_fs_get_fstype(fs, "btrfs"))

 why we need FS specific function exported by API?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
