Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD41A2F4A15
	for <util-linux@vger.kernel.org>; Thu, 23 Apr 2026 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776939332; cv=none; b=GRxn3cuZt0Q5j8wsw5CnFxUSIr3WhUhUkbP//Cb9p+EefSm1yUIi26yPaMpBWq+umM3vqg2SV1BiiFNHyaAj6aWeJMPeOnfB+8l8WPZDC8T6cDjibinDysLRaY6PIszCN4TkktswL5Vf2YOEHGorjUAskCD6SEUZfs7Up071uwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776939332; c=relaxed/simple;
	bh=iJxdNOjPVY9g9pDmaK1Rc3f9LN+EFPHVSKgabyk1Jto=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rygTUEDNQSV/YRiSdYSyXPyzJpyqGfpZzX61PIqybNuLnXo1SrLUYMR7eitgwvHGUsQ8Jj/AkZWOIJx6pyjrCeg77Lmu0EWcjPtb34laV7Na8jVzTuqgZCRtBAYbwts0o/nwMKHsfPEhH9R9MnqEh48OWj1K0odV3F8Bw/01zsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3s4PWfI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3s4PWfI"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so29385805e9.0
        for <util-linux@vger.kernel.org>; Thu, 23 Apr 2026 03:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776939329; x=1777544129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E2SgYaNy4qIu6DeXd05dRdL1RhJxKKEhsmTQIWkK1o0=;
        b=f3s4PWfI7/B56ZBN68+hKy+VAHNv2vk5srtnn8q+trGAa9dJJmELJpH7lqfr1dTG1Z
         nnqSJjyyEL7t2Fig4v91mZk1c42RFVdJtqWb0up7YWftYbPJUK+ehHhMjflrtW+C0aBr
         3Ddv7P8pJZHE6HUqAXlOLkN/px8XKY60fqqOyU/+XHLmUQcx/9gPDRnyPAMxwb3tkaiU
         /4Lo7twPfDsVE02Ece+FLMu+OUzP4H1ZYnyz4ui20IoagoM0SMo0weDyzrn1uUOdcDCp
         VWz6LMZQmouPXjvViVm/xTAw6CVBAENq75Vuvd/bF5ISezeUC2CRugKA6FH87O19FJuA
         plew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776939329; x=1777544129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2SgYaNy4qIu6DeXd05dRdL1RhJxKKEhsmTQIWkK1o0=;
        b=B4CVAPM608DF2m4hKQh09h4G/XQeK7DvAuVHs37q5wjmWKj8NXdIUYM30BrFsP5V1w
         2C/LViLXdviSnPJ0konG9o0xNwdd4KSIF7yoUAN4YgKnSlJS4uDgsLzUh0l4EQUVRLMg
         tXpvONDE8pmagKinHXDPHWOQ/2wO8UnIOr2AMw7HKiAJu5VZjCTRiNXpODegAML0DrkC
         6IyCx33muzcn7dsHNPABoX0px6lzELA+gB/n1sVl0GjlWU42onAhPVoC/z/ovlnDsLvZ
         2Zq3AWVAgTtGYsxjuOg3hO+C2lQBTMDd5vowv++Oa5dl54tUpxFInbkzv5yRqqb4+B1s
         Mqiw==
X-Gm-Message-State: AOJu0Yw4BW7IVMVhRI3UzvS/H9RZPJJgp78NyzWQssMfCMsMqsRnHI1w
	TbIVd+5ZNSKgpulayJuRaLWU8rDCe+RatUN62/s+NlHSORN41LrkaFsrLgEjmg2P
X-Gm-Gg: AeBDievWY3n1jpWscWqY66lw6aubvGdmICGeMBYMMJ2vxAvRpzQDxzd1udiHXkbELds
	j+AulAINPYTmvR4hUpmgAFOUrOLTcIkYx93BcFSr8WA4A24yAKlvS0qpxO0tt0GmtXC+KYiEtMT
	bY4bHvi7aKFqX3ehYHe6zUCIYma+uES4d2bfDwQCIiLG5kZUEdgzde1fn6ydQ0GnSUglqyly5Gp
	jKRKY12p5il+TUuiXUmMbTvINsO1PPlW/LSUR2Pd2CfPe0zNlZQA2D+iNPKY1+Q9hKBHIRyRPTv
	rcqD/2UtmCtPCW5z8/borf61BWpHRZofTqYhy3i6UaBmh5Sye20lFrS+qkIz6qas/cG1m7Y/1ON
	uwvqVBmsOoEVX4d5GiRlzBqYY4K2Gk3vR1qVB91m0xVtQ8dv9euRBPPPGZqIQNZVrdDlZB52AKY
	vBc3OvnKlJkddIah6ZnukwBINNB6CJADdyPt0=
