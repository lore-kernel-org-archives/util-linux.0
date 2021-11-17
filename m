Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9AAC4332F
	for <util-linux@archiver.kernel.org>; Wed, 17 Nov 2021 02:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B81C061507
	for <util-linux@archiver.kernel.org>; Wed, 17 Nov 2021 02:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbhKQCNp (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 16 Nov 2021 21:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhKQCNp (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 16 Nov 2021 21:13:45 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF025C061570
        for <util-linux@vger.kernel.org>; Tue, 16 Nov 2021 18:10:47 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id l8so1189412qtk.6
        for <util-linux@vger.kernel.org>; Tue, 16 Nov 2021 18:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p4wfJZ29OiW+HA7JjnqIv380CxJLJmPVBfwqfxw1vb4=;
        b=FMEXyZD15PNvvMeGB08hiwTllJ+hRGL1tk2F9AlKSMonMZd/v32a8mJ+fFVt/fzfS4
         n+6fCwsXIzJy7kpAsj2LHPMDUEpUlNhzY3FWZK4nYO/DW1obxe48ypzJwTNgd6Op/rpS
         GGJUxhn9QIYyFq5KDVUJykvciLb0JQhiRXS15NULqeL7wkuIzUPGWGV01kZEdDGIhdDo
         IpVg6smjS90KOkNURH0iCJ+YHK9hiNik6LQNyJBx9quKsJ61UB5ZDRB0Vlfg7S8pLQhb
         Ib7J3tQFzQy3KrRea53M+gHVG3WvQi6q2leoqC5n2mPUZzv4WhokeMmUFBgsOfPrtmM9
         cs7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p4wfJZ29OiW+HA7JjnqIv380CxJLJmPVBfwqfxw1vb4=;
        b=Up5XtRsHVP07skLYwgMqbn9+8uFoQpTtVyDsEG3qQ57PPn/QB9qk5D6HgqsFLov1/p
         tx0OGGjt7kUe++W0YYsiyxgA1HUMBFu6pREhtwzt8kug3QbQlTb2iBtuxX7Oq1nH6TW7
         BvExP0obq8hoWlrv2Z8U13zTbzAN10HL7kd1OvXUHQ8dpCs/ijLRWRTZYL0L/B3diLKN
         NDeTqlbcATYBaRSZRC2fhl6GLMDNTBKoTarur+KvOX8FNwP8JWp1CLwsMmj9QR5VndIP
         ZIRsUtpJeONu3U55ZpK/6E6Mdp1+EHFfvV5pNS2nhGrJ0nOaclwI5P8Ek5cNm0sbGjCf
         w5iQ==
X-Gm-Message-State: AOAM530DALttEiPoDsszGXVWwg9bEbXsIqSVxC5VFwzGkBNnmeAgvign
        +IP3XhFXGCw/yUl4PPimUfgJ+CwYpw4=
X-Google-Smtp-Source: ABdhPJzRFDsWlDBdwzvAYSu6q9lammWR2872oXVLq/8q7zsi3ADxc3LfDFZJ4eQKD2d3714oGjDk8g==
X-Received: by 2002:ac8:5855:: with SMTP id h21mr12911930qth.8.1637115046678;
        Tue, 16 Nov 2021 18:10:46 -0800 (PST)
Received: from godwin.fios-router.home (pool-108-18-207-184.washdc.fios.verizon.net. [108.18.207.184])
        by smtp.gmail.com with ESMTPSA id t11sm9326200qkm.96.2021.11.16.18.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 18:10:46 -0800 (PST)
From:   Sean Anderson <seanga2@gmail.com>
To:     util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Cc:     Mikhail Gusarov <dottedmag@dottedmag.net>,
        Matthew Harm Bekkema <id@mbekkema.name>,
        James Peach <jpeach@apache.org>,
        Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 4/5] unshare: Add option to automatically create user and group maps
Date:   Tue, 16 Nov 2021 21:10:37 -0500
Message-Id: <20211117021038.823851-5-seanga2@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211117021038.823851-1-seanga2@gmail.com>
References: <20211117021038.823851-1-seanga2@gmail.com>
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

 sys-utils/unshare.c | 74 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 247925aa6..33d1a829c 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -373,6 +373,72 @@ static struct map_range *get_map_range(const char *s)
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
+        char *line = NULL, *pwbuf;
+        FILE *idmap;
+        size_t n;
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
+        idmap = fopen(filename, "r");
+        if (!idmap)
+                err(EXIT_FAILURE, _("could not open '%s'"), filename);
+
+        /*
+         * Each line in sub[ug]idmap looks like
+         * username:subuid:count
+         * OR
+         * uid:subuid:count
+         */
+        while (getline(&line, &n, idmap) != -1) {
+                char *rest, *s;
+
+                rest = strchr(line, ':');
+                if (!rest)
+                        continue;
+                *rest = '\0';
+
+                if (strcmp(line, pw->pw_name) &&
+                    strtoul(line, NULL, 10) != pw->pw_uid)
+                        continue;
+
+                s = rest + 1;
+                rest = strchr(s, ':');
+                if (!rest)
+                        continue;
+                *rest = '\0';
+		map->outer = strtoul_or_err(s, _("failed to parse subid map"));
+
+                s = rest + 1;
+                rest = strchr(s, '\n');
+                if (rest)
+                        *rest = '\0';
+		map->count = strtoul_or_err(s, _("failed to parse subid map"));
+
+                fclose(idmap);
+                return map;
+        }
+
+        err(EXIT_FAILURE, _("no line matching user \"%s\" in %s"),
+	    pw->pw_name, filename);
+}
+
 /**
  * map_ids() - Create a new uid/gid map
  * @idmapper: Either newuidmap or newgidmap
@@ -571,6 +637,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" --map-group=<gid>|<name>  map current group to gid (implies --user)\n"), out);
 	fputs(_(" -r, --map-root-user       map current user to root (implies --user)\n"), out);
 	fputs(_(" -c, --map-current-user    map current user to itself (implies --user)\n"), out);
+	fputs(_(" --map-auto                map users and groups automatically (implies --user)\n"), out);
 	fputs(_(" --map-users=<outeruid>,<inneruid>,<count>\n"
 		"                           map count users from outeruid to inneruid (implies --user)\n"), out);
 	fputs(_(" --map-groups=<outergid>,<innergid>,<count>\n"
@@ -612,6 +679,7 @@ int main(int argc, char *argv[])
 		OPT_MAPUSERS,
 		OPT_MAPGROUP,
 		OPT_MAPGROUPS,
+		OPT_MAPAUTO,
 	};
 	static const struct option longopts[] = {
 		{ "help",          no_argument,       NULL, 'h'             },
@@ -635,6 +703,7 @@ int main(int argc, char *argv[])
 		{ "map-groups",    required_argument, NULL, OPT_MAPGROUPS   },
 		{ "map-root-user", no_argument,       NULL, 'r'             },
 		{ "map-current-user", no_argument,    NULL, 'c'             },
+		{ "map-auto",      no_argument,       NULL, OPT_MAPAUTO     },
 		{ "propagation",   required_argument, NULL, OPT_PROPAGATION },
 		{ "setgroups",     required_argument, NULL, OPT_SETGROUPS   },
 		{ "keep-caps",     no_argument,       NULL, OPT_KEEPCAPS    },
@@ -753,6 +822,11 @@ int main(int argc, char *argv[])
 			unshare_flags |= CLONE_NEWUSER;
 			groupmap = get_map_range(optarg);
 			break;
+		case OPT_MAPAUTO:
+			unshare_flags |= CLONE_NEWUSER;
+			usermap = read_subid_range("/etc/subuid", real_euid);
+			groupmap = read_subid_range("/etc/subgid", real_egid);
+			break;
 		case OPT_SETGROUPS:
 			setgrpcmd = setgroups_str2id(optarg);
 			break;
-- 
2.33.0

