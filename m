Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818B61487E9
	for <util-linux@vger.kernel.org>; Mon, 30 Jun 2025 18:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751308130; cv=none; b=Ci026B34+LpSD6W3vyVSWfhbCa98Zox+3vyYVjvWNziLtGKBhWlCYmNz79RL/uaV1FMjfgW7Ia9w5ZYieIfTdBeDu7UNxqTdYnfZksMw5QrDzz0649MI5/eHR8eI3+ELvaksR89/QxDAJwXA3IqMniPCiBqpIOiYTk5H6HV3K68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751308130; c=relaxed/simple;
	bh=1ftLnuTRP0sRwdW37HR9itO6RGLfnP6OLcBNQjYWrOA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=AJJLCyCNFoH8Oev1QnyZgRDe+gKS24ogGv5j133/XhHxVUJuoGXTI9BDUICTL2WgvqtZLq20THOiG3XrYeVBtBjXoZgj5YyvR+Bj6TkmMFlajIhdjkrZ8YfkR+Qb38CfcTHdbSWIPdJ2B6GgGNE4fe8+KspFyRIJJOm6/X3hNSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YKDg9g9c; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YKDg9g9c"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60b86fc4b47so1363a12.1
        for <util-linux@vger.kernel.org>; Mon, 30 Jun 2025 11:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751308126; x=1751912926; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nrfae+RyHx3DkLVTle8nImW+3VaDfe18ndExYhzNi1I=;
        b=YKDg9g9ciblShJ4FtbUAEc+L7GjzqNzNNUyy7HITur5ONQYMwFWpBddoL0rDDrxF7S
         Ky4Npnz6W73stPvli9HxQMbb36lYmnzlX8NXerUe3JXoUt8osiSlkt9DgWQ47gn2O5Aw
         2LF0jMRkCOC9SnI5ydcOjw5KXLfjHTkWhqp4g5sfDgHpccV4YWToQ9SQApzaN152XLcc
         qPRPmW9pa/QpNJhSVv1jPuBixhiOK0BEGhOOtMC/hOTHE6OmpXV1TaxVPL1vwYFeSR2U
         MEVGI9ffNb6J7eg9GXe7yy0XUGPojjrsFV2m4VNQmOzUYTpf1J1Bvq3qFq3LsqahMbsY
         duHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751308126; x=1751912926;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nrfae+RyHx3DkLVTle8nImW+3VaDfe18ndExYhzNi1I=;
        b=wJpn6lz8T8lGAJQevSKgQh6fCInSwo1WdNGU1bNDwlOFEXU/xSHuwOji9p9GxEtU2j
         l7gVnQdW2Y6LNvXc/Io5KJvN8zP8M9wPbgYY/aU7ULU3rKcR0GOW1vJDulzL2ay3Vyt0
         4nVMr5cYkwGnsLNk+3PFnc1/XkWhePQZ5UiA18axGOsYS9R0eLgMPwDpSSvbNdtu6ULI
         PH0mewQNyYZTUZKvwdkojY0gEmlpy5xqUAGoTE944nNDtCak78p38Xwudj13BIXt01lE
         HxWd/CJuE8P6yKoStvF3DSTt4LKLS9daAULGYzCLlZlO5waAStQqLSn433kNRqtHsGfR
         eYWg==
X-Gm-Message-State: AOJu0YxFr+6ZIUTjyNhnK19E6MImbFJMCSkTVQ1cq+uXyTBkn7mGC9nK
	/Ecd5l0ToWDbX4iAVw7O46yreDwYvoVMFOxK8ZtO3EVnSuDNHSD0PdEokjB176UGOwydMIUYs3o
	+siT99ijauk0sDz7oH5+sixyUZOHlWWseRsWsGcX5A5aC4tyoL5wEtwPGjRw=
