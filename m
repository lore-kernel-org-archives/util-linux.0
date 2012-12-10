Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vc0-f174.google.com ([209.85.220.174]:38420 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279Ab2LJXi0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 10 Dec 2012 18:38:26 -0500
Received: by mail-vc0-f174.google.com with SMTP id d16so3048897vcd.19
        for <util-linux@vger.kernel.org>; Mon, 10 Dec 2012 15:38:25 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20121210090607.GB21405@x2.net.home>
References: <1355087316-12422-1-git-send-email-kerolasa@iki.fi>
	<20121210090607.GB21405@x2.net.home>
Date: Mon, 10 Dec 2012 23:38:24 +0000
Message-ID: <CAG27Bk286UPt6dSVHCi3RsTYRzBuSqJyNsXdjByMyj_CVYiNOA@mail.gmail.com>
Subject: Re: [PATCH 1/3] ipcs: add --human readable size conversion option
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Dec 10, 2012 at 9:06 AM, Karel Zak <kzak@redhat.com> wrote:

Thank you for review Karel,

> On Sun, Dec 09, 2012 at 09:08:34PM +0000, Sami Kerola wrote:
>> +.B \-\-human
>> +Show print sizes in human readable format (e.g., 1K 234M 2G).
>
>  Nice idea, but what about create any smart function to print the stuff
>  to avoid all the "if (unit == UNIT_DEFAULT) else" in the code?

Yes, that could be done.

>> +             if (unit == UNIT_DEFAULT)
>> +                     printf(_("max seg size (kbytes) = %ju\n"),
>> +                            lim.shmmax / 1024);
>> +             else if (unit == UNIT_HUMAN)
>> +                     printf(_("max seg size = %s\n"),
>> +                            size_to_human_string(SIZE_SUFFIX_1LETTER,
>> +                                                 lim.shmmax));
>
>  ipc_print(IPC_UNIT_KB, _("max seg size), lim.shmmax, "\n");
>
> (append " (bytes) = " if there is not "=" at the end of the string)

I hear the preference,
  - Small changes are good change.
  - But changes that result to understandable clean code are better.

The earlier patches are modified match with thinking above, and pushed to
my weekly branch;

The following changes since commit
72c9217951b7dd317a5d903d88291a9e87297969:

  tests: unset *_DEBUG variables (2012-12-10 13:43:11 +0100)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git 2012wk50

for you to fetch changes up to af1fe782e029b40fd99d5dccba8bb77ca2d2b0fa:

  ipcs: add --bytes size output option (2012-12-10 22:58:08 +0000)

----------------------------------------------------------------
Sami Kerola (4):
      docs: swapon.8 option name fix
      ipcs: assist debugging
      ipcs: add --human readable size conversion option
      ipcs: add --bytes size output option

 sys-utils/ipcs.c     | 111
++++++++++++++++++++++++++++++++-------------------
 sys-utils/ipcutils.c |  40 +++++++++++++++++++
 sys-utils/ipcutils.h |   9 +++++
 sys-utils/swapon.8   |   2 +-
 4 files changed, 119 insertions(+), 43 deletions(-)


Here full diff of that patch that is completely rethought.


>From ee5ba39f135c195e2939c3234512782b6c97ddec Mon Sep 17 00:00:00 2001
From: Sami Kerola <kerolasa@iki.fi>
Date: Mon, 10 Dec 2012 20:39:26 +0000
Subject: ipcs: add --human readable size conversion option
Organization: Lastminute.com

Introduces new function ipc_print_size() which will call
size_to_human_string(), and handles the occasional '([k]bytes)' printing
if default size format is requested.

Reviewed-by: Karel Zak <kzak@redhat.com>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/ipcs.c     | 88 ++++++++++++++++++++++++++++++++--------------------
 sys-utils/ipcutils.c | 40 ++++++++++++++++++++++++
 sys-utils/ipcutils.h |  9 ++++++
 3 files changed, 103 insertions(+), 34 deletions(-)

diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
index 889c868..66c6302 100644
--- a/sys-utils/ipcs.c
+++ b/sys-utils/ipcs.c
@@ -33,14 +33,16 @@ enum output_formats {
  TIME,
  PID
 };
+enum {
+ OPT_HUMAN = CHAR_MAX + 1
+};

-static void do_shm (char format);
-static void print_shm (int id);
+static void do_shm (char format, int unit);
+static void print_shm (int id, int unit);
 static void do_sem (char format);
 static void print_sem (int id);
-static void do_msg (char format);
-
-void print_msg (int id);
+static void do_msg (char format, int unit);
+static void print_msg (int id, int unit);

 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
@@ -64,6 +66,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
  fputs(_(" -c, --creator     show creator and owner\n"), out);
  fputs(_(" -l, --limits      show resource limits\n"), out);
  fputs(_(" -u, --summary     show status summary\n"), out);
+ fputs(_("     --human       show sizes in human readable format\n"), out);
  fprintf(out, USAGE_MAN_TAIL("ipcs(1)"));
  exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
@@ -72,6 +75,7 @@ int main (int argc, char **argv)
 {
  int opt, msg = 0, sem = 0, shm = 0, id=0, print=0;
  char format = NOTSPECIFIED;
+ int unit = IPC_UNIT_DEFAULT;
  static const struct option longopts[] = {
  {"id", required_argument, NULL, 'i'},
  {"shmems", no_argument, NULL, 'm'},
@@ -83,6 +87,7 @@ int main (int argc, char **argv)
  {"creator", no_argument, NULL, 'c'},
  {"limits", no_argument, NULL, 'l'},
  {"summary", no_argument, NULL, 'u'},
+ {"human", no_argument, NULL, OPT_HUMAN},
  {"version", no_argument, NULL, 'V'},
  {"help", no_argument, NULL, 'h'},
  {NULL, 0, NULL, 0}
@@ -127,6 +132,9 @@ int main (int argc, char **argv)
  case 'u':
  format = STATUS;
  break;
+ case OPT_HUMAN:
+ unit = IPC_UNIT_HUMAN;
+ break;
  case 'h':
  usage(stdout);
  case 'V':
@@ -139,11 +147,11 @@ int main (int argc, char **argv)

  if  (print) {
  if (shm)
- print_shm (id);
+ print_shm (id, unit);
  if (sem)
  print_sem (id);
  if (msg)
- print_msg (id);
+ print_msg (id, unit);
  if (!shm && !sem && !msg )
  usage (stderr);
  } else {
@@ -152,7 +160,7 @@ int main (int argc, char **argv)
  printf ("\n");

  if (shm) {
- do_shm (format);
+ do_shm (format, unit);
  printf ("\n");
  }
  if (sem) {
@@ -160,14 +168,14 @@ int main (int argc, char **argv)
  printf ("\n");
  }
  if (msg) {
- do_msg (format);
+ do_msg (format, unit);
  printf ("\n");
  }
  }
  return EXIT_SUCCESS;
 }

-static void do_shm (char format)
+static void do_shm (char format, int unit)
 {
  struct passwd *pw;
  struct shm_data *shmds, *shmdsp;
@@ -181,10 +189,13 @@ static void do_shm (char format)
  if (ipc_shm_get_limits(&lim))
  return;
  printf (_("max number of segments = %ju\n"), lim.shmmni);
- printf (_("max seg size (kbytes) = %ju\n"), lim.shmmax / 1024);
- printf (_("max total shared memory (kbytes) = %ju\n"),
- (lim.shmall / 1024) * getpagesize());
- printf (_("min seg size (bytes) = %ju\n"), lim.shmmin);
+ ipc_print_size(unit == IPC_UNIT_DEFAULT ? IPC_UNIT_KB : unit,
+       _("max seg size"), lim.shmmax, "\n", 0);
+ ipc_print_size(unit == IPC_UNIT_DEFAULT ? IPC_UNIT_KB : unit,
+       _("max total shared memory"),
+       lim.shmall * getpagesize(), "\n", 0);
+ ipc_print_size(unit == IPC_UNIT_DEFAULT ? IPC_UNIT_BYTES : unit,
+       _("min seg size"), lim.shmmin, "\n", 0);
  return;
  }
  case STATUS:
@@ -248,7 +259,8 @@ static void do_shm (char format)
  default:
  printf (_("------ Shared Memory Segments --------\n"));
  printf ("%-10s %-10s %-10s %-10s %-10s %-10s %-12s\n",
- _("key"),_("shmid"),_("owner"),_("perms"),_("bytes"),
+ _("key"),_("shmid"),_("owner"),_("perms"),
+ unit == IPC_UNIT_HUMAN ? _("size") : _("bytes"),
  _("nattch"),_("status"));
  break;
  }
@@ -295,9 +307,9 @@ static void do_shm (char format)
  printf ("%-10d %-10.10s", shmdsp->shm_perm.id, pw->pw_name);
  else
  printf ("%-10d %-10u", shmdsp->shm_perm.id, shmdsp->shm_perm.uid);
- printf (" %-10o %-10lu %-10ld %-6s %-6s\n",
- shmdsp->shm_perm.mode & 0777,
- shmdsp->shm_segsz,
+ printf (" %-10o ", shmdsp->shm_perm.mode & 0777);
+ ipc_print_size(unit, NULL, shmdsp->shm_segsz, NULL, -10);
+ printf (" %-10ld %-6s %-6s\n",
  shmdsp->shm_nattch,
  shmdsp->shm_perm.mode & SHM_DEST ? _("dest") : " ",
  shmdsp->shm_perm.mode & SHM_LOCKED ? _("locked") : " ");
@@ -410,7 +422,7 @@ static void do_sem (char format)
  return;
 }

-static void do_msg (char format)
+static void do_msg (char format, int unit)
 {
  struct passwd *pw;
  struct msg_data *msgds, *msgdsp;
@@ -424,8 +436,10 @@ static void do_msg (char format)
  return;
  printf (_("------ Messages Limits --------\n"));
  printf (_("max queues system wide = %d\n"), lim.msgmni);
- printf (_("max size of message (bytes) = %zu\n"), lim.msgmax);
- printf (_("default max size of queue (bytes) = %d\n"), lim.msgmnb);
+ ipc_print_size(unit == IPC_UNIT_DEFAULT ? IPC_UNIT_BYTES : unit,
+       _("max size of message"), lim.msgmax, "\n", 0);
+ ipc_print_size(unit == IPC_UNIT_DEFAULT ? IPC_UNIT_BYTES : unit,
+       _("default max size of queue"), lim.msgmnb, "\n", 0);
  return;
  }
  case STATUS:
@@ -438,7 +452,8 @@ static void do_msg (char format)
  printf (_("------ Messages Status --------\n"));
  printf (_("allocated queues = %d\n"), msginfo.msgpool);
  printf (_("used headers = %d\n"), msginfo.msgmap);
- printf (_("used space = %d bytes\n"), msginfo.msgtql);
+ ipc_print_size(unit, _("used space ="), msginfo.msgtql,
+       unit == IPC_UNIT_DEFAULT ? _(" bytes\n") : "\n", 0);
  return;
  }
  case CREATOR:
@@ -463,7 +478,8 @@ static void do_msg (char format)
  printf (_("------ Message Queues --------\n"));
  printf ("%-10s %-10s %-10s %-10s %-12s %-12s\n",
  _("key"), _("msqid"), _("owner"), _("perms"),
- _("used-bytes"), _("messages"));
+ unit == IPC_UNIT_HUMAN ? _("size") : _("used-bytes"),
+ _("messages"));
  break;
  }

