Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93ECAC433F5
	for <util-linux@archiver.kernel.org>; Wed, 17 Nov 2021 02:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73DEB61507
	for <util-linux@archiver.kernel.org>; Wed, 17 Nov 2021 02:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbhKQCNp (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 16 Nov 2021 21:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbhKQCNo (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 16 Nov 2021 21:13:44 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FAFC061764
        for <util-linux@vger.kernel.org>; Tue, 16 Nov 2021 18:10:46 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id v22so1177656qtx.8
        for <util-linux@vger.kernel.org>; Tue, 16 Nov 2021 18:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BwfNzfbp/YFjIC1PGZTKWyovpGUUqQ5DZtMVrwhtJa4=;
        b=P9oYDARCeMS7ldrMSsOnvce9DWWvD5cALk25oehF3ikBfAGUj+79v9fmwVZBjPi95a
         PsAi1swkSaVPJaVxRwwTjeqzgVqg5cn2qm5n4dAF/USgDGh5wKpB/tspOwCXwgI3Oyjb
         JsbznDaVVaCgz6pt0hKqKRsdXB2NY8YeBmM0tvbBYbO4mDhlAV15QcScRlgQlIq2+bpZ
         /CgYusoYqws9ZWifeIMw20Pt2+qJcRz2QkIhV8zvNgy5V+0hxJybMKhRIVwuzMoZv+bG
         I1zdHRe8HoOSZGy5lzMNxmY3YU+rrNPnD3Cm1On8b1gDz3GeBFZL6mWi5uJWTl2xsj3u
         P+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BwfNzfbp/YFjIC1PGZTKWyovpGUUqQ5DZtMVrwhtJa4=;
        b=E8MlBfUSdw5dtAXdP2Hcy7iQBArVtgvFS9CHqNRtRni05MHii68UL4LKPqjb1WMRj6
         vtEpn8fzYmfkptf3lWY8JYEEuLiRo/Nul9m+k9JVPAy+1J4K3SGwAMJpbTbtCWJgTWpE
         F/JNzwQlAIYcX748zjgKxc029pLgPYxJjB0n2djxvD7eFekEuPyIkJPQG8wYfAhqyrFS
         6ynfyoxCHSgdCD4PSowwtZ3T2ejHIAtq/SssTAO9Fh+ll4+EKaOIWec3cjclyFPTj42K
         81HpYQPhg0YqcTnr8uaUyc5UPCr7nOAxzyZUtyXTHpj/oRup2ImoJd/p4SmI/MsuFaE3
         u9Lg==
X-Gm-Message-State: AOAM531VWStQmlV1uEgCsdJyQAXPaOuhiWF0498bQiZfZ746QqdrAa+Q
        ySrY5BCtwgL0tzrauYayuvhwMjupIC8=
X-Google-Smtp-Source: ABdhPJy4FwnHLygi8IU8n6L/k9g55bPTXD521fWtxolV+0AgXZBtDYE0tv1a/P0V6QDEz0ERC3odLA==
X-Received: by 2002:ac8:7f43:: with SMTP id g3mr13227283qtk.127.1637115045818;
        Tue, 16 Nov 2021 18:10:45 -0800 (PST)
Received: from godwin.fios-router.home (pool-108-18-207-184.washdc.fios.verizon.net. [108.18.207.184])
        by smtp.gmail.com with ESMTPSA id t11sm9326200qkm.96.2021.11.16.18.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 18:10:45 -0800 (PST)
From:   Sean Anderson <seanga2@gmail.com>
To:     util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Cc:     Mikhail Gusarov <dottedmag@dottedmag.net>,
        Matthew Harm Bekkema <id@mbekkema.name>,
        James Peach <jpeach@apache.org>,
        Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 3/5] unshare: Add options to map blocks of user/group IDs
Date:   Tue, 16 Nov 2021 21:10:36 -0500
Message-Id: <20211117021038.823851-4-seanga2@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211117021038.823851-1-seanga2@gmail.com>
References: <20211117021038.823851-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

This adds the ability to map multiple user/group IDs when creating a new
user namespace. Regular processes cannot map any user other than the
effective user, so we need to use the setuid helpers newuidmap and
newgidmap, provided by shadow. Typically, users will be assigned blocks
of user/group IDs in /etc/sub{u,g}id, although it is also possible to
use NSS. There is a second advantage in using these helpers: because we
never write to /proc/self/gid_map, we don't have to disable setgroups.

Because the process of mapping IDs is almost identical, whether we are
mapping user IDs or group IDs, we put both in a common "map_range"
structure. These are read in by (ab)using string_to_idarray. In addition
to any map created with --map-users, we still need to handle a map of
size one created with --map-user. This makes constructing the helpers'
command line the trickiest part of the whole process. newuidmap/
newgidmap check to see if any ranges overlap before creating a mapping.
To avoid failing, we carve out a hole in the mapping for the singular
map. In the worst case, we may have three separate maps.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 sys-utils/unshare.c | 270 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 267 insertions(+), 3 deletions(-)

diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 540305ee7..247925aa6 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -24,6 +24,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <sys/eventfd.h>
 #include <sys/wait.h>
 #include <sys/mount.h>
 #include <sys/types.h>
@@ -314,6 +315,236 @@ static gid_t get_group(const char *s, const char *err)
 	return ret;
 }
 
