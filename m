Return-Path: util-linux-owner@vger.kernel.org
Received: from smtprelay-b32.telenor.se ([213.150.131.21]:40793 "EHLO
	smtprelay-b32.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934106AbaGXT3M (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 24 Jul 2014 15:29:12 -0400
Received: from ipb5.telenor.se (ipb5.telenor.se [195.54.127.168])
	by smtprelay-b32.telenor.se (Postfix) with ESMTP id 3CF7AEC40E
	for <util-linux@vger.kernel.org>; Thu, 24 Jul 2014 21:29:09 +0200 (CEST)
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH] tests: Fall back on host/getent in ts_resolve_host
Date: Thu, 24 Jul 2014 21:28:44 +0200
Message-Id: <1406230124-22099-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Neither dig or nslookup would be my first option for resolving,
so add the host utility of ISC/bind fame and the (slow) getent
utility shipped with libc.

This extends the conditions introduced in ...

  commit a98de9696e1a898f925c9154e5693e73aec0779d
  Author: Ruediger Meier <ruediger.meier@ga-group.nl>
  Date:   Wed Jun 11 19:28:20 2014 +0200

      tests: skip some last tests if no dns support

... and should help us not skip certain tests when we have
network connection but none of dig or nslookup available.

Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 tests/functions.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/functions.sh b/tests/functions.sh
index 6998343..59107b0 100644
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -635,6 +635,12 @@ function ts_resolve_host {
 	elif type "nslookup" >/dev/null 2>&1; then
 		tmp=$(nslookup "$host" 2>/dev/null) || return 1
 		tmp=$(echo "$tmp"| grep -A1 "^Name:"| grep "^Address:"| cut -d" " -f2)
+	elif type "host" >/dev/null 2>&1; then
+		tmp=$(host "$host" 2>/dev/null) || return 1
+		tmp=$(echo "$tmp" | grep " has address " | cut -d " " -f4)
+	elif type "getent" >/dev/null 2>&1; then
+		tmp=$(getent ahosts "$host" 2>/dev/null) || return 1
+		tmp=$(echo "$tmp" | cut -d " " -f 1 | sort -u)
 	fi
 
 	# we return 1 if tmp is empty
-- 
2.0.1

