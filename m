Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83782E7199
	for <util-linux@vger.kernel.org>; Mon, 30 Jun 2025 19:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751310014; cv=none; b=l3hq72XvSnnoX5s+dlWM7FQpoJjdAFzZMOxqckkpW/2qcYjFH/ge64loPwPQuA4ib8JaW3q7KP7WJSkdKJGbHN86ETfsRNLFGdKUpgk231/kctfFY29Y++/cvOL682ZuUoVX/+jXgNrk7WEXtSRvMqe0w7wrMG6ClCDjYB2uW7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751310014; c=relaxed/simple;
	bh=vszTmDEIu7cyqATsIQtXwm8giFegD3pLx+Ra6BI38eQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Mi0DH3lu9CluRU4K6eQ1XeRyXcfujf4A4Tca0/0JDrbjgHqPJEVzwwMyxq1YQeHf0HvnOzHeleQkkEViz/4j4bqYFfAzpGfrX3Mj2z1eezH89RXo147RZIFZlrmC46Zf03voIhUbQcNJAJSo+AiGNwBgOck4/0BpOnRFu2BKRpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pfq3ywd7; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pfq3ywd7"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6098ef283f0so2140a12.0
        for <util-linux@vger.kernel.org>; Mon, 30 Jun 2025 12:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751310007; x=1751914807; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IM9y/K2x85NTxS/USIICnUASxaygyr+Jh9y09Ep4cwU=;
        b=pfq3ywd72nR74UZ3P/MrMG5OX+7+XTGbPQoBSzyWt1oA7GO60Pe0YjCdiWbGhy5xqk
         r+xsQmGF1jpRnusTuIgXi+WuezZFQ7JaRno+sDw5Sy9MELvGtjUxYxGbutbSFIujR6aj
         c8DsGleD5j2i2EbPK7mmJsS9ZeI/+Acw0wY+Gxu9ik+lWytS7huk1mManIE7fdvqNVw1
         Wz6xpDmAwmjp3lkKt6Gc8e9l23YgIL68HmmU6cHhDqT+oweONRvVOvsW5Lj0QHL9Kiza
         FmbAvGQVmAuKuZyw99iDxJnTDGfd7K2eMdizNBlMuI/wYIbhwTk7ykC8cLcRL8mmogzF
         q3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751310007; x=1751914807;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IM9y/K2x85NTxS/USIICnUASxaygyr+Jh9y09Ep4cwU=;
        b=hiPrJriigSL/DyrJIxRQTx2y79gpk0VLD5cpDycUVFWwiIHfR26EnHputMxYTvyMnk
         XYRaAQP3UYpGUsjU6UW1juhJ8DLbQKLUWENlum6LhmFf5ruv+bZvufW69htJ0L7kIGdO
         vCiAMuaCCZ6fg6flJufpeznGCWrJPw3n34UC5nBAwufctUuILWNEcST3ABVEasVyWrBP
         ZXGlC8HN85FSoCdvFLM2v+CbcwiQtPHHV45b4z9P0AjOMP9A3spOu7TTNX/oi4UJoO2L
         2KVDlKBZNDRH4+Y8Cp5tU+jCmp6ZManeUfuPRDuP7lWAHxW5CQiVrV2nn9Ps5XkSj1dv
         8MzQ==
X-Gm-Message-State: AOJu0Yy3Bke99oE7wM5bRpOsturqut74qXtyeq8RCpf8CBTjzk77iNim
	brMS3EmfyNM3kMLuKvJPLvVpSGFA7jG7OsqUOvphJT8ehCwDZf+VT6zLllwTf1f7L3XKqkz5gbp
	dWIG06UMhu5qKh1WrhS1F6UKcWwfSe8Dxa+PwWm4Ctf5u4XFQJ20uXPvxWT8=
X-Gm-Gg: ASbGnctBvIbHrX7zLTWCKl2C5PvDMb3abkMpBJ8yGcLJUdcAvpbs4xRvoNk5gfAEpzH
	mQkhT/H34MAasye/EDjshruNtYLAgohEcrRjCaB1vQHJAg5s7aH7fB8mSaLFIddaFoD7Q9Y8e5Z
	QVvP9IFQ/8Mfw+nP/gjJr8g730IqVuGk1J8rLPdDZY/MNEkdnXBo4fyg==
X-Google-Smtp-Source: AGHT+IEeNssRc4jRRTa6P9rmEPh+VM9TXPsTRVDirXVYaQLFe+ldU/553xjjaarPCp4ovJKUqKR82HbSlP3cIXMzahU=
X-Received: by 2002:a50:9343:0:b0:607:d206:7657 with SMTP id
 4fb4d7f45d1cf-60e33366f07mr7755a12.2.1751310006402; Mon, 30 Jun 2025 12:00:06
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jesse Rosenstock <jmr@google.com>
Date: Mon, 30 Jun 2025 20:59:55 +0200
X-Gm-Features: Ac12FXwHo09RQYivLgPMWKpc6qSAmGdTXw7nssRmP02EfR0IXe6NQfRgl8QS6YM
Message-ID: <CAMZQ0rKb4J1LqtQ_vYbCi7sBvD9pp-jQpcmwzeY2y=vFDCLgPw@mail.gmail.com>
Subject: [PATCH] man: Replace RETURN VALUE with EXIT STATUS in section 1
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

According to man-pages(7), sections 1 and 8 should normally use
EXIT STATUS, while sections 2 and 3 should use RETURN VALUE.

https://man7.org/linux/man-pages/man7/man-pages.7.html

https://github.com/util-linux/util-linux/pull/3638

Signed-off-by: Jesse Rosenstock <jmr@google.com>
---
 schedutils/coresched.1.adoc | 2 +-
 schedutils/taskset.1.adoc   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/schedutils/coresched.1.adoc b/schedutils/coresched.1.adoc
index 997b6ab36e..483fff9929 100644
--- a/schedutils/coresched.1.adoc
+++ b/schedutils/coresched.1.adoc
@@ -96,7 +96,7 @@
 Retrieving or modifying the core scheduling cookie of a process
requires *PTRACE_MODE_READ_REALCREDS* ptrace access to that process.
 See the section "Ptrace access mode checking" in *ptrace*(2) for more
information.

-== RETURN VALUE
+== EXIT STATUS
 On success, *{command}* returns 0.
 If *{command}* fails, it will print an error and return 1.

diff --git a/schedutils/taskset.1.adoc b/schedutils/taskset.1.adoc
index 9773303f73..9384347372 100644
--- a/schedutils/taskset.1.adoc
+++ b/schedutils/taskset.1.adoc
@@ -106,7 +106,7 @@

 A user can change the CPU affinity of a process belonging to the same
user. A user must possess *CAP_SYS_NICE* to change the CPU affinity of
a process belonging to another user. A user can retrieve the affinity
mask of any process.

-== RETURN VALUE
+== EXIT STATUS

 *taskset* returns 0 in its affinity-getting mode as long as the
provided PID exists.
