Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:29542 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752002Ab2GZNw2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Jul 2012 09:52:28 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q6QDqSXF026890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Thu, 26 Jul 2012 09:52:28 -0400
From: Milan Broz <mbroz@redhat.com>
To: util-linux@vger.kernel.org
Cc: Milan Broz <mbroz@redhat.com>
Subject: [PATCH 1/5] Add string_add_to_idarray() - parse and add to id list.
Date: Thu, 26 Jul 2012 15:52:04 +0200
Message-Id: <1343310728-16624-1-git-send-email-mbroz@redhat.com>
In-Reply-To: <1343304884-14297-1-git-send-email-mbroz@redhat.com>
References: <1343304884-14297-1-git-send-email-mbroz@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Milan Broz <mbroz@redhat.com>
---
 include/strutils.h |    4 ++++
 lib/strutils.c     |   26 ++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/strutils.h b/include/strutils.h
index 57b13fd..123907f 100644
--- a/include/strutils.h
+++ b/include/strutils.h
@@ -59,6 +59,10 @@ extern char *size_to_human_string(int options, uint64_t bytes);
 
 extern int string_to_idarray(const char *list, int ary[], size_t arysz,
 			   int (name2id)(const char *, size_t));
+extern int string_add_to_idarray(const char *list, int ary[],
+				 size_t arysz, int *ary_pos,
+				 int (name2id)(const char *, size_t));
+
 extern int string_to_bitarray(const char *list, char *ary,
 			    int (*name2bit)(const char *, size_t));
 
diff --git a/lib/strutils.c b/lib/strutils.c
index 036ae06..df31682 100644
--- a/lib/strutils.c
+++ b/lib/strutils.c
@@ -479,6 +479,32 @@ int string_to_idarray(const char *list, int ary[], size_t arysz,
 }
 
 /*
+ * Parses the array like string_to_idarray but if format is "+aaa,bbb"
+ * it adds fields to array instead of replacing them.
+ */
+int string_add_to_idarray(const char *list, int ary[], size_t arysz,
+			int *ary_pos, int (name2id)(const char *, size_t))
+{
+	const char *list_add;
+	int r;
+
+	if (!list || !*list || !ary_pos || *ary_pos < 0 | *ary_pos > (int)arysz)
+		return -1;
+
+	if (list[0] == '+')
+		list_add = &list[1];
+	else {
+		list_add = list;
+		*ary_pos = 0;
+	}
+
+	r = string_to_idarray(list_add, &ary[*ary_pos], arysz - *ary_pos, name2id);
+	if (r > 0)
+		*ary_pos += r;
+	return r;
+}
+
+/*
  * LIST ::= <item> [, <item>]
  *
  * The <item> is translated to 'id' by name2id() function and the 'id' is used
-- 
1.7.10.4

