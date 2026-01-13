Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D3A36A02D
	for <util-linux@vger.kernel.org>; Tue, 13 Jan 2026 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768325412; cv=none; b=HmoiMvBB8CW62UFubnk4yFwOhLeViPLrzvCsMMfFZiR/sUn//OZFa6BirQyo/WBqz+9Pc2Z6LCB3FJQYwp8nBbJKjJ6lcu3ZP/iYsvV3o15fdzTgx6DtCLsJTYNgHR4wMX8R2zxew0e1UKXOILWOmqUU/ALMohIkDPaMOLm1IZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768325412; c=relaxed/simple;
	bh=97dJHlvEUUYdU64O43BOzFbYobZjVtbMt+YnIn8UAjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWNYAjqDq2peVcsiBr11bPKvR7vWholQ4dGx6tHiCpxdHHq7xCNhnrK15vfMatiZy5E4pvVBLB0OenQtXON3W6WaEfyoohRD2QfxK5dfqUsH9aVx33TfvRHITh/JaSZi67CCGOACrkQzOI8ePTuNXVWTBzTFfBEWJ3ofSJGRfbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/8U6KH9; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/8U6KH9"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-650854c473fso58716a12.1
        for <util-linux@vger.kernel.org>; Tue, 13 Jan 2026 09:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768325409; x=1768930209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUe8EO5m0gV0LKgvrtYbeh8g/MEOZ10uSLUbv4E8BTY=;
        b=O/8U6KH94Fzb0hBgLHSwyR9zwQVB4QwpApz2Hc+qcih0KtQWu43FQOjYzWotWcyunD
         r03+bkDqGabEuGEIuDVVx0Cqa/8bSzlu+tlgP9m2JynAaOcjDa+eNBqI98IVcrM1Vgj5
         b2zFex0jgDzbpYHSVZRcbTsf6ONFDhceuWat5WJiEF22L6KQEIctTPUacdnraKLJcLj3
         VTngRESM3Lx6uXNq1gZ5P9+4bx/0E89DK5XaQju5hyPCD90VgTa11pJPmeEDFE85Q2wt
         IE3vAoVURxNjw3PUKhpOUS2+ilpbBXHdeA2ehtpPNVMGn7AiSdFpPy4Sen0SFSoHhVTX
         QQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768325409; x=1768930209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MUe8EO5m0gV0LKgvrtYbeh8g/MEOZ10uSLUbv4E8BTY=;
        b=ZtToOb5jCfaQgp2UHSilHam5E94tvfLmKHqT/gYuQqTgvXZHlRni8/nQdE1/SlOi0A
         5ya4Hmcoj60TR+wt1ZFxCVCnFKcQ+M8zQoYI60tL/4d7bKVunD5FQCNCdk5NjAfQuQIK
         NLQBCjTKEGH8/P+xXMIBHeTnIkBCD+XLOkQMxKa224irkMB7M9pgHfldvy4BhPFNrttl
         +mJJZlbywk9gDRmbd2G8W8Qx5195HGE7dWv5qMyABndO9u9e8bjtca7P9UXPXlVODgSY
         FgTF958iSf9Lf+q5rqLxmVVQ/cl98fdYPAdfXZnd9DRW/ocr+GpJkn8i8x1PrO2jTVDy
         EGaA==
X-Gm-Message-State: AOJu0YxXg/UYtKAq5vCG7enR21zT1cO9Lsj9KKXOzmRelYJ2ErY1Uid3
	MO4xqCNtXQ8I+6BYmboB+oC09SFHlpF0osrmQP7XP5yW+iGxyCJgWyaelJiC/mkG4IU=
