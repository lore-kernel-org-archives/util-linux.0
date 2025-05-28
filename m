Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61277202C3A
	for <util-linux@vger.kernel.org>; Wed, 28 May 2025 09:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748425049; cv=none; b=G/gIbKqwj3uMrG90Lx3v6OFHTK7UGvWbrkWLVLxBfsDpBhKG+ubeNdTPzAhFmG0wBDmM53nxxPEA6ONaOpFwe0kEsTDPBS5nD+Ig8Q6liAYrUzyKdHbzsKY8R5HVD6venlXhhJdVExrC5QeX929hAOuY/1DhZzz0BrzlKklksPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748425049; c=relaxed/simple;
	bh=cOVeljJKT0wR15R8RMBIyMcZyqU6F8LYvf7BePfJPK8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ViXOUDv890HFpkJp9n/0w272Uud4UCjTNetDuYjMB6Y8W3AJMMAFqIJ/uoHeGxDPhSjgJZQYlRI0XKcrsrBQ0vZXqovqdklp3GGGLILy4IlanfexUbaazN4CRnpZxFugee0iGzDUcfnSnpMpgOOq5liTgE91s8Slj2aM6cnYMg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=grgjre2e; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="grgjre2e"
X-KPN-MessageId: 7ae37984-3ba7-11f0-bc2b-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 7ae37984-3ba7-11f0-bc2b-005056ab378f;
	Wed, 28 May 2025 11:38:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=BDEe4/LKQrodGp9jBD7/9t0SPscx/iei5bKrOq3wRog=;
	b=grgjre2eCKyhJDUKHPH1F2FqMyTo5ba3z2H2fWIydh0hTvbqghCxxpkNgHMisD7zczDalY+pznmEo
	 W4OT8bzfekM7eQImU1VTdsO5GNsAkOSBT0dg5m2BD1OooguX2A/4wfdsU2nwgHyNlRBAhoQE7yoLct
	 sklNudL3iWshxQRM=
X-KPN-MID: 33|rakK81DtZCad5BBAXQ2lYlb2ozd7UHJkrDx+Mh9BJVQit4MfTi+Icg5xSx5YbpZ
 pBmNoTRmxs5rok+kH31AzarvbJ9EwJVdoauNJr4KfU9E=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|q8tJEZurF+VThvAzAFkDMysI2cLq/tNQdu34lFNSlmmaKMIC2jrhOAFXqAilTqo
 FriBd0SyRZmLnHPqcznH+0g==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 59133378-3ba7-11f0-9c4a-005056ab7447;
	Wed, 28 May 2025 11:37:19 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/4] lib/strutils: call gettext() only when argument of --hyperlink is invalid
Date: Wed, 28 May 2025 11:37:02 +0200
Message-ID: <20250528093704.8896-2-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250528093704.8896-1-bensberg@telfort.nl>
References: <20250528093704.8896-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 include/strutils.h   | 2 +-
 lib/strutils.c       | 4 ++--
 lsfd-cmd/lsfd.c      | 3 +--
 misc-utils/findmnt.c | 3 +--
 misc-utils/lsblk.c   | 3 +--
 5 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/strutils.h b/include/strutils.h
index a81fdea89..70f97f0c8 100644
--- a/include/strutils.h
+++ b/include/strutils.h
@@ -59,7 +59,7 @@ extern void strtotimespec_or_err(const char *str, struct timespec *ts,
 		const char *errmesg);
 extern time_t strtotime_or_err(const char *str, const char *errmesg);
 
-extern bool hyperlinkwanted_or_err(const char *mode, const char *errmesg);
+extern bool hyperlinkwanted(const char *mode);
 
 extern int isdigit_strend(const char *str, const char **end);
 #define isdigit_string(_s)	isdigit_strend(_s, NULL)
diff --git a/lib/strutils.c b/lib/strutils.c
index af538207a..64fefa878 100644
--- a/lib/strutils.c
+++ b/lib/strutils.c
@@ -524,7 +524,7 @@ time_t strtotime_or_err(const char *str, const char *errmesg)
 	return (time_t) user_input;
 }
 
-bool hyperlinkwanted_or_err(const char *mode, const char *errmesg)
+bool hyperlinkwanted(const char *mode)
 {
 	if (mode && strcmp(mode, "never") == 0)
 		return false;
@@ -535,7 +535,7 @@ bool hyperlinkwanted_or_err(const char *mode, const char *errmesg)
 	if (!mode || strcmp(mode, "auto") == 0)
 		return isatty(STDOUT_FILENO) ? true : false;
 
-	errx(EXIT_FAILURE, "%s: '%s'", errmesg, mode);
+	errx(EXIT_FAILURE, _("invalid argument of --hyperlink: %s"), mode);
 }
 
 /*
diff --git a/lsfd-cmd/lsfd.c b/lsfd-cmd/lsfd.c
index d05a09396..ffaca8c31 100644
--- a/lsfd-cmd/lsfd.c
+++ b/lsfd-cmd/lsfd.c
@@ -2648,8 +2648,7 @@ int main(int argc, char *argv[])
 				err(EXIT_FAILURE, _("failed to drop privilege"));
 			break;
 		case OPT_HYPERLINK:
-			if (hyperlinkwanted_or_err(optarg,
-					_("invalid hyperlink argument")))
+			if (hyperlinkwanted(optarg))
 				ctl.uri = xgethosturi(NULL);
 			break;
 		case 'V':
diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index 130ac1b13..1211bfa07 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -2026,8 +2026,7 @@ int main(int argc, char *argv[])
 			findmnt.flags |= FL_SHADOWED;
 			break;
 		case FINDMNT_OPT_HYPERLINK:
-			if (hyperlinkwanted_or_err(optarg,
-					_("invalid hyperlink argument")))
+			if (hyperlinkwanted(optarg))
 				findmnt.uri = xgethosturi(NULL);
 			break;
 		case FINDMNT_OPT_ID:
diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index a65f5e4e6..da44bd631 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -2678,8 +2678,7 @@ int main(int argc, char *argv[])
 				errtryhelp(EXIT_FAILURE);
 			break;
 		case OPT_HYPERLINK:
-			if (hyperlinkwanted_or_err(optarg,
-					_("invalid hyperlink argument")))
+			if (hyperlinkwanted(optarg))
 				lsblk->uri = xgethosturi(NULL);
 			break;
 		case 'H':
-- 
2.48.1

