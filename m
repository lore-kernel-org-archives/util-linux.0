Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20140422100920.GB2405@x2.net.home>
References: <1397560535-14622-1-git-send-email-kerolasa@iki.fi>
	<1397560535-14622-8-git-send-email-kerolasa@iki.fi>
	<20140416101308.GG5786@x2.net.home>
	<CAG27Bk0oL7rEh-uDH7A6J5sofE+XrXcK-kavtOBiXQiF0JCjwA@mail.gmail.com>
	<5353E97D.5010603@bernhard-voelker.de>
	<20140422100920.GB2405@x2.net.home>
Date: Tue, 22 Apr 2014 21:55:53 +0100
Message-ID: <CAG27Bk1doKzO=tsqdde4jt0aBQxUm3NnBJGAYgwY3FvHH=fOOw@mail.gmail.com>
Subject: Re: [PATCH 7/9] tests: check kill all user processes
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: Bernhard Voelker <mail@bernhard-voelker.de>,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 22 April 2014 11:09, Karel Zak <kzak@redhat.com> wrote:
> On Sun, Apr 20, 2014 at 05:36:29PM +0200, Bernhard Voelker wrote:
>> On 04/20/2014 11:53 AM, Sami Kerola wrote:
>> > On 16 April 2014 11:13, Karel Zak <kzak@redhat.com> wrote:
>> >> On Tue, Apr 15, 2014 at 12:15:33PM +0100, Sami Kerola wrote:
>> >>> +HELPER_SYMLINK="$TS_CWD/$(mktemp -u XXXXXXXXXXXXXXX)"
>> >>> +ln -s "$TS_HELPER_SIGRECEIVE" "$HELPER_SYMLINK"
>> >>> +trap "rm -f $HELPER_SYMLINK" 0
>> >>> +
>> >>> +su nobody -s /bin/sh -c "$HELPER_SYMLINK $TS_CWD/nobody" >> "$TS_OUTPUT" 2>&1 &
>> >>
>> >> I don't understand this idea, on my system Mr.Nobody can not write
>> >> to my directories.
>> >>
>> >> It would be also better to add --setgit and --setuid to the helper to
>> >> avoid extra su(1) process, then you can use TEST_PID=$!
>> >
>> > The --setuid is added, [...]
>>
>> yes, setuid is a great idea, yet I'm not sure
>> if using UID 1 is a good idea:
>>
>>               if (setuid(1) < 0)
>>                       err(TEST_SIGRECEIVE_FAILURE, "setuid failed");

My thinking was that anything but zero uid is fine, as the test is
required to be run as root.  So hardcoding with a numeric value of 1 felt
a bit better than relying that an user account might be available.  That
said mr nobody is probably part of every single linux since early days.

>  Hmm, I though about non-hardcoded uid
>
>     --seruid <uid>
>
>  or so...  BTW, we have
>
>    tests/commands.sh:TS_TESTUSER=${TS_TESTUSER:-"test"}
>
>  maybe we can use "nobody" rather than the "test", and if the
>  $TS_TESTUSER does not exist then ts_skip the test. Currently the
>  $TS_TESTUSER is nowhere used.

The test_sigreceiver --setuid requires now an argument that is either a
login name or uid.

