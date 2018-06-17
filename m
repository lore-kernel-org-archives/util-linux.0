Return-Path: util-linux-owner@vger.kernel.org
Received: from 82-209-166-85.cust.bredband2.com ([82.209.166.85]:51466 "EHLO
        pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933241AbeFQMtb (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 17 Jun 2018 08:49:31 -0400
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: cespedes@debian.org, 898426@bugs.debian.org,
        Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH] partx: exit with error code when partition read failed
Date: Sun, 17 Jun 2018 14:49:15 +0200
Message-Id: <20180617124916.2124-1-andreas@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Make sure partx exits with a non-0 return code when
it runs into either code-path where getting the partition
table failed (or wasn't even attempted because of previous
error condition).

Change was tested using:
touch /tmp/foobar
partx -s - /tmp/foobar

Previously that was only printing an error/warning message
and then exiting with 0, but after this change it exits
with 1.

Signed-off-by: Andreas Henriksson <andreas@fatal.se>
Reported-by: Juan Céspedes <cespedes@debian.org>
Addresses: https://bugs.debian.org/898426
---
 disk-utils/partx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/disk-utils/partx.c b/disk-utils/partx.c
index 3ccd1afad..f895b9be3 100644
--- a/disk-utils/partx.c
+++ b/disk-utils/partx.c
@@ -1054,7 +1054,9 @@ int main(int argc, char **argv)
 			default:
 				abort();
 			}
-		}
+		} else
+			rc = 1;
+
 		blkid_free_probe(pr);
 	}
 
-- 
2.17.1

