Received: from outbound.soverin.net (outbound.soverin.net [185.233.34.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53612135A4F
	for <util-linux@vger.kernel.org>; Wed, 27 Mar 2024 12:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.34.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711543414; cv=none; b=CsUodwCnvFalCAQUI8MFk5UZrJj08ANCzn/Oy0AboXaR5SJa5ceIowppjdzjBETzF9qEiNS8OLaObXjhnNgxbiEbj7NIAtJvWCEzLIjpa6eYO0ojiSzRJgXHieeHxy817rSKh56jHMFNYhHLQDEO1qIYGplEEiSLVDDVpaYjBZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711543414; c=relaxed/simple;
	bh=H78u7WxpqFMbaxmf1UQvd5rtOhKpHuRhOrRqPm/zdMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gFargv7sKWkoRPZdyjb9lg9vaJFFbBa01diZBJjcfWPwnA2X5gSM48xhdM+tKDVpnwWb8ZEBeIG3bsb7ZlDYDZlqhE2/5jzwV/N8YcJK3eqyBNa7DkZ4eG/mlOxWnYZHCqt0g1WN1IKqeVUzXCEhIedHmYElR1np69ll/ncL72I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raymakers.nl; spf=pass smtp.mailfrom=raymakers.nl; dkim=pass (2048-bit key) header.d=raymakers.nl header.i=@raymakers.nl header.b=iy/b98Qo; arc=none smtp.client-ip=185.233.34.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raymakers.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raymakers.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raymakers.nl header.i=@raymakers.nl header.b="iy/b98Qo"
Received: from smtp.soverin.net (c04cst-smtp-sov02.int.sover.in [10.10.4.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by outbound.soverin.net (Postfix) with ESMTPS id 4V4RDG2LXMz79;
	Wed, 27 Mar 2024 12:43:26 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [10.10.4.100]) by soverin.net (Postfix) with ESMTPSA id 4V4RDF5rJTzPP;
	Wed, 27 Mar 2024 12:43:25 +0000 (UTC)
Authentication-Results: smtp.soverin.net;
	dkim=pass (2048-bit key; unprotected) header.d=raymakers.nl header.i=@raymakers.nl header.a=rsa-sha256 header.s=soverin1 header.b=iy/b98Qo;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raymakers.nl;
	s=soverin1; t=1711543405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EOTII9ykXG5fQvwNmah+w8OBNUv1c+xww9Xi0Oepwu8=;
	b=iy/b98Qorawu4GkEzQYEJV40tTgDmO4D5AeVd/d1h1M1pLQrhF40LlfjgYa0CVbTe9D2Pu
	2JDGst03kZObfZo8W1DQfG+T+oIznhxCQgQ97k8yC5+Ohhk3Yjn7MT9o0C2SVs5OWKreun
	Z6YuVe/i7bfZrHSokxKlsMaFrUZJQev9yWjNtoBotd0s/UAgA/qK7hmZLH+smcaWfEnWYh
	Ux3E0at+tqi4TqrzVprVYVLQeKzYXdPC814r3Z4jQQBdwf2dPLmRZH4ih28kVodz7Xe4h7
	l6UtANkHh5Yf9rX20HlGfC4832rOgeg+3LNEEPIsn/vP2oILpaAvqwM7Y4ulWQ==
From: Thijs Raymakers <thijs@raymakers.nl>
To: pauld@redhat.com
Cc: kzak@redhat.com,
	util-linux@vger.kernel.org,
	Thijs Raymakers <thijs@raymakers.nl>
Subject: [PATCH v2 0/1] coresched: Manage core scheduling cookies for tasks
Date: Wed, 27 Mar 2024 13:43:20 +0100
Message-ID: <20240327124323.27029-1-thijs@raymakers.nl>
In-Reply-To: <20240326201722.gf315070@lorien.usersys.redhat.com>
References: <20240326201722.gf315070@lorien.usersys.redhat.com> <20240326201618.GE315070@lorien.usersys.redhat.com> <20240326181327.GC315070@lorien.usersys.redhat.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Phil,

Op 26-03-2024 om 19:13 schreef Phil Auld:
> On Tue, Mar 26, 2024 at 06:49:07PM +0100 Thijs Raymakers wrote:
>> Op 26-03-2024 om 15:41 schreef Phil Auld:
>>> On Sat, Mar 16, 2024 at 06:10:03PM +0100, Thijs Raymakers wrote:
>>>> - How should the program behave if the prctl core scheduling API is not
>>>>   available? It has been in Linus' tree since november 2021
>>>>   (commit a41b74451b35f7a6529689760eb8c05241feecbc) but it can be
>>>>   disabled with CONFIG_SCHED_CORE=n
>>> This one is tricky. If I recall the error you get is ambiguous in this case
>>> (EINVAL, which can be returned for other reasons). It would be nice to be
>>> able to report that specifically. 
>> In general, `prctl` does indeed return EINVAL if the operation is not
>> recognized, or not supported on the system. The `PR_SCHED_CORE`
>> operation itself only returns EINVAL if it is called with
>>   - an invalid operation
>>   - an invalid type
>>   - a negative PID
>>   - an invalid cookie store address (for PR_SCHED_CORE_GET)
>> Assuming that all these cases are prevented by the util, we could
>> interpret a EINVAL as a sign that PR_SCHED_CORE is not supported on
>> the system.
> Fair enough. Could say something like "got EINVAL. Does your kernel
> support CONFIG_SCHED_CORE?". 

I've added this as a warning in case a prctl call returns EINVAL. I
haven't tested it on a kernel with CONFIG_SCHED_CORE=n yet but I will do
that later.

> There is also
>        err_exclusive_options(c, longopts, excl, excl_st);
> 
> in the optuils.h code which can handle the tests for mutually exclusive
> arguments.
> 
> Thomas pointed me to that. It works nicely and can remove some of the extra
> checks (once you get it setup). And the error then looks the same as other
> util-linux progs. 

Good suggestion, I replaced some of the earlier mutually exclusive
checks with a call to err_exclusive_options.

> You might consider "errtryhelp(EXIT_FAILURE);"  in usage failures. A lot of
> the progs (incl taskset which is my model for this) do that. Then you only
> do the full usage when given -h/--help.

This does indeed feel a slightly nicer to use. I've added this in case a
of a usage failure. In case no options are given, it defaults to
printing the --help page. This matches the behavior of some other utils like
uclampset, and saves some time.


Op 26-03-2024 om 21:16 schreef Phil Auld:
> So "-n/--new" creates a new cookie and so does "". Just one on an existing task
> and one on the exec'd task.  Seems inconsistent, no?

Hmmm, I didn't intially see this as inconsistent behavior but I get why
you say this. I've modified this now to have -n/--new deal both with
assigning cookies to existing processes and to spawn new processes.


Op 26-03-2024 om 21:17 schreef Phil Auld:
> Btw, did you try coreset to see if it does what you need?

I did take a look at it. Thanks for adding the functionality of copying
a cookie from/to an existing PID. The commands take a bit of getting
used to for me, so I guess it is just a matter of preference of what feels
natural to use.
Some things that weren't directly clear to me:
- Both `coreset ls` and `coreset -n ls` spawn a new program. If I
  understood it correctly, the former spawns the program without
  a cookie, and the latter spawns it with a cookie. I'm not entirely
  sure what the point of the former would be, as the cookie would either
  be 0 or equal to the cookie of the `coreset` process itself since the
  cookie in inherited across execs. It is not necessary to run the
  provided program in that case.
- Not entirely sure what the difference between --dest and --to is.
  The names of these options are similar in meaning and do almost the
  same thing.
- It is not clear in what cases --scope is ignored and in which
  cases it is necessary.
- What does `coreset -c -s 0 -d 2 -p 1 ls` do? Does it first copy the
  cookie from PID 1 to PID 2, and then run `ls` with the same or
  different cookie? Or the other way around?

Now I do see what you meant earlier with imitating the behavior of the
`taskset` command. I don't think this is strictly necessary since it is
a different utility program, but I can understand that it can be useful
for people if the command behaves similar to a program that they already
know and have certain expectations of.

I've modified the options of coresched to be more in line with these
expectations, while also addressing the things I mentioned above.

Usage:
 coresched [-p PID]
 coresched --new [-t <TYPE>] -p <PID>
 coresched --new [-t <TYPE>] -- PROGRAM [ARGS...]
 coresched --copy -p <PID> [-t <TYPE>] -d <PID>
 coresched --copy -p <PID> [-t <TYPE>] -- PROGRAM [ARGS...]

This follows the taskset's behavior (i.e. perform the same operation
on either an existing PID or on a new program) and taskset's arguments
(-p for PID instead of the -s I had earlier) more closely than before.

I've attached an interdiff of the util compared to the previous version
that I sent yesterday. I think that this version encompases both our use
cases quite nicely.

Thijs

Thijs Raymakers (1):
  coresched: Manage core scheduling cookies for tasks

 .gitignore                  |   1 +
 bash-completion/coresched   |   0
 configure.ac                |  12 +-
 meson.build                 |  16 +-
 meson_options.txt           |   2 +-
 schedutils/Makemodule.am    |   8 +
 schedutils/coresched.1.adoc |  16 ++
 schedutils/coresched.c      | 363 ++++++++++++++++++++++++++++++++++++
 8 files changed, 412 insertions(+), 6 deletions(-)
 create mode 100644 bash-completion/coresched
 create mode 100644 schedutils/coresched.1.adoc
 create mode 100644 schedutils/coresched.c

Interdiff against v1:
diff --git a/schedutils/coresched.c b/schedutils/coresched.c
index 17d775f2d..537281fdb 100644
--- a/schedutils/coresched.c
+++ b/schedutils/coresched.c
@@ -12,10 +12,12 @@
 #include <stdio.h>
 #include <sys/prctl.h>
 #include <sys/wait.h>
+#include <unistd.h>
 
 #include "c.h"
 #include "closestream.h"
 #include "nls.h"
+#include "optutils.h"
 #include "strutils.h"
 
 // These definitions might not be defined, even if the
@@ -26,32 +28,34 @@
 #ifndef PR_SCHED_CORE_SCOPE_THREAD_GROUP
 #define PR_SCHED_CORE_SCOPE_THREAD_GROUP 1
 #endif
+
 #ifndef PR_SCHED_CORE_SCOPE_PROCESS_GROUP
 #define PR_SCHED_CORE_SCOPE_PROCESS_GROUP 2
 #endif
 
 typedef int core_sched_type_t;
+typedef unsigned long cookie_t;
 typedef enum {
-	SCHED_CORE_CMD_EXEC = 0,
-	SCHED_CORE_CMD_GET = 1,
-	SCHED_CORE_CMD_CREATE = 2,
-	SCHED_CORE_CMD_COPY = 4,
+	SCHED_CORE_CMD_GET,
+	SCHED_CORE_CMD_NEW,
+	SCHED_CORE_CMD_COPY,
 } core_sched_cmd_t;
 
 struct args {
-	pid_t from_pid;
-	pid_t to_pid;
+	pid_t pid;
+	pid_t dest;
 	core_sched_type_t type;
 	core_sched_cmd_t cmd;
 	int exec_argv_offset;
 };
 
-unsigned long core_sched_get_cookie(struct args *args);
-void core_sched_create_cookie(struct args *args);
+cookie_t core_sched_get_cookie(pid_t pid);
+void core_sched_create_cookie(pid_t pid, core_sched_type_t type);
 void core_sched_pull_cookie(pid_t from);
 void core_sched_push_cookie(pid_t to, core_sched_type_t type);
-void core_sched_copy_cookie(struct args *args);
+void core_sched_copy_cookie(pid_t from, pid_t to, core_sched_type_t to_type);
 void core_sched_exec_with_cookie(struct args *args, char **argv);
+void core_sched_get_and_print_cookie(pid_t pid);
 
 core_sched_type_t parse_core_sched_type(char *str);
 bool verify_arguments(struct args *args);
@@ -59,22 +63,31 @@ void parse_arguments(int argc, char **argv, struct args *args);
 void set_pid_or_err(pid_t *dest, pid_t src, const char *err_msg);
 static void __attribute__((__noreturn__)) usage(void);
 
-unsigned long core_sched_get_cookie(struct args *args)
+#define bad_usage(FMT...) \
+	warnx(FMT);       \
+	errtryhelp(EINVAL);
+
+#define check_coresched_in_kernel(errno)                              \
+	if (errno == EINVAL) {                                        \
+		warnx("Does your kernel support CONFIG_SCHED_CORE?"); \
+	}
+
+cookie_t core_sched_get_cookie(pid_t pid)
 {
-	unsigned long cookie = 0;
-	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, args->from_pid,
+	cookie_t cookie = 0;
+	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, pid,
 		  PR_SCHED_CORE_SCOPE_THREAD, &cookie)) {
-		err(errno, "Failed to get cookie from PID %d", args->from_pid);
+		check_coresched_in_kernel(errno);
+		err(errno, "Failed to get cookie from PID %d", pid);
 	}
 	return cookie;
 }
 