X-Gm-Gg: AY/fxX4VIBLdwKM+iI6C0BEYmS+m24PYuqSPNDJ67ND7r7+b1nxfdm9YsGhfNxwAw0N
	cL+W/tesnQwOiZ8hZxzeC18mPx2ZmrydBDUzs+MQ/crKOf0dBCeYPVyQKUjAvqC4AYQsUf+zA++
	M0CZFPu2sYjmcHJyLzNlhkA7G74BWabcTJXSh2va21jLX6P0bEaa4IBYqJ24LeFTxneypYxnef3
	TagnalYOxEWIS3ZCFtAMfbyBOTRnkSb8WuP7ZS1wzLQOoK1GrTMm7XEzUK2RxUM/8cvyM/r3kiY
	xE+wAaep2nQfm6L9O3IrDWXWklSAcLxDOarzcZQ7zFM8Gzgdl8OfZeBQyrP4FVdY+kFe2q8cZZN
	58GxUNyx83U/hrZhVMSUqsCUGS+c5Vife1L1YfXpRtQcRSU8DjZ/5J2ESK50uvSMfAGjn2d6eKb
	lDn5149713Dc6Pqg==
X-Google-Smtp-Source: AGHT+IH0g/ijlddp1Eh1MGuuQQpHo5eQnT7WIAlHIgDaeaASt41UN3qoOw5pk/TUAmRHlKZy9Qx9OA==
X-Received: by 2002:aa7:c999:0:b0:649:a157:3327 with SMTP id 4fb4d7f45d1cf-652e539ae7cmr2643106a12.17.1768325408633;
        Tue, 13 Jan 2026 09:30:08 -0800 (PST)
Received: from penguin.lxd ([149.88.27.131])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b8c4484sm20835469a12.7.2026.01.13.09.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 09:30:08 -0800 (PST)
From: Kiran Rangoon <kiranrangoon0@gmail.com>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com,
	Kiran Rangoon <kiranrangoon0@gmail.com>
Subject: [V2 2/4] unshare: implement signal forwarding when --forward-signals is used
Date: Tue, 13 Jan 2026 12:29:40 -0500
Message-ID: <20260113172942.10678-3-kiranrangoon0@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260113172942.10678-1-kiranrangoon0@gmail.com>
References: <3tysdpabjulwlmr3hkm4pr7romwtf6cofhghth7buyuxnmwr5r@pliehv2xicmy>
 <20260113172942.10678-1-kiranrangoon0@gmail.com>
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
 sys-utils/unshare.c | 59 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 53 insertions(+), 6 deletions(-)

diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 7e94b9148..efcb57cba 100644
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
@@ -1106,11 +1122,32 @@ int main(int argc, char *argv[])
 		settime(monotonic, CLOCK_MONOTONIC);
 
 	if (forkit) {
-		if (sigemptyset(&sigset) != 0 ||
-			sigaddset(&sigset, SIGINT) != 0 ||
-			sigaddset(&sigset, SIGTERM) != 0 ||
-			sigprocmask(SIG_BLOCK, &sigset, &oldsigset) != 0)
-			err(EXIT_FAILURE, _("sigprocmask block failed"));
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
+			/* Save old mask for child to restore */
+			if (sigemptyset(&sigset) != 0 ||
+				sigprocmask(SIG_SETMASK, NULL, &oldsigset) != 0)
+				err(EXIT_FAILURE, _("sigprocmask failed"));
+		} else {
+			/* Block signals to prevent "impatient parent" problem */
+			if (sigemptyset(&sigset) != 0 ||
+				sigaddset(&sigset, SIGINT) != 0 ||
+				sigaddset(&sigset, SIGTERM) != 0 ||
+				sigprocmask(SIG_BLOCK, &sigset, &oldsigset) != 0)
+				err(EXIT_FAILURE, _("sigprocmask block failed"));
+		}
 #ifdef HAVE_PIDFD_OPEN
 		if (kill_child_signo != 0) {
 			/* make a connection to the original process (parent) */
@@ -1127,6 +1164,7 @@ int main(int argc, char *argv[])
 		case -1:
 			err(EXIT_FAILURE, _("fork failed"));
 		case 0:	/* child */
+			child_pid = 0; /* Clear in child process */
 			if (sigprocmask(SIG_SETMASK, &oldsigset, NULL))
 				err(EXIT_FAILURE,
 					_("sigprocmask restore failed"));
@@ -1134,6 +1172,8 @@ int main(int argc, char *argv[])
 				close(fd_bind);
 			break;
 		default: /* parent */
+			if (forward_signals)
+				child_pid = pid; /* Store for signal handler */
 			break;
 		}
 	}
@@ -1148,7 +1188,14 @@ int main(int argc, char *argv[])
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

