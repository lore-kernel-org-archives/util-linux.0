Return-Path: <SRS0=cyBV=DZ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771C2C433DF
	for <util-linux@archiver.kernel.org>; Sun, 18 Oct 2020 14:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A78321D7F
	for <util-linux@archiver.kernel.org>; Sun, 18 Oct 2020 14:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgJROpg (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 18 Oct 2020 10:45:36 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52710 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726519AbgJROpf (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 18 Oct 2020 10:45:35 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 09IEjVBl012141
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 18 Oct 2020 10:45:32 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5BCE0420107; Sun, 18 Oct 2020 10:45:31 -0400 (EDT)
Date:   Sun, 18 Oct 2020 10:45:31 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Thomas Stringer <trstringer@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: fallocate on ext4 creating holes
Message-ID: <20201018144531.GI181507@mit.edu>
References: <58f7cb75-1e2b-ec2b-221f-0af2c80b2728@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58f7cb75-1e2b-ec2b-221f-0af2c80b2728@gmail.com>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Oct 16, 2020 at 02:30:10PM -0400, Thomas Stringer wrote:
> I've found that in recent kernel versions (5.7+) that fallocate creates
> files on ext4 filesystem with holes.

It's not actually that it is creating holes, but rather it was fallouth
from switching ext4 to use iomap for FIBMAP/FIEMAP.

The following patch is queued up to be pushed to Linus shortly, and
will be backported to stable kernels.
 
Apologies for the inconvenience.  This would have been pushed to Linus
before 5.8 was cut, but an unrelated kernel bug that showed up after
5.8-rc1 and was causing very hard-to-reproduce memory corruptions
(although it was happening quite reliably in my test setup) caused my
regression testing to go completely dark for most of the 5.8-rcX
development, and by the time the bug was finally fixed (around -rc6 if
I remember correctly), I decided to wait until the 5.9 merge window.

  	   	       	 	    - Ted

commit 0e6895ba00b7be45f3ab0d2107dda3ef1245f5b4
Author: Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Fri Sep 4 14:46:53 2020 +0530

    ext4: implement swap_activate aops using iomap
    
    After moving ext4's bmap to iomap interface, swapon functionality
    on files created using fallocate (which creates unwritten extents) are
    failing. This is since iomap_bmap interface returns 0 for unwritten
    extents and thus generic_swapfile_activate considers this as holes
    and hence bail out with below kernel msg :-
    
    [340.915835] swapon: swapfile has holes
    
    To fix this we need to implement ->swap_activate aops in ext4
    which will use ext4_iomap_report_ops. Since we only need to return
    the list of extents so ext4_iomap_report_ops should be enough.
    
    Cc: stable@kernel.org
    Reported-by: Yuxuan Shui <yshuiv7@gmail.com>
    Fixes: ac58e4fb03f ("ext4: move ext4 bmap to use iomap infrastructure")
    Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
    Link: https://lore.kernel.org/r/20200904091653.1014334-1-riteshh@linux.ibm.com
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index bf596467c234..771ed8b1fadb 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3601,6 +3601,13 @@ static int ext4_set_page_dirty(struct page *page)
 	return __set_page_dirty_buffers(page);
 }
 
+static int ext4_iomap_swap_activate(struct swap_info_struct *sis,
+				    struct file *file, sector_t *span)
+{
+	return iomap_swapfile_activate(sis, file, span,
+				       &ext4_iomap_report_ops);
+}
+
 static const struct address_space_operations ext4_aops = {
 	.readpage		= ext4_readpage,
 	.readahead		= ext4_readahead,
@@ -3616,6 +3623,7 @@ static const struct address_space_operations ext4_aops = {
 	.migratepage		= buffer_migrate_page,
 	.is_partially_uptodate  = block_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
+	.swap_activate		= ext4_iomap_swap_activate,
 };
 
 static const struct address_space_operations ext4_journalled_aops = {
@@ -3632,6 +3640,7 @@ static const struct address_space_operations ext4_journalled_aops = {
 	.direct_IO		= noop_direct_IO,
 	.is_partially_uptodate  = block_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
+	.swap_activate		= ext4_iomap_swap_activate,
 };
 
 static const struct address_space_operations ext4_da_aops = {
@@ -3649,6 +3658,7 @@ static const struct address_space_operations ext4_da_aops = {
 	.migratepage		= buffer_migrate_page,
 	.is_partially_uptodate  = block_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
+	.swap_activate		= ext4_iomap_swap_activate,
 };
 
 static const struct address_space_operations ext4_dax_aops = {
@@ -3657,6 +3667,7 @@ static const struct address_space_operations ext4_dax_aops = {
 	.set_page_dirty		= noop_set_page_dirty,
 	.bmap			= ext4_bmap,
 	.invalidatepage		= noop_invalidatepage,
+	.swap_activate		= ext4_iomap_swap_activate,
 };
 
 void ext4_set_aops(struct inode *inode)