-void core_sched_create_cookie(struct args *args)
+void core_sched_create_cookie(pid_t pid, core_sched_type_t type)
 {
-	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, args->to_pid, args->type,
-		  0)) {
-		err(errno, "Failed to create cookie for PID %d",
-		    args->from_pid);
+	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, pid, type, 0)) {
+		check_coresched_in_kernel(errno);
+		err(errno, "Failed to create cookie for PID %d", pid);
 	}
 }
 
@@ -82,6 +95,7 @@ void core_sched_pull_cookie(pid_t from)
 {
 	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_FROM, from,
 		  PR_SCHED_CORE_SCOPE_THREAD, 0)) {
+		check_coresched_in_kernel(errno);
 		err(errno, "Failed to pull cookie from PID %d", from);
 	}
 }
@@ -89,14 +103,18 @@ void core_sched_pull_cookie(pid_t from)
 void core_sched_push_cookie(pid_t to, core_sched_type_t type)
 {
 	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, to, type, 0)) {
+		check_coresched_in_kernel(errno);
 		err(errno, "Failed to push cookie to PID %d", to);
 	}
 }
 
-void core_sched_copy_cookie(struct args *args)
+void core_sched_copy_cookie(pid_t from, pid_t to, core_sched_type_t to_type)
 {
-	core_sched_pull_cookie(args->from_pid);
-	core_sched_push_cookie(args->to_pid, args->type);
+	core_sched_pull_cookie(from);
+	cookie_t before = core_sched_get_cookie(from);
+	core_sched_push_cookie(to, to_type);
+	printf("%s: copied cookie 0x%lx from PID %d to PID %d\n",
+	       program_invocation_short_name, before, from, to);
 }
 
 void core_sched_exec_with_cookie(struct args *args, char **argv)
