Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79932C433FE
	for <util-linux@archiver.kernel.org>; Wed, 24 Nov 2021 18:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238178AbhKXS3p (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 24 Nov 2021 13:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236712AbhKXS3p (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 24 Nov 2021 13:29:45 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68764C061574
        for <util-linux@vger.kernel.org>; Wed, 24 Nov 2021 10:26:35 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id m192so3836599qke.2
        for <util-linux@vger.kernel.org>; Wed, 24 Nov 2021 10:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bwGigrpKC0uqsNDG3WiB1D1XNM5n5BDCHP7E4fEn1IQ=;
        b=KRqFmulKmgTxh5Ih/1LPubXfSq7Bia+pLYr46lyKjxUITpasY/EYnV9iRB12ZdC1dz
         AkcioyK4FO9jG4o/twrJfPJ30o6GF1ndATfeaIzm2QWwFgLH94XzUfhREYMlR5FWhu/C
         pJ/EiDw+D6kUP0bJiI7cz1Ul1vjZIM7byr0UrXv6oDupvHUGIJ9K1vMLNtlxo97jNwXa
         SwXqwwAVS1xkIoSSyPxPla7+cd5nvSOEd1UfYfq8dZArPXkNE9eimmVVooPLzdeRSg3w
         fi88Lrn+Pf/KX24+3pR3pnudPk2vAaUCjfCaLQfGeV8l6nNH/xvERzyv5YCd6Kf2q6oD
         Ig6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bwGigrpKC0uqsNDG3WiB1D1XNM5n5BDCHP7E4fEn1IQ=;
        b=KgYGtJ6AMddZr0EF7t1tG1gSUbVIGWCvXrteTdeu9cNYcq50gY4hGXBXFcE1XtxXPI
         U+wW+huI4/VA4/6m5xLIHsIQYIji4jK58q3iunvgT2SPDUcsg7+LQkTVtbVqttctWDmH
         gSnwa0sf9fzJLOKvmuzsZViwN+eCA/Dnk46ZhRMFW+BCUP3H+Fk8yy7hEaOcODXhAsnI
         AuYnLnox+289D1sucuSpaoAAy9h6LT1gCy42q5axoX94EzNRxvs5vOeNHvZjfgUdLQS1
         WQ4QaUIZXr0SBtX1b6K4pZ0+tPp3kHyhW9yo0zPSBdthtFUUKAqChobT0lSVtKqk75W8
         QjeA==
X-Gm-Message-State: AOAM532DAMVZ0CcraspcNLGM9AUNivedDZduSFBuA6yHQJc7n4uH5yPJ
        xM4zhawJSb3jmmSql9yPXXQjSsF8MOQ=
X-Google-Smtp-Source: ABdhPJx4klFGi1rSYpR7aYKA0MhGdCx/Na86280QIlGfaAhUDzbhG/3sSyGEgSV9WcGrwZI1PAI6hA==
X-Received: by 2002:a05:620a:44d3:: with SMTP id y19mr8434078qkp.276.1637778394450;
        Wed, 24 Nov 2021 10:26:34 -0800 (PST)
Received: from godwin.fios-router.home (pool-108-18-207-184.washdc.fios.verizon.net. [108.18.207.184])
        by smtp.gmail.com with ESMTPSA id h19sm274936qth.63.2021.11.24.10.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 10:26:33 -0800 (PST)
From:   Sean Anderson <seanga2@gmail.com>
To:     util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Cc:     Mikhail Gusarov <dottedmag@dottedmag.net>,
        Matthew Harm Bekkema <id@mbekkema.name>,
        James Peach <jpeach@apache.org>,
        Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 5/6] unshare: Add option to automatically create user and group maps
Date:   Wed, 24 Nov 2021 13:26:17 -0500
Message-Id: <20211124182618.1801447-6-seanga2@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211124182618.1801447-1-seanga2@gmail.com>
References: <20211124182618.1801447-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

This option is designed to handle the "garden path" user/group ID
mapping:

- The user has one big map in /etc/sub[u,g]id
- The user wants to map as many user and group IDs as they can,
  especially the first 1000 users and groups.

The "auto" map is designed to handle this. We find the first map
matching the current user, and then map the whole thing to the ID range
starting at ID 0.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

Changes in v2:
- Add "auto" option for --map-users and --map-groups
- Fix most of read_subid_range using spaces instead of tabs
- Use pathname macros for /etc/sub{u,g}id

 include/pathnames.h |  3 ++
 sys-utils/unshare.c | 84 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/include/pathnames.h b/include/pathnames.h
index 9be2baa83..5db815880 100644
--- a/include/pathnames.h
+++ b/include/pathnames.h
@@ -97,6 +97,9 @@
 #define _PATH_PROC_LOCKS        "/proc/locks"
 #define _PATH_PROC_CDROMINFO	"/proc/sys/dev/cdrom/info"
 
+/* unshare paths */
+#define _PATH_SUBUID		"/etc/subuid"
+#define _PATH_SUBGID		"/etc/subgid"
 #define _PATH_PROC_UIDMAP	"/proc/self/uid_map"
 #define _PATH_PROC_GIDMAP	"/proc/self/gid_map"
 #define _PATH_PROC_SETGROUPS	"/proc/self/setgroups"
diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 6d0a56334..b5a18ed95 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -418,6 +418,72 @@ static struct map_range *get_map_range(const char *s)
 	return ret;
 }
 
