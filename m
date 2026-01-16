Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01120346E41
	for <util-linux@vger.kernel.org>; Fri, 16 Jan 2026 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768583223; cv=none; b=Ljjy7a+zdiTQ30NmwgqCWdO/8sdiR46XNFGkM0mzS35d+8X+2sB8YPepA8IuO9KGpkSa+wlNdXspbYNMy0kc+eseL8XUksjXA3bxcnWAxMSkmTzAqN7gABkOUFVnHWkeHzcIjQ2LKmf12xKhaRusmL3DrXUALfjGZRmcJ6scn/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768583223; c=relaxed/simple;
	bh=p66Qfvh3mmYj2IdjqkjcD8qLtJrcYvYWndLhVysjtq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbLW6f4ZicXlL+kS0Y7RVJPX4Arqx3ISzgzgRFbFS5UzzSfsN+7m/CnkLMAnu3IgjAB9YWg9PxKCR0MbLv3beIQzzzuts7LdZD5fMm2KAGN/zQgSDI4DKU/f2QOwsAxQC8KDpucFDbpmiVgZUTOBqmP/dSZ1BeRsUVAnuVKbhO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBlPsr44; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBlPsr44"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42fbc305914so1787774f8f.0
        for <util-linux@vger.kernel.org>; Fri, 16 Jan 2026 09:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768583220; x=1769188020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqND6/hegMyu5/PTEI1e5SlCARXk6lv6pm1lY3gpas8=;
        b=dBlPsr44w05ndzNZPohJj9Yn/rZyrX0K4c2FkjgwMrhnnNuRs1beRYqwoNT54FIuvq
         Qaq75isz+o1hXyJ6X61KEq8rtIP5zgbWWygi5CmcBoREiD5R8yvvFZI87WmjeZlLnSnZ
         8Hi0dL/tgTamKh3xJ8dgGGDubTnR9MQVR5/LoL7Dk75fFNPJRGZjmWKEXrUW4r/kxMNm
         4832f5aSrPtO969/cpL056ZyG3YSv2TveggVrg3S4tp7B1wJCnvQoMgBO3lcDFArnMv7
         RRocKUZmaGBtW3PPXIM7s+MMD5chRLbSOxwC24paXpGZeTk2wslL5xMnoHN84qiAPY4M
         ym+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768583220; x=1769188020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BqND6/hegMyu5/PTEI1e5SlCARXk6lv6pm1lY3gpas8=;
        b=f6paxnU0pyP+yjNO6YKcSU+3kdN7e0CQMw0tloaEU9nW842AngYtKBevw0nszaGJzG
         bApvdRcIOVbsv5LFOHKf/vF/Ntd7lnVYds+TvTVwUhO0K7nnlCMa4/VU2rCHSZOTGbOQ
         LDOI8Imil5s91QVK+k9KDnzG1xY8Uu1/JtA6jqwf8NzDmAh0zwGrrKhdHNx7PiGIXNTs
         qyF4Z4VBrn7xMbuEy8liVoE9rIE2fp0QkrryuKIAErlKX2YydQQRAdtDgQLo41hGVHlp
         TZL2hHVOAS4LNJHqANQoCXMfxj7uB/Nv4OWeHFL5vw+Ad2BDVjiGluxgHkh6G5ShLSWD
         ewjw==
X-Gm-Message-State: AOJu0YxAO/35q0uknv7ZvEoisfm0PJpy8+OyNUzU6Hc+8YUiTXE2jKll
	hddaZd6NuLFEgI2NYtbo8tMHA9iXXQLWlF/YOzFeJkPIlEvd5u+jQkynSqjvkr8qRsw=
X-Gm-Gg: AY/fxX4EEgk0ctZtH8cQdwGM+l5rhziSd+wAcUEhzxBpxAlXGFpeAb1xiUGoFgACRAU
	U5vNkrJLhYzRI63yi+nBPpHMAgBRl3QF07BwfFpaTdQDL+oMRHqpBIhU35q+EcBRfR2iMTL+Qq4
	20hrQC+NwDgtNYIh0uGbRUuRa4bhUs/KFYmDESDQpf+4vLyeKqHZS9ZZhcougo9FlQvEvdl1Uao
	7u+/sPyBzZE1iO/H69zcHV6xUDzSP3OLR3YH5OtOeFmw70eKLyKUHXRKJAHvLgK9wp7X6qFtXYU
	6XEoQb5XEW3n8vXTZ0yhEnivcbBlu+e/RgtanTjHD3X/cgvFYRqco9u2BNWKJxo7/pp54JkD8u0
	hmE7ab9T1xrkpo7Mr3Uw/deYvjD2s3+DYNz0l2pGrWkaWoPsm5WfiW3UyvoW2BSAB5/qHLi9ht8
	fUTGXInXqqH93YrEDP
X-Received: by 2002:a05:6000:1447:b0:430:feb3:f5ae with SMTP id ffacd0b85a97d-43569bcfc88mr3803029f8f.55.1768583219906;
        Fri, 16 Jan 2026 09:06:59 -0800 (PST)