X-Gm-Gg: ASbGncscgSTkceidSXFVDPNNgL3rLDKzb6CrHZUPs2/HFHzXLaN22W5kjHED2LWW9q0
	fnOluyAJQ8QsAeaNELE+S0ZsFhZDOxLcO4v0fIa52n6vt3Xb7My5SGZPEUEAiO03RlIKDObmzC4
	lBX60Ltyxq/9DGZAc2zDiHVoxv7If2bMnWQaBH4LLtxx0=
X-Google-Smtp-Source: AGHT+IEuk/ih/llgKEa8nzT1zyJYYSNBsE+2ecCqT4AeD5fQj/ALEZhzD62Bbi7IdWOQEsB6O0LOrlTBN1Z0rH96naw=
X-Received: by 2002:a05:6402:17d5:b0:609:99a7:efdb with SMTP id
 4fb4d7f45d1cf-60e33326819mr7587a12.2.1751308126191; Mon, 30 Jun 2025 11:28:46
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jesse Rosenstock <jmr@google.com>
Date: Mon, 30 Jun 2025 20:28:34 +0200
X-Gm-Features: Ac12FXzTxewenuttCz0IB3pmzgCQOP4213bzBEkHviQHK9PZs-pqM1qSLPxiKw4
Message-ID: <CAMZQ0rJXkMMkyWfLW8y6cTsrpoELoCM4emjg7Aex2vxQ2RFhBA@mail.gmail.com>
Subject: [PATCH] taskset: Accept 0 pid for current process
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This is useful to print the current mask without using `$$`: `taskset -p 0`.

It is also helpful to test taskset: `taskset -c 1-4 taskset -p 0`.
This is not easy with `$$`.

sched_setaffinity(2)/sched_getaffinity(2) accept 0 for the calling
thread, so this seems consistent.

As an implementation detail, we replace 0 with getpid(), so the existing
pid != 0 <==> "will exec" logic continues to work unchanged.

A reasonable alternative would be to interpret just `taskset` (currently
an error) as printing the current mask.  This seems less orthogonal,
and a better use may be found for plain `taskset` in the future.

https://github.com/util-linux/util-linux/pull/3637

Signed-off-by: Jesse Rosenstock <jmr@google.com>
---
 schedutils/taskset.1.adoc |  8 ++++++++
 schedutils/taskset.c      | 10 +++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/schedutils/taskset.1.adoc b/schedutils/taskset.1.adoc
index 9773303f73..ebd9fdafe8 100644
--- a/schedutils/taskset.1.adoc
+++ b/schedutils/taskset.1.adoc
@@ -77,6 +77,7 @@

 *-p*, *--pid*::
 Operate on an existing PID and do not launch a new task.
+If PID is zero, then operate on the *taskset* process.

 include::man-common/help-version.adoc[]

@@ -134,6 +135,13 @@
 $ echo $? +
 1 +

+== EXAMPLES
+
+Print the current CPU affinity.
+
+$ taskset -pc 0 +
+pid 1355988's current affinity list: 0-47 +
+
 == AUTHORS

 Written by Robert M. Love.
diff --git a/schedutils/taskset.c b/schedutils/taskset.c
index b52cd4338b..40ccbb7342 100644
--- a/schedutils/taskset.c
+++ b/schedutils/taskset.c
@@ -186,7 +186,15 @@
                        all_tasks = 1;
                        break;
                case 'p':
-                       pid = strtopid_or_err(argv[argc - 1],
_("invalid PID argument"));
+                       // Like strtopid_or_err() but accept 0 for this process,
+                       // like sched_getaffinity()/sched_setaffinity() do.
+                       pid = (pid_t) str2num_or_err(
+                               argv[argc - 1], 10, _("invalid PID argument"),
+                               0, SINT_MAX(pid_t));
+                       if (pid == 0)
+                               pid = getpid();
+                       // After this point, pid == 0 means "no pid" and that
+                       // we will exec a command.
                        break;
                case 'c':
                        ts.use_list = 1;
