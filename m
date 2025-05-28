Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43071202C3A
	for <util-linux@vger.kernel.org>; Wed, 28 May 2025 09:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748425058; cv=none; b=M2+PFvNJNKJvYRKzqF7w/zfFuRVi1d11eoqGni6/G9MBN1KWAu+cZTdVQaNMV466fA4emkYoI0BitPD8SctUYDJtZtpckm7ydrSvcck/aC0XrlzMSOoGpDe3RFIpBrXMXQ2qn12wufefW0LMymHQybvVu3LdCg4ZcgXmvhMXwmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748425058; c=relaxed/simple;
	bh=4Eig1eUdF/yjPVZhdlkgwZzUqsSadp9yqEFlTGqbWmY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWIiK7fxvoCNrDD6KPpk0vcG/TCNAhqn7z28sDYSwz9W5Wx38byjyZ6iC4NiLkXOkJKAFkz9VgVoGzJMsdFYd/ozhfxZ/YiMXNzGW9CckP6U27Np1xxFaype0FJBemrmdXA3MrpelS1xgao/OGQ9SfCG3sY+OyE6swiukzdGsE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=C688VqoJ; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="C688VqoJ"
X-KPN-MessageId: 829817e3-3ba7-11f0-86ce-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 829817e3-3ba7-11f0-86ce-005056aba152;
	Wed, 28 May 2025 11:38:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=hIgF94BdxAg+WHXWUEki/OFf9HA4yvlH8/HiJrhBbXw=;
	b=C688VqoJT9ce9H7vBrKdxzhAyXzX6v0Wl5IsesMlh6iUlGwYynKaAyAYkypkuqogtmh9qOYBU6rAZ
	 3pk/K4bPsceZIlsGXw7z4IbM76jHEpdcGTXllzcWxfs6gwbzZjBfWQllNXHWlC+FOGT5nZGvmAYElA
	 XIG80/LTs3KgIe9c=
X-KPN-MID: 33|DKQSucMCmRrtvl+j1GEjqLlMb7RcI6NeeHMs95ogTIxEJ+XZg4UrnYWeaXMhYfx
 leCTK9JgDg1WFJ4XUKHZk4WDAVV8hU8WNuDMvF5boB5A=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|djp+31amyX109IViPLS4vn9+nKVZu9CreZTkgSJH145hYRIbdgl5Apj1wMVga/B
 FISoJlYmWyyDsICP/412d3Q==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 621a99ee-3ba7-11f0-9bdc-005056ab1411;
	Wed, 28 May 2025 11:37:34 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/4] textual: harmonize the wording of the error message for an invalid PID
Date: Wed, 28 May 2025 11:37:04 +0200
Message-ID: <20250528093704.8896-4-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250528093704.8896-1-bensberg@telfort.nl>
References: <20250528093704.8896-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Having four different forms for the same basic message is unneeded.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc-utils/kill.c      | 4 ++--
 misc-utils/lsclocks.c  | 2 +-
 misc-utils/lslocks.c   | 2 +-
 misc-utils/waitpid.c   | 2 +-
 schedutils/coresched.c | 5 ++---
 schedutils/taskset.c   | 3 +--
 sys-utils/setpriv.c    | 2 +-
 7 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/misc-utils/kill.c b/misc-utils/kill.c
index fefe0d891..81dd5f191 100644
--- a/misc-utils/kill.c
+++ b/misc-utils/kill.c
@@ -396,7 +396,7 @@ static char **parse_arguments(int argc, char **argv, struct kill_control *ctl)
 			if (2 < argc)
 				errx(EXIT_FAILURE, _("too many arguments"));
 			arg = argv[1];
-			pid = strtopid_or_err(arg, _("invalid pid argument"));
+			pid = strtopid_or_err(arg, _("invalid PID argument"));
 			print_process_signal_state(pid);
 			exit(EXIT_SUCCESS);
 		}
@@ -404,7 +404,7 @@ static char **parse_arguments(int argc, char **argv, struct kill_control *ctl)
 			pid_t pid;
 			char *p = strchr(arg, '=') + 1;
 
-			pid = strtopid_or_err(p, _("invalid pid argument"));
+			pid = strtopid_or_err(p, _("invalid PID argument"));
 			print_process_signal_state((pid_t)pid);
 			exit(EXIT_SUCCESS);
 		}
