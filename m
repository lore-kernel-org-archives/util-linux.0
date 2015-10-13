Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37225 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932079AbbJML3Z (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 13 Oct 2015 07:29:25 -0400
Received: by wijq8 with SMTP id q8so27288329wij.0
        for <util-linux@vger.kernel.org>; Tue, 13 Oct 2015 04:29:24 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 3/8] libuuid: add uuid_generate_file() function
Date: Tue, 13 Oct 2015 12:29:09 +0100
Message-Id: <1444735754-18976-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1444735754-18976-1-git-send-email-kerolasa@iki.fi>
References: <1444735754-18976-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The uuid_generate_file() allows generating UUID using input file, and thus
leading to stable output.  Purpose of this function is to have a facility
that allows tests to be wrote.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libuuid/man/uuid_generate.3 | 11 +++++++++++
 libuuid/src/gen_uuid.c      | 21 +++++++++++++++++++++
 libuuid/src/libuuid.sym     |  8 ++++++++
 libuuid/src/uuid.h          |  2 ++
 4 files changed, 42 insertions(+)

diff --git a/libuuid/man/uuid_generate.3 b/libuuid/man/uuid_generate.3
index 19904d7..53045c0 100644
--- a/libuuid/man/uuid_generate.3
+++ b/libuuid/man/uuid_generate.3
@@ -41,6 +41,7 @@ uuid_generate_time_safe \- create a new unique UUID value
 .BI "void uuid_generate_random(uuid_t " out );
 .BI "void uuid_generate_time(uuid_t " out );
 .BI "int uuid_generate_time_safe(uuid_t " out );
+.BI "int uuid_generate_file(uuid_t " out ", const char " *path ");"
 .fi
 .SH DESCRIPTION
 The
@@ -100,11 +101,21 @@ the universe according to Carl Sagan's
 The new UUID can reasonably be considered unique among all UUIDs created
 on the local system, and among UUIDs created on other systems in the past
 and in the future.
+.sp
+The
+.B uuid_generate_file
+function will read up to 16 bytes from beginning of a file as a not-random
+source of UUID.  Purpose of this function is to provide a facility that will
+always return the same UUID, and thus is ideal for testing.
 .SH RETURN VALUE
 The newly created UUID is returned in the memory location pointed to by
 .IR out .
 .B uuid_generate_time_safe
 returns zero if the UUID has been generated in a safe manner, \-1 otherwise.
+The
+.B uuid_generate_file
+will return zero for success, or 1 when errno indicates an error with file
+defined by path.
 .SH "CONFORMING TO"
 OSF DCE 1.1
 .SH AUTHOR
diff --git a/libuuid/src/gen_uuid.c b/libuuid/src/gen_uuid.c
index 4d60997..cf164fb 100644
--- a/libuuid/src/gen_uuid.c
+++ b/libuuid/src/gen_uuid.c
@@ -551,3 +551,24 @@ void uuid_generate(uuid_t out)
 	else
 		uuid_generate_time(out);
 }
+
+/*
+ * Generate file-based UUID and store it to @out.  Useful for testing.
+ *
+ */
+int uuid_generate_file(uuid_t out, const char *path)
+{
+	int fd;
+	uuid_t buf = { 0 };
+	struct uuid uu = { 0 };
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return 1;
+	if ((read(fd, &buf, sizeof(buf))) < 0)
+		return 1;
+	close(fd);
+	uuid_unpack(buf, &uu);
+	uuid_pack(&uu, out);
+	return 0;
+}
diff --git a/libuuid/src/libuuid.sym b/libuuid/src/libuuid.sym
index 28a2076..ead4046 100644
--- a/libuuid/src/libuuid.sym
+++ b/libuuid/src/libuuid.sym
@@ -34,6 +34,14 @@ global:
 	uuid_generate_time_safe;
 } UUID_1.0;
 
+/*
+ * version(s) since util-linux 2.28
+ */
+UUID_2.28 {
+global:
+	uuid_generate_file;
+} UUID_2.20;
+
 
 /*
  * __uuid_* this is not part of the official API, this is
diff --git a/libuuid/src/uuid.h b/libuuid/src/uuid.h
index 30bd4c0..f3f117a 100644
--- a/libuuid/src/uuid.h
+++ b/libuuid/src/uuid.h
@@ -52,6 +52,7 @@ typedef unsigned char uuid_t[16];
 /* UUID Type definitions */
 #define UUID_TYPE_DCE_TIME   1
 #define UUID_TYPE_DCE_RANDOM 4
+#define UUID_TYPE_DCE_FILE   8
 
 /* Allow UUID constants to be defined */
 #ifdef __GNUC__
@@ -80,6 +81,7 @@ extern void uuid_generate(uuid_t out);
 extern void uuid_generate_random(uuid_t out);
 extern void uuid_generate_time(uuid_t out);
 extern int uuid_generate_time_safe(uuid_t out);
+extern int uuid_generate_file(uuid_t out, const char *path);
 
 /* isnull.c */
 extern int uuid_is_null(const uuid_t uu);
-- 
2.6.1