+/**
+ * struct map_range - A range of IDs to map
+ * @outer: First ID inside the namespace
+ * @inner: First ID outside the namespace
+ * @count: Length of the inside and outside ranges
+ *
+ * A range of uids/gids to map using new[gu]idmap.
+ */
+struct map_range {
+	unsigned int outer;
+	unsigned int inner;
+	unsigned int count;
+};
+
+static int uint_to_id(const char *cname, size_t sz)
+{
+	char old, *name = (char *)cname;
+	unsigned long ret;
+
+	/* Add a NUL-terminator */
+	old = name[sz];
+	name[sz] = '\0';
+	ret = strtoul_or_err(name, _("could not parse ID"));
+	if (ret > UINT_MAX)
+		errx(EXIT_FAILURE, "id %lu is too big", ret);
+	/* And put back the old value to preserve const-ness */
+	name[sz] = old;
+	return ret;
+}
+
+/**
+ * get_map_range() - Parse a mapping range from a string
+ * @s: A string of the format upper,lower,count
+ * @res: The mapping to fill
+ *
+ * Parse a string of the form upper,lower,count into a new mapping range.
+ *
+ * Return: A new &struct map_range
+ */
+static struct map_range *get_map_range(const char *s)
+{
+	int n, map[3];
+	struct map_range *ret;
+
+	n = string_to_idarray(s, map, ARRAY_SIZE(map), uint_to_id);
+	if (n < 0)
+		errx(EXIT_FAILURE, _("too many elements for mapping '%s'"), s);
+	if (n != ARRAY_SIZE(map))
+		errx(EXIT_FAILURE, _("mapping '%s' contains only %d elements"),
+		     s, n);
+
+	ret = xmalloc(sizeof(*ret));
+	ret->outer = map[0];
+	ret->inner = map[1];
+	ret->count = map[2];
+	return ret;
+}
+
+/**
+ * map_ids() - Create a new uid/gid map
+ * @idmapper: Either newuidmap or newgidmap
+ * @ppid: Pid to set the map for
+ * @outer: ID outside the namespace for a single map.
+ * @inner: ID inside the namespace for a single map. May be -1 to only use @map.
+ * @map: A range of IDs to map
+ *
+ * This creates a new uid/gid map for @ppid using @idmapper. The ID @outer in
+ * the parent (our) namespace is mapped to the ID @inner in the child (@ppid's)
+ * namespace. In addition, the range of IDs beginning at @map->outer is mapped
+ * to the range of IDs beginning at @map->inner. The tricky bit is that we
+ * cannot let these mappings overlap. We accomplish this by removing a "hole"
+ * from @map, if @outer or @inner overlap it. This may result in one less than
+ * @map->count IDs being mapped from @map. The unmapped IDs are always the
+ * topmost IDs of the mapping (either in the parent or the child namespace).
+ *
+ * Most of the time, this function will be called with @map->outer as some
+ * large ID, @map->inner as 0, and @map->count as a large number (at least
+ * 1000, but less than @map->outer). Typically, there will be no conflict with
+ * @outer. However, @inner may split the mapping for e.g. --map-current-user.
+ *
+ * This function always exec()s or errors out and does not return.
+ */
+static void __attribute__((__noreturn__))
+map_ids(const char *idmapper, int ppid, unsigned int outer, unsigned int inner,
+	struct map_range *map)
+{
+	/* idmapper + pid + 4 * map + NULL */
+	char *argv[15];
+	/* argv - idmapper - "1" - NULL */
+	char args[12][16];
+	int i = 0, j = 0;
+	struct map_range lo, mid, hi;
+	unsigned int inner_offset, outer_offset;
+
+	/* Some helper macros to reduce bookkeeping */
+#define push_str(s) do { \
+	argv[i++] = s; \
+} while (0)
+#define push_ul(x) do { \
+	snprintf(args[j], 16, "%u", x); \
+	push_str(args[j++]); \
+} while (0)
+
+	push_str(xstrdup(idmapper));
+	push_ul(ppid);
+	if ((int)inner == -1) {
+		/*
+		 * If we don't have a "single" mapping, then we can just use
+		 * map directly
+		 */
+		push_ul(map->inner);
+		push_ul(map->outer);
+		push_ul(map->count);
+		push_str(NULL);
+
+		execvp(idmapper, argv);
+		errexec(idmapper);
+	}
+
+	/* If the mappings overlap, remove an ID from map */
+	if ((outer >= map->outer && outer <= map->outer + map->count) ||
+	    (inner >= map->inner && inner <= map->inner + map->count))
+		map->count--;
+
+	/* Determine where the splits between lo, mid, and hi will be */
+	outer_offset = min(outer > map->outer ? outer - map->outer : 0,
+			   map->count);
+	inner_offset = min(inner > map->inner ? inner - map->inner : 0,
+			   map->count);
+
+	/*
+	 * In the worst case, we need three mappings:
+	 * From the bottom of map to either inner or outer
+	 */
+	lo.outer = map->outer;
+	lo.inner = map->inner;
+	lo.count = min(inner_offset, outer_offset);
+
+	/* From the lower of inner or outer to the higher */
+	mid.outer = lo.outer + lo.count;
+	mid.outer += mid.outer == outer;
+	mid.inner = lo.inner + lo.count;
+	mid.inner += mid.inner == inner;
+	mid.count = abs_diff(outer_offset, inner_offset);
+
+	/* And from the higher of inner or outer to the end of the map */
+	hi.outer = mid.outer + mid.count;
+	hi.outer += hi.outer == outer;
+	hi.inner = mid.inner + mid.count;
+	hi.inner += hi.inner == inner;
+	hi.count = map->count - lo.count - mid.count;
+
+	push_ul(inner);
+	push_ul(outer);
+	push_str("1");
+	/* new[gu]idmap doesn't like zero-length mappings, so skip them */
+	if (lo.count) {
+		push_ul(lo.inner);
+		push_ul(lo.outer);
+		push_ul(lo.count);
+	}
+	if (mid.count) {
+		push_ul(mid.inner);
+		push_ul(mid.outer);
+		push_ul(mid.count);
+	}
+	if (hi.count) {
+		push_ul(hi.inner);
+		push_ul(hi.outer);
+		push_ul(hi.count);
+	}
+	push_str(NULL);
+	execvp(idmapper, argv);
+	errexec(idmapper);
+}
+
+/**
+ * map_ids_from_child() - Set up a new uid/gid map
+ * @child: The PID of the child process
+ * @fd: The eventfd to send our PID over
+ * @mapuser: The user to map the current user to (or -1)
+ * @usermap: The range of UIDs to map (or %NULL)
+ * @mapgroup: The group to map the current group to (or -1)
+ * @groupmap: The range of GIDs to map (or %NULL)
+ *
+ * Fork (to pid @child) and wait for a message on @fd. Upon recieving this
+ * message, use newuidmap and newgidmap to set the uid/gid map for our parent's
+ * PID.
+ */
+static void map_ids_from_child(pid_t *child, int *fd, uid_t mapuser,
+			       struct map_range *usermap, gid_t mapgroup,
+			       struct map_range *groupmap)
+{
+	pid_t pid = 0;
+	pid_t ppid = getpid();
+	uint64_t ch;
+
+	*fd = eventfd(0, 0);
+	if (*fd < 0)
+		err(EXIT_FAILURE, _("eventfd failed"));
+
+	*child = fork();
+	if (*child < 0)
+		err(EXIT_FAILURE, _("fork failed"));
+	if (*child)
+		return;
+
+	/* wait for the our parent to call unshare() */
+	if (read_all(*fd, (char *)&ch, sizeof(ch)) != sizeof(ch) ||
+	    ch != PIPE_SYNC_BYTE)
+		err(EXIT_FAILURE, _("failed to read eventfd"));
+	close(*fd);
+
+	/* Avoid forking more than we need to */
+	if (usermap && groupmap) {
+		pid = fork();
+		if (pid < 0)
+			err(EXIT_FAILURE, _("fork failed"));
+		if (pid)
+			waitchild(pid);
+	}
+
+	if (!pid && usermap)
+		map_ids("newuidmap", ppid, geteuid(), mapuser, usermap);
+	if (groupmap)
+		map_ids("newgidmap", ppid, getegid(), mapgroup, groupmap);
+	exit(EXIT_SUCCESS);
+}
+
+
 static void __attribute__((__noreturn__)) usage(void)
 {
 	FILE *out = stdout;
@@ -340,6 +571,10 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" --map-group=<gid>|<name>  map current group to gid (implies --user)\n"), out);
 	fputs(_(" -r, --map-root-user       map current user to root (implies --user)\n"), out);
 	fputs(_(" -c, --map-current-user    map current user to itself (implies --user)\n"), out);
