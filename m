Received: from outbound.soverin.net (outbound.soverin.net [185.233.34.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706771CF8A
	for <util-linux@vger.kernel.org>; Tue, 26 Mar 2024 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.34.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711475683; cv=none; b=bMcBqedhLdOukl3ke9S1ejI0IUR0ICTe/Zie+0Wr2eKZyCC0REBFjHZM9nCc9gpyATnrc4oHLZUSzwwkyVU0SlUmHNJroCyJQHLMQJ7vLHSPA22rNQOvXBdD2beWf3w7E2VQ6Wj3xPozqOYFRAPqhoaW9bbHdqsWeZAdHJoYgsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711475683; c=relaxed/simple;
	bh=Cd2zs+B25V8ZlNKpM1DiSwPXpb0ABS+0d7Rn/goqMUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kh1c33bmyI5iTuuc5uJafVHLPKOqnONCYYHHGPpDKLmGyjarbZcCj6p6lZbgoArC5kHt1FGEQa2A/GSwtDefJIeCgwFWDsaeDrwhpqvCigEsabdm1hdtf1LMjV/OVAvD0WqWc3IHERQAJE8P3N1NazbOLiB4aKrgbO4n4rPMYsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raymakers.nl; spf=pass smtp.mailfrom=raymakers.nl; dkim=pass (2048-bit key) header.d=raymakers.nl header.i=@raymakers.nl header.b=l/tAiFLp; arc=none smtp.client-ip=185.233.34.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raymakers.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raymakers.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raymakers.nl header.i=@raymakers.nl header.b="l/tAiFLp"
Received: from smtp.soverin.net (c04cst-smtp-sov02.int.sover.in [10.10.4.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by outbound.soverin.net (Postfix) with ESMTPS id 4V3y3c2Lfkz7x;
	Tue, 26 Mar 2024 17:49:16 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [10.10.4.100]) by soverin.net (Postfix) with ESMTPSA id 4V3y3b5yQJzHS;
	Tue, 26 Mar 2024 17:49:15 +0000 (UTC)
Authentication-Results: smtp.soverin.net;
	dkim=pass (2048-bit key; unprotected) header.d=raymakers.nl header.i=@raymakers.nl header.a=rsa-sha256 header.s=soverin1 header.b=l/tAiFLp;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raymakers.nl;
	s=soverin1; t=1711475355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R8w1QZlCltfGWiJUzFTs8oXWnfGhILDjTo2s/qjZ0xg=;
	b=l/tAiFLpIhgAD7LsOTh6gjo+hdQ2AcKO41IlX26838glZwmJxC2oZ6m6OSxIC2VX4Up3Tb
	K6T1Dhiz8/KuqUwT1p5oJZPNJZQ2JkEs6ffoNmZxHxRKcFl3TNQKgHLPt6hKSag5YFn7sV
	d6ZzcPsurVE7KHaahVy1gIH9VoIJbCMn1kYefhxgQFbY9LdW4G9WJx7SrH1r04/Rbq6tRd
	sRS699MxUcCm8DTwa+91ODm7PwMF2Qbo0t4P1ob96Gf0DCIuQvtatG4YflMQ2sAz6Pm9gt
	w9FRMm8nFdAqdsv74NWQRx3bQhJtD5YwMlKb0mzAAkLkCDVOdTBfETzX8hLRsA==
From: Thijs Raymakers <thijs@raymakers.nl>
To: pauld@redhat.com
Cc: kzak@redhat.com,
	util-linux@vger.kernel.org,
	Thijs Raymakers <thijs@raymakers.nl>
Subject: [PATCH 0/1] coresched: Manage core scheduling cookies for tasks
Date: Tue, 26 Mar 2024 18:49:07 +0100
Message-ID: <20240326174909.117426-1-thijs@raymakers.nl>
In-Reply-To: <20240326144129.GA315070@lorien.usersys.redhat.com>
References: <20240326144129.GA315070@lorien.usersys.redhat.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Phil,

Thank you for your comments. I've attached an interdiff to this email
with all the changes that I've made in response.

Phil Auld wrote on 26-03-2024 at 15:41:
> The exec should not fork first.

You're right, this is not necessary. I've removed it.

> And the error handling I think is just not right. I believe prctl()
> returns -1 on error and sets errno. This code will report EPERM for all
> prtcl errors.  While EPERM is likely I don't think it's the only error.

Good catch! I assumed that the return values of the `prctl()` call
matched the return values of `sched_core_share_pid` in
`kernel/sched/core_sched.c`. I've updated the error handling code to
just use errno instead.

> On Sat, Mar 16, 2024 at 06:10:03PM +0100, Thijs Raymakers wrote:
>> - How should the program behave if the prctl core scheduling API is not
>>   available? It has been in Linus' tree since november 2021
>>   (commit a41b74451b35f7a6529689760eb8c05241feecbc) but it can be
>>   disabled with CONFIG_SCHED_CORE=n
> 
> This one is tricky. If I recall the error you get is ambiguous in this case
> (EINVAL, which can be returned for other reasons). It would be nice to be
> able to report that specifically. 

In general, `prctl` does indeed return EINVAL if the operation is not
recognized, or not supported on the system. The `PR_SCHED_CORE`
operation itself only returns EINVAL if it is called with
  - an invalid operation
  - an invalid type
  - a negative PID
  - an invalid cookie store address (for PR_SCHED_CORE_GET)
Assuming that all these cases are prevented by the util, we could
interpret a EINVAL as a sign that PR_SCHED_CORE is not supported on
the system.

>> - I've currently licensed it under the EUPL v1.2, which is easier to
>>   enforce in my jurisdiction than the GPL. It is GPL compatible so it
>>   shouldn't be an issue, but if anybody has any remarks on this, please
>>   let me know.
> 
> The util-linux package is GPL so personally I think it would be good to just
> make any new addition to that package also GPL. 

As far as I understand it, util-linux is a collection of different works
with different licenses (see the README.licensing file). Not every
program included in util-linux has to be GPL.

>> +typedef enum {
>> +	SCHED_CORE_SCOPE_PID = PR_SCHED_CORE_SCOPE_THREAD,
>> +	SCHED_CORE_SCOPE_TGID = PR_SCHED_CORE_SCOPE_THREAD_GROUP,
>> +	SCHED_CORE_SCOPE_PGID = PR_SCHED_CORE_SCOPE_PROCESS_GROUP,
>> +} core_sched_type_t;
>> +
> 
> Is this needed? You've made the names a little shorter I guess.
> Also some versions of prctl.h don't have the PR_SCHED_CORE_SCOPE* defines
> even when they have the base PR_SCHED_CORE macros.

I've changed to to just use the PR_SCHED_CORE_SCOPE* definitions
instead.

>> +void core_sched_create_cookie(struct args *args)
>> +{
>> +	int prctl_errno = prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE,
>> +				args->from_pid, args->type, 0);
> 
> We are creating a new cookie on from_pid, seems odd.

I agree, I changed to to `args->to_pid` because that is more logical.

>> +	fprintf(stdout, _(" %s --get <PID>\n"), program_invocation_short_name);
>> +	fprintf(stdout, _(" %s --new <PID> [-t <TYPE>]\n"),
>> +		program_invocation_short_name);
>> +	fprintf(stdout, _(" %s --copy -s <PID> -d <PID> [-t <TYPE>]\n"),
>> +		program_invocation_short_name);
>> +	fprintf(stdout, _(" %s --exec [-s <PID>] -- PROGRAM ARGS... \n"),
>> +		program_invocation_short_name);
> 
> There are 4 different arguments that take a pid when there are really
> only at most 2 needed.

I chose this to keep the amount of options that you have to provide as
small possible. I thought that `coresched -n 123` would be easier to use
than `coresched -n -p 123`. I guess the amount of different arguments
that can take PIDs can be reduced to two, but it would make the commands
a bit longer.

> "Get" could just be the default with no arguments given.

I've removed the explicit --exec and made it the default when a program
name is provided. If no program name is provided, it defaults to --get.

>> +	enum {
>> +		OPT_GET = 'g',
>> +		OPT_NEW = 'n',
>> +		OPT_COPY = 'c',
>> +		OPT_EXEC = 'e',
>> +		OPT_SRC = 's',
>> +		OPT_DEST = 'd',
>> +		OPT_TYPE = 't',
>> +		OPT_VERSION = 'V',
>> +		OPT_HELP = 'h'
>> +	};
> 
> This seems over-engineered.  You have to specificy the characters
> in the getopt_long call anyway so this just complicates the code for
> no reason it seems to me.

Fair point, I've removed this. I initially added this to make it easier
to experiment a bit with different values for the options, but that is
no longer necessary.

Thanks!

- Thijs

Thijs Raymakers (1):
  coresched: Manage core scheduling cookies for tasks

 .gitignore                  |   1 +
 bash-completion/coresched   |   0
 configure.ac                |  12 +-
 meson.build                 |  16 +-
 meson_options.txt           |   2 +-
 schedutils/Makemodule.am    |   8 +
 schedutils/coresched.1.adoc |  16 ++
 schedutils/coresched.c      | 353 ++++++++++++++++++++++++++++++++++++
 8 files changed, 402 insertions(+), 6 deletions(-)
 create mode 100644 bash-completion/coresched
 create mode 100644 schedutils/coresched.1.adoc
 create mode 100644 schedutils/coresched.c

Interdiff:
diff --git a/schedutils/coresched.c b/schedutils/coresched.c
index 4be8f9fda..17d775f2d 100644
--- a/schedutils/coresched.c
+++ b/schedutils/coresched.c
@@ -18,18 +18,24 @@
 #include "nls.h"
 #include "strutils.h"
 
+// These definitions might not be defined, even if the
+// prctl interface accepts them.
+#ifndef PR_SCHED_CORE_SCOPE_THREAD
+#define PR_SCHED_CORE_SCOPE_THREAD 0
+#endif
+#ifndef PR_SCHED_CORE_SCOPE_THREAD_GROUP
+#define PR_SCHED_CORE_SCOPE_THREAD_GROUP 1
+#endif
+#ifndef PR_SCHED_CORE_SCOPE_PROCESS_GROUP
+#define PR_SCHED_CORE_SCOPE_PROCESS_GROUP 2
+#endif
+
+typedef int core_sched_type_t;
 typedef enum {
-	SCHED_CORE_SCOPE_PID = PR_SCHED_CORE_SCOPE_THREAD,
-	SCHED_CORE_SCOPE_TGID = PR_SCHED_CORE_SCOPE_THREAD_GROUP,
-	SCHED_CORE_SCOPE_PGID = PR_SCHED_CORE_SCOPE_PROCESS_GROUP,
-} core_sched_type_t;
-
-typedef enum {
-	SCHED_CORE_CMD_NONE = 0,
+	SCHED_CORE_CMD_EXEC = 0,
 	SCHED_CORE_CMD_GET = 1,
 	SCHED_CORE_CMD_CREATE = 2,
 	SCHED_CORE_CMD_COPY = 4,
-	SCHED_CORE_CMD_EXEC = 8,
 } core_sched_cmd_t;
 
 struct args {
@@ -50,44 +56,40 @@ void core_sched_exec_with_cookie(struct args *args, char **argv);
 core_sched_type_t parse_core_sched_type(char *str);
 bool verify_arguments(struct args *args);
 void parse_arguments(int argc, char **argv, struct args *args);
+void set_pid_or_err(pid_t *dest, pid_t src, const char *err_msg);
+static void __attribute__((__noreturn__)) usage(void);
 
 unsigned long core_sched_get_cookie(struct args *args)
 {
 	unsigned long cookie = 0;
-	int prctl_errno = prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET,
-				args->from_pid, SCHED_CORE_SCOPE_PID, &cookie);
-	if (prctl_errno) {
-		errx(-prctl_errno, "Failed to get cookie from PID %d",
-		     args->from_pid);
+	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, args->from_pid,
+		  PR_SCHED_CORE_SCOPE_THREAD, &cookie)) {
+		err(errno, "Failed to get cookie from PID %d", args->from_pid);
 	}
 	return cookie;
 }
 
 void core_sched_create_cookie(struct args *args)
 {
-	int prctl_errno = prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE,
-				args->from_pid, args->type, 0);
-	if (prctl_errno) {
-		errx(-prctl_errno, "Failed to create cookie for PID %d",
-		     args->from_pid);
+	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, args->to_pid, args->type,
+		  0)) {
+		err(errno, "Failed to create cookie for PID %d",
+		    args->from_pid);
 	}
 }
 
 void core_sched_pull_cookie(pid_t from)
 {
-	int prctl_errno = prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_FROM, from,
-				SCHED_CORE_SCOPE_PID, 0);
-	if (prctl_errno) {
-		errx(-prctl_errno, "Failed to pull cookie from PID %d", from);
+	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_FROM, from,
+		  PR_SCHED_CORE_SCOPE_THREAD, 0)) {
+		err(errno, "Failed to pull cookie from PID %d", from);
 	}
 }
 
 void core_sched_push_cookie(pid_t to, core_sched_type_t type)
 {
-	int prctl_errno =
-		prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, to, type, 0);
-	if (prctl_errno) {
-		errx(-prctl_errno, "Failed to push cookie to PID %d", to);
+	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, to, type, 0)) {
+		err(errno, "Failed to push cookie to PID %d", to);
 	}
 }
 
