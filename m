Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59432 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753071AbdKXKbk (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 24 Nov 2017 05:31:40 -0500
From: Masatake YAMATO <yamato@redhat.com>
To: util-linux@vger.kernel.org
Cc: yamato@redhat.com
Subject: [PATCH v2 5/7] lsns: add --nowrap(-W) option
Date: Fri, 24 Nov 2017 19:31:08 +0900
Message-Id: <20171124103110.17077-7-yamato@redhat.com>
In-Reply-To: <20171124103110.17077-1-yamato@redhat.com>
References: <20171124103110.17077-1-yamato@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This option forces lsns command not use
multi-line presentation when printing a cell.

Currently, it affects only NSFS column.

Implementing this option is suggested by Karl Zak.

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 sys-utils/lsns.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sys-utils/lsns.c b/sys-utils/lsns.c
index c4d806e24..8af363317 100644
--- a/sys-utils/lsns.c
+++ b/sys-utils/lsns.c
@@ -173,7 +173,8 @@ struct lsns {
 		     tree	: 1,
 		     list	: 1,
 		     notrunc	: 1,
-		     no_headings: 1;
+		     no_headings: 1,
+		     no_wrap    : 1;
 
 	struct libmnt_table *tab;
 };
@@ -746,7 +747,7 @@ static void add_scols_line(struct lsns *ls, struct libscols_table *table,
 			break;
 		case COL_NSFS:
 			nsfs_xasputs(&str, ns, ls->tab,
-				     ls->raw ? ',' : '\n');
+				     (ls->raw || ls->no_wrap) ? ',' : '\n');
 			break;
 		default:
 			break;
@@ -786,6 +787,8 @@ static struct libscols_table *init_scols_table(struct lsns *ls)
 		       flags &= ~SCOLS_FL_TRUNC;
 		if (ls->tree && get_column_id(i) == COL_COMMAND)
 			flags |= SCOLS_FL_TREE;
+		if (ls->no_wrap)
+			flags &= ~SCOLS_FL_WRAP;
 
 		cl = scols_table_new_column(tab, col->name, col->whint, flags);
 		if (cl == NULL) {
@@ -891,6 +894,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -p, --task <pid>       print process namespaces\n"), out);
 	fputs(_(" -r, --raw              use the raw output format\n"), out);
 	fputs(_(" -u, --notruncate       don't truncate text in columns\n"), out);
+	fputs(_(" -W, --nowrap           don't use multi-line representation\n"), out);
 	fputs(_(" -t, --type <name>      namespace type (mnt, net, ipc, user, pid, uts, cgroup)\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
@@ -920,6 +924,7 @@ int main(int argc, char *argv[])
 		{ "notruncate", no_argument,       NULL, 'u' },
 		{ "version",    no_argument,       NULL, 'V' },
 		{ "noheadings", no_argument,       NULL, 'n' },
+		{ "nowrap",     no_argument,       NULL, 'W' },
 		{ "list",       no_argument,       NULL, 'l' },
 		{ "raw",        no_argument,       NULL, 'r' },
 		{ "type",       required_argument, NULL, 't' },
@@ -988,6 +993,9 @@ int main(int argc, char *argv[])
 				enabling_netnsid = true;
 			break;
 		}
+		case 'W':
+			ls.no_wrap = 1;
+			break;
 		default:
 			errtryhelp(EXIT_FAILURE);
 		}
-- 
2.13.6