@@ -508,10 +524,9 @@ static void do_msg (char format)
  printf ("%-10d %-10.10s", msgdsp->msg_perm.id, pw->pw_name);
  else
  printf ("%-10d %-10u", msgdsp->msg_perm.id, msgdsp->msg_perm.uid);
- printf (" %-10o %-12ld %-12ld\n",
- msgdsp->msg_perm.mode & 0777,
- msgdsp->q_cbytes,
- msgdsp->q_qnum);
+ printf (" %-10o ", msgdsp->msg_perm.mode & 0777);
+ ipc_print_size(unit, NULL, msgdsp->q_cbytes, NULL, -12);
+ printf (" %-12ld\n", msgdsp->q_qnum);
  break;
  }
  }
@@ -520,7 +535,7 @@ static void do_msg (char format)
  return;
 }

-static void print_shm(int shmid)
+static void print_shm(int shmid, int unit)
 {
  struct shm_data *shmdata;

@@ -535,8 +550,10 @@ static void print_shm(int shmid)
        shmdata->shm_perm.cuid, shmdata->shm_perm.cgid);
  printf(_("mode=%#o\taccess_perms=%#o\n"), shmdata->shm_perm.mode,
        shmdata->shm_perm.mode & 0777);
- printf(_("bytes=%ju\tlpid=%u\tcpid=%u\tnattch=%jd\n"),
-       shmdata->shm_segsz, shmdata->shm_lprid, shmdata->shm_cprid,
+ ipc_print_size(unit, unit == IPC_UNIT_HUMAN ? _("size=") : _("bytes="),
+       shmdata->shm_segsz, "\t", 0);
+ printf(_("lpid=%u\tcpid=%u\tnattch=%jd\n"),
+       shmdata->shm_lprid, shmdata->shm_cprid,
        shmdata->shm_nattch);
  printf(_("att_time=%-26.24s\n"),
        shmdata->shm_atim ? ctime(&(shmdata->shm_atim)) : _("Not set"));
@@ -548,8 +565,7 @@ static void print_shm(int shmid)
  ipc_shm_free_info(shmdata);
 }

