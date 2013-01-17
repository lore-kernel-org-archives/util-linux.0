Return-Path: ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: Karel Zak <kzak@redhat.com>
Cc: Mike Frysinger <vapier@gentoo.org>, util-linux@vger.kernel.org,
        Neil Horman <nhorman@tuxdriver.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>
References: <876234812z.fsf@xmission.com> <20130111161320.GA16206@x2.net.home>
	<87fw27jq29.fsf_-_@xmission.com>
	<201301111845.16591.vapier@gentoo.org>
	<20130114082846.GA16421@x2.net.home> <87a9s8lkbq.fsf_-_@xmission.com>
Date: Wed, 16 Jan 2013 16:34:17 -0800
In-Reply-To: <87a9s8lkbq.fsf_-_@xmission.com> (Eric W. Biederman's message of
	"Wed, 16 Jan 2013 16:33:29 -0800")
Message-ID: <874niglkae.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [PATCH 1/5] nsenter: Enhance waiting for a child process
List-ID: <util-linux.vger.kernel.org>


In the case of a pid namespace we need to fork a child process instead
of calling exec.  Move all of that logic out of line into a function
continue_as_child, making the logic of the primary case easier to
understand.

Update the logic for waiting for a child process to suspend ourselves
when the child processes suspends and to continue the child process
when we are unsuspsended.  This supports the bash suspend command and
various editors that suspend themselves.

If the child process exits with a signal update the logic to run
kill(getpid(), WTERMSIG(status)) so the caller sees the same exit code
that nsenter observed.

There will always be permission to send signals to our children and
the tty is not changing so there is no need for the intermediate
process to forward signals to it's child.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 sys-utils/nsenter.c |   48 +++++++++++++++++++++++++++++++++++-------------
 1 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
index e1f3995..ad01355 100644
--- a/sys-utils/nsenter.c
+++ b/sys-utils/nsenter.c
@@ -145,6 +145,39 @@ static void open_namespace_fd(int nstype, char *path)
 	err(EXIT_FAILURE, "Unrecognized namespace type");
 }
 
+static void continue_as_child(void)
+{
+	pid_t child = fork();
+	int status;
+	pid_t ret;
+
+	if (child < 0)
+		err(EXIT_FAILURE, _("fork failed"));
+
+	/* Only the child returns */
+	if (child == 0)
+		return;
+
+	for (;;) {
+		ret = waitpid(child, &status, WUNTRACED);
+		if ((ret == child) && (WIFSTOPPED(status))) {
+			/* The child suspended so suspend us as well */
+			kill(getpid(), SIGSTOP);
+			kill(child, SIGCONT);
+		} else {
+			break;
+		}
+	}
+	/* Return the child's exit code if possible */
+	if (WIFEXITED(status)) {
+		exit(WEXITSTATUS(status));
+	}
+	else if (WIFSIGNALED(status)) {
+		kill(getpid(), WTERMSIG(status));
+	}
+	exit(EXIT_FAILURE);
+}
+
 int main(int argc, char *argv[])
 {
 	static const struct option longopts[] = {
@@ -266,19 +299,8 @@ int main(int argc, char *argv[])
 		wd_fd = -1;
 	}
 
-	if (do_fork) {
-		pid_t child = fork();
-		if (child < 0)
-			err(EXIT_FAILURE, _("fork failed"));
-		if (child != 0) {
-			int status;
-			if ((waitpid(child, &status, 0) == child) &&
-			     WIFEXITED(status)) {
-				exit(WEXITSTATUS(status));
-			}
-			exit(EXIT_FAILURE);
-		}
-	}
+	if (do_fork)
+		continue_as_child();
 
 	execvp(argv[optind], argv + optind);
 
-- 
1.7.5.4
