Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AF738BF9C
	for <util-linux@vger.kernel.org>; Wed, 13 May 2026 10:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778666481; cv=none; b=GisHLKfQxnezJCBm8Yvpnq7HgV6ubU9ACeT3e13E6kwYf8b22GiscN6csOOrk7oBz2F853P3UWpA9yQTe+FR0rbWFO/99y5fE2IN5oiMzHUa22MZth0HK71F3zkCc4mq4ojAPRVP+ceT3ltydqIkeTCixHd0lfpLDk9XchgqIgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778666481; c=relaxed/simple;
	bh=uagF3F7xgd2kxwov8ARCTlDL9Wg9AyI9klSTi6J3sGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LQWDXFBVWyj1PM3PZqe7qQOFSdELtI6ySrtCePUwhV2qSgrjSAtie8xZ1ADyNp3tSbs6RyFTpCW2sUhpVSq8ldgCgA7Sn43ThtUSGksexw/PnND4yDwSRtSoOuIqjB7DiUiRnZfLwzyRzIdCGqmBSmQWLDIsuMyiMpF3p15xNpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oFFCZovY; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFFCZovY"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43fe3e22e33so3948579f8f.0
        for <util-linux@vger.kernel.org>; Wed, 13 May 2026 03:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778666476; x=1779271276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c8fojooG2OWzpuYl7t+Pz6YWd0os7JqH/FCccxi98Hg=;
        b=oFFCZovY2e2+mGEJmLQ1ntvv9dHm38itztOE/+EegEQVwoZwNOkKiDTIaKcogJbSmG
         bwQ29d/Nsudf6KxTamB/7K9re+303k6TWCTijMIo/JHVVA7HBiY2W46T1Uc7+OAdtrEH
         QKuQnSZafEf6GDsVJWTkoS+k9H3fk2C9L8uAZmhkXTUfrK2eVUzkn+9dKQe0EF1sPGN6
         NaHHE+LIx2IxByZucRjfrCL3SXDcKL09CR/jiH7GK+eFvknic9grRLAfSkY3r38Rou79
         X7re7aiQMJWw0oAcoZo4ZzsoSFAxRMPKPdnKtym5kKdwXBrR8n2fKwPaS3dtDiTebVam
         pdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778666476; x=1779271276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8fojooG2OWzpuYl7t+Pz6YWd0os7JqH/FCccxi98Hg=;
        b=aRpDfOOFNnsno7swepDCto6FCZijvKY6zRB9MRjKT3Ig98sEfFx0iqRds6Oc7EYtXj
         L28vWD7vFSIaURebK7uZUVP8MbvBL1+VYIj7y5fQSN6Nj4/fZGj9BwORlwzBuIhZcM0t
         d+8WmLTNUrtgN6Hc2vEe6UBXQN9QLd2HxJFB75pOGbNCPMiIpvCZioRZPhgvB1NS2a9l
         6ZhX3f8yh2gl4fRiq6ievM3Y0dY5Yo6tX6z5G2I/uZqrJT5DTMF23Lt6f0rybXDf5mLI
         a2AM7GtxTDzHKzcL9m2rsf6RsGB8OqWW5Ez4IJw0s3LByS082P7EPt+3B883OG6sXgjw
         f0eQ==
X-Gm-Message-State: AOJu0Yw5T2E5Oo3TIW9ofa8MY8G6CTijDAYfH+GQ8no79BcHmPMm4njk
	zzHcAAxpe7mCLLLvgdBqqmOd3qH/uM8BUgcNBVsbXBBvgOc2yuQaRyNIIar49g35
X-Gm-Gg: Acq92OFzwWCa02Ubb9iW6e/wDtc6K/lM8JlKU/RJcaYemPQ4IV45Gt+F+UGaybCjB35
	d04qvs/XTJSMcOiSj1UKynk7+yday9RZZN43QEbKcMsuEc2+xA2RNSLX/EhQAfCgRsElt4sX/Qd
	XptyScVvOtU2jZ7aDGHf5UnedhtIpWh9e+o4MMq24yjLdKWXEQDKU9gE2cZHBQPKRzioBiwLV55
	/3lgi5BWCISON6jseUM7DcSAccUU8zf61BxxpQ/ISlkYe9FjLAsvK5oObO6Dza/CuipjWF9t3Pe
	KArxhberrpxO48dBi/Y6EvDl68EgbmErI508kc/Qjt+hEWfoSjcaeQwAtmM4Gy1DRnpx2GbqtO9
	uYLPlQCGqvFwb0xBOkLxrdihEL7NxzbGrNxcLOJlHZN1+Smli3HRlhYO6ZhOFYMFFYC/OTCGjIw
	TnhEak1+ZsJIB9j9uXVOx2dmM=
X-Received: by 2002:a05:600c:5298:b0:48a:768b:eea9 with SMTP id 5b1f17b1804b1-48fc9a08e50mr34830895e9.4.1778666475864;
        Wed, 13 May 2026 03:01:15 -0700 (PDT)
