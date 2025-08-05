Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F826194137
	for <util-linux@vger.kernel.org>; Tue,  5 Aug 2025 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754385984; cv=none; b=k0cMZlr2hYVoVMiUVrxcM6uz2J6pKs8hrWHd1UObNT+19B8NK2ZDD8gXWF2uYu6wL4ljo77W8DaD8F49uZGal7nRtZiqGhgMc+d1x+97Ql7ezftis1arBD8Ja7hPeKtYR2HzhD95NJgc0IoPaSF7freaDuUUlPBzq33XhS3Zp1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754385984; c=relaxed/simple;
	bh=w0odWbczduIT0uwqzsOqLQ41/L6oze5B72MJ9cYz8yU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VtHq9Q+44cvwK2IdyxYxojKi+JrPLu0jsTZyDCYSZa41UneaOKJW8LqF/DKvc88o4vFgC9HRi79o6SVnadrgPkH9Mf3UzMS8KvAT/HzuSZ2mdXU6J5CKG2oyL1A2A45psaWEjrXK8n7eo2y8r9RMJeEOAvcbSH/D2y+1AJ+ZLdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=NoYJlQ5T; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="NoYJlQ5T"
X-KPN-MessageId: 3f52b1a1-71de-11f0-a4bf-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 3f52b1a1-71de-11f0-a4bf-005056abad63;
	Tue, 05 Aug 2025 11:26:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=ecdZ3qgnfhib/bs6Tr70HJ8heLeV9Trm8u4G5+b5Hjw=;
	b=NoYJlQ5TmvDPtSzOp/niioMtCj77MOnfOcZrxSL3hPkRzQ3APhrO5Ex78vkwZKouERtiHHbmi4zlI
	 MCPDBiaeQoYYbSsB4GGyd9yrAp/zjJLBE5yikHWwv6Aya0fxQo1voFuMVtBP02y7B3qcuJ63qr0D8z
	 vvhypQNYJBzqLgSs=
X-KPN-MID: 33|MIIzLa7t6xuGBtV2jRU7FI057PHCWW3iMfK+gfWbg+FFj39w5S8BwlBbo61EwbB
 +0ThCDQrg8Zn3I+MJabjPNFChq948qXn/ipjSYFigztQ=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|MopJTCkiGD/0iybG5DR7emv5nhB5og1AacDk/TnJ6h/veZHD295joftfV82NBhi
 PBk4hUz8Jjddcm55LD2nW9Q==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 1666bfbe-71de-11f0-abc8-005056abf0db;
	Tue, 05 Aug 2025 11:25:12 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: [PATCH 4/4] chrt: (man,usage) put --pid first in synopses and examples, for clarity
Date: Tue,  5 Aug 2025 11:24:43 +0200
Message-ID: <20250805092443.5847-4-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.2
In-Reply-To: <20250805092443.5847-1-bensberg@telfort.nl>
References: <20250805092443.5847-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When --pid is among the options, it is clearest when it is given as the
first option, because then it doesn't sit between the policy option and
the somewhat related priority value.  It creates some kind of symmetry:
the --pid option first, then other things, and the actual PID last.

CC: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 schedutils/chrt.1.adoc | 12 ++++++------
 schedutils/chrt.c      |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/schedutils/chrt.1.adoc b/schedutils/chrt.1.adoc
index 7ed676a9a..7805ec6d2 100644
--- a/schedutils/chrt.1.adoc
+++ b/schedutils/chrt.1.adoc
@@ -40,13 +40,13 @@ chrt - manipulate the real-time attributes of a process
 
 *chrt* [options] [_priority_] _command_ [_argument_...]
 
-*chrt* [options] *--pid* [_priority_] _PID_
+*chrt --pid* [options] [_priority_] _PID_
 
 == DESCRIPTION
 
 *chrt* sets or retrieves the real-time scheduling attributes of an existing _PID_, or runs _command_ with the given attributes.
 
-== POLICIES
+== POLICY OPTIONS
 
 *-o*, *--other*::
 Set scheduling policy to *SCHED_OTHER* (time-sharing scheduling). This is the default Linux scheduling policy. Since util-linux v2.42, the priority argument is optional; if specified, it must be set to zero.
@@ -122,19 +122,19 @@ ____
 //TRANSLATORS: Keep {colon} untranslated
 Or set them{colon}::
 ____
-*chrt* _policy-option_ *--pid* _priority PID_
+*chrt --pid* _policy-option priority PID_
 ____
 For example, to set the scheduling policy to *SCHED_RR* (round-robin) and the priority to *30* for process *1234*{colon}::
 ____
-*chrt -r --pid 30 1234*
+*chrt --pid -r 30 1234*
 ____
 Reset priorities to default for a process{colon}::
 ____
-*chrt -o --pid 0* _PID_
+*chrt --pid -o 0* _PID_
 ____
 Set a custom slice of 1 ms for a *SCHED_OTHER* task (priority is optional for policies other than *SCHED_FIFO* and *SCHED_RR*){colon}::
 ____
-*chrt -o -T 1000000 --pid* _PID_
+*chrt --pid -o -T 1000000* _PID_
 ____
 See *sched*(7) for a detailed discussion of the different scheduler classes and how they interact.
 
diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index de1898160..b5ddc53bd 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -61,7 +61,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_("Set policy:\n"
 		" chrt [options] [<priority>] <command> [<argument>...]\n"
-		" chrt [options] --pid [<priority>] <PID>\n"), out);
+		" chrt --pid <policy-option> [options] [<priority>] <PID>\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_("Get policy:\n"
 		" chrt --pid <PID>\n"), out);
-- 
2.48.2

