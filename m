Return-Path: util-linux-owner@vger.kernel.org
Received: from c-83-233-174-181.cust.bredband2.com ([83.233.174.181]:56176
        "EHLO pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759727AbcLBOK2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 2 Dec 2016 09:10:28 -0500
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Patrick Pelissier <patrick.pelissier@gmail.com>,
        Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH] chrt: default to SCHED_RR policy
Date: Fri,  2 Dec 2016 15:10:18 +0100
Message-Id: <1480687818-16387-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This fixes a regression introduced in:

commit 7a4ea5664edba98bff28adec3a9c3cfb5763a495
"chrt: add control struct"

Previously (and as documented in the manpage) the default policy
was SCHED_RR. Now it's implicitly SCHED_OTHER (0) as the value
is not initialized explicitly anymore.

Test-command: chrt 90 echo hello

Reported-by: Patrick Pelissier <patrick.pelissier@gmail.com>
Addresses: http://bugs.debian.org/846572
Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 schedutils/chrt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index a861d9f..73d1ffa 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -409,7 +409,7 @@ static void set_sched(struct chrt_ctl *ctl)
 
 int main(int argc, char **argv)
 {
-	struct chrt_ctl _ctl = { .pid = -1 }, *ctl = &_ctl;
+	struct chrt_ctl _ctl = { .pid = -1, .policy = SCHED_RR }, *ctl = &_ctl;
 	int c;
 
 	static const struct option longopts[] = {
-- 
2.10.2