-
-void print_msg(int msgid)
+void print_msg(int msgid, int unit)
 {
  struct msg_data *msgdata;

@@ -563,8 +579,12 @@ void print_msg(int msgid)
        msgdata->msg_perm.uid, msgdata->msg_perm.uid,
        msgdata->msg_perm.cuid, msgdata->msg_perm.cgid,
        msgdata->msg_perm.mode);
- printf(_("cbytes=%jd\tqbytes=%jd\tqnum=%jd\tlspid=%d\tlrpid=%d\n"),
-       msgdata->q_cbytes, msgdata->q_qbytes, msgdata->q_qnum,
+ ipc_print_size(unit, unit == IPC_UNIT_HUMAN ? _("csize=") : _("cbytes="),
+       msgdata->q_cbytes, "\t", 0);
+ ipc_print_size(unit, unit == IPC_UNIT_HUMAN ? _("qsize=") : _("qbytes="),
+       msgdata->q_qbytes, "\t", 0);
+ printf("qnum=%jd\tlspid=%d\tlrpid=%d\n",
+       msgdata->q_qnum,
        msgdata->q_lspid, msgdata->q_lrpid);
  printf(_("send_time=%-26.24s\n"),
        msgdata->q_stime ? ctime(&msgdata->q_stime) : _("Not set"));
diff --git a/sys-utils/ipcutils.c b/sys-utils/ipcutils.c
index 7d1f0d1..d81ca20 100644
--- a/sys-utils/ipcutils.c
+++ b/sys-utils/ipcutils.c
@@ -7,6 +7,7 @@
 #include "path.h"
 #include "pathnames.h"
 #include "ipcutils.h"
+#include "strutils.h"

 #ifndef SEMVMX
 # define SEMVMX  32767 /* <= 32767 semaphore maximum value */
@@ -504,3 +505,42 @@ void ipc_print_perms(FILE *f, struct ipc_stat *is)
  else
  fprintf(f, " %-10u\n", is->gid);
 }
