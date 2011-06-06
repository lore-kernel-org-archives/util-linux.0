Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcaid.dreamhost.com ([208.97.132.83]:40192 "EHLO
	homiemail-a6.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757208Ab1FFNwe convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 6 Jun 2011 09:52:34 -0400
Subject: Re: [PATCH 1/3] minix: add common functionality
From: Davidlohr Bueso <dave@gnu.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
In-Reply-To: <20110602113358.GH25562@nb.net.home>
References: <1306967576.1760.7.camel@offworld>
	 <20110602113358.GH25562@nb.net.home>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 06 Jun 2011 09:52:30 -0400
Message-ID: <1307368350.2006.2.camel@offworld>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, 2011-06-02 at 13:33 +0200, Karel Zak wrote:
> On Wed, Jun 01, 2011 at 06:32:56PM -0400, Davidlohr Bueso wrote:
> > Unite common features and code present in mkfs.minix and fsck.minix
> > into a single minix.h header.
> 
>  All three patches applied, but...
> 
>   CC     fsck.minix.o
> In file included from fsck.minix.c:105:0:
> minix.h: In function ‘inode_blocks’:
> minix.h:126:16: warning: unused variable ‘ret’
> fsck.minix.c: In function ‘map_block2’:
> fsck.minix.c:467:9: warning: array subscript is above array bounds
>   CC     ismounted.o
>   CCLD   fsck.minix
>   CC     mkfs.minix.o
> In file included from mkfs.minix.c:76:0:
> minix.h: In function ‘inode_blocks’:
> minix.h:126:16: warning: unused variable ‘ret’
> 
> 
>  ... I guess you will fix these warnings in some next cleanup patches.
> 

The array subscript warning is old, here's a patch that silences the
unused variable one. I will look into the first shortly.

From: Davidlohr Bueso <dave@gnu.org>
Date: Mon, 6 Jun 2011 09:48:25 -0400
Subject: [PATCH] minix: fix warning

This patch fixes an unused variable warning.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 disk-utils/minix.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/disk-utils/minix.h b/disk-utils/minix.h
index 4e670ba..0ebaa26 100644
--- a/disk-utils/minix.h
+++ b/disk-utils/minix.h
@@ -123,8 +123,6 @@ static inline unsigned long get_max_size(void)
 
 static unsigned long inode_blocks(void)
 {
-	unsigned long ret;
-
 	if (fs_version == 2)
 		return UPPER(get_ninodes(), MINIX2_INODES_PER_BLOCK);
 	else
-- 
1.7.4.1