>> >>    awk '/SigCgt/ { print $2}' /proc/<pid>/status
>> >>
>> >> to check if the signal handlers are already initialized (the final
>> >> mask is 800000027ffbfeff on my system).
>>
>> > That is a much better way to determine if the process is ready to be
>> > killed. Implemented in my git, and I have only one remaining question.
>>
>> I'm not a big fan of magic numbers. Is there a chance to narrow down
>> the relevant bits?
>
>  Good point, hardcoded mask is probably bad idea as we use #ifdefs for
>  the signals in the code.
>
>  We don't have to test whole mask, just test for the last signal used
>  in the test_sigreceive.c, for example if the last signal specified
>  by sigaction() in the code is SIGHUP (=1), then
>
>     sigmask=$((16#$( awk '/SigCgt/ { print $2}' /proc/$TEST_PID/status) ))
>
>     if [ $(( $sigmask & 1 )) == 1 ]; then
>        echo "yes, test program is ready"
>     fi
>
>  is enough.

I had a look of awk manual to see if it could do the bit operation so
that rather awkward looking shell expression could be avoided, which
turned out to be (IMHO) nice way to do the SIGHUP bit check.

>  Note that now the code add SIGHUP as the first thing to the mask.

Move to bottom of the helper, with a comment it should stay there.

Here are the changes to previous submissions, that are also available in
branch kill-tests-v4


diff --git a/tests/commands.sh b/tests/commands.sh
index 33bb1ab..4b5a7d9 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -1,5 +1,5 @@
 # Misc settings
-TS_TESTUSER=${TS_TESTUSER:-"test"}
+TS_TESTUSER=${TS_TESTUSER:-"nobody"}

 # helpers
 TS_HELPER_BYTESWAP="$top_builddir/test_byteswap"
diff --git a/tests/helpers/Makemodule.am b/tests/helpers/Makemodule.am
index 0b927e9..6ac5b7f 100644
--- a/tests/helpers/Makemodule.am
+++ b/tests/helpers/Makemodule.am
@@ -13,3 +13,4 @@ test_sysinfo_SOURCES = tests/helpers/test_sysinfo.c

 check_PROGRAMS += test_sigreceive
 test_sigreceive_SOURCES = tests/helpers/test_sigreceive.c
+test_sigreceive_LDADD = $(LDADD) libcommon.la
diff --git a/tests/helpers/test_sigreceive.c b/tests/helpers/test_sigreceive.c
index 6424fbf..c7a8949 100644
--- a/tests/helpers/test_sigreceive.c
+++ b/tests/helpers/test_sigreceive.c
@@ -19,17 +19,21 @@

 #include <err.h>
 #include <getopt.h>
+#include <pwd.h>
 #include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/select.h>
+#include <sys/types.h>
 #include <unistd.h>

+#include "strutils.h"
+
 #define TEST_SIGRECEIVE_FAILURE 0

 static void __attribute__((__noreturn__)) usage(FILE *out)
 {
-	fputs("Usage: test_sigreceive [-s|--setuid]\n", out);
+	fputs("Usage: test_sigreceive [-s|--setuid <login|uid>]\n", out);
 	exit(TEST_SIGRECEIVE_FAILURE);
 }

@@ -44,18 +48,18 @@ int main(int argc, char **argv)
 	struct sigaction sigact;
 	fd_set rfds;
 	struct timeval timeout;
+	char *user = NULL;
 	int c;

 	static const struct option longopts[] = {
-		{"setuid", no_argument, NULL, 's'},
+		{"setuid", required_argument, NULL, 's'},
 		{NULL, 0, NULL, 0}
 	};

-	while ((c = getopt_long(argc, argv, "hs", longopts, NULL)) != -1)
+	while ((c = getopt_long(argc, argv, "s:h", longopts, NULL)) != -1)
 		switch (c) {
 		case 's':
-			if (setuid(1) < 0)
-				err(TEST_SIGRECEIVE_FAILURE, "setuid failed");
+			user = optarg;
 			break;
 		case 'h':
 			usage(stdout);
@@ -63,13 +67,25 @@ int main(int argc, char **argv)
 			usage(stderr);
 		}

+	if (user) {
+		struct passwd *pw;
+		uid_t uid;
+
+		pw = getpwnam(user);
+		if (pw)
+			uid = pw->pw_uid;
+		else
+			uid = strtou32_or_err(user, "failed to parse uid");
+		if (setuid(uid) < 0)
+			err(TEST_SIGRECEIVE_FAILURE, "setuid failed");
+	}
+
 	sigemptyset(&sigact.sa_mask);
 	sigact.sa_flags = 0;
 	sigact.sa_handler = exiter;
 	timeout.tv_sec = 5;
 	timeout.tv_usec = 0;

-	sigaction(SIGHUP, &sigact, NULL);
 	sigaction(SIGINT, &sigact, NULL);
 	sigaction(SIGQUIT, &sigact, NULL);
 	sigaction(SIGILL, &sigact, NULL);
@@ -87,7 +103,6 @@ int main(int argc, char **argv)
 	sigaction(SIGBUS, &sigact, NULL);
 #endif
 	sigaction(SIGFPE, &sigact, NULL);
-	sigaction(SIGKILL, &sigact, NULL);
 	sigaction(SIGUSR1, &sigact, NULL);
 	sigaction(SIGSEGV, &sigact, NULL);
 	sigaction(SIGUSR2, &sigact, NULL);
@@ -102,7 +117,6 @@ int main(int argc, char **argv)
 	sigaction(SIGCLD, &sigact, NULL);
 #endif
 	sigaction(SIGCONT, &sigact, NULL);
-	sigaction(SIGSTOP, &sigact, NULL);
 	sigaction(SIGTSTP, &sigact, NULL);
 	sigaction(SIGTTIN, &sigact, NULL);
 	sigaction(SIGTTOU, &sigact, NULL);
@@ -146,12 +160,15 @@ int main(int argc, char **argv)
 	sigaction(SIGSYS, &sigact, NULL);
 #endif
 #ifdef SIGRTMIN
-	sigaction(SIGRTMIN+0, &sigact, NULL);
-	sigaction(SIGRTMAX+0, &sigact, NULL);
+	sigaction(SIGRTMIN, &sigact, NULL);
+	sigaction(SIGRTMAX, &sigact, NULL);
 #endif
+	/* Keep SIGHUP last, the bit it flips tells to check script the
+	 * helper is ready to be killed.  */
+	sigaction(SIGHUP, &sigact, NULL);

 	FD_ZERO(&rfds);
-	FD_SET(0, &rfds);
+	FD_SET(STDIN_FILENO, &rfds);
 	select(STDIN_FILENO, &rfds, NULL, NULL, &timeout);

 	exiter(TEST_SIGRECEIVE_FAILURE);
diff --git a/tests/ts/kill/all_processes b/tests/ts/kill/all_processes
index 196866d..8d62381 100755
--- a/tests/ts/kill/all_processes
+++ b/tests/ts/kill/all_processes
@@ -27,14 +27,15 @@ HELPER_SYMLINK="$TS_CWD/$(mktemp -u XXXXXXXXXXXXXXX)"
 ln -s "$TS_HELPER_SIGRECEIVE" "$HELPER_SYMLINK"
 trap "rm -f $HELPER_SYMLINK" 0

-"$HELPER_SYMLINK" -s >> "$TS_OUTPUT" 2>&1 &
+"$HELPER_SYMLINK" -s "$TS_TESTUSER" >> "$TS_OUTPUT" 2>&1 &
 TEST_PID=$!

 # test_sigreceive needs time to start up
 for i in 0.01 0.1 1 1 1 1; do
 	awk 'BEGIN { retval=1 }
 	$1 ~ /^SigCgt/ {
-		if ($2 == "800000027ffbfeff") {
+		lbyte = strtonum("0x" substr($2, 16, 16))
+		if (and(lbyte, 1)) {
 			retval=0
 		}
 	} END {
diff --git a/tests/ts/kill/name_to_number b/tests/ts/kill/name_to_number
index c9afff1..a6a70fc 100755
--- a/tests/ts/kill/name_to_number
+++ b/tests/ts/kill/name_to_number
@@ -46,7 +46,8 @@ for SIG in $($TS_CMD_KILL -L); do
 	for i in 0.01 0.1 1 1 1 1; do
 		awk 'BEGIN { retval=1 }
 		$1 ~ /^SigCgt/ {
-			if ($2 == "800000027ffbfeff") {
+			lbyte = strtonum("0x" substr($2, 16, 16))
+			if (and(lbyte, 1)) {
 				retval=0
 			}
 		} END {
diff --git a/tests/ts/kill/options b/tests/ts/kill/options
index f040a1b..33a9b9b 100755
--- a/tests/ts/kill/options
+++ b/tests/ts/kill/options
@@ -36,7 +36,8 @@ try_option()
 	for i in 0.01 0.1 1 1 1 1; do
 		awk 'BEGIN { retval=1 }
 		$1 ~ /^SigCgt/ {
-			if ($2 == "800000027ffbfeff") {
+			lbyte = strtonum("0x" substr($2, 16, 16))
+			if (and(lbyte, 1)) {
 				retval=0
 			}
 		} END {
diff --git a/tests/ts/kill/print_pid b/tests/ts/kill/print_pid
index efe47e9..46bbb13 100755
--- a/tests/ts/kill/print_pid
+++ b/tests/ts/kill/print_pid
@@ -34,7 +34,8 @@ up=0
 for i in 0.01 0.1 1 1 1 1; do
 	awk 'BEGIN { retval=1 }
 	$1 ~ /^SigCgt/ {
-		if ($2 == "800000027ffbfeff") {
+		lbyte = strtonum("0x" substr($2, 16, 16))
+		if (and(lbyte, 1)) {
 			retval=0
 		}
 	} END {

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
