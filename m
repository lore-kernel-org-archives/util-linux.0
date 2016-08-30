Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36578 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753282AbcH3Kpf (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 30 Aug 2016 06:45:35 -0400
Date: Tue, 30 Aug 2016 12:45:32 +0200
From: Karel Zak <kzak@redhat.com>
To: Rostislav Skudnov <rostislav@tuxera.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libblkid exfat.c: Limit maximum number of iterations in
 find_label
Message-ID: <20160830104532.ljatevqoeisnecos@ws.net.home>
References: <1472551669-14450-1-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472551669-14450-1-git-send-email-rostislav@tuxera.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 30, 2016 at 10:07:49AM +0000, Rostislav Skudnov wrote:
> Do not hang if there is a cluster chain loop in rootdir
> ---
>  libblkid/src/superblocks/exfat.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/libblkid/src/superblocks/exfat.c b/libblkid/src/superblocks/exfat.c
> index 01ed30b..e058423 100644
> --- a/libblkid/src/superblocks/exfat.c
> +++ b/libblkid/src/superblocks/exfat.c
> @@ -86,8 +86,10 @@ static struct exfat_entry_label *find_label(blkid_probe pr,
>  	uint32_t cluster = le32_to_cpu(sb->rootdir_cluster);
>  	uint64_t offset = cluster_to_offset(sb, cluster);
>  	uint8_t *entry;
> +	const size_t max_iter = 10000;

for FAT we have 100 as the limit, would be this smaller number
better?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
