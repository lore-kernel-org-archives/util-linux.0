Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34773 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1046081AbdDWU6m (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 23 Apr 2017 16:58:42 -0400
Received: by mail-wm0-f68.google.com with SMTP id z129so13769415wmb.1
        for <util-linux@vger.kernel.org>; Sun, 23 Apr 2017 13:58:41 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 03/10] docs: raw devices are deprecated
Date: Sun, 23 Apr 2017 21:58:14 +0100
Message-Id: <20170423205821.7444-4-kerolasa@iki.fi>
In-Reply-To: <20170423205821.7444-1-kerolasa@iki.fi>
References: <20170423205821.7444-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Tell in manual page that one should use open(2) O_DIRECT flag rather than
raw device.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/raw.8 | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/disk-utils/raw.8 b/disk-utils/raw.8
index 717f4ef1b..5d04aa226 100644
--- a/disk-utils/raw.8
+++ b/disk-utils/raw.8
@@ -88,6 +88,13 @@ device buffer cache.  If you use raw I/O to overwrite data already in
 the buffer cache, the buffer cache will no longer correspond to the
 contents of the actual storage device underneath.  This is deliberate,
 but is regarded either a bug or a feature depending on who you ask!
+.SH NOTES
+Kernel developers consider raw driver deprecated.  Applications should
+preferably
+.BR open (2)
+the device, such as /dev/sda1, with the O_DIRECT flag.  See also
+https://lkml.\:org/lkml\:/2007/5\:/13/92 and
+https://lkml.\:org/lkml\:/2007/5\:/14/515 mails.
 .SH AUTHOR
 Stephen Tweedie (sct@redhat.com)
 .SH AVAILABILITY
-- 
2.12.2

