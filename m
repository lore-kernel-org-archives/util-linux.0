Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0854A34BA35
	for <util-linux@vger.kernel.org>; Sun,  5 Oct 2025 13:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759670535; cv=none; b=PSaxWCrkf5PFMepuGJL1c8utiT3RQljNLiKL62ILLTXZunWI3EMWxpAutGAr4uD7wj2AmQBiya3tcl1Gr4ULKpWUfYKP8UGIU5o/f3K4J1oRrXXUYW+d+3Ba9eCtqLVxBMrXwXlxZTIse0ZqetBeQR/yogvo7yn8FokeWF3n6Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759670535; c=relaxed/simple;
	bh=JLsrhlrSibmc1mgLaobSaKSrfQP6NEhKKDEIRv//eIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSIKeeQGlmgdfciZ7B1rlfVpYjsd0E/YWTWh/QnOd07PtKYzTO+dUeFlnHKGvIlbZSRvOnIjQRmL5QXBrdKGbeMsD3CxB2+b3GyuPFkkjhb3iMINhwbA9Ox3SGIEyxSw2CHjuV9NWtF0sGfi8Ms1CXO1n8aif7pNBSQy1J1HlCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=F2EsUIUG; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="F2EsUIUG"
X-KPN-MessageId: 268cd198-a1ee-11f0-bd6b-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 268cd198-a1ee-11f0-bd6b-005056aba152;
	Sun, 05 Oct 2025 15:21:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=bh7i8f3A4Id5NfUzm0hZZQe5lv7MmZNNb0S2pnhSHgY=;
	b=F2EsUIUGY5fJjpFewwTREpHnNy2AZ+MAaMfRlSFgbUfVnZ1TNaH6t+UR3c1kn8kBVxThliF4rT9BE
	 HlALHRZ19FGu44BWFADiKLGzhaYUcZDOT5Cogct5tfAw0qU6mm7J+QNFOu2Xzl/RfUImKJL13K9Uyb
	 Mcq4I0ITLa56G4IM=
X-KPN-MID: 33|ZuX/kH/kj5PFdH94w4AY6WRzpaOmjQtB3yUtulgOWrh9XuqY43yEyKUhiDFAcN0
 ZWNWk9IhTA72hhGRBpZqJADE+08AaKoJ3MCYy1HFs6SQ=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|acl9A9GIQ35CoBHvy+nPGMEmv5Vb71yGYSLgnh5Xs2lNBrYvh8/Kz1il1vhMKgM
 I6j73SNBZ9MIXY2/k7AlANA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 23fcb51d-a1ee-11f0-8003-005056ab7447;
	Sun, 05 Oct 2025 15:21:02 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Christian Goeschel Ndjomouo <cgoesc2@wgu.edu>
Subject: [PATCH 2/2] swapon: rename the new --annotation option to --annotate
Date: Sun,  5 Oct 2025 15:20:48 +0200
Message-ID: <20251005132048.78447-2-bensberg@telfort.nl>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251005132048.78447-1-bensberg@telfort.nl>
References: <20251005132048.78447-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The form --annotation gave the impression that after the subsequent
"=" comes the text that each column name should be annotated with.
Furthermore, the other two options with optional arguments (--show
and --discard) are in the imperative, so follow that style and use
--annotate instead.

(In the bargain, this allows aligning the descriptions in the help
text perfectly again.)

Also, improve the description of --annotate in the man page somewhat.

CC: Christian Goeschel Ndjomouo <cgoesc2@wgu.edu>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 bash-completion/swapon     | 2 +-
 lib/strutils.c             | 2 +-
 man-common/annotation.adoc | 8 ++++----
 sys-utils/swapon.c         | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/bash-completion/swapon b/bash-completion/swapon
index d94d2234d..5906ec844 100644
--- a/bash-completion/swapon
+++ b/bash-completion/swapon
@@ -56,7 +56,7 @@ _swapon_module()
 	case $cur in
 		-*)
 			OPTS="--all
-				--annotation
+				--annotate
 				--discard
 				--ifexists
 				--fixpgsz
diff --git a/lib/strutils.c b/lib/strutils.c
index e4dabf212..a3b1376e3 100644
--- a/lib/strutils.c
+++ b/lib/strutils.c
@@ -562,7 +562,7 @@ bool annotationwanted(const char *mode)
 	if (!mode || strcmp(mode, "auto") == 0)
 		return isatty(STDOUT_FILENO) ? true : false;
 
-	errx(EXIT_FAILURE, _("invalid argument of --annotation: %s"), mode);
+	errx(EXIT_FAILURE, _("invalid argument of --annotate: %s"), mode);
 }
 
 /*
diff --git a/man-common/annotation.adoc b/man-common/annotation.adoc
index 8f9d4c879..cbace162e 100644
--- a/man-common/annotation.adoc
+++ b/man-common/annotation.adoc
@@ -1,6 +1,6 @@
-*--annotation*[**=**_when_]::
-Adds an annotation to column header names which can be printed as a
-tooltip by supporting terminals. The optional _when_ argument can be
-*always*, *never*, or *auto*. If the argument is omitted, it defaults to
+*--annotate*[**=**_when_]::
+Adds an annotation to each column header name. Such an annotation can be shown
+as a tooltip by terminals that support this feature. The optional _when_ argument
+can be *always*, *never*, or *auto*. If the argument is omitted, it defaults to
 *auto*, which means that annotations will only be used when the output
 goes to a terminal.
diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index 896728880..fc5351e21 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -840,7 +840,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -T, --fstab <path>       alternative file to /etc/fstab\n"), out);
 	fputs(_("     --show[=<columns>]   display summary in definable table\n"), out);
 	fputs(_("     --output-all         output all available columns\n"), out);
-	fputs(_("     --annotation[=<when>]  annotate columns with a tooltip (always|never|auto)\n"), out);
+	fputs(_("     --annotate[=<when>]  annotate columns with a tooltip (always|never|auto)\n"), out);
 	fputs(_("     --noheadings         don't print table heading (with --show)\n"), out);
 	fputs(_("     --raw                use the raw output format (with --show)\n"), out);
 	fputs(_("     --bytes              display swap size in bytes in --show output\n"), out);
@@ -900,7 +900,7 @@ int main(int argc, char *argv[])
 		{ "version",      no_argument,       NULL, 'V'                 },
 		{ "show",         optional_argument, NULL, SHOW_OPTION         },
 		{ "output-all",   no_argument,       NULL, OPT_LIST_TYPES      },
-		{ "annotation",   optional_argument, NULL, ANNOTATION_OPTION   },
+		{ "annotate",     optional_argument, NULL, ANNOTATION_OPTION   },
 		{ "noheadings",   no_argument,       NULL, NOHEADINGS_OPTION   },
 		{ "raw",          no_argument,       NULL, RAW_OPTION          },
 		{ "bytes",        no_argument,       NULL, BYTES_OPTION        },
-- 
2.51.0

