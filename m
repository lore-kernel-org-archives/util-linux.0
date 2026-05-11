Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE783FB07A
	for <util-linux@vger.kernel.org>; Mon, 11 May 2026 14:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508659; cv=none; b=kCOWRq++QStFiKU27yGBNK/E4LRrlTm8rjLlNZEvL02WP0KJGvsjiBpL+oZYtO2yqsoDh4FjHx9t5NbEMPbPINqZ7VfydxxFKaoeP8WXiMpus40prCqSzb2pDTNQUkM/vwH1//0M6itj/QrpLhkIuH/1oRhdl7ufnHoIk3EFwj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508659; c=relaxed/simple;
	bh=+JMtB28yhHTJBu6qkA2XU6vIklCgMSu+u9WgpEnLSFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B9jviFTXtn88uNAYu5Nbvo9Y/hMnpSqXoWpMyYKNwxNxzWdKNomCiWeu3YYtpItNUGGaiAcjv6F9fSmoXMoIifircTWhEZmTHh86k7CVayVEbooFHJRl7tPBA3HhwLv6xWc2m7ksXi5KqnjMsIq/rbx8wkWsOLpTF3Mp9ZyYDjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3PJddfF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3PJddfF"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488ad135063so35459095e9.0
        for <util-linux@vger.kernel.org>; Mon, 11 May 2026 07:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778508656; x=1779113456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPS/sfOIzuFiUvztrpqCqkztGsJKjAt6ewdibV5dNVQ=;
        b=h3PJddfFteBlPkzQs8KK81liFkQAT7JrAIMMEc2tPbMFi4OXz8K6dNcbOVl/X6ZLcM
         AcqcY0t4jxZ6YYuXQf8YV11qQaDmlYdedQ8i3q8h3fSDbiGFcvpTOUdljTdn/1OeNtm3
         sXk4zfMI7qojfMucOB7rjZOylSNHZ/m2nZx663uzL96cCpEZWS1DUJbpS4TdJ/XRRO6T
         HU8mbv8CUFegxsth6CAEIUXkfwmdFN0+BzERUU0lHbF/7vn70VN6FoLeG8TH8/KTOvUU
         J00xdeeGRwXic7rhaFCkOihtZQkhVUBmIJ7F4c8qPc1P0cxP5ADv3orzjeH9m7h9floU
         xt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778508656; x=1779113456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pPS/sfOIzuFiUvztrpqCqkztGsJKjAt6ewdibV5dNVQ=;
        b=qmoGpH0Ku9Wh3MywSNdyBkq8cm96aeugJAW74xNAfn22YTpgsLUm8lOLkNOlSCi3Jw
         AwUA47boa6HF2FMQgrhH7qkG4JwmparOvq0/VGXx9kGQGNp9YCzbbHFecs6DdNGHiUpg
         cmfLFqSbDk4Af2CTB6qplqhuPjsoN5c3NygfC2NZNWMwn1v3jIrXhjEIWi9KBFiHnDxy
         nF0hfe0cP5Rl+E8cGS0RAiX52xWEwt40ILv9lcQrh8wXYirwoJv5yUv5AHgGJsztoIRc
         S2c9YQEIqfURPvToB6/r9MlL+IWPzY+T/uhrFe7yy345NxPphrihkMNF/h68HNsPrh85
         0SHw==
X-Gm-Message-State: AOJu0YzdLfx/3l/8z0IpG/qfDUtrGOEhtlGz7dk9HrbFXLdc7xdjOmkj
	sP8bp9NgHsQ9ri790LyUj6TJcZG/KILjwRW4z+giQ0yY9zKQJu3lhLrEQmf7FQ==
