Return-Path: util-linux-owner@vger.kernel.org
Received: from katla.rhi.hi.is ([130.208.165.1]:47490 "EHLO katla.rhi.hi.is"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751043AbaDUAc1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 20 Apr 2014 20:32:27 -0400
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Cc: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
Subject: [PATCH 4/4] swaplabel.8: Improve the typesetting of the manual
Date: Mon, 21 Apr 2014 00:30:27 +0000
Message-Id: <1398040227-14535-4-git-send-email-bjarniig@rhi.hi.is>
In-Reply-To: <1398040227-14535-1-git-send-email-bjarniig@rhi.hi.is>
References: <1398040227-14535-1-git-send-email-bjarniig@rhi.hi.is>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

  Change macro 'IR' to 'I' if it has only one (italic) argument

  Remove space at end of lines

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 disk-utils/swaplabel.8 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/disk-utils/swaplabel.8 b/disk-utils/swaplabel.8
index 4e655ef..0f83b2d 100644
--- a/disk-utils/swaplabel.8
+++ b/disk-utils/swaplabel.8
@@ -15,13 +15,13 @@ swaplabel \- print or change the label or UUID of a swap area
 .SH DESCRIPTION
 .B swaplabel
 will display or change the label or UUID of a swap partition located on
-.IR device 
+.I device
 (or regular file).
 .PP
 If the optional arguments
-.B \-L 
+.B \-L
 and
-.B \-U 
+.B \-U
 are not given,
 .B swaplabel
 will simply display the current swap-area label and UUID of
-- 
1.9.0