@@ -111,11 +129,15 @@ void core_sched_exec_with_cookie(struct args *args, char **argv)
 	// If a source PID is provided, try to copy the cookie from
 	// that PID. Otherwise, create a brand new cookie with the
 	// provided type.
-	if (args->from_pid) {
-		core_sched_pull_cookie(args->from_pid);
+	if (args->pid) {
+		core_sched_pull_cookie(args->pid);
+		core_sched_get_and_print_cookie(args->pid);
 	} else {
-		args->to_pid = getpid();
-		core_sched_create_cookie(args);
+		pid_t pid = getpid();
+		core_sched_create_cookie(pid, args->type);
+		cookie_t after = core_sched_get_cookie(pid);
+		printf("%s: set cookie of PID %d to 0x%lx\n",
+		       program_invocation_short_name, pid, after);
 	}
 
 	if (execvp(argv[0], argv)) {
@@ -123,6 +145,13 @@ void core_sched_exec_with_cookie(struct args *args, char **argv)
 	}
 }
 
+void core_sched_get_and_print_cookie(pid_t pid)
+{
+	cookie_t after = core_sched_get_cookie(pid);
+	printf("%s: set cookie of PID %d to 0x%lx\n",
+	       program_invocation_short_name, pid, after);
+}
+
 core_sched_type_t parse_core_sched_type(char *str)
 {
 	if (!strncmp(str, "pid\0", 4)) {
@@ -133,156 +162,96 @@ core_sched_type_t parse_core_sched_type(char *str)
 		return PR_SCHED_CORE_SCOPE_PROCESS_GROUP;
 	}
 
-	errx(EINVAL, "'%s' is an invalid option. Must be one of pid/tgid/pgid",
-	     str);
+	bad_usage("'%s' is an invalid option. Must be one of pid/tgid/pgid",
+		  str);
 	__builtin_unreachable();
 }
 
 static void __attribute__((__noreturn__)) usage(void)
 {
 	fputs(USAGE_HEADER, stdout);
-	fprintf(stdout, _(" %s --get <PID>\n"), program_invocation_short_name);
-	fprintf(stdout, _(" %s --new <PID> [-t <TYPE>]\n"),
+	fprintf(stdout, _(" %s [-p PID]\n"), program_invocation_short_name);
+	fprintf(stdout, _(" %s --new [-t <TYPE>] -p <PID>\n"),
 		program_invocation_short_name);
-	fprintf(stdout, _(" %s --copy -s <PID> -d <PID> [-t <TYPE>]\n"),
+	fprintf(stdout, _(" %s --new [-t <TYPE>] -- PROGRAM [ARGS...]\n"),
 		program_invocation_short_name);
-	fprintf(stdout, _(" %s [-s <PID>] -- PROGRAM ARGS... \n"),
+	fprintf(stdout, _(" %s --copy -p <PID> [-t <TYPE>] -d <PID>\n"),
+		program_invocation_short_name);
+	fprintf(stdout,
+		_(" %s --copy -p <PID> [-t <TYPE>] -- PROGRAM [ARGS...]\n"),
 		program_invocation_short_name);
 
 	fputs(USAGE_SEPARATOR, stdout);
 	fputsln(_("Manage core scheduling cookies for tasks."), stdout);
 
 	fputs(USAGE_FUNCTIONS, stdout);
-	fputsln(_(" -g, --get <PID>         get the core scheduling cookie of a PID"),
+	fputsln(_(" -n, --new          assign a new core scheduling cookie to an existing PID or\n"
+		  "                      execute a program with a new cookie."),
 		stdout);
-	fputsln(_(" -n, --new <PID>         assign a new core scheduling cookie to PID"),
+	fputsln(_(" -c, --copy         copy the core scheduling cookie from an existing PID to\n"
+		  "                      either another PID, or copy it to a new program"),
 		stdout);
-	fputsln(_(" -c, --copy              copy the core scheduling cookie from PID to\n"
-		  "                           another PID, requires the --source and --dest option"),
+	fputsln(_("\n If no function is provided, it will retrieve and print the cookie from\n"
+		  "   the PID provided via --pid.\n"),
 		stdout);
 
 	fputs(USAGE_OPTIONS, stdout);
-	fputsln(_(" -s, --source <PID>      where to copy the core scheduling cookie from."),
-		stdout);
-	fputsln(_(" -d, --dest <PID>        where to copy the core scheduling cookie to."),
+	fputsln(_(" -p, --pid <PID>    operate on an existing PID"), stdout);
+	fputsln(_(" -d, --dest <PID>   when copying a cookie from an existing PID, --dest is\n"
+		  "                      the destination PID where to copy the cookie to."),
 		stdout);
-	fputsln(_(" -t, --type              type of the destination PID, or the type of\n"
-		  "                           the PID when a new core scheduling cookie\n"
-		  "                           is created. Can be one of the following:\n"
-		  "                           pid, tgid or pgid. Defaults to tgid."),
+	fputsln(_(" -t, --type <TYPE>  type of the destination PID, or the type of the PID\n"
+		  "                      when a new core scheduling cookie is created.\n"
+		  "                      Can be one of the following: pid, tgid or pgid.\n"
+		  "                      The default is tgid."),
 		stdout);
 	fputs(USAGE_SEPARATOR, stdout);
 	fprintf(stdout,
 		USAGE_HELP_OPTIONS(
-			25)); /* char offset to align option descriptions */
+			20)); /* char offset to align option descriptions */
 	fprintf(stdout, USAGE_MAN_TAIL("coresched(1)"));
 	exit(EXIT_SUCCESS);
 }
 
-bool verify_arguments(struct args *args)
-{
-	// Check if the value of args->cmd is a power of 2
-	// In that case, only a single function option was set.
-	if (args->cmd & (args->cmd - 1)) {
-		errx(EINVAL,
-		     "Cannot do more than one function at a time. See %s --help",
-		     program_invocation_short_name);
-	}
-
-	switch (args->cmd) {
-	case SCHED_CORE_CMD_GET:
-		if (args->to_pid) {
-			errx(EINVAL,
-			     "Cannot use -d/--dest with this -g/--get. See %s --help",
-			     program_invocation_short_name);
-		}
-		break;
-	case SCHED_CORE_CMD_CREATE:
-		if (args->from_pid) {
-			errx(EINVAL,
-			     "Cannot use -s/--source with this -n/--new. See %s --help",
-			     program_invocation_short_name);
-		}
-		break;
-	case SCHED_CORE_CMD_COPY:
-		if (!args->from_pid) {
-			errx(EINVAL,
-			     "-s/--source PID is required when copying");
-		}
-		if (!args->to_pid) {
-			errx(EINVAL, "-d/--dest PID is required when copying");
-		}
-		break;
-	case SCHED_CORE_CMD_EXEC:
-		if (args->to_pid) {
-			errx(EINVAL,
-			     "Cannot use -d/--dest when spawning a program. See %s --help",
-			     program_invocation_short_name);
-		}
-		break;
-	}
-	return true;
-}
-
-void set_pid_or_err(pid_t *dest, pid_t src, const char *err_msg)
-{
-	if (*dest) {
-		errx(EINVAL, "Ambigious usage: %s", err_msg);
-	} else {
-		*dest = src;
-	}
-}
-
-static const char *ERR_MSG_MULTIPLE_SOURCE_PIDS =
-	"Multiple source PIDs defined";
 void parse_arguments(int argc, char **argv, struct args *args)
 {
 	int c;
-	pid_t tmp;
 
 	static const struct option longopts[] = {
-		{ "get", required_argument, NULL, 'g' },
-		{ "new", required_argument, NULL, 'n' },
+		{ "new", no_argument, NULL, 'n' },
 		{ "copy", no_argument, NULL, 'c' },
-		{ "source", required_argument, NULL, 's' },
-		{ "destination", required_argument, NULL, 'd' },
+		{ "pid", required_argument, NULL, 'p' },
+		{ "dest", required_argument, NULL, 'd' },
 		{ "type", required_argument, NULL, 't' },
 		{ "version", no_argument, NULL, 'V' },
 		{ "help", no_argument, NULL, 'h' },
 		{ NULL, 0, NULL, 0 }
 	};
+	static const ul_excl_t excl[] = {
+		{ 'c', 'n' }, // Cannot do both --new and --copy
+		{ 'd', 'n' }, // Cannot have both --new and --dest
+		{ 0 }
+	};
 
-	while ((c = getopt_long(argc, argv, "g:n:cs:d:t:Vh", longopts, NULL)) !=
-	       -1)
+	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
+
+	while ((c = getopt_long(argc, argv, "ncp:d:t:Vh", longopts, NULL)) !=
+	       -1) {
+		err_exclusive_options(c, longopts, excl, excl_st);
 		switch (c) {
-		case 'g':
-			args->cmd |= SCHED_CORE_CMD_GET;
-			tmp = strtopid_or_err(
-				optarg, "Failed to parse PID for -g/--get");
-			set_pid_or_err(&args->from_pid, tmp,
-				       ERR_MSG_MULTIPLE_SOURCE_PIDS);
-			break;
 		case 'n':
-			args->cmd |= SCHED_CORE_CMD_CREATE;
-			tmp = strtopid_or_err(
-				optarg, "Failed to parse PID for -n/--new");
-			set_pid_or_err(&args->to_pid, tmp,
-				       ERR_MSG_MULTIPLE_SOURCE_PIDS);
+			args->cmd = SCHED_CORE_CMD_NEW;
 			break;
 		case 'c':
-			args->cmd |= SCHED_CORE_CMD_COPY;
+			args->cmd = SCHED_CORE_CMD_COPY;
 			break;
-		case 's':
-			tmp = strtopid_or_err(
-				optarg, "Failed to parse PID for -s/--source");
-			set_pid_or_err(&args->from_pid, tmp,
-				       ERR_MSG_MULTIPLE_SOURCE_PIDS);
+		case 'p':
+			args->pid = strtopid_or_err(
+				optarg, "Failed to parse PID for -p/--pid");
 			break;
 		case 'd':
-			tmp = strtopid_or_err(
+			args->dest = strtopid_or_err(
 				optarg, "Failed to parse PID for -d/--dest");
-			set_pid_or_err(&args->to_pid, tmp,
-				       "Multiple destination PIDs defined");
 			break;
 		case 't':
 			args->type = parse_core_sched_type(optarg);
@@ -294,57 +263,98 @@ void parse_arguments(int argc, char **argv, struct args *args)
 		default:
 			errtryhelp(EXIT_FAILURE);
 		}
+	}
 
+	if (args->cmd == SCHED_CORE_CMD_COPY && !args->pid) {
+		bad_usage("--copy: requires a -p/--pid");
+	}
+
+	// More arguments have been passed, which means that the user wants to run
+	// another program with a core scheduling cookie.
 	if (argc > optind) {
-		if (args->cmd == SCHED_CORE_CMD_EXEC) {
-			args->exec_argv_offset = optind;
-		} else {
-			// -g, -n or -c AND a program to run is provided
-			errx(EINVAL, "bad usage, see %s --help",
-			     program_invocation_short_name);
+		switch (args->cmd) {
+		case SCHED_CORE_CMD_GET:
+			bad_usage("Unknown command");
+			break;
+		case SCHED_CORE_CMD_NEW:
+			if (args->pid) {
+				bad_usage(
+					"--new: cannot accept both a -p/--pid and a command");
+			} else {
+				args->exec_argv_offset = optind;
+			}
+			break;
+		case SCHED_CORE_CMD_COPY:
+			if (args->dest) {
+				bad_usage(
+					"--copy: cannot accept both a destination PID "
+					"-d/--dest and a command")
+			} else {
+				args->exec_argv_offset = optind;
+			}
+			break;
 		}
-	} else if (argc == optind && args->from_pid) {
-		// Neither a function (-g, -n, or -c), nor a program to
-		// run is given
-		args->cmd = SCHED_CORE_CMD_GET;
 	}
 
-	verify_arguments(args);
+	if (argc <= optind) {
+		if (args->cmd == SCHED_CORE_CMD_NEW && !args->pid) {
+			bad_usage(
+				"--new: requires either a -p/--pid or a command");
+		}
+		if (args->cmd == SCHED_CORE_CMD_COPY && !args->dest) {
+			bad_usage(
+				"--copy: requires either a -d/--dest or a command");
+		}
+	}
 }
 
 int main(int argc, char **argv)
 {
-	struct args arguments = { 0 };
-	arguments.type = PR_SCHED_CORE_SCOPE_THREAD_GROUP;
+	struct args args = { 0 };
+	args.cmd = SCHED_CORE_CMD_GET;
+	args.type = PR_SCHED_CORE_SCOPE_THREAD_GROUP;
 
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 	close_stdout_atexit();
 
-	parse_arguments(argc, argv, &arguments);
+	parse_arguments(argc, argv, &args);
+
+	cookie_t cookie = 0;
 
-	unsigned long cookie = 0;
-	switch (arguments.cmd) {
+	switch (args.cmd) {
 	case SCHED_CORE_CMD_GET:
-		cookie = core_sched_get_cookie(&arguments);
-		if (cookie) {
-			printf("core scheduling cookie of pid %d is 0x%lx\n",
-			       arguments.from_pid, cookie);
+		if (args.pid) {
+			cookie = core_sched_get_cookie(args.pid);
+			if (cookie) {
+				printf("%s: cookie of pid %d is 0x%lx\n",
+				       program_invocation_short_name, args.pid,
+				       cookie);
+			} else {
+				errx(ENODATA,
+				     "pid %d doesn't have a core scheduling cookie",
+				     args.pid);
+			}
 		} else {
-			printf("pid %d doesn't have a core scheduling cookie\n",
-			       arguments.from_pid);
-			exit(1);
+			usage();
+			exit(0);
 		}
 		break;
-	case SCHED_CORE_CMD_CREATE:
-		core_sched_create_cookie(&arguments);
+	case SCHED_CORE_CMD_NEW:
+		if (args.pid) {
+			core_sched_create_cookie(args.pid, args.type);
+			core_sched_get_and_print_cookie(args.pid);
+		} else {
+			core_sched_exec_with_cookie(&args, argv);
+		}
 		break;
 	case SCHED_CORE_CMD_COPY:
-		core_sched_copy_cookie(&arguments);
-		break;
-	case SCHED_CORE_CMD_EXEC:
-		core_sched_exec_with_cookie(&arguments, argv);
+		if (args.dest) {
+			core_sched_copy_cookie(args.pid, args.dest, args.type);
+		} else {
+			core_sched_exec_with_cookie(&args, argv);
+		}
 		break;
 	default:
 		usage();
-- 
2.44.0

