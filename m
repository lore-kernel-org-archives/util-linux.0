Return-Path: davidlohr@hp.com
From: Davidlohr Bueso <davidlohr@hp.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Davidlohr Bueso <davidlohr@hp.com>
Subject: [PATCH 1/3] libfdisk: gpt: avoid unnecessary pmbr check
Date: Sat, 21 Sep 2013 20:45:14 -0700
Message-Id: <1379821516-2540-1-git-send-email-davidlohr@hp.com>
List-ID: <util-linux.vger.kernel.org>

We only jump to the 'check_hybrid' label when a valid pmbr
is detected, so we need not recheck again. Move the label's
logic so it doesn't include the check.

Signed-off-by: Davidlohr Bueso <davidlohr@hp.com>
---
 libfdisk/src/gpt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libfdisk/src/gpt.c b/libfdisk/src/gpt.c
index b929b84..2a6284a 100644
--- a/libfdisk/src/gpt.c
+++ b/libfdisk/src/gpt.c
@@ -503,9 +503,10 @@ static int valid_pmbr(struct fdisk_context *cxt)
 			goto check_hybrid;
 		}
 	}
-check_hybrid:
+
 	if (ret != GPT_MBR_PROTECTIVE)
 		goto done;
+check_hybrid:
 	for (i = 0 ; i < 4; i++) {
 		if ((pmbr->partition_record[i].os_type != EFI_PMBR_OSTYPE) &&
 		    (pmbr->partition_record[i].os_type != 0x00))
-- 
1.7.11.7
