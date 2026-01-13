Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAAC311C05
	for <util-linux@vger.kernel.org>; Tue, 13 Jan 2026 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768325392; cv=none; b=SszlmY6YIMkiqQ0/8NBmBhvMyoxiU/OCX1WVdaxvlM1OocVkBl/MetJ8hwGRl++VYXY/r4xvXOIUAEkQzXyou1nyBeVQVGvrSvq/1M9PwIBwPJup8y57wQ5ETMdd+NYvh/TxjgmIpNL3Zb5aicKpGhZl9LoKmjr2Un3KknGNiOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768325392; c=relaxed/simple;
	bh=r+cTC+oHEykxfIc2gh/uSRNULe4n06T9/fy3PVEeWAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/4whRuNRxx2PkPfA9xffFoIVNvoqaQhOm7dI8UJcladFsrJaVV7fEjj0HlFBQUKxkEqyHwYxQRPfMVrroTNWmSudWU0r+wNncLZcd5Gh/OVQ4J10hpPDEkW5ULhQoebt6q/V+jbtYLtSTuu9f/hrYwU3wQR2isa35nXxbQOfvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAifln8l; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAifln8l"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64d30dc4ed7so15353440a12.0
        for <util-linux@vger.kernel.org>; Tue, 13 Jan 2026 09:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768325389; x=1768930189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sV+yTpVz7IU8aicF4NiyLgGs7Eo1GFk1C94uuvy33Fo=;
        b=DAifln8l9AXm+ciQe/q2L0XB1SIUftxowRadRm4wH/nSsxNlCglKdtlLADTCtKYrBi
         cfGw3/dEVhwJSkmw6KFiHNl90z4gr8k9hPaS+ViXPxQmi1yRUR/9DkMyizRdPGiDRTv2
         Ckb2eiAqIDXNPMJ06vu8bmNrwox3AMkgu4Hgu/+VeUH17eJ4Eog8Jgw4dBRgPt1MyK0G
         xwNu/u2QA1udOTt89ZYarD9EzVYMhkkImqOO85LZI58Akc7JxuFRHNC241mrqgO9XIE5
         f2A7RlxXhUvoAGoataABfm2PlI6ygfCHoAmJHHAlk9S/nc4XURvp5vOryuWFwgXB5cxS
         bzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768325389; x=1768930189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sV+yTpVz7IU8aicF4NiyLgGs7Eo1GFk1C94uuvy33Fo=;
        b=Day7joKayp+WlfAI0BXDoDHS7lpwnuS042QyMh7bwT0wnn/c8ogA3bxkBjiaaB13Fr
         v+XkXRGbi6RcoWFYwFRxyWe2/1Dk/OGznEXYcRuysoOW57BccSkKukyrxD4MIbTqk/Dp
         d/3sjvLD+vBS6lHm7r7FcrYgGUrf+ttxZvjDPS3f9j0YAkHqiihaQZMQuVi9+P+eh//p
         aM1+jWiQioPRRK9cGWQltWJfLbJzYU13oWcRUNn39xQYQ9Qnbx3ON+EF2rajEzogc8Uy
         HTzfI5c2J2L51XbfPO159q0iQOpPqOIt1d7fPuYM2w7Qe9LSFz9IL7P1PcuKo9PTspEh
         1c4g==
X-Gm-Message-State: AOJu0Yz4m+oCgeVSHfp6X6W5bSoH3yKRiVKevJUB4lrcCrTb1VJOkhac
	N9leN3jHVIF8dR/6iQKIwfoD2KTDGH8WLrK33Ier+JIkYnf7nPugk13zrSK6DqRaJOY=