+	fputs(_(" --map-users=<outeruid>,<inneruid>,<count>\n"
+		"                           map count users from outeruid to inneruid (implies --user)\n"), out);
+	fputs(_(" --map-groups=<outergid>,<innergid>,<count>\n"
+		"                           map count groups from outergid to innergid (implies --user)\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_(" --kill-child[=<signame>]  when dying, kill the forked child (implies --fork)\n"
 		"                             defaults to SIGKILL\n"), out);
@@ -374,7 +609,9 @@ int main(int argc, char *argv[])
 		OPT_MONOTONIC,
 		OPT_BOOTTIME,
 		OPT_MAPUSER,
+		OPT_MAPUSERS,
 		OPT_MAPGROUP,
+		OPT_MAPGROUPS,
 	};
 	static const struct option longopts[] = {
 		{ "help",          no_argument,       NULL, 'h'             },
@@ -393,7 +630,9 @@ int main(int argc, char *argv[])
 		{ "kill-child",    optional_argument, NULL, OPT_KILLCHILD   },
 		{ "mount-proc",    optional_argument, NULL, OPT_MOUNTPROC   },
 		{ "map-user",      required_argument, NULL, OPT_MAPUSER     },
+		{ "map-users",     required_argument, NULL, OPT_MAPUSERS    },
 		{ "map-group",     required_argument, NULL, OPT_MAPGROUP    },
+		{ "map-groups",    required_argument, NULL, OPT_MAPGROUPS   },
 		{ "map-root-user", no_argument,       NULL, 'r'             },
 		{ "map-current-user", no_argument,    NULL, 'c'             },
 		{ "propagation",   required_argument, NULL, OPT_PROPAGATION },
@@ -413,13 +652,16 @@ int main(int argc, char *argv[])
 	int c, forkit = 0;
 	uid_t mapuser = -1;
 	gid_t mapgroup = -1;
+	struct map_range *usermap = NULL;
+	struct map_range *groupmap = NULL;
 	int kill_child_signo = 0; /* 0 means --kill-child was not used */
 	const char *procmnt = NULL;
 	const char *newroot = NULL;
 	const char *newdir = NULL;
-	pid_t pid_bind = 0;
+	pid_t pid_bind = 0, pid_idmap = 0;
 	pid_t pid = 0;
 	int fds[2];
+	int efd;
 	int status;
 	unsigned long propagation = UNSHARE_PROPAGATION_DEFAULT;
 	int force_uid = 0, force_gid = 0;
@@ -503,6 +745,14 @@ int main(int argc, char *argv[])
 			mapuser = real_euid;
 			mapgroup = real_egid;
 			break;
+		case OPT_MAPUSERS:
+			unshare_flags |= CLONE_NEWUSER;
+			usermap = get_map_range(optarg);
+			break;
+		case OPT_MAPGROUPS:
+			unshare_flags |= CLONE_NEWUSER;
+			groupmap = get_map_range(optarg);
+			break;
 		case OPT_SETGROUPS:
 			setgrpcmd = setgroups_str2id(optarg);
 			break;
@@ -565,9 +815,23 @@ int main(int argc, char *argv[])
 	if (npersists && (unshare_flags & CLONE_NEWNS))
 		bind_ns_files_from_child(&pid_bind, fds);
 
+	if (usermap || groupmap)
+		map_ids_from_child(&pid_idmap, &efd, mapuser, usermap,
+				   mapgroup, groupmap);
+
 	if (-1 == unshare(unshare_flags))
 		err(EXIT_FAILURE, _("unshare failed"));
 
+	if (usermap || groupmap) {
+		uint64_t ch = PIPE_SYNC_BYTE;
+
+		/* Tell child we've called unshare() */
+		write_all(efd, &ch, sizeof(ch));
+		close(efd);
+
+		waitchild(pid_idmap);
+	}
+
 	if (force_boottime)
 		settime(boottime, CLOCK_BOOTTIME);
 
@@ -628,14 +892,14 @@ int main(int argc, char *argv[])
 	if (kill_child_signo != 0 && prctl(PR_SET_PDEATHSIG, kill_child_signo) < 0)
 		err(EXIT_FAILURE, "prctl failed");
 
-        if (mapuser != (uid_t) -1)
+        if (mapuser != (uid_t) -1 && !usermap)
 		map_id(_PATH_PROC_UIDMAP, mapuser, real_euid);
 
         /* Since Linux 3.19 unprivileged writing of /proc/self/gid_map
          * has been disabled unless /proc/self/setgroups is written
          * first to permanently disable the ability to call setgroups
          * in that user namespace. */
-	if (mapgroup != (gid_t) -1) {
+	if (mapgroup != (gid_t) -1 && !groupmap) {
 		if (setgrpcmd == SETGROUPS_ALLOW)
 			errx(EXIT_FAILURE, _("options --setgroups=allow and "
 					"--map-group are mutually exclusive"));
-- 
2.33.0