Received: from notebook.. ([88.230.46.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f438890sm45497745e9.23.2026.05.13.03.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 03:01:15 -0700 (PDT)
From: Furkan Caliskan <frn1furkan10@gmail.com>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com,
	bensberg@telfort.nl,
	vineethr@linux.ibm.com,
	Furkan Caliskan <frn1furkan10@gmail.com>
Subject: [PATCH] chrt: Add support for SCHED_FLAG_DL_OVERRUN
Date: Wed, 13 May 2026 13:01:00 +0300
Message-Id: <20260513100100.31857-1-frn1furkan10@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When set on a SCHED_DEADLINE task, the kernel sends SIGXCPU to the
task if it exceeds its runtime budget within a period. Without this
flag the task is silently throttled until the next period. Useful
for real-time applications that need to detect when they are not
meeting their timing requirements.

Add -O/--deadline-overrun option to allow users to toggle this
feature using the deadline scheduling class.

Signed-off-by: Furkan Caliskan <frn1furkan10@gmail.com>
---
 bash-completion/chrt   |  1 +
 schedutils/chrt.1.adoc |  3 +++
 schedutils/chrt.c      | 17 ++++++++++++++++-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/bash-completion/chrt b/bash-completion/chrt
index 363efdfa1..ead03b023 100644
--- a/bash-completion/chrt
+++ b/bash-completion/chrt
@@ -19,6 +19,7 @@ _chrt_module()
 				--all-tasks
 				--batch
 				--deadline
+				--deadline-overrun
 				--ext
 				--fifo
 				--help
diff --git a/schedutils/chrt.1.adoc b/schedutils/chrt.1.adoc
index 7c2ceab86..13a785c7e 100644
--- a/schedutils/chrt.1.adoc
+++ b/schedutils/chrt.1.adoc
@@ -85,6 +85,9 @@ Specifies deadline parameter for *SCHED_DEADLINE* policy (Linux-specific).
 *-G*, *--reclaim-grub*::
 Enables GRUB (Greedy Reclamation of Unused Bandwidth) algorithm. Linux-specific, supported since 4.13.
 
+*-O*, *--deadline-overrun*::
+Set *SCHED_FLAG_DL_OVERRUN* to receive *SIGXCPU* when a *SCHED_DEADLINE* task exceeds its runtime budget within a period. Without this flag the task is silently throttled until the next period. Linux-specific, supported since 4.16.
+
 *-R*, *--reset-on-fork*::
 Use *SCHED_RESET_ON_FORK* or *SCHED_FLAG_RESET_ON_FORK* flag. Linux-specific, supported since 2.6.31.
 +
diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index 6bf08c5c1..cec41468a 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -93,6 +93,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_("Scheduling options:\n"), out);
 	fputs(_(" -R, --reset-on-fork       set reset-on-fork flag\n"), out);
 	fputs(_(" -G, --reclaim-grub        set SCHED_FLAG_RECLAIM\n"), out);
+	fputs(_(" -O, --deadline-overrun    set SCHED_FLAG_DL_OVERRUN\n"), out);
 	fputs(_(" -T, --sched-runtime <ns>  runtime parameter for DEADLINE\n"), out);
 	fputs(_(" -P, --sched-period <ns>   period parameter for DEADLINE\n"), out);
 	fputs(_(" -D, --sched-deadline <ns> deadline parameter for DEADLINE\n"), out);
@@ -440,6 +441,7 @@ int main(int argc, char **argv)
 		{ "all-tasks",  no_argument, NULL, 'a' },
 		{ "batch",	no_argument, NULL, 'b' },
 		{ "deadline",   no_argument, NULL, 'd' },
+		{ "deadline-overrun", no_argument, NULL, 'O' },
 		{ "ext",	no_argument, NULL, 'e' },
 		{ "fifo",	no_argument, NULL, 'f' },
 		{ "idle",	no_argument, NULL, 'i' },
@@ -463,7 +465,7 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	close_stdout_atexit();
 
-	while((c = getopt_long(argc, argv, "+abdD:efiphmoP:T:rRGvV", longopts, NULL)) != -1)
+	while((c = getopt_long(argc, argv, "+abdD:efiphmoOP:T:rRGvV", longopts, NULL)) != -1)
 	{
 		switch (c) {
 		case 'a':
@@ -499,6 +501,11 @@ int main(int argc, char **argv)
 		case 'G':
 #ifdef SCHED_FLAG_RECLAIM
 			ctl->sched_flags |= SCHED_FLAG_RECLAIM;
+#endif
+			break;
+		case 'O':
+#ifdef SCHED_FLAG_DL_OVERRUN
+			ctl->sched_flags |= SCHED_FLAG_DL_OVERRUN;
 #endif
 			break;
 		case 'i':
@@ -596,6 +603,14 @@ int main(int argc, char **argv)
 #  endif
 	if ((ctl->sched_flags & SCHED_FLAG_RECLAIM) && ctl->policy != SCHED_DEADLINE)
 		errx(EXIT_FAILURE, _("--reclaim-grub is only supported for SCHED_DEADLINE"));
+# endif
+# ifdef SCHED_FLAG_DL_OVERRUN
+#  ifndef HAVE_SCHED_SETATTR
+	if (ctl->sched_flags & SCHED_FLAG_DL_OVERRUN)
+		errx(EXIT_FAILURE, _("SCHED_FLAG_DL_OVERRUN is unsupported"));
+#  endif
+	if ((ctl->sched_flags & SCHED_FLAG_DL_OVERRUN) && ctl->policy != SCHED_DEADLINE)
+		errx(EXIT_FAILURE, _("--deadline-overrun is only supported for SCHED_DEADLINE"));
 # endif
 	if (ctl->policy == SCHED_DEADLINE) {
 		/* The basic rule is runtime <= deadline <= period, so we can
-- 
2.34.1

