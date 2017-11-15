Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757203AbdKOC7X (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 14 Nov 2017 21:59:23 -0500
From: Masatake YAMATO <yamato@redhat.com>
To: util-linux@vger.kernel.org
Cc: yamato@redhat.com
Subject: [PATCH 1/2] lsns: add netnsid column
Date: Wed, 15 Nov 2017 11:59:18 +0900
Message-Id: <20171115025920.22394-1-yamato@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Linux network subsystem assigns an unique integer to a network
namespace.

  term0# ip netns add UTIL-LINUX-LSNS-TEST-NS
  term0# ip netns list
  UTIL-LINUX-LSNS-TEST-NS
  term0# ip link add name lsns-vetha type veth peer name lsns-vethb
  term0 # ip link set lsns-vethb netns UTIL-LINUX-LSNS-TEST-NS
  term0# ip netns list
  UTIL-LINUX-LSNS-TEST-NS (id: 0)
  term0# ip link show dev lsns-vetha
  230: lsns-vetha@if229: <BROADCAST,MULTICAST> mtu 1500 qdisc noop ...
         link/ether 3e:27:68:ba:b3:95 brd ff:ff:ff:ff:ff:ff link-netnsid 0
In this example 0 is assigned to UTIL-LINUX-LSNS-TEST-NS net namespace.
The name, UTIL-LINUX-LSNS-TEST-NS, and it semantics is given and defined
by iproute2 in userland; and nothing to do with util-linux.

However, the id, 0, is managed in linux kernel. If lsns can show
the ids, it helps users understand the state of network namespaces.

This commit adds NETNSID column to the output.

Here is an example of session:

  term0# ip netns exec UTIL-LINUX-LSNS-TEST-NS cat

  (Open another terminal)

  term1# ./lsns --type net
          NS TYPE NPROCS   PID USER     NETNSID COMMAND
  4026531993 net     383     1 root  unassigned /usr/lib/systemd/...
  4026532433 net       1  1219 rtkit unassigned /usr/libexec/rtkit-daemon
  4026532562 net       1 18201 root           0 cat

0 is shown as NETNSID for the cat process.

For the initial name space, "unassigned" is printed.
For the namespaces other type than net, "n/a" is printed.
If an error occurred during getting the id, "n/a" is printed.

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 configure.ac     |   1 +
 sys-utils/lsns.c | 190 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 189 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index eebe92259..b2ad5ea98 100644
--- a/configure.ac
+++ b/configure.ac
@@ -223,6 +223,7 @@ AC_CHECK_HEADERS([ \
 	linux/tiocl.h \
 	linux/version.h \
 	linux/securebits.h \
+	linux/net_namespace.h \
 	locale.h \
 	mntent.h \
 	net/if.h \
diff --git a/sys-utils/lsns.c b/sys-utils/lsns.c
index 1fb0b87f3..6252d09fe 100644
--- a/sys-utils/lsns.c
+++ b/sys-utils/lsns.c
@@ -29,6 +29,14 @@
 #include <wchar.h>
 #include <libsmartcols.h>
 
+#ifdef HAVE_LINUX_NET_NAMESPACE_H
+#include <stdbool.h>
+#include <sys/socket.h>
+#include <linux/netlink.h>
+#include <linux/rtnetlink.h>
+#include <linux/net_namespace.h>
+#endif
+
 #include "pathnames.h"
 #include "nls.h"
 #include "xalloc.h"
@@ -52,6 +60,8 @@ UL_DEBUG_DEFINE_MASKNAMES(lsns) = UL_DEBUG_EMPTY_MASKNAMES;
 #define LSNS_DEBUG_NS		(1 << 3)
 #define LSNS_DEBUG_ALL		0xFFFF
 
+#define LSNS_NETNS_UNUSABLE -2
+
 #define DBG(m, x)       __UL_DBG(lsns, LSNS_DEBUG_, m, x)
 #define ON_DBG(m, x)    __UL_DBG_CALL(lsns, LSNS_DEBUG_, m, x)
 
@@ -67,7 +77,8 @@ enum {
 	COL_PPID,
 	COL_COMMAND,
 	COL_UID,
-	COL_USER
+	COL_USER,
+	COL_NETNSID
 };
 
 /* column names */
@@ -88,7 +99,8 @@ static const struct colinfo infos[] = {
 	[COL_PPID]    = { "PPID",    5, SCOLS_FL_RIGHT, N_("PPID of the PID") },
 	[COL_COMMAND] = { "COMMAND", 0, SCOLS_FL_TRUNC, N_("command line of the PID")},
 	[COL_UID]     = { "UID",     0, SCOLS_FL_RIGHT, N_("UID of the PID")},
-	[COL_USER]    = { "USER",    0, 0, N_("username of the PID")}
+	[COL_USER]    = { "USER",    0, 0, N_("username of the PID")},
+	[COL_NETNSID] = { "NETNSID", 0, SCOLS_FL_RIGHT, N_("Net namespace ID")}
 };
 
 static int columns[ARRAY_SIZE(infos) * 2];
@@ -118,6 +130,7 @@ struct lsns_namespace {
 	ino_t id;
 	int type;			/* LSNS_* */
 	int nprocs;
+	int netnsid;
 
 	struct lsns_process *proc;
 
@@ -139,6 +152,8 @@ struct lsns_process {
 
 	struct libscols_line *outline;
 	struct lsns_process *parent;
+
+	int netnsid;
 };
 
 struct lsns {
@@ -158,6 +173,16 @@ struct lsns {
 		     no_headings: 1;
 };
 
+struct netnsid_cache {
+	ino_t ino;
+	int   id;
+	struct list_head netnsids;
+};
+
+static struct list_head netnsids_cache;
+
+static int netlink_fd = -1;
+
 static void lsns_init_debug(void)
 {
 	__UL_INIT_DEBUG(lsns, LSNS_DEBUG_, 0, LSNS_DEBUG);
@@ -242,6 +267,137 @@ error:
 	return rc;
 }
 
+#ifdef HAVE_LINUX_NET_NAMESPACE_H
+static bool netnsid_cache_find(ino_t netino, int *netnsid)
+{
+	struct list_head *p;
+
+	list_for_each(p, &netnsids_cache) {
+		struct netnsid_cache *e = list_entry(p,
+						     struct netnsid_cache,
+						     netnsids);
+		if (e->ino == netino) {
+			*netnsid = e->id;
+			return true;
+		}
+	}
+
+	return false;
+}
+
+static void netnsid_cache_add(ino_t netino, int netnsid)
+{
+	struct netnsid_cache *e;
+
+	e = xcalloc(1, sizeof(*e));
+	e->ino = netino;
+	e->id  = netnsid;
+	INIT_LIST_HEAD(&e->netnsids);
+	list_add(&e->netnsids, &netnsids_cache);
+}
+
+static int get_netnsid_via_netlink_send_request(int target_fd)
+{
+	unsigned char req[NLMSG_SPACE(sizeof(struct rtgenmsg))
+			  + RTA_SPACE(sizeof(int32_t))];
+
+	struct nlmsghdr *nlh = (struct nlmsghdr *)req;
+	struct rtgenmsg *rt = NLMSG_DATA(req);
+	struct rtattr *rta = (struct rtattr *)
+		(req + NLMSG_SPACE(sizeof(struct rtgenmsg)));
+	int32_t *fd = RTA_DATA(rta);
+
+	nlh->nlmsg_len = sizeof(req);
+	nlh->nlmsg_flags = NLM_F_REQUEST;
+	nlh->nlmsg_type = RTM_GETNSID;
+	rt->rtgen_family = AF_UNSPEC;
+	rta->rta_type = NETNSA_FD;
+	rta->rta_len = RTA_SPACE(sizeof(int32_t));
+	*fd = target_fd;
+
+	if (send(netlink_fd, req, sizeof(req), 0) < 0)
+		return -1;
+	return 0;
+}
+
+static int get_netnsid_via_netlink_recv_response(int *netnsid)
+{
+	unsigned char res[NLMSG_SPACE(sizeof(struct rtgenmsg))
+			  + ((RTA_SPACE(sizeof(int32_t))
+			      < RTA_SPACE(sizeof(struct nlmsgerr)))
+			     ? RTA_SPACE(sizeof(struct nlmsgerr))
+			     : RTA_SPACE(sizeof(int32_t)))];
+	int reslen, rtalen;
+
+	struct nlmsghdr *nlh;
+	struct rtattr *rta;
+
+	reslen = recv(netlink_fd, res, sizeof(res), 0);
+	if (reslen < 0)
+		return -1;
+
+	nlh = (struct nlmsghdr *)res;
+	if (!(NLMSG_OK(nlh, reslen)
+	      && nlh->nlmsg_type == RTM_NEWNSID))
+		return -1;
+
+	rtalen = NLMSG_PAYLOAD(nlh, sizeof(struct rtgenmsg));
+	rta = (struct rtattr *)(res + NLMSG_SPACE(sizeof(struct rtgenmsg)));
+	if (!(RTA_OK(rta, rtalen)
+	      && rta->rta_type == NETNSA_NSID))
+		return -1;
+
+	*netnsid = *(int *)RTA_DATA(rta);
+
+	return 0;
+}
+
+static int get_netnsid_via_netlink(int dir, const char *path)
+{
+	int netnsid;
+	int target_fd;
+
+	if (netlink_fd < 0)
+		return LSNS_NETNS_UNUSABLE;
+
+	target_fd = openat(dir, path, O_RDONLY);
+	if (target_fd < 0)
+		return LSNS_NETNS_UNUSABLE;
+
+	if (get_netnsid_via_netlink_send_request(target_fd) < 0) {
+		netnsid = LSNS_NETNS_UNUSABLE;
+		goto out;
+	}
+
+	if (get_netnsid_via_netlink_recv_response(&netnsid) < 0) {
+		netnsid = LSNS_NETNS_UNUSABLE;
+		goto out;
+	}
+
+ out:
+	close(target_fd);
+	return netnsid;
+}
+
+static int get_netnsid(int dir, ino_t netino)
+{
+	int netnsid;
+
+	if (!netnsid_cache_find(netino, &netnsid)) {
+		netnsid = get_netnsid_via_netlink(dir, "ns/net");
+		netnsid_cache_add(netino, netnsid);
+	}
+
+	return netnsid;
+}
+#else
+static int get_netnsid(int dir __attribute__((__unused__)),
+		       ino_t netino __attribute__((__unused__)))
+{
+	return LSNS_NETNS_UNUSABLE;
+}
+#endif /* HAVE_LINUX_NET_NAMESPACE_H */
+
 static int read_process(struct lsns *ls, pid_t pid)
 {
 	struct lsns_process *p = NULL;
@@ -264,6 +420,7 @@ static int read_process(struct lsns *ls, pid_t pid)
 		rc = -ENOMEM;
 		goto done;
 	}
+	p->netnsid = LSNS_NETNS_UNUSABLE;
 
 	if (fstat(dirfd(dir), &st) == 0) {
 		p->uid = st.st_uid;
@@ -293,6 +450,8 @@ static int read_process(struct lsns *ls, pid_t pid)
 		rc = get_ns_ino(dirfd(dir), ns_names[i], &p->ns_ids[i]);
 		if (rc && rc != -EACCES && rc != -ENOENT)
 			goto done;
+		if (i == LSNS_ID_NET)
+			p->netnsid = get_netnsid(dirfd(dir), p->ns_ids[i]);
 		rc = 0;
 	}
 
@@ -413,6 +572,18 @@ static int cmp_namespaces(struct list_head *a, struct list_head *b,
 	return cmp_numbers(xa->id, xb->id);
 }
 
+static int netnsid_xasputs(char **str, int netnsid)
+{
+	if (netnsid >= 0)
+		return xasprintf(&str, "%d", netnsid);
+#ifdef NETNSA_NSID_NOT_ASSIGNED
+	else if (netnsid == NETNSA_NSID_NOT_ASSIGNED)
+		return xasprintf(&str, "%s", "unassigned");
+#endif
+	else
+		return xasprintf(&str, "%s", "n/a");
+}
+
 static int read_namespaces(struct lsns *ls)
 {
 	struct list_head *p;
@@ -490,6 +661,11 @@ static void add_scols_line(struct lsns *ls, struct libscols_table *table,
 		case COL_USER:
 			xasprintf(&str, "%s", get_id(uid_cache, proc->uid)->name);
 			break;
+		case COL_NETNSID:
+			if (ns->type == LSNS_ID_NET)
+				netnsid_xasputs(&str, proc->netnsid);
+			else
+				xasprintf(&str, "n/a");
 		default:
 			break;
 		}
@@ -675,6 +851,7 @@ int main(int argc, char *argv[])
 
 	INIT_LIST_HEAD(&ls.processes);
 	INIT_LIST_HEAD(&ls.namespaces);
+	INIT_LIST_HEAD(&netnsids_cache);
 
 	while ((c = getopt_long(argc, argv,
 				"Jlp:o:nruhVt:", long_opts, NULL)) != -1) {
@@ -748,6 +925,7 @@ int main(int argc, char *argv[])
 		columns[ncolumns++] = COL_NPROCS;
 		columns[ncolumns++] = COL_PID;
 		columns[ncolumns++] = COL_USER;
+		columns[ncolumns++] = COL_NETNSID;
 		columns[ncolumns++] = COL_COMMAND;
 	}
 
@@ -761,6 +939,12 @@ int main(int argc, char *argv[])
 	if (!uid_cache)
 		err(EXIT_FAILURE, _("failed to allocate UID cache"));
 
+#ifdef HAVE_LINUX_NET_NAMESPACE_H
+	netlink_fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
+#endif
+	if (netlink_fd < 0)
+		netlink_fd = -errno;
+
 	r = read_processes(&ls);
 	if (!r)
 		r = read_namespaces(&ls);
@@ -775,6 +959,8 @@ int main(int argc, char *argv[])
 			r = show_namespaces(&ls);
 	}
 
+	if (netlink_fd >= 0)
+		close(netlink_fd);
 	free_idcache(uid_cache);
 	return r == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
 }
-- 
2.13.6

