Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33858 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751654AbcFXJQP (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 24 Jun 2016 05:16:15 -0400
Date: Fri, 24 Jun 2016 11:16:11 +0200
From: Karel Zak <kzak@redhat.com>
To: Torsten Hilbrich <torsten.hilbrich@secunet.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCHv2] liblkid: Add length check in probe_nilfs2 before crc32
Message-ID: <20160624091611.hws25zpnwhlchtay@ws.net.home>
References: <576384D1.4000602@secunet.com>
 <57677A76.1040503@secunet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57677A76.1040503@secunet.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 20, 2016 at 07:09:10AM +0200, Torsten Hilbrich wrote:
>  libblkid/src/superblocks/nilfs.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/libblkid/src/superblocks/nilfs.c b/libblkid/src/superblocks/nilfs.c
> index d12472c..fbafb8d 100644
> --- a/libblkid/src/superblocks/nilfs.c
> +++ b/libblkid/src/superblocks/nilfs.c
> @@ -72,6 +72,7 @@ static int nilfs_valid_sb(blkid_probe pr, struct nilfs_super_block *sb, int is_b
>  	static unsigned char sum[4];
>  	const int sumoff = offsetof(struct nilfs_super_block, s_sum);
>  	size_t bytes;
> +	const size_t crc_start = sumoff + 4;
>  	uint32_t crc;
>  
>  	if (!sb || le16_to_cpu(sb->s_magic) != NILFS_SB_MAGIC)
> @@ -82,9 +83,15 @@ static int nilfs_valid_sb(blkid_probe pr, struct nilfs_super_block *sb, int is_b
>  		return 0;
>  
>  	bytes = le16_to_cpu(sb->s_bytes);
> +	/* ensure that no underrun can happen in the length parameter
> +	 * of the crc32 call or more data are processed than read into
> +	 * sb */
> +	if (bytes < crc_start || bytes > sizeof(struct nilfs_super_block))
> +		return -1;

 I guess that -1 is not expected return code there; nilfs_valid_sb() is
 used as boolean, see probe_nilfs2(). Fixed (replaced with zero).

 Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