diff --git a/misc-utils/lsclocks.c b/misc-utils/lsclocks.c
index 376bc6e51..42a91fb94 100644
--- a/misc-utils/lsclocks.c
+++ b/misc-utils/lsclocks.c
@@ -593,7 +593,7 @@ int main(int argc, char **argv)
 			break;
 		case 'c':
 			cpu_clock = xmalloc(sizeof(*cpu_clock));
-			cpu_clock->pid = strtopid_or_err(optarg, _("failed to parse pid"));
+			cpu_clock->pid = strtopid_or_err(optarg, _("invalid PID argument"));
 			snprintf(cpu_clock->name, sizeof(cpu_clock->name),
 				 "%jd", (intmax_t) cpu_clock->pid);
 			list_add(&cpu_clock->head, &cpu_clocks);
diff --git a/misc-utils/lslocks.c b/misc-utils/lslocks.c
index e58890207..4ed3a3716 100644
--- a/misc-utils/lslocks.c
+++ b/misc-utils/lslocks.c
@@ -383,7 +383,7 @@ static struct lock *get_lock(char *buf, struct override_info *oinfo, void *fallb
 				l->cmdname = xstrdup(oinfo->cmdname);
 			} else {
 				/* strtopid_or_err() is not suitable here; tok can be -1.*/
-				l->pid = strtos32_or_err(tok, _("failed to parse pid"));
+				l->pid = strtos32_or_err(tok, _("invalid PID argument"));
 				if (l->pid > 0) {
 					l->cmdname = pid_get_cmdname(l->pid);
 					if (!l->cmdname)
diff --git a/misc-utils/waitpid.c b/misc-utils/waitpid.c
index 4d77e1df4..379246b26 100644
--- a/misc-utils/waitpid.c
+++ b/misc-utils/waitpid.c
@@ -51,7 +51,7 @@ static pid_t *parse_pids(size_t n_strings, char * const *strings)
 	pid_t *pids = xcalloc(n_strings, sizeof(*pids));
 
 	for (size_t i = 0; i < n_strings; i++)
-		pids[i] = strtopid_or_err(strings[i], _("failed to parse pid"));
+		pids[i] = strtopid_or_err(strings[i], _("invalid PID argument"));
 
 	return pids;
 }
diff --git a/schedutils/coresched.c b/schedutils/coresched.c
index 7634d988c..419745897 100644
--- a/schedutils/coresched.c
+++ b/schedutils/coresched.c
@@ -232,12 +232,11 @@ static void parse_and_verify_arguments(int argc, char **argv, struct args *args)
 		switch (c) {
 		case 's':
 			args->src = strtopid_or_err(
-				optarg,
-				_("Failed to parse PID for -s/--source"));
+				optarg, _("invalid PID for -s/--source"));
 			break;
 		case 'd':
 			args->dest = strtopid_or_err(
-				optarg, _("Failed to parse PID for -d/--dest"));
+				optarg, _("invalid PID for -d/--dest"));
 			break;
 		case 't':
 			args->type = parse_core_sched_type(optarg);
diff --git a/schedutils/taskset.c b/schedutils/taskset.c
index 46fef5051..dedcdf602 100644
--- a/schedutils/taskset.c
+++ b/schedutils/taskset.c
@@ -187,8 +187,7 @@ int main(int argc, char **argv)
 			all_tasks = 1;
 			break;
 		case 'p':
-			pid = strtopid_or_err(argv[argc - 1],
-					      _("invalid PID argument"));
+			pid = strtopid_or_err(argv[argc - 1], _("invalid PID argument"));
 			break;
 		case 'c':
 			ts.use_list = 1;
diff --git a/sys-utils/setpriv.c b/sys-utils/setpriv.c
index 10274f5f6..d714650e8 100644
--- a/sys-utils/setpriv.c
+++ b/sys-utils/setpriv.c
@@ -473,7 +473,7 @@ static void parse_ptracer(struct privctx *opts, const char *str)
 	} else if (!strcmp(str, "none")) {
 		opts->ptracer = 0;
 	} else {
-		opts->ptracer = strtopid_or_err(str, _("failed to parse ptracer pid"));
+		opts->ptracer = strtopid_or_err(str, _("invalid PID argument"));
 	}
 }
 
-- 
2.48.1

