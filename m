Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47864 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753071AbdKXKba (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 24 Nov 2017 05:31:30 -0500
From: Masatake YAMATO <yamato@redhat.com>
To: util-linux@vger.kernel.org
Cc: yamato@redhat.com
Subject: [PATCH v2 4/7] lsns: add nsfs column
Date: Fri, 24 Nov 2017 19:31:06 +0900
Message-Id: <20171124103110.17077-5-yamato@redhat.com>
In-Reply-To: <20171124103110.17077-1-yamato@redhat.com>
References: <20171124103110.17077-1-yamato@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

nsfs provides kernel level interface for assigning
logical name to a namespace. Following message is quoted
from git log of linux kernel:

    commit 0226f4923f6c9b40cfa1c1c1b19a6ac6b3924ead
    Author: Al Viro <viro@zeniv.linux.org.uk>
    Date:   Tue Dec 6 12:21:54 2011 -0500

	vfs: take /proc/*/mounts and friends to fs/proc_namespace.c

	rationale: that stuff is far tighter bound to fs/namespace.c than to
	the guts of procfs proper.

	Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

/proc/self/mountinfo lists the logical names for namespaces:
  ...
  652 81 0:3 net:[4026532579] /tmp/XYZ rw shared:192 - nsfs nsfs rw,seclabel
  ...

In the lines /tmp/XYZ is a logical name for 4026532579 of net
namespace.

This patch adds nsfs column. It seems that the logical name is
used only in "ip netns" now. So the column is disabled by default.
Use '--type=net' or '-o NSFS' options to enable it.

This feature and the way to implementation using multi lines in a column
is Suggested by Karel Zak.

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 sys-utils/Makemodule.am |   4 +-
 sys-utils/lsns.c        | 108 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 106 insertions(+), 6 deletions(-)

diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index a85987c8e..b5b1d4f15 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -260,8 +260,8 @@ if BUILD_LSNS
 usrbin_exec_PROGRAMS += lsns
 dist_man_MANS += sys-utils/lsns.8
 lsns_SOURCES =	sys-utils/lsns.c
-lsns_LDADD = $(LDADD) libcommon.la libsmartcols.la
-lsns_CFLAGS = $(AM_CFLAGS) -I$(ul_libsmartcols_incdir)
+lsns_LDADD = $(LDADD) libcommon.la libsmartcols.la libmount.la
+lsns_CFLAGS = $(AM_CFLAGS) -I$(ul_libsmartcols_incdir) -I$(ul_libmount_incdir)
 endif
 
 
diff --git a/sys-utils/lsns.c b/sys-utils/lsns.c
index bb7d3956d..c4d806e24 100644
--- a/sys-utils/lsns.c
+++ b/sys-utils/lsns.c
@@ -28,6 +28,7 @@
 #include <sys/types.h>
 #include <wchar.h>
 #include <libsmartcols.h>
+#include <libmount.h>
 
 #ifdef HAVE_LINUX_NET_NAMESPACE_H
 #include <stdbool.h>
@@ -78,7 +79,8 @@ enum {
 	COL_COMMAND,
 	COL_UID,
 	COL_USER,
-	COL_NETNSID
+	COL_NETNSID,
+	COL_NSFS,
 };
 
 /* column names */
@@ -100,7 +102,8 @@ static const struct colinfo infos[] = {
 	[COL_COMMAND] = { "COMMAND", 0, SCOLS_FL_TRUNC, N_("command line of the PID")},
 	[COL_UID]     = { "UID",     0, SCOLS_FL_RIGHT, N_("UID of the PID")},
 	[COL_USER]    = { "USER",    0, 0, N_("username of the PID")},
-	[COL_NETNSID] = { "NETNSID", 0, SCOLS_FL_RIGHT, N_("Net namespace ID")}
+	[COL_NETNSID] = { "NETNSID", 0, SCOLS_FL_RIGHT, N_("Net namespace ID")},
+	[COL_NSFS]    = { "NSFS",    0, SCOLS_FL_WRAP, N_("Logical name established by nsfs")}
 };
 
 static int columns[ARRAY_SIZE(infos) * 2];
@@ -171,6 +174,8 @@ struct lsns {
 		     list	: 1,
 		     notrunc	: 1,
 		     no_headings: 1;
+
+	struct libmnt_table *tab;
 };
 
 struct netnsid_cache {
@@ -612,6 +617,80 @@ static int read_namespaces(struct lsns *ls)
 	return 0;
 }
 
+static int find_nsfs_in_tab(struct libmnt_fs *fs, void *data)
+{
+	return (mnt_fs_match_fstype(fs, "nsfs") &&
+		(strcmp(mnt_fs_get_root(fs), (char *)data) == 0));
+}
+
+static bool str_includes_path(const char *path_set, const char *elt,
+			      const char sep)
+{
+	size_t elt_len;
+	size_t path_set_len;
+	char *tmp;
+
+
+	tmp = strstr(path_set, elt);
+	if (!tmp)
+		return false;
+
+	elt_len = strlen(elt);
+	path_set_len = strlen(path_set);
+
+	/* path_set includes only elt or
+	 * path_set includes elt as the first element.
+	 */
+	if (tmp == path_set
+	    && ((path_set_len == elt_len)
+		|| (path_set[elt_len] == sep)))
+		return true;
+	/* path_set includes elt at the middle
+	 * or as the last element.
+	 */
+	if ((*(tmp - 1) == sep)
+	    && ((*(tmp + elt_len) == sep)
+		|| (*(tmp + elt_len) == '\0')))
+		return true;
+
+	return false;
+}
+
+static int nsfs_xasputs(char **str,
+			struct lsns_namespace *ns,
+			struct libmnt_table *tab,
+			char sep)
+{
+	struct libmnt_iter *itr = mnt_new_iter(MNT_ITER_FORWARD);
+	char *expected_root;
+	char *tmp;
+
+	xasprintf(&expected_root, "%s:[%lu]", ns_names[ns->type], ns->id);
+
+	tmp = NULL;
+	while (1) {
+		struct libmnt_fs *fs = NULL;
+
+		if (mnt_table_find_next_fs(tab, itr, find_nsfs_in_tab,
+					   expected_root, &fs) != 0)
+			break;
+		if (tmp == NULL) {
+			xasprintf(str, "%s", mnt_fs_get_target(fs));
+			tmp = *str;
+		} else if (!str_includes_path(*str, mnt_fs_get_target(fs),
+					      sep)) {
+			*str = NULL;
+			xasprintf(str, "%s%c%s",
+				  tmp, sep, mnt_fs_get_target(fs));
+			free(tmp);
+			tmp = *str;
+		}
+	}
+	free(expected_root);
+	mnt_free_iter(itr);
+
+	return 1;
+}
 static void add_scols_line(struct lsns *ls, struct libscols_table *table,
 			   struct lsns_namespace *ns, struct lsns_process *proc)
 {
@@ -665,6 +744,10 @@ static void add_scols_line(struct lsns *ls, struct libscols_table *table,
 			if (ns->type == LSNS_ID_NET)
 				netnsid_xasputs(&str, proc->netnsid);
 			break;
+		case COL_NSFS:
+			nsfs_xasputs(&str, ns, ls->tab,
+				     ls->raw ? ',' : '\n');
+			break;
 		default:
 			break;
 		}
@@ -697,16 +780,25 @@ static struct libscols_table *init_scols_table(struct lsns *ls)
 	for (i = 0; i < ncolumns; i++) {
 		const struct colinfo *col = get_column_info(i);
 		int flags = col->flags;
+		struct libscols_column *cl;
 
 		if (ls->notrunc)
 		       flags &= ~SCOLS_FL_TRUNC;
 		if (ls->tree && get_column_id(i) == COL_COMMAND)
 			flags |= SCOLS_FL_TREE;
 
-		if (!scols_table_new_column(tab, col->name, col->whint, flags)) {
+		cl = scols_table_new_column(tab, col->name, col->whint, flags);
+		if (cl == NULL) {
 			warnx(_("failed to initialize output column"));
 			goto err;
 		}
+		if (get_column_id(i) == COL_NSFS) {
+			scols_column_set_wrapfunc(cl,
+						  scols_wrapnl_chunksize,
+						  scols_wrapnl_nextchunk,
+						  NULL);
+			scols_column_set_safechars(cl, "\n");
+		}
 	}
 
 	return tab;
@@ -928,8 +1020,10 @@ int main(int argc, char *argv[])
 		columns[ncolumns++] = COL_NPROCS;
 		columns[ncolumns++] = COL_PID;
 		columns[ncolumns++] = COL_USER;
-		if (enabling_netnsid)
+		if (enabling_netnsid) {
 			columns[ncolumns++] = COL_NETNSID;
+			columns[ncolumns++] = COL_NSFS;
+		}
 		columns[ncolumns++] = COL_COMMAND;
 	}
 
@@ -956,6 +1050,11 @@ int main(int argc, char *argv[])
 	if (enabling_netnsid)
 		netlink_fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
 #endif
+
+	ls.tab = mnt_new_table_from_file(_PATH_PROC_MOUNTINFO);
+	if (!ls.tab)
+		err(MNT_EX_FAIL, _("failed to parse %s"), _PATH_PROC_MOUNTINFO);
+
 	r = read_processes(&ls);
 	if (!r)
 		r = read_namespaces(&ls);
@@ -970,6 +1069,7 @@ int main(int argc, char *argv[])
 			r = show_namespaces(&ls);
 	}
 
+	mnt_free_table(ls.tab);
 	if (netlink_fd >= 0)
 		close(netlink_fd);
 	free_idcache(uid_cache);
-- 
2.13.6

