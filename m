Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E162459F3
	for <util-linux@vger.kernel.org>; Tue,  1 Jul 2025 06:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751351726; cv=none; b=Zm4K077hjKOomoxIfVr4fW2C+QLgcAXXwANAVuVu7WjLDrk+CwbJMVOaKzJn1An4UkYz/kABJkfaFGT6SBPeSwyop+DrIIRAi+4cvKpK9/OwgTQ/4+S8VVXiBNk07ET9F57Cb+e5/Iimkb3V86xSZ5Jdd0FIcXMqbW7SC4ZNKrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751351726; c=relaxed/simple;
	bh=1oqTpKmFbFnM4Pm3eR1rU2VniRMxMhqQdP+scT+ErWo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Ryih8rlf5HkzW9gpsiGyXdxFYYkY9JM+2cHG/u/7sFAdBtQOxyRAmku/lFeey67IUvZcehmRik7KJmnNKQ6jdBC3UetAS+kdNdrU8yMdLsWQPP2dv/089S6VWWace8QWE8pFe1gBt9JTu7raFTIFjmO8lHlEpU+bzBgXPu+t48Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uE/ju+J2; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uE/ju+J2"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60b86fc4b47so4998a12.1
        for <util-linux@vger.kernel.org>; Mon, 30 Jun 2025 23:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751351723; x=1751956523; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uJZ0K6phg1Abf3Sko2IXYZ2ELhGE7Krl7vtergN8Tus=;
        b=uE/ju+J2noz27ldYZn0vXofNlFAuHtRqe2N9SpSlCQTx0bRq+OjMdvcKbwNS58/I5M
         yhLCpZcpW1zqbQ3fQ4Jh643NgWBsFobmkBwdkDXWcPby6sU38+QhhB9qrGFythjcZxK+
         d4EERpN56lqIKwoktPVTXhf3r7pql1GG0KwOqHSLwfUU+9g6b2unjjAj4gXNFJlmMco6
         UB3c8aN+7imtOCiEe3QN4xV4GAfvWg7SuRDyr8XqOQqD7j4qJHR9YE4WpTT0QT8vJZVS
         s/asbyLMEVCOtKoXm4ygu+g8PpGEyCdkxI1vNDrVZutpN+pAb6NK3ZEtNfC+NGtkkqCl
         SaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751351723; x=1751956523;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uJZ0K6phg1Abf3Sko2IXYZ2ELhGE7Krl7vtergN8Tus=;
        b=Neqgnfw/IwbwS283fJ1EX3hCZSei2Rb+byLH9/KDLi1jw2/tC94ilcWtH+Uq2W5dVK
         o4JSUlOF1FO2e9iNtqNTEsOJGjl/aFWe2fT/thMPGUj6wa1wEjSxPcBNvnTO0Ol4Fru1
         abR2flY67rIDnDL0YDO2J9iD5ArgLj04rh3fspmHL1d8jPVB/ZRFA1LJ8p5ibITx4XT/
         27RE1RD2fNrpjWoxjnVcSyrsrcamlJt+C7nt2Ln4XAIUH8waBte9kpRKPB1HUHp6+3Fi
         qqzjO2fmlnKt9P6rUluSyIgAQAeOtmcpb5wovwclOrgV6TlBJLU1KO/S/7PFLvDCu3X9
         Qm9A==
X-Gm-Message-State: AOJu0YyOKao9XQXcC00AjjHbEB5z9moTngtlK/hO3Q4HOkBNGq4OuA9i
	f3TU7nxvP7NRzhH8M/JG/CWrj87BefkaqfG+F3RbxW5oRqUOCmOlWdIgBV8AlLmfU4pI+7PJ8qS
	3GEOofMx5y3Yogo8EpPLlb0Ui4ChuRXjkX/cJwo34kCOVdlxVJCjgzh75gcw=
X-Gm-Gg: ASbGncurAB/LDX+NcB5QJXkjMe9Hps2iRIKxOBWRPUH3JGqlMlX9TnDwY5G0/0JyyVn
	SZg3H/y3vBW83VnzcrwLj/GiYmc3eMmbIDELIl7RVI65FAhR/vCWWmu0F0/s7ADGx+Zjxn/XWvO
	NuKaWJAM1n7CwP8RzuppFLIPwGCnuhDHXvpLpzRQ3Wy0iy+s/8AqclsqiYZfgJZ+n0c875MMqKD
	/conyObo3g=
X-Google-Smtp-Source: AGHT+IFOUqMmP90fiourWBOL2IQBbTzOen5jVZ7o1HvMaZYpef89OU7/dJOfjL9yohCGSRFbsrrXZa6yp+TJjpkFGQA=
X-Received: by 2002:a05:6402:4496:b0:5e6:15d3:ffe7 with SMTP id
 4fb4d7f45d1cf-60e38a8846fmr41077a12.7.1751351722519; Mon, 30 Jun 2025
 23:35:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jesse Rosenstock <jmr@google.com>
Date: Tue, 1 Jul 2025 08:35:11 +0200
X-Gm-Features: Ac12FXwXBxKqwI0wf8fQUjleyf_KRtS-Sb1nklW2SYmZwlGuDcMs9Mi3Yzj_2Qw
Message-ID: <CAMZQ0rLM9UYMupEX4WLmi-J9mh0jGhruzDw3OwpU8yEf0+2E_Q@mail.gmail.com>
Subject: [PATCH v2] taskset: Accept 0 pid for current process
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fixed comment style and expanded man page example.

https://github.com/util-linux/util-linux/compare/2c585534e8350aaaa2a1958a619d67febb613dc7..7591728c7f2a4c04c7faa0cc1141ee6df9ecc45b

https://github.com/util-linux/util-linux/pull/3637

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

Signed-off-by: Jesse Rosenstock <jmr@google.com>
---
 schedutils/taskset.1.adoc |  8 ++++++++
 schedutils/taskset.c      | 14 +++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/schedutils/taskset.1.adoc b/schedutils/taskset.1.adoc
index 9773303f73..c919f82ec6 100644
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
+Print the current CPU affinity as a list.
+
+$ taskset -pc 0 +
+pid 1355988's current affinity list: 0-47 +
+
 == AUTHORS

 Written by Robert M. Love.
diff --git a/schedutils/taskset.c b/schedutils/taskset.c
index b52cd4338b..dfcf291edb 100644
--- a/schedutils/taskset.c
+++ b/schedutils/taskset.c
@@ -186,7 +186,19 @@
                        all_tasks = 1;
                        break;
                case 'p':
-                       pid = strtopid_or_err(argv[argc - 1],
_("invalid PID argument"));
+                       /*
+                        * Like strtopid_or_err() but accept 0 for this process,
+                        * like sched_getaffinity()/sched_setaffinity() do.
+                        */
+                       pid = (pid_t) str2num_or_err(
+                               argv[argc - 1], 10, _("invalid PID argument"),
+                               0, SINT_MAX(pid_t));
+                       if (pid == 0)
+                               pid = getpid();
+                       /*
+                        * After this point, pid == 0 means "no pid" and that
+                        * we will exec a command.
+                        */
                        break;
                case 'c':
                        ts.use_list = 1;
