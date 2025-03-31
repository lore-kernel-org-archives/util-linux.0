Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE6818B46E
	for <util-linux@vger.kernel.org>; Mon, 31 Mar 2025 09:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743414367; cv=none; b=rgpe5MjJlIyVNan5ZFDsbmHyh2l5Gj/3rcDQFl/pyJzhJzjwcu3dHYWxKd7GApM9iW54yPynuDLcHpP16Ng1JNE9q668YzTE7pj7d5NuX9ZlUEdGJnJsUadaVUKkLfZzf7ljWTtXLEHySlhupYgTH9/4ZTVHVBe7mRuaVzzBlpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743414367; c=relaxed/simple;
	bh=4drbTagWLOiT8bSu/TdP34asBwNS5LMvbpwJBbdEK+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lot19d1bHznK/gkbWpge/cLRwtBhXM9DYZR+wOzUUvxTICkSbSfYrJtlfFJZ1kn89l91QNIMdkZwBl1j0FPeUM75jMR4QiNnlu18svyP2CSNGMW3VCT0jRbdZHCzAWZo81J42FHU1zhD3MwdSE8fd2K5M0a2kh+bTC/xiZ5Bh98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=GL8qhGwC; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="GL8qhGwC"
X-KPN-MessageId: 05df3787-0e15-11f0-a82d-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 05df3787-0e15-11f0-a82d-005056abad63;
	Mon, 31 Mar 2025 11:46:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=vsblLQm27Vs2GbUWmJgssRlK0TFz2AjxRZE4PE9K+IU=;
	b=GL8qhGwCHAyib62TY+fSnNGtEnvP63YMM9wHjcA3Klm2iQup5U6+KW9/aVeIePTRrwowUEug3PcVU
	 BQpU5izcSGqplXQn8vFUm167youSreTzCraXuNIsKlXUCp5xhQB7CAlGF0k3eHLhCObUPW7HqJPCs3
	 jb8M326RidECKzCk=
X-KPN-MID: 33|D/hIfuCtSDmfzMxgR3PZnV8K25ioUNMRWiwOZFPgvjvjr558LwcT/pScJB5b6wd
 OmhD5RQ83qOxc30L/R1mCPOM3AnkguO2NdF96LtGL42I=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|0u//54gAhjZzjNNTGf/htwvVb8OcfwEI5H6erK/grXnRK6+uUyRu72JWPvWA9VL
 01I3NzKlpS2wYa4G+u1fd/g==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id f658fd62-0e14-11f0-9bef-005056ab7447;
	Mon, 31 Mar 2025 11:46:04 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Phil Auld <pauld@redhat.com>,
	Thijs Raymakers <thijs@raymakers.nl>
Subject: [PATCH 10/10] coresched: rename option '--dest-type' to just '--type'
Date: Mon, 31 Mar 2025 11:44:43 +0200
Message-ID: <20250331094443.9619-10-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331094443.9619-1-bensberg@telfort.nl>
References: <20250331094443.9619-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Long options are nice, but they should be as different from each other
as possible, so that one can abbreviate them to just a few letters.
(Not that abbreviating matters here, but that is the general idea.)

The side effect of this change is that the usage text becomes more
readable.

CC: Phil Auld <pauld@redhat.com>
CC: Thijs Raymakers <thijs@raymakers.nl>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 bash-completion/coresched |  6 +++---
 schedutils/coresched.c    | 19 +++++++++----------
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/bash-completion/coresched b/bash-completion/coresched
index 3a14c5080..a502207e4 100644
--- a/bash-completion/coresched
+++ b/bash-completion/coresched
@@ -18,7 +18,7 @@ _coresched_module()
       COMPREPLY=( $(compgen -W "$sorted_pids" -- "$2") )
       return 0
       ;;
-    "-t"|"--dest-type")
+    "-t"|"--type")
       COMPREPLY=( $(compgen -W "pid tgid pgid" -- "$2") )
       return 0
       ;;
@@ -35,11 +35,11 @@ _coresched_module()
       return 0
       ;;
     'new')
-      COMPREPLY=( $(compgen -W "--dest -- --dest-type --verbose" -- "$2") )
+      COMPREPLY=( $(compgen -W "--dest -- --type --verbose" -- "$2") )
       return 0
       ;;
     'copy')
-      COMPREPLY=( $(compgen -W "--source --dest -- --dest-type --verbose" -- "$2") )
+      COMPREPLY=( $(compgen -W "--source --dest -- --type --verbose" -- "$2") )
       return 0
       ;;
     '-h'|'--help'|'-V'|'--version')
diff --git a/schedutils/coresched.c b/schedutils/coresched.c
index 7634d988c..62eac4b98 100644
--- a/schedutils/coresched.c
+++ b/schedutils/coresched.c
@@ -91,16 +91,16 @@ static void __attribute__((__noreturn__)) usage(void)
 
 	fputs(USAGE_OPTIONS, stdout);
 	fprintf(stdout,
-		_(" -s, --source <PID>       which PID to get the cookie from; if this option\n"
-		  "                            is omitted, the PID of %s itself is used\n"),
+		_(" -s, --source <PID>   which PID to get the cookie from; if this option\n"
+		  "                        is omitted, the PID of %s itself is used\n"),
 		program_invocation_short_name);
-	fputsln(_(" -d, --dest <PID>         which PID to modify the cookie of"), stdout);
-	fputsln(_(" -t, --dest-type <TYPE>   type of the new or destination PID; can be one\n"
-		  "                            of: pid, tgid, pgid; default: tgid"), stdout);
+	fputsln(_(" -d, --dest <PID>     which PID to modify the cookie of"), stdout);
+	fputsln(_(" -t, --type <TYPE>    the type of the new or destination PID; can be\n"
+		  "                        one of: pid, tgid, pgid; default: tgid"), stdout);
 
 	fputs(USAGE_SEPARATOR, stdout);
-	fputsln(_(" -v, --verbose      verbose"), stdout);
-	fprintf(stdout, USAGE_HELP_OPTIONS(20));
+	fputsln(_(" -v, --verbose        say what is being done"), stdout);
+	fprintf(stdout, USAGE_HELP_OPTIONS(22));
 	fprintf(stdout, USAGE_MAN_TAIL("coresched(1)"));
 	exit(EXIT_SUCCESS);
 }
@@ -210,8 +210,7 @@ static sched_core_scope parse_core_sched_type(char *str)
 	else if (!strcmp(str, "pgid"))
 		return PR_SCHED_CORE_SCOPE_PROCESS_GROUP;
 
-	bad_usage(_("'%s' is an invalid option. Must be one of pid/tgid/pgid"),
-		  str);
+	bad_usage(_("'%s' is an invalid type; must be one of pid/tgid/pgid"), str);
 }
 
 static void parse_and_verify_arguments(int argc, char **argv, struct args *args)
@@ -221,7 +220,7 @@ static void parse_and_verify_arguments(int argc, char **argv, struct args *args)
 	static const struct option longopts[] = {
 		{ "source", required_argument, NULL, 's' },
 		{ "dest", required_argument, NULL, 'd' },
-		{ "dest-type", required_argument, NULL, 't' },
+		{ "type", required_argument, NULL, 't' },
 		{ "verbose", no_argument, NULL, 'v' },
 		{ "version", no_argument, NULL, 'V' },
 		{ "help", no_argument, NULL, 'h' },
-- 
2.48.1

