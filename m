Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946183B7762
	for <util-linux@vger.kernel.org>; Thu, 12 Mar 2026 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773330947; cv=none; b=kaSCP/Fs9lkUo7wwiPyVC3fQM3fjORE14shWuN29xeFUeioSB6BC2UezV4wR4Y9noVmv1OV/VAn73AecCfSIEDYeK1/uBp7KPSbtboyaLyyhRf+l7l4VZP2nO6pTBgsp4Yz16iYF/aL4uUoqDbb+0GF1rLs3ax4Zbd9nqyP/t2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773330947; c=relaxed/simple;
	bh=oxaZWDc3lpSLgdfYLu8PUDXvK1j/bfLvSLzopHs5I64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kZTF3qXemblwCCPOFDVLozEVl6EGfYM+tfEpA3KhtHgL36LxIU7HL4QkZkx16I9pcyAJtn6cZvOE1XoIF3BipZisTlJEcqWc3HyQu+I26fJ/p+f0ALOI+CgV6DQV0QgPkifKHNfoHPNDDblyn3835yG67bMlK7fvlp3YrSzA3g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=cg3UQhPo; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="cg3UQhPo"
X-KPN-MessageId: ea0923d9-1e2b-11f1-92a5-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id ea0923d9-1e2b-11f1-92a5-005056aba152;
	Thu, 12 Mar 2026 16:55:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=6KfQUhaHC+iPMcFt76gwGDe90JJednWNzxZXfj1FAR0=;
	b=cg3UQhPomJea0z9GSvCDYht1w+3xTAsADTefXVR3GCVlYmB5lusXocMicTLul4iI9h4wosIo+rFeI
	 318LlEf4DgBeO6nvtA445j0UsdDUyLyY/dmZmz37SxfxdJiAhdQQd+DuTeYYevD5L+Lw8ls516JzWZ
	 YLkTKQ8YEq+24se8=
X-KPN-MID: 33|PFxYldFmBkS37/mtC3Jsxvc9s5kI7GuigYDmRSbF9mBT7D1lhkLP+T7mFZJxJuk
 /Z38Qt+phIAnEEkeLfaIAVeWMU3slsCAvZZN+8iweZi8=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|OllIcI6SF4rZKBPju+WpmnE7iKlOJoZqmu1c+GMNSfLkFBhu6NQMGpYUvFHMtZQ
 EuTNCyVieyzQaivv/gGLsFQ==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id e9f014b4-1e2b-11f1-b8e4-005056ab7584;
	Thu, 12 Mar 2026 16:55:38 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Dick Marinus <dick@mrns.nl>
Subject: [PATCH 1/2 V2] copyfilerange: (usage) correct the markup and improve the wording
Date: Thu, 12 Mar 2026 16:55:31 +0100
Message-ID: <20260312155532.52342-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The <source>, <destination>, and <range> arguments are required,
so do not mark them as optional (with the square brackets).
Also, trim the redundant lines about the source and destination
files, improve the explanation for the <range> argument and put
it after the options, and keep the text within 80 columns.

Furthermore, list the short options first (as is custom), and
match the indentaion of the -h and -V options to the others.

CC: Dick Marinus <dick@mrns.nl>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
V2: Use the standard USAGE_ARGUMENTS header instead of an
    unusually placed lone paragraph.
---
 misc-utils/copyfilerange.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/misc-utils/copyfilerange.c b/misc-utils/copyfilerange.c
index 20f0373bd..5ee562d22 100644
--- a/misc-utils/copyfilerange.c
+++ b/misc-utils/copyfilerange.c
@@ -55,25 +55,23 @@ static void __attribute__((__noreturn__)) usage(void)
 	FILE *out = stdout;
 	fputs(USAGE_HEADER, out);
 	fprintf(out,
-		_(" %1$s [options] [<source>] [<destination>] [<range>...]\n"),
+		_(" %1$s [options] <source> <destination> <range>...\n"),
 		program_invocation_short_name);
 
 	fputs(USAGE_SEPARATOR, out);
-	fputsln(_("Copy file ranges from source to destination file."), out);
-
-	fputs(USAGE_SEPARATOR, out);
-	fputsln(_(" source                      source filename"), out);
-	fputsln(_(" destination                 destination filename"), out);
-	fputsln(_(" range                       source_offset:dest_offset:length, all values are in bytes"), out);
-	fputsln(_("                             if length is set to 0 as much as available will be copied"), out);
-	fputsln(_("                             when the offset is omitted the last file position is used"), out);
+	fputsln(_("Copy the specified range(s) from source to destination file."), out);
 
 	fputs(USAGE_OPTIONS, out);
-	fputsln(_(" --ranges, -r filename       read range(s) separated by newlines from filename"), out);
-	fputsln(_(" --verbose, -v               verbose mode"), out);
+	fputsln(_(" -r, --ranges <file>     read ranges separated by newlines from this file"), out);
+	fputsln(_(" -v, --verbose           verbose mode"), out);
 
 	fputs(USAGE_SEPARATOR, out);
-	fprintf(out, USAGE_HELP_OPTIONS(16));
+	fprintf(out, USAGE_HELP_OPTIONS(25));
+
+	fputs(USAGE_ARGUMENTS, out);
+	fputsln(_(" <range> is of the form <source_offset>:<destination_offset>:<length>,\n"
+	          " with all values in bytes. If <length> is 0, as much data as available\n"
+	          " is copied. When an offset is omitted, the last file position is used."), out);
 
 	fprintf(out, USAGE_MAN_TAIL("copyfilerange(1)"));
 	exit(EXIT_SUCCESS);
-- 
2.53.0

