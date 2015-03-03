Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <CAG27Bk0MbRfsQtAwZx7bjrP-HwoYV6798-2MS7yDuwBazUO-HA@mail.gmail.com>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
	<1424616106-580-2-git-send-email-kerolasa@iki.fi>
	<20150224094007.GE19430@ws.net.home>
	<alpine.LNX.2.03.1503011106350.822@iki.fi>
	<20150303113250.GP8046@ws.net.home>
	<CAG27Bk0MbRfsQtAwZx7bjrP-HwoYV6798-2MS7yDuwBazUO-HA@mail.gmail.com>
Date: Tue, 3 Mar 2015 23:07:52 +0000
Message-ID: <CAG27Bk3F6Bhdz4i5M+LQAY2yPU7+EfxWxGr=WJf7Cm-PfFBadA@mail.gmail.com>
Subject: Re: [PATCH 01/16] whereis: tell when mandatory option is missing
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 3 March 2015 at 12:59, Sami Kerola <kerolasa@iki.fi> wrote:
> On 3 March 2015 at 11:32, Karel Zak <kzak@redhat.com> wrote:
>>  Did you update your "various" branch? I still see old patches on
>>  github. (And I'd like to "git pull" :-)
>
> I left the original branches as-is. Now when all has had enough time
> to have look of my github commits I'll rewrite the history where
> needed, and send update pull as various2, script2, more2, and so on
> branches. Since that's not a lot of work I assume to do the submission
> at evening (work is distracting hobbies).

The second versions of the four branches are available.

Fix to comment Benno mentioned is here. And of course I removed the
earlier mistake addition to unrelated commit.

https://github.com/kerolasa/lelux-utiliteetit/commit/fc5097c31b7e5eb43e92e577b2b66c6fe66de240

Karel, your proposal to avoid unnecessary fopen() && fclose() pairs
resulted to new commit

https://github.com/kerolasa/lelux-utiliteetit/commit/2a6f4ec60281bf69f1ac2d72d06752c376b78053

that is also below, but does not make the script2 branch quite ready.
The HAVE_LIBUTEMPTER problem is still present.

Summary: the following two branches ought to be ready for merge:
  git://github.com/kerolasa/lelux-utiliteetit.git rtcwake2
  git://github.com/kerolasa/lelux-utiliteetit.git various2

p.s. Here's mail list review copy of commit 2a6f4ec6.

--->8----
From: Sami Kerola <kerolasa@iki.fi>
Date: Tue, 3 Mar 2015 22:06:01 +0000
Subject: [PATCH] script: move timing file opening close to use of it

This allows removing almost immediate closure of file handle in the
doshell() function that does not use the file.

Proposed-by: Karel Zak <kzak@redhat.com>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/script.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index e15ea38..6812548 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -90,6 +90,7 @@ struct script_control {
     char *cflg;        /* command to be executed */
     char *fname;        /* output file path */
     FILE *typescriptfp;    /* output file pointer */
+    char *tname;        /* timing file path */
     FILE *timingfp;        /* timing file pointer */
     struct timeval oldtime;    /* previous write or command start time */
     int master;        /* pseudoterminal master file descriptor */
@@ -169,6 +170,9 @@ static void __attribute__((__noreturn__))
done(struct script_control *ctl)
         else
             exit(WEXITSTATUS(ctl->childstatus));
     }
+    if (ctl->timingfp)
+        fclose(ctl->timingfp);
+    fclose(ctl->typescriptfp);
     exit(EXIT_SUCCESS);
 }

@@ -271,8 +275,17 @@ static void do_io(struct script_control *ctl)
     time_t tvec = time((time_t *)NULL);
     char buf[128];

-    if (ctl->tflg && !ctl->timingfp)
-        ctl->timingfp = fdopen(STDERR_FILENO, "w");
+    if ((ctl->typescriptfp = fopen(ctl->fname, ctl->aflg ? "a" :
"w")) == NULL) {
+        warn(_("cannot open %s"), ctl->fname);
+        fail(ctl);
+    }
+    if (ctl->tflg) {
+        if (!ctl->tname) {
+            if (!(ctl->timingfp = fopen("/dev/stderr", "w")))
+                err(EXIT_FAILURE, _("cannot open %s"), "/dev/stderr");
+        } else if (!(ctl->timingfp = fopen(ctl->tname, "w")))
+            err(EXIT_FAILURE, _("cannot open %s"), ctl->tname);
+    }

     pfd[0].fd = STDIN_FILENO;
     pfd[0].events = POLLIN;
@@ -344,11 +357,6 @@ static void __attribute__((__noreturn__))
doshell(struct script_control *ctl)

     /* close things irrelevant for this process */
     close(ctl->master);
-    if (ctl->typescriptfp)
-        fclose(ctl->typescriptfp);
-    if (ctl->timingfp)
-        fclose(ctl->timingfp);
-    ctl->typescriptfp = ctl->timingfp = NULL;

     dup2(ctl->slave, STDIN_FILENO);
     dup2(ctl->slave, STDOUT_FILENO);
@@ -522,8 +530,8 @@ int main(int argc, char **argv)
             ctl.qflg = 1;
             break;
         case 't':
-            if (optarg && !(ctl.timingfp = fopen(optarg, "w")))
-                err(EXIT_FAILURE, _("cannot open %s"), optarg);
+            if (optarg)
+                ctl.tname = optarg;
             ctl.tflg = 1;
             break;
         case 'V':
@@ -546,11 +554,6 @@ int main(int argc, char **argv)
         die_if_link(&ctl);
     }

-    if ((ctl.typescriptfp = fopen(ctl.fname, ctl.aflg ? "a" : "w")) == NULL) {
-        warn(_("cannot open %s"), ctl.fname);
-        fail(&ctl);
-    }
-
     ctl.shell = getenv("SHELL");
     if (ctl.shell == NULL)
         ctl.shell = _PATH_BSHELL;
-- 
2.3.1
