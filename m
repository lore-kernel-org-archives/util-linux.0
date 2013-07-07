Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ea0-f171.google.com ([209.85.215.171]:43300 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab3GGTzi (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Jul 2013 15:55:38 -0400
Received: by mail-ea0-f171.google.com with SMTP id m14so2476603eaj.16
        for <util-linux@vger.kernel.org>; Sun, 07 Jul 2013 12:55:37 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 14/34] ipcs: assigned values are never read [clang-analyzer]
Date: Sun,  7 Jul 2013 20:54:29 +0100
Message-Id: <1373226889-3451-15-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/ipcs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
index 14f5f0b..16e5206 100644
--- a/sys-utils/ipcs.c
+++ b/sys-utils/ipcs.c
@@ -278,7 +278,6 @@ static void do_shm (char format, int unit)
 	 */
 	if (ipc_shm_get_info(-1, &shmds) < 1)
 		return;
-	shmdsp = shmds;
 
 	for (shmdsp = shmds; shmdsp->next != NULL; shmdsp = shmdsp->next) {
 		if (format == CREATOR)  {
@@ -396,7 +395,6 @@ static void do_sem (char format)
 	 */
 	if (ipc_sem_get_info(-1, &semds) < 1)
 		return;
-	semdsp = semds;
 
 	for (semdsp = semds; semdsp->next != NULL; semdsp = semdsp->next) {
 		if (format == CREATOR)  {
@@ -501,7 +499,6 @@ static void do_msg (char format, int unit)
 	 */
 	if (ipc_msg_get_info(-1, &msgds) < 1)
 		return;
-	msgdsp = msgds;
 
 	for (msgdsp = msgds; msgdsp->next != NULL; msgdsp = msgdsp->next) {
 		if (format == CREATOR) {
-- 
1.8.3.2

