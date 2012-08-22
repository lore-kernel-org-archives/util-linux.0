Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.10]:58864 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588Ab2HVHDq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 22 Aug 2012 03:03:46 -0400
Message-ID: <5034844F.1040501@bernhard-voelker.de>
Date: Wed, 22 Aug 2012 09:03:43 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH] fdisk: fix typo in comment
References: <1345562793-25246-1-git-send-email-mail@bernhard-voelker.de>
In-Reply-To: <1345562793-25246-1-git-send-email-mail@bernhard-voelker.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Re-adding the list.

On 08/21/2012 05:37 PM, Pádraig Brady wrote:
> On 08/21/2012 04:26 PM, Bernhard Voelker wrote:
>> * fdisks/utils.c: s/firts/first/. Found by misspellings.

> Might as well s/Zero's/Zeros/ while at it.
> 
> cheers,
> Pádraig.

Here is the amended patch.

Have a nice day,
Berny


>From 248962be6fa942da5e49f96f8ac560d803d4bb60 Mon Sep 17 00:00:00 2001
From: Bernhard Voelker <mail@bernhard-voelker.de>
Date: Wed, 22 Aug 2012 08:59:43 +0200
Subject: [PATCH] fdisk: fix typo in comment
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

* fdisks/utils.c: s/firts/first/: found by misspellings.
s/Zero's/Zeros/: denoted by Pádraig Brady <P@draigBrady.com>.

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
 fdisks/utils.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fdisks/utils.c b/fdisks/utils.c
index 84cdd4d..85e09c5 100644
--- a/fdisks/utils.c
+++ b/fdisks/utils.c
@@ -317,7 +317,7 @@ static int __discover_topology(struct fdisk_context *cxt)
  * fdisk_zeroize_firstsector:
  * @cxt: fdisk context
  *
- * Zero's in-memory firts sector buffer
+ * Zeros in-memory first sector buffer
  */
 void fdisk_zeroize_firstsector(struct fdisk_context *cxt)
 {
-- 
1.7.7

