Return-Path: util-linux-owner@vger.kernel.org
Received: from mailbigip.dreamhost.com ([208.97.132.5]:47932 "EHLO
	homiemail-a61.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755805Ab2BNLNP (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 14 Feb 2012 06:13:15 -0500
Subject: [PATCH 1/4] misc-utils: fix typos
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 14 Feb 2012 12:13:12 +0100
Message-ID: <1329217992.3269.5.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 misc-utils/findmnt.c |    2 +-
 misc-utils/whereis.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index 9acc6e2..9a5ed3a 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -1067,7 +1067,7 @@ int main(int argc, char *argv[])
 		if (tabtype != TABTYPE_KERNEL)
 			errx_mutually_exclusive("--{poll,fstab,mtab}");
 		if (ntabfiles > 1)
-			errx(EXIT_FAILURE, _("--poll accepts only one file, but mure specified by --tab-file"));
+			errx(EXIT_FAILURE, _("--poll accepts only one file, but more specified by --tab-file"));
 	}
 
 	if (optind < argc && (get_match(COL_SOURCE) || get_match(COL_TARGET)))
diff --git a/misc-utils/whereis.c b/misc-utils/whereis.c
index 17bb2d4..4a123f1 100644
--- a/misc-utils/whereis.c
+++ b/misc-utils/whereis.c
@@ -147,7 +147,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 		" -M <dirs>  define man lookup path\n"
 		" -s         search only sources path\n"
 		" -S <dirs>  define sources lookup path\n"
-		" -u         search from unusual enties\n"
+		" -u         search from unusual entities\n"
 		" -V         output version information and exit\n"
 		" -h         display this help and exit\n\n"), out);
 
-- 
1.7.4.1




