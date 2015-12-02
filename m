Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47963 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756444AbbLBMvS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 2 Dec 2015 07:51:18 -0500
Date: Wed, 2 Dec 2015 13:51:17 +0100
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>, David Sterba <dsterba@suse.cz>,
        =?iso-8859-1?Q?S=F8ren?= Holm <sgh@sgh.dk>
Subject: Re: [PATCH] fix mount -a on btrfs bind mount
Message-ID: <20151202125117.GJ4955@ws.net.home>
References: <56573D53.1020406@suse.cz>
 <56588FBD.9000502@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56588FBD.9000502@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Nov 27, 2015 at 06:15:41PM +0100, Stanislav Brabec wrote:
> root has to be literally the same as src_root, which is already the path
> prefixed by /{subvolume}. Otherwise it will not match in
> mnt_fs_streq_target(fs, xtgt) inside mnt_table_is_fs_mounted() and
> repeated "mount -a" will mount it again and again.

yes

>  		if (src_root && !startswith(root, src_root)) {
> -			size_t sz = strlen(root) + strlen(src_root) + 1;
> -			char *tmp = malloc(sz);
> -
> +			char *tmp = strdup (src_root);
>  			if (!tmp)
>  				goto err;
> -			snprintf(tmp, sz, "%s%s", src_root, root);
>  			free(root);
>  			root = tmp;
>  		}

but this code is there for another use case. The problem is when the
fstab_fs source is *sub-directory* on btrfs subvolume (or another bind
mount). For example imagine:

  /dev/sdc        /mnt/test       btrfs   subvol=/anydir
  /mnt/test/foo   /mnt/test2      auto    bind

then FS root for /mnt/test2 is /anydir/foo on /dev/sdc. The problem is
that the code does not recognize your use-case with "/" (no sub-directory 
on source FS).

My bugfix:

 https://github.com/karelzak/util-linux/commit/352740e88e2c9cb180fe845ce210b1c7b5ad88c7

try it :-)

Anyway, we need more regression tests for these crazy use-cases.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