@@ -100,46 +102,35 @@ void core_sched_copy_cookie(struct args *args)
 void core_sched_exec_with_cookie(struct args *args, char **argv)
 {
 	if (!args->exec_argv_offset) {
-		errx(EINVAL, "when --exec is provided, a program name "
-			     "has to be given.");
+		usage();
 	}
 
 	// Move the argument list to the first argument of the program
 	argv = &argv[args->exec_argv_offset];
 
-	pid_t pid = fork();
-	if (pid == -1) {
-		errx(errno, "Failed to spawn new process");
+	// If a source PID is provided, try to copy the cookie from
+	// that PID. Otherwise, create a brand new cookie with the
+	// provided type.
+	if (args->from_pid) {
+		core_sched_pull_cookie(args->from_pid);
+	} else {
+		args->to_pid = getpid();
+		core_sched_create_cookie(args);
 	}
 
-	if (!pid) {
-		// If a source PID is provided, try to copy the cookie from
-		// that PID. Otherwise, create a brand new cookie with the
-		// provided type.
-		if (args->from_pid) {
-			core_sched_pull_cookie(args->from_pid);
-		} else {
-			args->from_pid = getpid();
-			core_sched_create_cookie(args);
-		}
-		if (execvp(argv[0], argv)) {
-			errexec(argv[0]);
-		}
-	} else {
-		int status = 0;
-		waitpid(pid, &status, 0);
-		exit(status);
+	if (execvp(argv[0], argv)) {
+		errexec(argv[0]);
 	}
 }
 
 core_sched_type_t parse_core_sched_type(char *str)
 {
 	if (!strncmp(str, "pid\0", 4)) {
-		return SCHED_CORE_SCOPE_PID;
+		return PR_SCHED_CORE_SCOPE_THREAD;
 	} else if (!strncmp(str, "tgid\0", 5)) {
-		return SCHED_CORE_SCOPE_TGID;
+		return PR_SCHED_CORE_SCOPE_THREAD_GROUP;
 	} else if (!strncmp(str, "pgid\0", 5)) {
-		return SCHED_CORE_SCOPE_PGID;
+		return PR_SCHED_CORE_SCOPE_PROCESS_GROUP;
 	}
 
 	errx(EINVAL, "'%s' is an invalid option. Must be one of pid/tgid/pgid",
@@ -155,7 +146,7 @@ static void __attribute__((__noreturn__)) usage(void)
 		program_invocation_short_name);
 	fprintf(stdout, _(" %s --copy -s <PID> -d <PID> [-t <TYPE>]\n"),
 		program_invocation_short_name);
-	fprintf(stdout, _(" %s --exec [-s <PID>] -- PROGRAM ARGS... \n"),
+	fprintf(stdout, _(" %s [-s <PID>] -- PROGRAM ARGS... \n"),
 		program_invocation_short_name);
 
 	fputs(USAGE_SEPARATOR, stdout);
@@ -169,9 +160,6 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputsln(_(" -c, --copy              copy the core scheduling cookie from PID to\n"
 		  "                           another PID, requires the --source and --dest option"),
 		stdout);
-	fputsln(_(" -e, --exec              execute a program with a new core scheduling\n"
-		  "                           cookie."),
-		stdout);
 
 	fputs(USAGE_OPTIONS, stdout);
 	fputsln(_(" -s, --source <PID>      where to copy the core scheduling cookie from."),
@@ -193,116 +181,141 @@ static void __attribute__((__noreturn__)) usage(void)
 
 bool verify_arguments(struct args *args)
 {
-	if (args->cmd == SCHED_CORE_CMD_NONE) {
-		usage();
-	}
-
 	// Check if the value of args->cmd is a power of 2
 	// In that case, only a single function option was set.
-	if (!(args->cmd && !(args->cmd & (args->cmd - 1)))) {
-		errx(EINVAL, "Cannot do more than one function at a time.");
-	}
-
-	if (args->from_pid < 0) {
-		errx(EINVAL, "source PID cannot be negative");
+	if (args->cmd & (args->cmd - 1)) {
+		errx(EINVAL,
+		     "Cannot do more than one function at a time. See %s --help",
+		     program_invocation_short_name);
 	}
 
-	if (args->to_pid < 0) {
-		errx(EINVAL, "destination PID cannot be negative");
-	}
-
-	if (args->from_pid == 0 && args->cmd == SCHED_CORE_CMD_COPY) {
-		errx(EINVAL, "valid argument to --source is required");
-	}
-
-	if (args->to_pid == 0 && args->cmd == SCHED_CORE_CMD_COPY) {
-		errx(EINVAL, "valid argument to --dest is required");
+	switch (args->cmd) {
+	case SCHED_CORE_CMD_GET:
+		if (args->to_pid) {
+			errx(EINVAL,
+			     "Cannot use -d/--dest with this -g/--get. See %s --help",
+			     program_invocation_short_name);
+		}
+		break;
+	case SCHED_CORE_CMD_CREATE:
+		if (args->from_pid) {
+			errx(EINVAL,
+			     "Cannot use -s/--source with this -n/--new. See %s --help",
+			     program_invocation_short_name);
+		}
+		break;
+	case SCHED_CORE_CMD_COPY:
+		if (!args->from_pid) {
+			errx(EINVAL,
+			     "-s/--source PID is required when copying");
+		}
+		if (!args->to_pid) {
+			errx(EINVAL, "-d/--dest PID is required when copying");
+		}
+		break;
+	case SCHED_CORE_CMD_EXEC:
+		if (args->to_pid) {
+			errx(EINVAL,
+			     "Cannot use -d/--dest when spawning a program. See %s --help",
+			     program_invocation_short_name);
+		}
+		break;
 	}
+	return true;
+}
 
-	if (args->from_pid == 0 && args->cmd != SCHED_CORE_CMD_EXEC) {
-		errx(EINVAL, "PID cannot be zero");
+void set_pid_or_err(pid_t *dest, pid_t src, const char *err_msg)
+{
+	if (*dest) {
+		errx(EINVAL, "Ambigious usage: %s", err_msg);
+	} else {
+		*dest = src;
 	}
-
-	return true;
 }
 
+static const char *ERR_MSG_MULTIPLE_SOURCE_PIDS =
+	"Multiple source PIDs defined";
 void parse_arguments(int argc, char **argv, struct args *args)
 {
 	int c;
-
-	enum {
-		OPT_GET = 'g',
-		OPT_NEW = 'n',
-		OPT_COPY = 'c',
-		OPT_EXEC = 'e',
-		OPT_SRC = 's',
-		OPT_DEST = 'd',
-		OPT_TYPE = 't',
-		OPT_VERSION = 'V',
-		OPT_HELP = 'h'
-	};
+	pid_t tmp;
 
 	static const struct option longopts[] = {
-		{ "get", required_argument, NULL, OPT_GET },
-		{ "new", required_argument, NULL, OPT_NEW },
-		{ "copy", no_argument, NULL, OPT_COPY },
-		{ "exec", no_argument, NULL, OPT_EXEC },
-		{ "source", required_argument, NULL, OPT_SRC },
-		{ "destination", required_argument, NULL, OPT_DEST },
-		{ "type", required_argument, NULL, OPT_TYPE },
-		{ "version", no_argument, NULL, OPT_VERSION },
-		{ "help", no_argument, NULL, OPT_HELP },
+		{ "get", required_argument, NULL, 'g' },
+		{ "new", required_argument, NULL, 'n' },
+		{ "copy", no_argument, NULL, 'c' },
+		{ "source", required_argument, NULL, 's' },
+		{ "destination", required_argument, NULL, 'd' },
+		{ "type", required_argument, NULL, 't' },
+		{ "version", no_argument, NULL, 'V' },
+		{ "help", no_argument, NULL, 'h' },
 		{ NULL, 0, NULL, 0 }
 	};
 
-	while ((c = getopt_long(argc, argv, "g:n:ces:d:t:Vh", longopts,
-				NULL)) != -1)
+	while ((c = getopt_long(argc, argv, "g:n:cs:d:t:Vh", longopts, NULL)) !=
+	       -1)
 		switch (c) {
-		case OPT_GET:
+		case 'g':
 			args->cmd |= SCHED_CORE_CMD_GET;
-			args->from_pid = strtos32_or_err(
-				optarg, "Failed to parse PID for --get");
+			tmp = strtopid_or_err(
+				optarg, "Failed to parse PID for -g/--get");
+			set_pid_or_err(&args->from_pid, tmp,
+				       ERR_MSG_MULTIPLE_SOURCE_PIDS);
 			break;
-		case OPT_NEW:
+		case 'n':
 			args->cmd |= SCHED_CORE_CMD_CREATE;
-			args->from_pid = strtos32_or_err(
-				optarg, "Failed to parse PID for --new");
+			tmp = strtopid_or_err(
+				optarg, "Failed to parse PID for -n/--new");
+			set_pid_or_err(&args->to_pid, tmp,
+				       ERR_MSG_MULTIPLE_SOURCE_PIDS);
 			break;
-		case OPT_COPY:
+		case 'c':
 			args->cmd |= SCHED_CORE_CMD_COPY;
 			break;
-		case OPT_EXEC:
-			args->cmd |= SCHED_CORE_CMD_EXEC;
-			break;
-		case OPT_SRC:
-			args->from_pid = strtos32_or_err(
-				optarg, "Failed to parse PID for --source");
+		case 's':
+			tmp = strtopid_or_err(
+				optarg, "Failed to parse PID for -s/--source");
+			set_pid_or_err(&args->from_pid, tmp,
+				       ERR_MSG_MULTIPLE_SOURCE_PIDS);
 			break;
-		case OPT_DEST:
-			args->to_pid = strtos32_or_err(
-				optarg, "Failed to parse PID for --dest");
+		case 'd':
+			tmp = strtopid_or_err(
+				optarg, "Failed to parse PID for -d/--dest");
+			set_pid_or_err(&args->to_pid, tmp,
+				       "Multiple destination PIDs defined");
 			break;
-		case OPT_TYPE:
+		case 't':
 			args->type = parse_core_sched_type(optarg);
 			break;
-		case OPT_VERSION:
+		case 'V':
 			print_version(EXIT_SUCCESS);
-		case OPT_HELP:
+		case 'h':
 			usage();
 		default:
 			errtryhelp(EXIT_FAILURE);
 		}
 
 	if (argc > optind) {
-		args->exec_argv_offset = optind;
+		if (args->cmd == SCHED_CORE_CMD_EXEC) {
+			args->exec_argv_offset = optind;
+		} else {
+			// -g, -n or -c AND a program to run is provided
+			errx(EINVAL, "bad usage, see %s --help",
+			     program_invocation_short_name);
+		}
+	} else if (argc == optind && args->from_pid) {
+		// Neither a function (-g, -n, or -c), nor a program to
+		// run is given
+		args->cmd = SCHED_CORE_CMD_GET;
 	}
+
 	verify_arguments(args);
 }
 
 int main(int argc, char **argv)
 {
 	struct args arguments = { 0 };
-	arguments.type = SCHED_CORE_SCOPE_TGID;
+	arguments.type = PR_SCHED_CORE_SCOPE_THREAD_GROUP;
 
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
-- 
2.44.0