X-Gm-Gg: Acq92OEyzN8j/S/HmE6ipNsIU0dc6ReI/KGCqztU7SnCp6lTN59Zl/2RBISig++cy7L
	yj31/eM6nyPo2m27wqDjwkm+SPhGcQSzUeHGg2q6fpZBSLi1KUKnPvIm9WhrDyvTIxwg7vziTjs
	fcbnbjKQ79+9xWQNxjmxLaNm0hZSnnoY7b2HD9QHf6s+ZJHY1Xxm/e5LQm9Cx/pNjtkY/f9neM8
	Y7SBPLf6z6oAcdgKhvsc5Y9/GwCElEYCXYQaRwf8qa5RbYJa9x3q4lbVp9Zr9Mn3NIkxaIg7eZx
	lzDWU6FlcI+m4fgpOVc6EPg9soAUA7ABQDjGmttuRF4l2rkTedQBcO8pNgoWkcw5pPDgcxXNJqa
	wRy8Ckx46d4YQaKoPQVtuLIAak4kkhCJJER5StPH5oubTJiMmSd9WvIifHcyRlJkIZmF+QIAI5X
	BhgvErFf4ONYURheRbSLhr8y0=
X-Received: by 2002:a05:600c:15d1:b0:48d:112c:f582 with SMTP id 5b1f17b1804b1-48e51e1e415mr239627275e9.11.1778508655946;
        Mon, 11 May 2026 07:10:55 -0700 (PDT)