X-Gm-Gg: AY/fxX4ovwGHDEf9deewrPEI7xNozmnewMgNrqikD57HdaIiU+cz/Zbcif6uocmZNCf
	UhJhU2mU7GmcOyjYpCyn1wH8Bq2R4c8dqCxMslO4AlEbtOIiu+rTKp+tFkEKvO4dWTcPvR86+a4
	PWfPRvoTY9+04Pzl+R6qOID4BucvaQBsZQejjn1Tg4z/W5nEi7YABCyyJV4U3QYKD3TGhkVf8BQ
	fWMuem9VTPQq6mmWwXO0Twd/Lffpz0ZeuZ430AGagd33u6KiDsbLLyo4ZuonYOymX4vRjeuCzDG
	FPGfoKF0WJJdxndgyHXY2QSgmlV00xLHm1s+s0voGOIvkLnKTlQxnR+BvDEsGvuFN7fjZB3UbZr
	REyzdzabtEFk9UJPUhmSJmSytFX0HQ+pmp2hX9HgtKeIMHIajJU5FgikhYXNTgr1uLKIOq0Bc12
	AxZPCUrX3LAXk0lQ==
X-Google-Smtp-Source: AGHT+IGQ1dr1+M44xGW0ZRAWTNdIUjPqAoI4N7Uyds6/+DZhWurG4xL8A5CzC1fDHmQBJBWVJeg4/Q==
X-Received: by 2002:a05:6402:3551:b0:64d:1f6b:f594 with SMTP id 4fb4d7f45d1cf-65097dfc572mr23124627a12.15.1768325388616;
        Tue, 13 Jan 2026 09:29:48 -0800 (PST)
Received: from penguin.lxd ([149.88.27.131])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b8c4484sm20835469a12.7.2026.01.13.09.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 09:29:48 -0800 (PST)
From: Kiran Rangoon <kiranrangoon0@gmail.com>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com,
	Kiran Rangoon <kiranrangoon0@gmail.com>
Subject: [Patch V2 0/4] unshare: fix signal forwarding to child processes
Date: Tue, 13 Jan 2026 12:29:38 -0500
Message-ID: <20260113172942.10678-1-kiranrangoon0@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <3tysdpabjulwlmr3hkm4pr7romwtf6cofhghth7buyuxnmwr5r@pliehv2xicmy>
References: <3tysdpabjulwlmr3hkm4pr7romwtf6cofhghth7buyuxnmwr5r@pliehv2xicmy>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in V2 (responding to feedback from karelzak):
- Made signal forwarding opt-in via new --forward-signals flag
- Preserves default behavior (signals blocked) for backward compatibility
- Addresses concerns from PR #1087 about "impatient parent" problem

This adds --forward-signals to enable graceful shutdown of child processes
during system reboot. Since util-linux 2.36, unshare blocks SIGTERM/SIGINT
to prevent premature parent exit, but this prevents children from receiving
shutdown signals for cleanup.

The new flag installs signal handlers instead of blocking, forwards signals
to the child, and properly handles EINTR in waitpid(). Includes tests for
basic forwarding and --kill-child compatibility.


Kiran Rangoon (4):
  unshare: add --forward-signals option to argument parser
  unshare: implement signal forwarding when --forward-signals is used
  unshare: document --forward-signals in man page
  tests: add tests for unshare --forward-signals

 sys-utils/unshare.1.adoc                      | 13 ++++
 sys-utils/unshare.c                           | 67 +++++++++++++++++--
 tests/expected/unshare/forward-signals        |  1 +
 .../unshare/forward-signals-kill-child        |  1 +
 tests/ts/unshare/forward-signals              | 55 +++++++++++++++
 tests/ts/unshare/forward-signals-kill-child   | 56 ++++++++++++++++
 6 files changed, 186 insertions(+), 7 deletions(-)
 create mode 100644 tests/expected/unshare/forward-signals
 create mode 100644 tests/expected/unshare/forward-signals-kill-child
 create mode 100755 tests/ts/unshare/forward-signals
 create mode 100755 tests/ts/unshare/forward-signals-kill-child

-- 
2.47.3