+/**
+ * read_subid_range() - Look up a user's sub[gu]id range
+ * @filename: The file to look up the range from. This should be either
+ *            ``/etc/subuid`` or ``/etc/subgid``.
+ * @uid: The uid of the user whose range we should look up.
+ *
+ * This finds the first subid range matching @uid in @filename.
+ */
+static struct map_range *read_subid_range(char *filename, uid_t uid)
+{
+	char *line = NULL, *pwbuf;
+	FILE *idmap;
+	size_t n;
+	struct passwd *pw;
+	struct map_range *map;
+
+	map = xmalloc(sizeof(*map));
+	map->inner = 0;
+
+	pw = xgetpwuid(uid, &pwbuf);
+	if (!pw)
+		errx(EXIT_FAILURE, _("you (user %d) don't exist."), uid);
+
+	idmap = fopen(filename, "r");
+	if (!idmap)
+		err(EXIT_FAILURE, _("could not open '%s'"), filename);
+
+	/*
+	* Each line in sub[ug]idmap looks like
+	* username:subuid:count
+	* OR
+	* uid:subuid:count
+	*/
+	while (getline(&line, &n, idmap) != -1) {
+		char *rest, *s;
+
+		rest = strchr(line, ':');
+		if (!rest)
+			continue;
+		*rest = '\0';
+
+		if (strcmp(line, pw->pw_name) &&
+		    strtoul(line, NULL, 10) != pw->pw_uid)
+			continue;
+
+		s = rest + 1;
+		rest = strchr(s, ':');
+		if (!rest)
+			continue;
+		*rest = '\0';
+		map->outer = strtoul_or_err(s, _("failed to parse subid map"));
+
+		s = rest + 1;
+		rest = strchr(s, '\n');
+		if (rest)
+			*rest = '\0';
+		map->count = strtoul_or_err(s, _("failed to parse subid map"));
+
+		fclose(idmap);
+		return map;
+	}
+
+	err(EXIT_FAILURE, _("no line matching user \"%s\" in %s"),
+	pw->pw_name, filename);
+}
+
 /**
  * map_ids() - Create a new uid/gid map
  * @idmapper: Either newuidmap or newgidmap
@@ -603,6 +669,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" --map-group=<gid>|<name>  map current group to gid (implies --user)\n"), out);
 	fputs(_(" -r, --map-root-user       map current user to root (implies --user)\n"), out);
 	fputs(_(" -c, --map-current-user    map current user to itself (implies --user)\n"), out);
+	fputs(_(" --map-auto                map users and groups automatically (implies --user)\n"), out);
 	fputs(_(" --map-users=<outeruid>,<inneruid>,<count>\n"
 		"                           map count users from outeruid to inneruid (implies --user)\n"), out);
 	fputs(_(" --map-groups=<outergid>,<innergid>,<count>\n"
@@ -644,6 +711,7 @@ int main(int argc, char *argv[])
 		OPT_MAPUSERS,
 		OPT_MAPGROUP,
 		OPT_MAPGROUPS,
+		OPT_MAPAUTO,
 	};
 	static const struct option longopts[] = {
 		{ "help",          no_argument,       NULL, 'h'             },
@@ -667,6 +735,7 @@ int main(int argc, char *argv[])
 		{ "map-groups",    required_argument, NULL, OPT_MAPGROUPS   },
 		{ "map-root-user", no_argument,       NULL, 'r'             },
 		{ "map-current-user", no_argument,    NULL, 'c'             },
+		{ "map-auto",      no_argument,       NULL, OPT_MAPAUTO     },
 		{ "propagation",   required_argument, NULL, OPT_PROPAGATION },
 		{ "setgroups",     required_argument, NULL, OPT_SETGROUPS   },
 		{ "keep-caps",     no_argument,       NULL, OPT_KEEPCAPS    },
@@ -778,11 +847,22 @@ int main(int argc, char *argv[])
 			break;
 		case OPT_MAPUSERS:
 			unshare_flags |= CLONE_NEWUSER;
-			usermap = get_map_range(optarg);
+			if (!strcmp(optarg, "auto"))
+				usermap = read_subid_range(_PATH_SUBUID, real_euid);
+			else
+				usermap = get_map_range(optarg);
 			break;
 		case OPT_MAPGROUPS:
 			unshare_flags |= CLONE_NEWUSER;
-			groupmap = get_map_range(optarg);
+			if (!strcmp(optarg, "auto"))
+				groupmap = read_subid_range(_PATH_SUBGID, real_egid);
+			else
+				groupmap = get_map_range(optarg);
+			break;
+		case OPT_MAPAUTO:
+			unshare_flags |= CLONE_NEWUSER;
+			usermap = read_subid_range(_PATH_SUBUID, real_euid);
+			groupmap = read_subid_range(_PATH_SUBGID, real_egid);
 			break;
 		case OPT_SETGROUPS:
 			setgrpcmd = setgroups_str2id(optarg);
-- 
2.33.0