X-Received: by 2002:a05:600d:106:b0:488:a2a1:62cb with SMTP id 5b1f17b1804b1-488fb8b5753mr242303285e9.13.1776939328564;
        Thu, 23 Apr 2026 03:15:28 -0700 (PDT)
Received: from notebook.. ([85.107.102.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1365sm55581038f8f.7.2026.04.23.03.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 03:15:28 -0700 (PDT)
From: Furkan Caliskan <frn1furkan10@gmail.com>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com,
	bensberg@telfort.nl,
	vineethr@linux.ibm.com,
	Furkan Caliskan <frn1furkan10@gmail.com>
Subject: [PATCH] chrt: Add support for (GRUB) bandwidth reclaim
Date: Thu, 23 Apr 2026 13:14:07 +0300
Message-Id: <20260423101407.35502-1-frn1furkan10@gmail.com>
X-Mailer: git-send-email 2.34.1
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
 schedutils/chrt.1.adoc |  3 +++
 schedutils/chrt.c      | 13 ++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/schedutils/chrt.1.adoc b/schedutils/chrt.1.adoc
index b8d8874bc..da607d958 100644
--- a/schedutils/chrt.1.adoc
+++ b/schedutils/chrt.1.adoc
@@ -83,6 +83,9 @@ Specifies deadline parameter for *SCHED_DEADLINE* policy (Linux-specific).
 
 *-R*, *--reset-on-fork*::
 Use *SCHED_RESET_ON_FORK* or *SCHED_FLAG_RESET_ON_FORK* flag. Linux-specific, supported since 2.6.31.
+
+*-G*, *--reclaim-grub*::
+Enables GRUB (Greedy Reclamation of Unused Bandwidth) algorithm. 
 +
 Each thread has a _reset-on-fork_ scheduling flag. When this flag is set, children created by *fork*(2) do not inherit privileged scheduling policies. After the _reset-on-fork_ flag has been enabled, it can be reset only if the thread has the *CAP_SYS_NICE* capability. This flag is disabled in child processes created by *fork*(2).
 +
diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index 273905e5d..1a081e566 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -46,6 +46,7 @@ struct chrt_ctl {
 	uint64_t runtime;			/* --sched-* options */
 	uint64_t deadline;
 	uint64_t period;
+        uint64_t flag;                         /* For sched_attr->sched_flags member */ 
 
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
@@ -349,7 +351,7 @@ static int set_sched_one(struct chrt_ctl *ctl, pid_t pid)
 	/* old API is good enough for non-deadline */
 	if (!supports_runtime_param(ctl->policy))
 		return set_sched_one_by_setscheduler(ctl, pid);
-
+	
 	/* not changed by chrt, follow the current setting */
 	sa.sched_nice = getpriority(PRIO_PROCESS, pid);
 
@@ -359,6 +361,7 @@ static int set_sched_one(struct chrt_ctl *ctl, pid_t pid)
 	sa.sched_runtime  = ctl->runtime;
 	sa.sched_period   = ctl->period;
 	sa.sched_deadline = ctl->deadline;
+        sa.sched_flags    = ctl->flag;
 
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
@@ -460,6 +464,11 @@ int main(int argc, char **argv)
 		case 'R':
 			ctl->reset_on_fork = 1;
 			break;
+		case 'G':
+#ifdef SCHED_DEADLINE
+			ctl->flag |= SCHED_FLAG_RECLAIM;
+#endif
+			break;
 		case 'i':
 #ifdef SCHED_IDLE
 			ctl->policy = SCHED_IDLE;
@@ -546,6 +555,8 @@ int main(int argc, char **argv)
 	if ((ctl->deadline || ctl->period) && ctl->policy != SCHED_DEADLINE)
 		errx(EXIT_FAILURE, _("--sched-{deadline,period} options are "
 				     "supported for SCHED_DEADLINE only"));
+	if ((ctl->flag & SCHED_FLAG_RECLAIM) && ctl->policy != SCHED_DEADLINE)
+	        errx(EXIT_FAILURE, _("--reclaim-grub is only supported for SCHED_DEADLINE"));
 	if (ctl->policy == SCHED_DEADLINE) {
 		/* The basic rule is runtime <= deadline <= period, so we can
 		 * make deadline and runtime optional on command line. Note we
-- 
2.34.1

