Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:45673 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755781Ab1FPN7n (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 16 Jun 2011 09:59:43 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 227018AD27
	for <util-linux@vger.kernel.org>; Thu, 16 Jun 2011 15:59:42 +0200 (CEST)
From: Ludwig Nussel <ludwig.nussel@suse.de>
To: util-linux@vger.kernel.org
Cc: Ludwig Nussel <ludwig.nussel@suse.de>
Subject: [PATCH 4/4] update manpage
Date: Thu, 16 Jun 2011 15:59:39 +0200
Message-Id: <1308232779-21018-4-git-send-email-ludwig.nussel@suse.de>
In-Reply-To: <1308232779-21018-1-git-send-email-ludwig.nussel@suse.de>
References: <1308232779-21018-1-git-send-email-ludwig.nussel@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

---
 libuuid/man/Makefile.am     |    2 +-
 libuuid/man/uuid_generate.3 |   28 ++++++++++------------------
 misc-utils/uuidgen.1        |   11 ++++++++---
 3 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/libuuid/man/Makefile.am b/libuuid/man/Makefile.am
index 8e9ed6d..3880952 100644
--- a/libuuid/man/Makefile.am
+++ b/libuuid/man/Makefile.am
@@ -3,7 +3,7 @@ include $(top_srcdir)/config/include-Makefile.am
 dist_man_MANS = uuid.3 uuid_clear.3 uuid_compare.3 uuid_copy.3 uuid_generate.3 \
 		uuid_is_null.3 uuid_parse.3 uuid_time.3 uuid_unparse.3
 
-UUID_GENERATE_LINKS = uuid_generate_random.3 uuid_generate_time.3 uuid_generate_time_safe.3
+UUID_GENERATE_LINKS = uuid_generate_random.3 uuid_generate_time.3
 
 man_MANS = $(UUID_GENERATE_LINKS)
 CLEANFILES = $(man_MANS)
diff --git a/libuuid/man/uuid_generate.3 b/libuuid/man/uuid_generate.3
index 8185056..2b799ee 100644
--- a/libuuid/man/uuid_generate.3
+++ b/libuuid/man/uuid_generate.3
@@ -31,16 +31,15 @@
 .\" Created  Wed Mar 10 17:42:12 1999, Andreas Dilger
 .TH UUID_GENERATE 3 "May 2009" "util-linux" "Libuuid API"
 .SH NAME
-uuid_generate, uuid_generate_random, uuid_generate_time,
-uuid_generate_time_safe \- create a new unique UUID value
+uuid_generate, uuid_generate_random, uuid_generate_time
+\- create a new unique UUID value
 .SH SYNOPSIS
 .nf
 .B #include <uuid/uuid.h>
 .sp
-.BI "void uuid_generate(uuid_t " out );
-.BI "void uuid_generate_random(uuid_t " out );
-.BI "void uuid_generate_time(uuid_t " out );
-.BI "int uuid_generate_time_safe(uuid_t " out );
+.BI "int uuid_generate(uuid_t " out );
+.BI "int uuid_generate_random(uuid_t " out );
+.BI "int uuid_generate_time(uuid_t " out );
 .fi
 .SH DESCRIPTION
 The
@@ -82,16 +81,7 @@ to this file) and/or the
 daemon, if it is running already or can be be spawned by the process (if
 installed and the process has enough permissions to run it).  If neither of
 these two synchronization mechanisms can be used, it is theoretically possible
-that two concurrently running processes obtain the same UUID(s).  To tell
-whether the UUID has been generated in a safe manner, use
-.BR uuid_generate_time_safe .
-.sp
-The
-.B uuid_generate_time_safe
-is similar to
-.BR uuid_generate_time ,
-except that it returns a value which denotes whether any of the synchronization
-mechanisms (see above) has been used.
+that two concurrently running processes obtain the same UUID(s).
 .sp
 The UUID is 16 bytes (128 bits) long, which gives approximately 3.4x10^38
 unique values (there are approximately 10^80 elementary particles in
@@ -101,12 +91,14 @@ The new UUID can reasonably be considered unique among all UUIDs created
 on the local system, and among UUIDs created on other systems in the past
 and in the future.
 .SH RETURN VALUE
+The functions return zero if the UUID has been generated in a safe manner and -1
+if the UUID is potentially weak.
 The newly created UUID is returned in the memory location pointed to by
 .IR out .
-.B uuid_generate_time_safe
-returns zero if the UUID has been generated in a safe manner, -1 otherwise.
 .SH "CONFORMING TO"
 OSF DCE 1.1
+.sp
+In the original implementation the functions did not have a return value.
 .SH AUTHOR
 Theodore Y. Ts'o
 .SH AVAILABILITY
diff --git a/misc-utils/uuidgen.1 b/misc-utils/uuidgen.1
index 453a7f5..efb6d9b 100644
--- a/misc-utils/uuidgen.1
+++ b/misc-utils/uuidgen.1
@@ -37,15 +37,20 @@ or
 options.
 .SH OPTIONS
 .TP
-.B \-r
+.B \-r, \-\-random
 Generate a random-based UUID.  This method creates a UUID consisting mostly
 of random bits.  It requires that the operating system have a high
 quality random number generator, such as
 .IR /dev/random .
 .TP
-.B \-t
+.B \-t, \-\-time
 Generate a time-based UUID.  This method creates a UUID based on the system
-clock plus the system's ethernet hardware address, if present.
+clock plus the system's ethernet hardware address, if present. uuidd must be
+running to make sure no duplicate uuids are generated. 
+.TP
+.B \-\-force
+Force generating a UUID even if it's potentially weak, ie
+/dev/[u]random not available or uuidd not running.
 .SH "CONFORMING TO"
 OSF DCE 1.1
 .SH AUTHOR
-- 
1.7.3.4

