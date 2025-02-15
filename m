Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53BC1624E8
	for <util-linux@vger.kernel.org>; Sat, 15 Feb 2025 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739636454; cv=none; b=NGiXjZtrgYxagfATcNanDUQxkH1fmBJ5x4Pudlbo3qRFCde3Z6kbPj4fE76aVwJmaiqHmaR3zOKXcVJ9LWaZKz5LqM0jaDgaRrV8NRqsdg8uCIqPQ7tM17VO/uNhnnvnjpqSUuIu2u1nRAbykcJJMux3sQKg1FYDgZ8zbzsqwBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739636454; c=relaxed/simple;
	bh=DqtetZGFb7/3LEfr0heRZIDpfNR3SuEMih430oMlO50=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hIVVBAf3TR6YCCNB+c+MePKD7alwzxBaeC5xzDxxsnusrYqJrjVHs7zlGCayb6RipAvav8wSJyAvn8sbFYWlagaQmQgAd9/8lVSUOGk02HTg/dhbLWECHld7Fdx8ZVffqa8dUC2qlwf92Jv9Ap8qHd0pwBg4pABr3/QPvRKcyJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=E4hFTxFX; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="E4hFTxFX"
X-KPN-MessageId: d2c9a937-ebb8-11ef-99cf-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id d2c9a937-ebb8-11ef-99cf-005056abbe64;
	Sat, 15 Feb 2025 17:20:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=1JEkkSJZXdzd9oWNFx0OKtKmTBayo1PwletTS1TqK3k=;
	b=E4hFTxFXs6oYR6oR01HFVyZ+hgfWNmBdsoGSQWZxxnChsPepEtrBkgtcdgx/OMDRli7z+jxMuzFtN
	 tGZXsniy8K29lBIZMdiwPIsfHw4+zHC/ycxvnraS89szv4lBVo4e3sBc+imS3j7+2sWqkvMnCdaKKo
	 R22a6n69+Op3quu0=
X-KPN-MID: 33|rA2kA13OqmzMwpvnHsegJD/FO/CyhC1Ex6OW40qbhBU7g9XaA74/ZxmHeH/4sJ0
 pv12BVZXPy/87CIQ7vtNaMUBYA5MDZfAnwWbijk3bYtE=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|75Y/WzikrKdUq1anocgKLtV8KdBXhj6lFTQJ3ZrUApTH+2N0WUo0aaLs3/CZ96j
 1CHHm3HfFjigQ7ajNzZSeFA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id d2cac95b-ebb8-11ef-92ee-005056ab7447;
	Sat, 15 Feb 2025 17:20:51 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 10/10] unshare: in usage text, reshuffle options into somewhat related groups
Date: Sat, 15 Feb 2025 17:18:43 +0100
Message-ID: <20250215161843.12053-10-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250215161843.12053-1-bensberg@telfort.nl>
References: <20250215161843.12053-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First the mount-related options (because --mount was the first
namespace option earlier) plus two other options about folders;
then the options about UIDS and GIDS; then two options about
forking; then two miscellaneous options; and lastly the two
options about time, as --time was the last namespace option.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/unshare.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index b6c2f8b45..9ec6ef7cc 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -781,7 +781,16 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -C, --cgroup[=<file>]     unshare cgroup namespace\n"), out);
 	fputs(_(" -T, --time[=<file>]       unshare time namespace\n"), out);
 	fputs(USAGE_SEPARATOR, out);
-	fputs(_(" -f, --fork                fork before launching <program>\n"), out);
+	fputs(_(" --mount-proc[=<dir>]      mount proc filesystem first (implies --mount)\n"), out);
+	fputs(_(" --mount-binfmt[=<dir>]    mount binfmt filesystem first (implies --user and --mount)\n"), out);
+	fputs(_(" -l, --load-interp <file>  load binfmt definition in the namespace (implies --mount-binfmt)\n"), out);
+	fputs(_(" --propagation slave|shared|private|unchanged\n"
+	        "                           modify mount propagation in mount namespace\n"), out);
+	fputs(_(" -R, --root <dir>          run the command with root directory set to <dir>\n"), out);
+	fputs(_(" -w, --wd <dir>            change working directory to <dir>\n"), out);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(_(" -S, --setuid <uid>        set uid in entered namespace\n"), out);
+	fputs(_(" -G, --setgid <gid>        set gid in entered namespace\n"), out);
 	fputs(_(" --map-user <uid>|<name>   map current user to uid (implies --user)\n"), out);
 	fputs(_(" --map-group <gid>|<name>  map current group to gid (implies --user)\n"), out);
 	fputs(_(" -r, --map-root-user       map current user to root (implies --user)\n"), out);
@@ -792,22 +801,15 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" --map-groups <innergid>:<outergid>:<count>\n"
 		"                           map count groups from outergid to innergid (implies --user)\n"), out);
 	fputs(USAGE_SEPARATOR, out);
+	fputs(_(" -f, --fork                fork before launching <program>\n"), out);
 	fputs(_(" --kill-child[=<signame>]  when dying, kill the forked child (implies --fork)\n"
 		"                             defaults to SIGKILL\n"), out);
-	fputs(_(" --mount-proc[=<dir>]      mount proc filesystem first (implies --mount)\n"), out);
-	fputs(_(" --mount-binfmt[=<dir>]    mount binfmt filesystem first (implies --user and --mount)\n"), out);
-	fputs(_(" --propagation slave|shared|private|unchanged\n"
-	        "                           modify mount propagation in mount namespace\n"), out);
+	fputs(USAGE_SEPARATOR, out);
 	fputs(_(" --setgroups allow|deny    control the setgroups syscall in user namespaces\n"), out);
 	fputs(_(" --keep-caps               retain capabilities granted in user namespaces\n"), out);
 	fputs(USAGE_SEPARATOR, out);
-	fputs(_(" -R, --root <dir>          run the command with root directory set to <dir>\n"), out);
-	fputs(_(" -w, --wd <dir>            change working directory to <dir>\n"), out);
-	fputs(_(" -S, --setuid <uid>        set uid in entered namespace\n"), out);
-	fputs(_(" -G, --setgid <gid>        set gid in entered namespace\n"), out);
 	fputs(_(" --monotonic <offset>      set clock monotonic offset (seconds) in time namespaces\n"), out);
 	fputs(_(" --boottime <offset>       set clock boottime offset (seconds) in time namespaces\n"), out);
-	fputs(_(" -l, --load-interp <file>  load binfmt definition in the namespace (implies --mount-binfmt)\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	fprintf(out, USAGE_HELP_OPTIONS(27));
-- 
2.48.1