Received: from penguin.lxd ([149.102.244.113])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435699982aasm6526709f8f.42.2026.01.16.09.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 09:06:59 -0800 (PST)
From: Kiran Rangoon <kiranrangoon0@gmail.com>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com,
	Kiran Rangoon <kiranrangoon0@gmail.com>
Subject: [Patch V3 2/4] unshare: implement signal forwarding when --forward-signals is used
Date: Fri, 16 Jan 2026 12:06:46 -0500
Message-ID: <20260116170648.26439-3-kiranrangoon0@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116170648.26439-1-kiranrangoon0@gmail.com>
References: <20260113172942.10678-5-kiranrangoon0@gmail.com>
 <20260116170648.26439-1-kiranrangoon0@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When --forward-signals is specified, install signal handlers for
SIGTERM and SIGINT that forward these signals to the child process.
This allows child processes with cleanup handlers to execute gracefully during shutdown scenarios like
system reboot.

Also fix waitpid() to handle EINTR properly when signals are being
forwarded, ensuring the parent waits for the child to complete
signal handling before exiting.

Signed-off-by: Kiran Rangoon <kiranrangoon0@gmail.com>
---
 sys-utils/unshare.c | 55 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 8a7a26df2..a4d28892d 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -74,6 +74,9 @@ static struct namespace_file {
 
 static int npersists;	/* number of persistent namespaces */
 
+/* Global PID of child process for signal forwarding */
+static volatile pid_t child_pid = 0;
+
 enum {
 	SETGROUPS_NONE = -1,
 	SETGROUPS_DENY = 0,
@@ -135,6 +138,19 @@ static void map_id(const char *file, uint32_t from, uint32_t to)
 	close(fd);
 }
 
+/**
+ * forward_signal() - Forward signal to child process
+ * @sig: Signal number to forward
+ *
+ * Signal handler that forwards SIGTERM/SIGINT from parent to child.
+ * Only used when --forward-signals flag is enabled.
+ */
+static void forward_signal(int sig)
+{
+	if (child_pid > 0)
+		kill(child_pid, sig);
+}
+
 static unsigned long parse_propagation(const char *str)
 {
 	size_t i;
@@ -1107,11 +1123,32 @@ int main(int argc, char *argv[])
 		settime(monotonic, CLOCK_MONOTONIC);
 
 	if (forkit) {
+		if (forward_signals) {
+			/* Install signal handlers to forward signals to child */
+			struct sigaction sa;
+
+			memset(&sa, 0, sizeof(sa));
+			sa.sa_handler = forward_signal;
+			sigemptyset(&sa.sa_mask);
+			sa.sa_flags = SA_RESTART;
+
+			if (sigaction(SIGTERM, &sa, NULL) == -1)
+				err(EXIT_FAILURE, _("sigaction SIGTERM failed"));
+			if (sigaction(SIGINT, &sa, NULL) == -1)
+				err(EXIT_FAILURE, _("sigaction SIGINT failed"));
+
+		/* Save old mask for child to restore */
+		if (sigemptyset(&sigset) != 0 ||
+		    sigprocmask(SIG_SETMASK, NULL, &oldsigset) != 0)
+			err(EXIT_FAILURE, _("sigprocmask failed"));
+	} else {
+		/* Block signals to prevent "impatient parent" problem */
 		if (sigemptyset(&sigset) != 0 ||
-			sigaddset(&sigset, SIGINT) != 0 ||
-			sigaddset(&sigset, SIGTERM) != 0 ||
-			sigprocmask(SIG_BLOCK, &sigset, &oldsigset) != 0)
+		    sigaddset(&sigset, SIGINT) != 0 ||
+		    sigaddset(&sigset, SIGTERM) != 0 ||
+		    sigprocmask(SIG_BLOCK, &sigset, &oldsigset) != 0)
 			err(EXIT_FAILURE, _("sigprocmask block failed"));
+	}
 #ifdef HAVE_PIDFD_OPEN
 		if (kill_child_signo != 0) {
 			/* make a connection to the original process (parent) */
@@ -1128,6 +1165,7 @@ int main(int argc, char *argv[])
 		case -1:
 			err(EXIT_FAILURE, _("fork failed"));
 		case 0:	/* child */
+			child_pid = 0; /* Clear in child process */
 			if (sigprocmask(SIG_SETMASK, &oldsigset, NULL))
 				err(EXIT_FAILURE,
 					_("sigprocmask restore failed"));
@@ -1135,6 +1173,8 @@ int main(int argc, char *argv[])
 				close(fd_bind);
 			break;
 		default: /* parent */
+			if (forward_signals)
+				child_pid = pid; /* Store for signal handler */
 			break;
 		}
 	}
@@ -1149,7 +1189,14 @@ int main(int argc, char *argv[])
 	}
 
 	if (pid) {
-		if (waitpid(pid, &status, 0) == -1)
+		int rc;
+
+		/* Wait for child, handling EINTR from signal forwarding */
+		do {
+			rc = waitpid(pid, &status, 0);
+		} while (rc == -1 && errno == EINTR);
+
+		if (rc == -1)
 			err(EXIT_FAILURE, _("waitpid failed"));
 
 		if (WIFEXITED(status))
-- 
2.47.3

