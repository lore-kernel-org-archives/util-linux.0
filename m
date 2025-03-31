Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A6F1DDC3F
	for <util-linux@vger.kernel.org>; Mon, 31 Mar 2025 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743414303; cv=none; b=R8zI4kBoYMU6LHUr8f9Z1prwiQMWfIJvPIM5kFlw7YM11O0IcFkgdnQQb3fvOvi06A2G4wuMAJQUyNXUHniJjEqXAMew3S2hxlSdUn/diAO9gD9+ghjQ5kTUp7Hk3D+4NXlc+mIjHHPVxuY1h8CmaL7meZmb4sgQcTki8SRAGU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743414303; c=relaxed/simple;
	bh=Gb+rUWaNGeS2MZ5lYadQyYNI6AbSWrXWsFMYlVM7yq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BefS+Xyi8FmvKPP9bR5fthR7aIz+NkQ7/CTajHgzYYazjj2HL99EgKQyk14SGPupRCJHD/zbt4FeJPaQvDl2N8s+ZBDe34ieUWkrs7oD2lhfTkdbj5O/M0MD/MOSRZy/I9vG4LTQm4T9L1vvCKCbCtxTVGMMofA2cDjvuv87ktU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=KOjB85Wd; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="KOjB85Wd"
X-KPN-MessageId: dc028e13-0e14-11f0-86cb-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id dc028e13-0e14-11f0-86cb-005056aba152;
	Mon, 31 Mar 2025 11:45:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:mime-version:message-id:date:subject:to:from;
	bh=JpVKt2B5ZFP/7JIZ9/M6C5AmMEr2b8mrcULSI1IKKW4=;
	b=KOjB85Wd/f6/zrSBJgKqHbG0yKMG3bHWD3tLPkF6guWL7gvHpeyg4f7p0yb/+jUkN8Qk3arF0xvTL
	 c5r727R5mrqU/7UJrTp0zEmIONL6YNfhvI2Yhjm+oxC6CMUrlMSh0Xfd8Hgoo4czSM+TDl5+O4suZh
	 iiTLEPJ/o+pF8y2E=
X-KPN-MID: 33|L7sazuc6xaMuNDwaUI9ihgPC/ayss+g5F7Tx2n/NvulQGgc1gRBzu++apa6hYVL
 UMzW6ScyzljbgkVv6t0aAjIpD04CcUu0ckcT3xDxgqvM=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|cBdha0U/RCEOENKdOsdp6R4j80ujtuYo5XziaE5DtSQFGQMBw7EElwZtJI4tX+1
 U74u8w8wzx9+BYhvZIjWJqA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id caaf80bd-0e14-11f0-9b49-005056ab1411;
	Mon, 31 Mar 2025 11:44:51 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: [PATCH 01/10] enosys: add the missing arguments of -s and -i to the usage text
Date: Mon, 31 Mar 2025 11:44:34 +0200
Message-ID: <20250331094443.9619-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Also, add a docstring, drop the redundant double dash from the synopsis,
add the missing -m option, and add a missing word to an error message.

CC: Thomas Weißschuh <thomas@t-8ch.de>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc-utils/enosys.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/misc-utils/enosys.c b/misc-utils/enosys.c
index 1410676dd..b7469c6bf 100644
--- a/misc-utils/enosys.c
+++ b/misc-utils/enosys.c
@@ -78,13 +78,17 @@ static void __attribute__((__noreturn__)) usage(void)
 	FILE *out = stdout;
 
 	fputs(USAGE_HEADER, out);
-	fprintf(out, _(" %s [options] -- <command>\n"), program_invocation_short_name);
+	fprintf(out, _(" %s [options] <command>\n"), program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs(_("Block certain system calls while running a command.\n"), out);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -s, --syscall           syscall to block\n"), out);
-	fputs(_(" -i, --ioctl             ioctl to block\n"), out);
-	fputs(_(" -l, --list              list known syscalls\n"), out);
-	fputs(_(" -d, --dump[=<file>]     dump seccomp bytecode\n"), out);
+	fputs(_(" -s, --syscall <name>|<nr>    system call to block\n"), out);
+	fputs(_(" -i, --ioctl <name>|<nr>      ioctl to block\n"), out);
+	fputs(_(" -l, --list                   list known system calls\n"), out);
+	fputs(_(" -m, --list-ioctl             list known ioctls\n"), out);
+	fputs(_(" -d, --dump[=<file>]          dump bytecode of seccomp filter\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	fprintf(out, USAGE_HELP_OPTIONS(25));
@@ -297,7 +301,7 @@ int main(int argc, char **argv)
 		err_nosys(EXIT_FAILURE, _("Could not run prctl(PR_SET_NO_NEW_PRIVS)"));
 
 	if (ul_set_seccomp_filter_spec_allow(&prog))
-		err_nosys(EXIT_FAILURE, _("Could not seccomp filter"));
+		err_nosys(EXIT_FAILURE, _("Could not set seccomp filter"));
 
 	if (execvp(argv[optind], argv + optind))
 		err(EXIT_NOTSUPP, _("Could not exec"));
-- 
2.48.1