+
+void ipc_print_size(int unit, char *msg, size_t size, const char *end,
+    int width)
+{
+ char format[16];
+
+ if (!msg)
+ /* NULL */ ;
+ else if (msg[strlen(msg) - 1] == '=')
+ printf("%s", msg);
+ else if (unit == IPC_UNIT_BYTES)
+ printf(_("%s (bytes) = "), msg);
+ else if (unit == IPC_UNIT_KB)
+ printf(_("%s (kbytes) = "), msg);
+ else
+ printf("%s = ", msg);
+
+ switch (unit) {
+ case IPC_UNIT_DEFAULT:
+ case IPC_UNIT_BYTES:
+ sprintf(format, "%%%dzu", width);
+ printf(format, size);
+ break;
+ case IPC_UNIT_KB:
+ sprintf(format, "%%%dzu", width);
+ printf(format, size / 1024);
+ break;
+ case IPC_UNIT_HUMAN:
+ sprintf(format, "%%%ds", width);
+ printf(format, size_to_human_string(SIZE_SUFFIX_1LETTER, size));
+ break;
+ default:
+ /* impossible occurred */
+ abort();
+ }
+
+ if (end)
+ printf("%s", end);
+}
diff --git a/sys-utils/ipcutils.h b/sys-utils/ipcutils.h
index 28b35c1..6383124 100644
--- a/sys-utils/ipcutils.h
+++ b/sys-utils/ipcutils.h
@@ -78,6 +78,14 @@ union semun {
 # define KEY key
 #endif

+/* Size printing in ipcs is using these. */
+enum {
+ IPC_UNIT_DEFAULT,
+ IPC_UNIT_BYTES,
+ IPC_UNIT_KB,
+ IPC_UNIT_HUMAN
+};
+
 struct ipc_limits {
  uint64_t shmmni; /* max number of segments */
  uint64_t shmmax; /* max segment size */
@@ -110,6 +118,7 @@ struct ipc_stat {
 };

 extern void ipc_print_perms(FILE *f, struct ipc_stat *is);
+extern void ipc_print_size(int unit, char *msg, size_t size, const
char *end, int width);

 /* See 'struct shmid_kernel' in kernel sources
  */
--
1.8.0.1

--
   Sami Kerola
   http://www.iki.fi/kerolasa/
