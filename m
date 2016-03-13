Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:65331 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754276AbcCMWbZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 13 Mar 2016 18:31:25 -0400
Received: from tenfore.ga-group.nl ([2.247.85.77]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0MMYZG-1alIHN0ukQ-008GTz for
 <util-linux@vger.kernel.org>; Sun, 13 Mar 2016 23:31:23 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 03/12] tests: skip old socat silently
Date: Sun, 13 Mar 2016 23:31:11 +0100
Message-Id: <1457908280-15588-4-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1457908280-15588-1-git-send-email-sweet_f_a@gmx.de>
References: <1457908280-15588-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

I've seen enough logs with verbose socat output for now. Let's
make it quiet.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/functions.sh | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tests/functions.sh b/tests/functions.sh
index 74622b0..5246605 100644
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -699,22 +699,23 @@ function ts_init_socket_to_file {
 	ts_check_prog "socat"
 	rm -f "$socket" "$outfile"
 
+	# if socat is too old for these options we'll skip it below
 	socat -u UNIX-LISTEN:$socket,fork,max-children=1,backlog=128 \
-		STDOUT > "$outfile" &
+		STDOUT > "$outfile" 2>/dev/null &
 	pid=$!
 
 	# check for running background process
-	if [ "$pid" -le "0" ] || ! kill -s 0 "$pid"; then
+	if [ "$pid" -le "0" ] || ! kill -s 0 "$pid" &>/dev/null; then
 		ts_skip "unable to run socat"
 	fi
 	# wait for the socket listener
-	if ! socat -u /dev/null UNIX-CONNECT:$socket,retry=30,interval=0.1; then
-		kill -9 "$pid"
-		ts_skip "timeout waiting for socket"
+	if ! socat -u /dev/null UNIX-CONNECT:$socket,retry=30,interval=0.1 &>/dev/null; then
+		kill -9 "$pid" &>/dev/null
+		ts_skip "timeout waiting for socat socket"
 	fi
 	# check socket again
-	if ! socat -u /dev/null UNIX-CONNECT:$socket; then
-		kill -9 "$pid"
-		ts_skip "socket stopped listening"
+	if ! socat -u /dev/null UNIX-CONNECT:$socket &>/dev/null; then
+		kill -9 "$pid" &>/dev/null
+		ts_skip "socat socket stopped listening"
 	fi
 }
-- 
1.8.4.5

