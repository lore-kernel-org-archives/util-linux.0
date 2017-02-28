Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45894 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751500AbdB1Nsl (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 28 Feb 2017 08:48:41 -0500
Date: Tue, 28 Feb 2017 14:48:38 +0100
From: Karel Zak <kzak@redhat.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2 1/1] libmount: return tab entry for default node
Message-ID: <20170228134838.7lmyck23ewgnl6nw@ws.net.home>
References: <20170223182513.13634-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170223182513.13634-1-pvorel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Feb 23, 2017 at 07:25:13PM +0100, Petr Vorel wrote:
>  libmount/src/tab.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)

Applied, thanks.

    Karel

> +#ifdef HAVE_BTRFS_SUPPORT
> +			if (!strcmp(fs->fstype, "btrfs")) {
> +				uint64_t default_id = btrfs_get_default_subvol_id(mnt_fs_get_target(fs));
> +				uint64_t subvol_id;
> +				char *val;
> +				size_t len;
> +
> +				if (default_id == UINT64_MAX) {
> +					DBG(TAB, ul_debug("not found btrfs volume setting"));
> +					return fs;
> +				}

I have added

                else if (mnt_fs_get_option...

to avoid the "return fs"

> +
> +				if (mnt_fs_get_option(fs, "subvolid", &val, &len) == 0) {
> +					if (mnt_parse_offset(val, len, &subvol_id)) {
> +						DBG(TAB, ul_debugobj(tb, "failed to parse subvolid="));
> +						continue;
> +					}
> +					if (subvol_id != default_id)
> +						continue;
> +				}
> +			}
> +#endif /* HAVE_BTRFS_SUPPORT */
>  			return fs;
> +		}
>  		if (mnt_fs_get_tag(fs, NULL, NULL) == 0)
>  			ntags++;
>  	}
> -- 
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
