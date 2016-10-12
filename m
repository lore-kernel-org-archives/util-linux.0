Return-Path: heiko.carstens@de.ibm.com
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: [PATCH 1/4] lib,strutils: add strtoux[16|32|64]_or_err functions
Date: Wed, 12 Oct 2016 14:00:44 +0200
In-Reply-To: <20161012120047.60732-1-heiko.carstens@de.ibm.com>
References: <20161012120047.60732-1-heiko.carstens@de.ibm.com>
Message-Id: <20161012120047.60732-2-heiko.carstens@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

Add helper functions which allow to parse hexadecimal numbers.
Based on a patch from Clemens von Mann.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 include/strutils.h |  3 +++
 lib/strutils.c     | 44 ++++++++++++++++++++++++++++++++++++++------
 2 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/include/strutils.h b/include/strutils.h
index 51d9c9ff3553..aa31fc984c75 100644
--- a/include/strutils.h
+++ b/include/strutils.h
@@ -21,12 +21,15 @@ extern uintmax_t strtosize_or_err(const char *str, const char *errmesg);
 
 extern int16_t strtos16_or_err(const char *str, const char *errmesg);
 extern uint16_t strtou16_or_err(const char *str, const char *errmesg);
+extern uint16_t strtox16_or_err(const char *str, const char *errmesg);
 
 extern int32_t strtos32_or_err(const char *str, const char *errmesg);
 extern uint32_t strtou32_or_err(const char *str, const char *errmesg);
+extern uint32_t strtox32_or_err(const char *str, const char *errmesg);
 
 extern int64_t strtos64_or_err(const char *str, const char *errmesg);
 extern uint64_t strtou64_or_err(const char *str, const char *errmesg);
+extern uint64_t strtox64_or_err(const char *str, const char *errmesg);
 
 extern double strtod_or_err(const char *str, const char *errmesg);
 
diff --git a/lib/strutils.c b/lib/strutils.c
index d3b998f023bf..8a52be048210 100644
--- a/lib/strutils.c
+++ b/lib/strutils.c
@@ -264,6 +264,9 @@ char *strndup(const char *s, size_t n)
 }
 #endif
 
+static uint32_t _strtou32_or_err(const char *str, const char *errmesg, int base);
+static uint64_t _strtou64_or_err(const char *str, const char *errmesg, int base);
+
 int16_t strtos16_or_err(const char *str, const char *errmesg)
 {
 	int32_t num = strtos32_or_err(str, errmesg);
@@ -275,9 +278,9 @@ int16_t strtos16_or_err(const char *str, const char *errmesg)
 	return num;
 }
 
-uint16_t strtou16_or_err(const char *str, const char *errmesg)
+static uint16_t _strtou16_or_err(const char *str, const char *errmesg, int base)
 {
-	uint32_t num = strtou32_or_err(str, errmesg);
+	uint32_t num = _strtou32_or_err(str, errmesg, base);
 
 	if (num > UINT16_MAX) {
 		errno = ERANGE;
@@ -286,6 +289,16 @@ uint16_t strtou16_or_err(const char *str, const char *errmesg)
 	return num;
 }
 
+uint16_t strtou16_or_err(const char *str, const char *errmesg)
+{
+	return _strtou16_or_err(str, errmesg, 10);
+}
+
+uint16_t strtox16_or_err(const char *str, const char *errmesg)
+{
+	return _strtou16_or_err(str, errmesg, 16);
+}
+
 int32_t strtos32_or_err(const char *str, const char *errmesg)
 {
 	int64_t num = strtos64_or_err(str, errmesg);
@@ -297,9 +310,9 @@ int32_t strtos32_or_err(const char *str, const char *errmesg)
 	return num;
 }
 
-uint32_t strtou32_or_err(const char *str, const char *errmesg)
+static uint32_t _strtou32_or_err(const char *str, const char *errmesg, int base)
 {
-	uint64_t num = strtou64_or_err(str, errmesg);
+	uint64_t num = _strtou64_or_err(str, errmesg, base);
 
 	if (num > UINT32_MAX) {
 		errno = ERANGE;
@@ -308,6 +321,16 @@ uint32_t strtou32_or_err(const char *str, const char *errmesg)
 	return num;
 }
 
+uint32_t strtou32_or_err(const char *str, const char *errmesg)
+{
+	return _strtou32_or_err(str, errmesg, 10);
+}
+
+uint32_t strtox32_or_err(const char *str, const char *errmesg)
+{
+	return _strtou32_or_err(str, errmesg, 16);
+}
+
 int64_t strtos64_or_err(const char *str, const char *errmesg)
 {
 	int64_t num;
@@ -329,7 +352,7 @@ err:
 	errx(STRTOXX_EXIT_CODE, "%s: '%s'", errmesg, str);
 }
 
-uint64_t strtou64_or_err(const char *str, const char *errmesg)
+static uint64_t _strtou64_or_err(const char *str, const char *errmesg, int base)
 {
 	uintmax_t num;
 	char *end = NULL;
@@ -337,7 +360,7 @@ uint64_t strtou64_or_err(const char *str, const char *errmesg)
 	errno = 0;
 	if (str == NULL || *str == '\0')
 		goto err;
-	num = strtoumax(str, &end, 10);
+	num = strtoumax(str, &end, base);
 
 	if (errno || str == end || (end && *end))
 		goto err;
@@ -350,6 +373,15 @@ err:
 	errx(STRTOXX_EXIT_CODE, "%s: '%s'", errmesg, str);
 }
 
+uint64_t strtou64_or_err(const char *str, const char *errmesg)
+{
+	return _strtou64_or_err(str, errmesg, 10);
+}
+
+uint64_t strtox64_or_err(const char *str, const char *errmesg)
+{
+	return _strtou64_or_err(str, errmesg, 16);
+}
 
 double strtod_or_err(const char *str, const char *errmesg)
 {
-- 
2.8.4
