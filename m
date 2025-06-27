Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D0E19F461
	for <util-linux@vger.kernel.org>; Fri, 27 Jun 2025 12:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751025927; cv=none; b=cwyIyipS4Vs/25RxNbOBV84hnzTto5CN4G/7d4OSjtWw3JKi0sJStYSDWb5+arTl0BhaRDmjXgY0wLSWRNTkpYM71XZGtlusoIB7oYrdp5gvbtWQR2oXKmG8CTWZdUCF92zCpoXcgnM/N/sPIixzkpPK+rmh+MfitckiIdPZNO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751025927; c=relaxed/simple;
	bh=JXh4b5/UONxBRLh0EUIGRjQ3wa4wCh8XtgkEg94SPL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LsGhCmQXfzaRB1sK4bvCb7HEH2/PrwBWLGsEvdePiaWWy8OIODNdK5S1tqZHpfKm1XEUKfQ0EwKXr1n4AoGkNMr7nhyBpMmdcfHz8zBEOc8ePOvdSeDAt13H4bD/F3vteDdg1tyonS4Kq5CrNwExfWaxnjN3wkMoCeoEkAPBPP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=RCfdSqxp; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="RCfdSqxp"
X-KPN-MessageId: 0593f126-534f-11f0-86d0-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 0593f126-534f-11f0-86d0-005056aba152;
	Fri, 27 Jun 2025 14:05:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=srRZ+SplgrNCu/lSUnFzn7ldT5NqkpRfQk+pslw1MOU=;
	b=RCfdSqxpzlGNyr2INHq41VfQvQ/0KUb5/IsudL//nH1QhdOEEvjQDzhJL/Wamv/lYAVOTXzXLDZPV
	 vRkcY8UCumgNzHPpl/mcOYZP99VH0ZwzbNiT1QMUqksSujr94Zn+VE+yt9QkSzaK5USDxLlNgavIc2
	 GhfRH5XvQVHIS4hY=
X-KPN-MID: 33|DcTJEFEYjtDX2CNMApE15P38HR5zWg/xbiBFXRjcOA8qlXmnN6taXKcaMFPeaOa
 1ABEbeGUhmC+0m7ud4okf0SzqiBwi9/E+niOVSY4L/a4=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|3rNbFtyn96aM34COStKM2CYVZAYjvoGSX5dFKZst9Y9jGNPkNzWy4JLf4ldMr+J
 DhgtOmBuiPYpR1ouiefrV3g==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id d7b5b245-534e-11f0-9c81-005056ab7447;
	Fri, 27 Jun 2025 14:04:14 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: WanBingjiang <wanbingjiang@webray.com.cn>
Subject: [PATCH 1/2] script: (man,usage) correct the markup of the synopsis
Date: Fri, 27 Jun 2025 14:04:07 +0200
Message-ID: <20250627120408.11036-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also, use the word "command", to match the wording for the --command
option, and improve the wording of the description of that option.

This fixes 7268e79bc5.

CC: WanBingjiang <wanbingjiang@webray.com.cn>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 term-utils/script.1.adoc | 5 +++--
 term-utils/script.c      | 8 ++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/term-utils/script.1.adoc b/term-utils/script.1.adoc
index 688ec5e2d..b4bec0c02 100644
--- a/term-utils/script.1.adoc
+++ b/term-utils/script.1.adoc
@@ -49,7 +49,7 @@ script - make typescript of terminal session
 
 == SYNOPSIS
 
-*script* [options] [_file_] [ -- program [arguments]]
+*script* [options] [_file_] [*--* _command_ [_argument_...]]
 
 == DESCRIPTION
 
@@ -69,7 +69,8 @@ Below, the _size_ argument may be followed by the multiplicative suffixes KiB (=
 Append the output to _file_ or to _typescript_, retaining the prior contents.
 
 *-c*, *--command* _command_::
-Run the _command_ rather than an interactive shell. This makes it easy for a script to capture the output of a program that behaves differently when its stdout is not a tty. It's possible to specify the command after '--' too.
+Run the _command_ rather than an interactive shell. This makes it easy for a script to capture the output of a program that behaves differently when its stdout is not a tty.
+Instead of using option *-c*, the _command_ may also be specified after a double dash (*--*).
 
 *-E*, *--echo* _when_::
 This option controls the *ECHO* flag for the slave end of the session's pseudoterminal. The supported modes are _always_, _never_, or _auto_.
diff --git a/term-utils/script.c b/term-utils/script.c
index 80ea477ab..7ba57a6a6 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -191,7 +191,7 @@ static void __attribute__((__noreturn__)) usage(void)
 {
 	FILE *out = stdout;
 	fputs(USAGE_HEADER, out);
-	fprintf(out, _(" %s [options] [file] [-- program [arguments]]\n"), program_invocation_short_name);
+	fprintf(out, _(" %s [options] [<file>] [-- <command> [<argument>...]]\n"), program_invocation_short_name);
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_("Make a typescript of a terminal session.\n"), out);
@@ -208,8 +208,8 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(USAGE_SEPARATOR, out);
 
 	fputs(_(" -a, --append                  append to the log file\n"), out);
-	fputs(_(" -c, --command <command>       run command rather than interactive shell\n"
-		"                                 (alternative to '-- program [arguments]')\n"), out);
+	fputs(_(" -c, --command <command>       run <command> rather than an interactive shell\n"
+		"                                 (alternative to '-- <command> [<argument...>]')\n"), out);
 	fputs(_(" -e, --return                  return exit code of the child process\n"), out);
 	fputs(_(" -f, --flush                   run flush after each write\n"), out);
 	fputs(_("     --force                   use output file even when it is a link\n"), out);
@@ -930,7 +930,7 @@ int main(int argc, char **argv)
 	/* concat non-option arguments as command */
 	if (argc > 0 && strcmp(argv[-1], "--") == 0) {
 		if (ctl.command != NULL) {
-			warnx(_("option --command and '-- program' are mutually exclusive"));
+			warnx(_("option --command and a command after '--' cannot be combined"));
 			errtryhelp(EXIT_FAILURE);
 		}
 
-- 
2.48.1

