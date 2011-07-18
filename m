Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58048 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750946Ab1GRWTd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 18 Jul 2011 18:19:33 -0400
Date: Tue, 19 Jul 2011 00:19:26 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Davidlohr Bueso <dave@gnu.org>, util-linux@vger.kernel.org
Subject: Re: [PATCH] minix: v3 super-block does not have s_state field
Message-ID: <20110718221926.GE4354@nb.redhat.com>
References: <1310485846-3685-1-git-send-email-kerolasa@iki.fi> <1310529931.4444.7.camel@offbook> <CAG27Bk0vW2LZySAf8B38OBbVaXpSDP81C+wVuA1vSW1rwhgwgg@mail.gmail.com> <20110713121232.GC3486@nb.net.home> <CAG27Bk2m+d=N9yVTSbByzhfkMUmP-d7heQXS643uWE3n+05+Mw@mail.gmail.com> <20110713173430.GD3486@nb.net.home> <1310609005.3482.0.camel@offbook> <20110714091829.GE3486@nb.net.home> <CAG27Bk0DYx+jCD-iqQvt1n=VdHszceTEAQQRvCKLvPXqpagTXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk0DYx+jCD-iqQvt1n=VdHszceTEAQQRvCKLvPXqpagTXA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Sami, thanks for the patches, few notes:

On Thu, Jul 14, 2011 at 05:47:39PM +0200, Sami Kerola wrote:
> +++ b/include/minix.h
> @@ -1,69 +1,65 @@
>  #ifndef __MINIX_H__
>  #define __MINIX_H__

 we usually use UTIL_LINUX prefix, so #ifndef UTIL_LINUX_MINIX_H.

>  #define BLOCK_SIZE_BITS 10
>  #define BLOCK_SIZE (1<<BLOCK_SIZE_BITS)

 This is too generic. Please, use MINIX_ prefix.

>  #define Inode (((struct minix_inode *) inode_buffer)-1)
>  #define Inode2 (((struct minix2_inode *) inode_buffer)-1)
> 
>  #define INODE_SIZE (sizeof(struct minix_inode))
>  #define INODE2_SIZE (sizeof(struct minix2_inode))
> 
> -int fs_version = 1; /* this default value needs to change in a near future */
> -char *super_block_buffer, *inode_buffer = NULL;
> +static int fs_version = 1; /* this default value needs to change in a
> near future */
> +static char *super_block_buffer, *inode_buffer = NULL;
> 
>  static char *inode_map;
>  static char *zone_map;

 The global variables don't belong to this generic header file. The
 stuff around inode_buffer, fs_version and the inline functions are
 specific to the disk-utils/ utils. Please, add
 disk-utils/minix_programs.h and use it in {mkfs,fsck}.minix.

>  		/* sanity checks to be sure that the FS is really minix */
> -		if (sb->s_imap_blocks * MINIX_BLOCK_SIZE * 8 < sb->s_ninodes + 1)
> +		if (sb->s_imap_blocks * BLOCK_SIZE * 8 < sb->s_ninodes + 1)
>  			return -1;
> -		if (sb->s_zmap_blocks * MINIX_BLOCK_SIZE * 8 < zones -
> sb->s_firstdatazone + 1)
> +		if (sb->s_zmap_blocks * BLOCK_SIZE * 8 < zones - sb->s_firstdatazone + 1)
>  			return -1;

 No, please...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
