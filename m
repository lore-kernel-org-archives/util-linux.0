Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37634 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753071AbdKXKbZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 24 Nov 2017 05:31:25 -0500
From: Masatake YAMATO <yamato@redhat.com>
To: util-linux@vger.kernel.org
Cc: yamato@redhat.com
Subject: [PATCH v2 2/7] lsns: disable netnsid column by default
Date: Fri, 24 Nov 2017 19:31:04 +0900
Message-Id: <20171124103110.17077-3-yamato@redhat.com>
In-Reply-To: <20171124103110.17077-1-yamato@redhat.com>
References: <20171124103110.17077-1-yamato@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Enable only when

* --type=net is given, or
* -o NETNSID is given.

Suggested by Karel Zak.

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 sys-utils/lsns.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/sys-utils/lsns.c b/sys-utils/lsns.c
index 7ccc733a4..bb7d3956d 100644
--- a/sys-utils/lsns.c
+++ b/sys-utils/lsns.c
@@ -839,6 +839,7 @@ int main(int argc, char *argv[])
 		{ 0 }
 	};
 	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
+	bool enabling_netnsid = false;
 
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
@@ -891,6 +892,8 @@ int main(int argc, char *argv[])
 				errx(EXIT_FAILURE, _("unknown namespace type: %s"), optarg);
 			ls.fltr_types[type] = 1;
 			ls.fltr_ntypes++;
+			if (type == LSNS_ID_NET)
+				enabling_netnsid = true;
 			break;
 		}
 		default:
@@ -900,6 +903,7 @@ int main(int argc, char *argv[])
 
 	if (!ls.fltr_ntypes) {
 		size_t i;
+
 		for (i = 0; i < ARRAY_SIZE(ns_names); i++)
 			ls.fltr_types[i] = 1;
 	}
@@ -924,14 +928,24 @@ int main(int argc, char *argv[])
 		columns[ncolumns++] = COL_NPROCS;
 		columns[ncolumns++] = COL_PID;
 		columns[ncolumns++] = COL_USER;
-		columns[ncolumns++] = COL_NETNSID;
+		if (enabling_netnsid)
+			columns[ncolumns++] = COL_NETNSID;
 		columns[ncolumns++] = COL_COMMAND;
 	}
 
-	if (outarg && string_add_to_idarray(outarg, columns, ARRAY_SIZE(columns),
-					 &ncolumns, column_name_to_id) < 0)
-		return EXIT_FAILURE;
+	if (outarg) {
+		size_t i;
 
+		if (string_add_to_idarray(outarg, columns, ARRAY_SIZE(columns),
+					  &ncolumns, column_name_to_id) < 0)
+			return EXIT_FAILURE;
+		for (i = 0; i < ncolumns; i++) {
+			if (columns[i] == COL_NETNSID) {
+				enabling_netnsid = true;
+				break;
+			}
+		}
+	}
 	scols_init_debug(0);
 
 	uid_cache = new_idcache();
@@ -939,7 +953,8 @@ int main(int argc, char *argv[])
 		err(EXIT_FAILURE, _("failed to allocate UID cache"));
 
 #ifdef HAVE_LINUX_NET_NAMESPACE_H
-	netlink_fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
+	if (enabling_netnsid)
+		netlink_fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
 #endif
 	r = read_processes(&ls);
 	if (!r)
-- 
2.13.6

