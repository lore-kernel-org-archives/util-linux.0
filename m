Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD266FBF
	for <util-linux@vger.kernel.org>; Sun,  9 Feb 2025 08:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739089514; cv=none; b=UXApwloHVNa9JGclMhjyyNQsi79N2H2vBZlgu19i0K4bFfATFPht3Z9EnAp6eSIw9aB0WE/81RyPFRwe49M4wiODvyLquvlUHniFVJyBa+CY1p4nNSK038hjoM+6CWRChB60m1msYUe3viPhtr61HDnhZRVcFsbwdJTJqUiYU5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739089514; c=relaxed/simple;
	bh=RDx2cnRpfyYwWloTivoH4haxjU1re0QYWpE+9Cha+0E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4RyaBgM74hAzBmCzhWTo54O1LkfKiklyLzXDhwIYk87LAq2RXgkC6PUTu4AbBh3AWfEo7gQWggEORvp+aAFol4lPjSlZF20rRCzNYEj7NiP3T5LRHOlTdWD1GRaGaYlDWki5/lvfQtJ6wFDwekR8OwAN9UEZimw4nXQFZRSuqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=CcAyPiXj; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="CcAyPiXj"
X-KPN-MessageId: ae42b942-e6bf-11ef-87ce-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id ae42b942-e6bf-11ef-87ce-005056abbe64;
	Sun, 09 Feb 2025 09:27:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=bc0EHIIUZth4MsJATOioaByLfY03OgYtO0TRKKzqJYM=;
	b=CcAyPiXjUmqUUphR03Rjw+Ot7+Yuz9bTzcREl+1G2JCi7dI9DzKKSyY1m19pQs/qlUaXZew4gK3aq
	 YgsTgcoFYhEd6ua4BXUhQTWEDUK2DoqOfBKKCAgoREil5wzH+IDz/siiAdTolNzqbCdB35Nilory86
	 hVjnn+oZpLcyKywY=
X-KPN-MID: 33|uzKWxYI1T4u7CyrXAU68q0HgQDHk9/Fxx8GymkM/2VbRW59clqmydIKauNX6PLJ
 XUSn2Eb0m1uAoLn3/K07E0AUKaNKQF+xLTWjHeRj4UHU=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|zYtHNovroIALX4HupddstvlhTfgZclLFjhkcjI1nb1rM9LWHb4FTZucW0pv2fbf
 Ud1VbBSEcBWd7TWfEZISrHw==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 60d092d9-e6bf-11ef-a31b-005056abf0db;
	Sun, 09 Feb 2025 09:25:11 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 08/14] textual: give seven error messages the same form as two others
Date: Sun,  9 Feb 2025 09:23:24 +0100
Message-ID: <20250209082330.4235-8-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250209082330.4235-1-bensberg@telfort.nl>
References: <20250209082330.4235-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The form with the parentheses is easier for translators: it indicates
that the preceding text is not a translatable word.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 login-utils/newgrp.c | 6 +++---
 sys-utils/nsenter.c  | 4 ++--
 sys-utils/unshare.c  | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/login-utils/newgrp.c b/login-utils/newgrp.c
index b9b620ed7..ba3777b36 100644
--- a/login-utils/newgrp.c
+++ b/login-utils/newgrp.c
@@ -219,7 +219,7 @@ int main(int argc, char *argv[])
 
 	if (argc <= optind) {
 		if (setgid(pw_entry->pw_gid) < 0)
-			err(EXIT_FAILURE, _("setgid failed"));
+			err(EXIT_FAILURE, _("setgid() failed"));
 	} else {
 		errno = 0;
 		if (!(gr_entry = getgrnam(argv[optind++]))) {
@@ -231,11 +231,11 @@ int main(int argc, char *argv[])
 		if (!allow_setgid(pw_entry, gr_entry))
 			errx(EXIT_FAILURE, _("permission denied"));
 		if (setgid(gr_entry->gr_gid) < 0)
-			err(EXIT_FAILURE, _("setgid failed"));
+			err(EXIT_FAILURE, _("setgid() failed"));
 	}
 
 	if (setuid(getuid()) < 0)
-		err(EXIT_FAILURE, _("setuid failed"));
+		err(EXIT_FAILURE, _("setuid() failed"));
 
 	fflush(NULL);
 	shell = (pw_entry->pw_shell && *pw_entry->pw_shell ?
diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
index 66ce4b324..214893d1a 100644
--- a/sys-utils/nsenter.c
+++ b/sys-utils/nsenter.c
@@ -836,9 +836,9 @@ int main(int argc, char *argv[])
 		if (force_gid && setgroups(0, NULL) != 0 && setgroups_nerrs)	/* drop supplementary groups */
 			err(EXIT_FAILURE, _("setgroups failed"));
 		if (force_gid && setgid(gid) < 0)		/* change GID */
-			err(EXIT_FAILURE, _("setgid failed"));
+			err(EXIT_FAILURE, _("setgid() failed"));
 		if (force_uid && setuid(uid) < 0)		/* change UID */
-			err(EXIT_FAILURE, _("setuid failed"));
+			err(EXIT_FAILURE, _("setuid() failed"));
 	}
 
 	if (keepcaps && (namespaces & CLONE_NEWUSER))
diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 4d078e4d5..b6c2f8b45 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -1270,10 +1270,10 @@ int main(int argc, char *argv[])
 		if (setgroups(0, NULL) != 0)	/* drop supplementary groups */
 			err(EXIT_FAILURE, _("setgroups failed"));
 		if (setgid(gid) < 0)		/* change GID */
-			err(EXIT_FAILURE, _("setgid failed"));
+			err(EXIT_FAILURE, _("setgid() failed"));
 	}
 	if (force_uid && setuid(uid) < 0)	/* change UID */
-		err(EXIT_FAILURE, _("setuid failed"));
+		err(EXIT_FAILURE, _("setuid() failed"));
 
 	if (keepcaps && (unshare_flags & CLONE_NEWUSER))
 		cap_permitted_to_ambient();
-- 
2.48.1

