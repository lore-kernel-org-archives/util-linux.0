Return-Path: util-linux-owner@vger.kernel.org
Received: from c-83-233-174-181.cust.bredband2.com ([83.233.174.181]:45992
        "EHLO pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751890AbdHIURj (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 9 Aug 2017 16:17:39 -0400
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH] Fix syntax error in fsck(8) manpage
Date: Wed,  9 Aug 2017 22:17:34 +0200
Message-Id: <1502309854-10756-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

$ LC_ALL=en_US.UTF-8 MANROFFSEQ='' MANWIDTH=80     \
        man --warnings -E UTF-8 -l -Tutf8 -Z disk-utils/fsck.8 >/dev/null
<standard input>:407: warning: macro `fi.' not defined (possibly missing space after `fi')

As spotted by 'lintian':
https://lintian.debian.org/tags/manpage-has-errors-from-man.html

Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 disk-utils/fsck.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disk-utils/fsck.8 b/disk-utils/fsck.8
index dc3f5a773..01e39e288 100644
--- a/disk-utils/fsck.8
+++ b/disk-utils/fsck.8
@@ -404,7 +404,7 @@ or
 .nf
 Theodore Ts'o <tytso@mit.edu>
 Karel Zak <kzak@redhat.com>
-.fi.
+.fi
 .SH AVAILABILITY
 The fsck command is part of the util-linux package and is available from
 .UR ftp://\:ftp.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
-- 
2.14.0

