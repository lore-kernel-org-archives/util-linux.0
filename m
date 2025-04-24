Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629FB1E5B70
	for <util-linux@vger.kernel.org>; Thu, 24 Apr 2025 09:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745487220; cv=none; b=Sn2v/rfqdf9RcBSpwTp8l7wOEyTSWUznwjjn9piBvrCzVpBdYIU81w4HjJsdMEu3xxe25ZO0s4+hAHvZjwwiCxdDgCdwW3d8JEQuTg1KF2BH8qJGVGMN5Rrcg9sLmKzFH0DnKHIdDccXniTz7q5JqHxMwlPp6BrYWNp3g+/rcAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745487220; c=relaxed/simple;
	bh=v3IIDsuQtc+i1fh6DPXgdXEFengDHWFsMdOnwudWdQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sy6aCdKuykb6PFymd3tGbZWpCqjq7aWCuObiuR3lFW5gw8ebshN3ycWLEMcanWoQPUdYPRZz4xEw/S4hAEEd4lslfu+yQ25TKlIUQWxTq6Yz1397xO665jOsnO8cUb7KWEx75Umh3tiG63zAGDaBYyHkIJhB+EDjWWubO5oKdbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=UcfBjkIw; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="UcfBjkIw"
X-KPN-MessageId: 591c0672-20ef-11f0-b9a0-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 591c0672-20ef-11f0-b9a0-005056abbe64;
	Thu, 24 Apr 2025 11:34:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=2GNVShXTIrNxbXwBr3TOS/Hq76EnYqeF/XOpXUcox4c=;
	b=UcfBjkIwX/V+m3g6dIPPsUIE8LVvhGBrz6Phm3hjcCrxpA23N6v9Z+LbrogwWB6yyOLVzrCeiC7UB
	 JBAqz4kYRT6FuEGSbcn+jtWQyh09pR5iTLspTULywbrsAwjow1NkWSz1+kHOrP3abbGuivQMT2EwDx
	 7wbYtZUnRk6xK2DU=
X-KPN-MID: 33|0AXeE6ijfaANiRpSQxdutc6lG2WP1bTrGCH1+HhBE02JlrEquuNjh8E+ha5zuab
 3zA2UhhFYxjaMq87noGGcA4wb0mxuwUQ1vekNbmVRJM8=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|FrHvpiph7Elk1WbNumK4XmCr/B5BDNFo9KkaJNilzwmaT5E7U6CBsQHPlr0hsk9
 WP+dj3NShNtDLblb221isPQ==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 31ccdf3e-20ef-11f0-9b82-005056ab1411;
	Thu, 24 Apr 2025 11:33:35 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Michael Trapp <michael.trapp@sap.com>
Subject: [PATCH 7/7] uuidd: put an option and its description in a single message
Date: Thu, 24 Apr 2025 11:32:37 +0200
Message-ID: <20250424093237.6432-7-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250424093237.6432-1-bensberg@telfort.nl>
References: <20250424093237.6432-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also, improve the markup and the wording in the man page.

CC: Michael Trapp <michael.trapp@sap.com>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc-utils/uuidd.8.adoc | 16 ++++++++++++----
 misc-utils/uuidd.c      |  4 ++--
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/misc-utils/uuidd.8.adoc b/misc-utils/uuidd.8.adoc
index f8001f986..f15d7b631 100644
--- a/misc-utils/uuidd.8.adoc
+++ b/misc-utils/uuidd.8.adoc
@@ -24,12 +24,20 @@ The *uuidd* daemon is used by the UUID library to generate universally unique id
 
 == OPTIONS
 
-*-C*, *--cont-clock*[**=**_time_]::
-Activate continuous clock handling for time based UUIDs. *uuidd* could use all possible clock values, beginning with the daemon's start time. The optional argument can be used to set a value for the max_clock_offset. This guarantees, that a clock value of a UUID will always be within the range of the max_clock_offset.
+*-C*, *--cont-clock*[**=**_number_[*hd*]]::
+Activate continuous clock handling for time-based UUIDs. *uuidd* could
+use all possible clock values, beginning with the daemon's start time.
+The optional argument can be used to set a value for 'max_clock_offset'.
+This guarantees that a clock value of a UUID will always be within the
+range of 'max_clock_offset'.
 +
-The option *-C* or *--cont-clock* enables the feature with a default max_clock_offset of 2 hours.
+The option *-C* or *--cont-clock* (without an argument) enables the
+feature with a default 'max_clock_offset' of 2 hours.
 +
-The option *-C<NUM>[hd]* or *--cont-clock=<NUM>[hd]* enables the feature with a max_clock_offset of NUM seconds. In case of an appended h or d, the NUM value is read in hours or days. The minimum value is 60 seconds, the maximum value is 365 days.
+The option **-C**_number_ or **--cont-clock=**_number_ enables the
+feature with a 'max_clock_offset' of _number_ seconds.
+In case of an appended *h* or *d*, _number_ is understood in hours or days.
+The minimum value is 60 seconds, the maximum value is 365 days.
 
 *-d*, *--debug*::
 Run *uuidd* in debugging mode. This prevents *uuidd* from running as a daemon.
diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index 961c3a5fa..74e950307 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -108,8 +108,8 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -P, --no-pid            do not create pid file\n"), out);
 	fputs(_(" -F, --no-fork           do not daemonize using double-fork\n"), out);
 	fputs(_(" -S, --socket-activation do not create listening socket\n"), out);
-	fputs(_(" -C, --cont-clock[=<NUM>[hd]]\n"), out);
-	fputs(_("                         activate continuous clock handling\n"), out);
+	fputs(_(" -C, --cont-clock[=<number>[hd]]\n"
+		"                         activate continuous clock handling\n"), out);
 	fputs(_(" -d, --debug             run in debugging mode\n"), out);
 	fputs(_(" -q, --quiet             turn on quiet mode\n"), out);
 	fputs(USAGE_SEPARATOR, out);
-- 
2.48.1