Received: from notebook.. ([85.107.101.64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6fff9ab8sm197574275e9.2.2026.05.11.07.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:10:55 -0700 (PDT)
From: Furkan Caliskan <frn1furkan10@gmail.com>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com,
	Furkan Caliskan <frn1furkan10@gmail.com>
Subject: [PATCH v2] chrt: Add support for (GRUB) bandwidth reclaim
Date: Mon, 11 May 2026 17:10:30 +0300
Message-Id: <20260511141030.16291-1-frn1furkan10@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <qa5c2sqdvxiclkfszc7wdfdd3naa7e2w42mip3abj4auisqw6r@o2jtcbaibyep>
References: <qa5c2sqdvxiclkfszc7wdfdd3naa7e2w42mip3abj4auisqw6r@o2jtcbaibyep>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SCHED_DEADLINE policy supports the (GRUB) Greedy Reclamation
of Unused Bandwidth algorithm. This allows tasks to reclaim
bandwidth that are left over by other deadline tasks that finish
their work early, or voluntarily yield the cpu.

Currently, chrt has no way to set the SCHED_FLAG_RECLAIM bit in
the sched_flags field of the sched_attr structure.

Add -G/--reclaim-grub option to allow users to toggle this feature
using the deadline scheduling class.

Signed-off-by: Furkan Caliskan <frn1furkan10@gmail.com>
---
 bash-completion/chrt   |  1 +
 schedutils/chrt.1.adoc |  3 +++
 schedutils/chrt.c      | 17 ++++++++++++++++-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/bash-completion/chrt b/bash-completion/chrt
index 3ca13fc05..363efdfa1 100644
--- a/bash-completion/chrt
+++ b/bash-completion/chrt
@@ -26,6 +26,7 @@ _chrt_module()
 				--max
 				--other
 				--pid
+				--reclaim-grub
 				--reset-on-fork
 				--rr
 				--sched-deadline
diff --git a/schedutils/chrt.1.adoc b/schedutils/chrt.1.adoc
index b8d8874bc..90a3d376a 100644
--- a/schedutils/chrt.1.adoc
+++ b/schedutils/chrt.1.adoc
@@ -81,6 +81,9 @@ Specifies period parameter for *SCHED_DEADLINE* policy (Linux-specific). Note th
 *-D*, *--sched-deadline* _nanoseconds_::
 Specifies deadline parameter for *SCHED_DEADLINE* policy (Linux-specific).
 
+*-G*, *--reclaim-grub*::
+Enables GRUB (Greedy Reclamation of Unused Bandwidth) algorithm. Linux-specific, supported since 4.13.
+
 *-R*, *--reset-on-fork*::
 Use *SCHED_RESET_ON_FORK* or *SCHED_FLAG_RESET_ON_FORK* flag. Linux-specific, supported since 2.6.31.
 +
diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index 5ba9964c1..ab7e8e895 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -46,6 +46,7 @@ struct chrt_ctl {
 	uint64_t runtime;			/* --sched-* options */
 	uint64_t deadline;
 	uint64_t period;
+	uint64_t sched_flags;			/* For sched_attr->sched_flags member */
 
 	unsigned int all_tasks : 1,		/* all threads of the PID */
 		     reset_on_fork : 1,		/* SCHED_RESET_ON_FORK or SCHED_FLAG_RESET_ON_FORK */
@@ -79,6 +80,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_("Scheduling options:\n"), out);
 	fputs(_(" -R, --reset-on-fork       set reset-on-fork flag\n"), out);
+	fputs(_(" -G, --reclaim-grub        set SCHED_FLAG_RECLAIM\n"), out);
 	fputs(_(" -T, --sched-runtime <ns>  runtime parameter for DEADLINE\n"), out);
 	fputs(_(" -P, --sched-period <ns>   period parameter for DEADLINE\n"), out);
 	fputs(_(" -D, --sched-deadline <ns> deadline parameter for DEADLINE\n"), out);
@@ -359,6 +361,7 @@ static int set_sched_one(struct chrt_ctl *ctl, pid_t pid)
 	sa.sched_runtime  = ctl->runtime;
 	sa.sched_period   = ctl->period;
 	sa.sched_deadline = ctl->deadline;
+	sa.sched_flags    = ctl->sched_flags;
 
 # ifdef SCHED_FLAG_RESET_ON_FORK
 	/* Don't use SCHED_RESET_ON_FORK for sched_setattr()! */
@@ -417,6 +420,7 @@ int main(int argc, char **argv)
 		{ "sched-period",   required_argument, NULL, 'P' },
 		{ "sched-deadline", required_argument, NULL, 'D' },
 		{ "reset-on-fork",  no_argument,       NULL, 'R' },
+		{ "reclaim-grub",   no_argument,       NULL, 'G' },
 		{ "verbose",	no_argument, NULL, 'v' },
 		{ "version",	no_argument, NULL, 'V' },
 		{ NULL,		no_argument, NULL, 0 }
@@ -427,7 +431,7 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	close_stdout_atexit();
 
-	while((c = getopt_long(argc, argv, "+abdD:efiphmoP:T:rRvV", longopts, NULL)) != -1)
+	while((c = getopt_long(argc, argv, "+abdD:efiphmoP:T:rRGvV", longopts, NULL)) != -1)
 	{
 		switch (c) {
 		case 'a':
@@ -460,6 +464,11 @@ int main(int argc, char **argv)
 		case 'R':
 			ctl->reset_on_fork = 1;
 			break;
+		case 'G':
+#ifdef SCHED_FLAG_RECLAIM
+			ctl->sched_flags |= SCHED_FLAG_RECLAIM;
+#endif
+			break;
 		case 'i':
 #ifdef SCHED_IDLE
 			ctl->policy = SCHED_IDLE;
@@ -547,6 +556,12 @@ int main(int argc, char **argv)
 	if ((ctl->deadline || ctl->period) && ctl->policy != SCHED_DEADLINE)
 		errx(EXIT_FAILURE, _("--sched-{deadline,period} options are "
 				     "supported for SCHED_DEADLINE only"));
+#ifndef HAVE_SCHED_SETATTR
+	if (ctl->sched_flags & SCHED_FLAG_RECLAIM)
+		errx(EXIT_FAILURE, _("SCHED_FLAG_RECLAIM is unsupported"));
+#endif
+	if ((ctl->sched_flags & SCHED_FLAG_RECLAIM) && ctl->policy != SCHED_DEADLINE)
+		errx(EXIT_FAILURE, _("--reclaim-grub is only supported for SCHED_DEADLINE"));
 	if (ctl->policy == SCHED_DEADLINE) {
 		/* The basic rule is runtime <= deadline <= period, so we can
 		 * make deadline and runtime optional on command line. Note we
-- 
2.34.1

