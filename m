Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F6C42056
	for <util-linux@vger.kernel.org>; Sat, 25 Jan 2025 10:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737801594; cv=none; b=VyC2QOwSrFilRE9jY+6LLsN8vNGyv6pz2ZkGtJbh4VJJstaeLy2BqkQiFpYaYXQdyulQI4gwV0KjxHpdKv1fYosOGEr++J/gCuvFDjt/Vg29qndK3XERpAnojLUFF4lD383rPoGfRLcgLD1PPuLNuzvIpLp4xLwWxfEJF3w8izs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737801594; c=relaxed/simple;
	bh=515SX2EhKqy7PubabVFvLHFGSvxbvTgdGlBjUg1N8Qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tMmCdLPNbGQSc++cs2GiQQPH8S31GbP/eCsOcaKX7hmvLiqzIkT/DMYiuqjLsllODXCEuQXgeK1oVBmGShOktGIpsyF+milmx81UpRwXyZk+kXu1/oHEvGnIxabrWO3CnByQ0OQA4XdZo2/WCcHCTPfd1+Awg/IDsHj3VxPFxDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PApbLbnC; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PApbLbnC"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4afd68271b6so847039137.0
        for <util-linux@vger.kernel.org>; Sat, 25 Jan 2025 02:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737801589; x=1738406389; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nr97rhe1xpK4qWutfSB1rtTEcD/L7R2sxWyZsnK+HHQ=;
        b=PApbLbnCOvC3pDGMQbq/nTb0Lo3EZtqhz05/CEM/lK2ut+MMHJMWdrLpYp16nD5Aw9
         XiUA1HX0RGoIBHTW90M54nleJA3zQh+CdMLAodJoCrdKR5/X/6DLLgLIf8nAM06ifCmT
         fuIOqTDwMaMIeFv03yhmr+R4oiJnCXMgtqCVxqc/RFF5aVe2biizb2DDA7DKblMesauV
         7Akm93XJ5Lxxn77rWTG9+iK986tKMe1CwIeodbBANGVn/n9xZ4fHK5EQrcFo2J56d1rq
         1efAKdTDv3TtGBq5XE/o54fOQSjPvbDrD602BEAWLnqHQSCj8cqEr7EDFN3kAAfb6Vcq
         OFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737801589; x=1738406389;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nr97rhe1xpK4qWutfSB1rtTEcD/L7R2sxWyZsnK+HHQ=;
        b=fCS6Z5wkY9qG1H1ru2i6/ViVUmAsHe7u+4mx74y2L1SD7bwqwTxuEMNqhos0+e/NNU
         rLKmMCbe8AzLBvzLXFymLpM0Xe+H+K00jCNEiBVL+IXkipF1ik5WmOPBxr2d4/FaJpgz
         MFqpRP9UVmszs6xIWutcQtFEJLinfwZ8J2hlAcY1IA42H2Y+q/akknfvToPqp1/0hS/m
         W6Gojv/G5wGgKZ8haJ3YeyULdLuaZyn1Fpc6A0sNZx/6oU8aT6j3xXSgLI0n2OnIu80D
         jGsTHJBNyOoln76W00Wl3B6LOL1upZwsaO+UITTXf1WdzJzPaxwgjd6grzrIXvADBBs0
         cI7w==
X-Forwarded-Encrypted: i=1; AJvYcCUs+dA9VFoV3AoN+RRypmpfMIWLvOqypmWjfJ2xZarIQZxyexnEhvZHNw/PFHkFUPq1atoyCNI1lQsH@vger.kernel.org
X-Gm-Message-State: AOJu0YylVzpa+Fth7HzXvWBtd9JpGFjWBQpiMO6zStbK7qeCa8ebMmtT
	mrBOPCWhBGSu/Y+xDHex2v1pS2GHLUouz8pb+IqqNvAk66eiGPwX5Sh9FDuTGwY6Xu4vPLsd+lK
	mPSf2kVj+v397b+S0dfRkn3BVZZJw
X-Gm-Gg: ASbGnctsgKPxa8JRFzOmXpxK7n9WIQsivh3tywlgXka1pkuaIh8mEreDU4mhJvYBgLn
	Mz6Q6N4bvmL2r5YP9iu8RZZqSXuG8UsGOXQCm06CJnY1cGEtcAXnwjr54RnI0CQgMogki4/xl
X-Google-Smtp-Source: AGHT+IGgV2P9y0Pryk5GneJ3CU2FKczEKdmHsQRl/sA97uzzmedsy55W/MkNMcRF43cUKV/mRk5qKrBZb/OF7IDQ49s=
X-Received: by 2002:a05:6102:5129:b0:4af:d487:45ed with SMTP id
 ada2fe7eead31-4b690b87864mr27249379137.4.1737801588966; Sat, 25 Jan 2025
 02:39:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOfrUuZ8fL3kz=p2Pwh5JN6Nm9UvE4NPtcikNFCL8LC7r5FW0g@mail.gmail.com>
 <20240424095240.l2fzrswgtvaqpv2o@ws.net.home> <20240424.221517.2073047999286647720.yamato@redhat.com>
In-Reply-To: <20240424.221517.2073047999286647720.yamato@redhat.com>
From: Prasanna Paithankar <paithankarprasanna@gmail.com>
Date: Sat, 25 Jan 2025 16:09:37 +0530
X-Gm-Features: AWEUYZl_DdLS11viFJAwvkA80_F7FNAHqXPM5lnNLxGj6Acld-rO3-VMToe2Z8M
Message-ID: <CAOfrUuZWskGunBK9U62Lxf21iBiCFCkE5KfwACEiwRsowDgw+Q@mail.gmail.com>
Subject: Re: [RFC] ipcs for POSIX IPC
To: Masatake YAMATO <yamato@redhat.com>
Cc: kzak@redhat.com, util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Apr 2024 at 18:45, Masatake YAMATO <yamato@redhat.com> wrote:
> On Wed, 24 Apr 2024 11:52:40 +0200, Karel Zak wrote:
>> On Wed, Apr 24, 2024 at 04:10:48AM +0530, Prasanna Paithankar wrote:
>>> The 'ipcs' (and 'ipcrm') command provides information on (or removes
>>> some) System V IPC resources. I'd like to know why no similar utility
>>> for POSIX IPC has existed for a long time. I would like to know if
>>> such a tool exists in case I missed it. If not, I will provide patches
>>> to ipcs and ipcrm (or should I separate the functionality into a new
>>> utility).
>>
>> I would suggest improving 'lsipc' instead of using the old 'ipcs'.
>>
>> The question is where to find information about POSIX IPC. For System
>> V, there is /proc/sysvipc, but there is no equivalent for POSIX (or I
>> am not aware of it). It seems that the only way to gather this
>> information is by scanning all processes' memory maps for /dev/shm.
>> This could be achieved by using lsfd.

Gathered information about POSIX IPC by scanning through /dev/shm (for
shm and sem) and /dev/mqueue (for mqueue).
Used libmount to mount /dev/mqueue if not already mounted in ipcutils.c.

Patched ipcrm.c and ipcmk.c to unlink and open POSIX IPC objects respectively.

Didn't add short command line options in ipcrm as recommended (Open
Group requirements).

Pull request open at: https://github.com/util-linux/util-linux/pull/3382

Yours sincerely
Prasanna Paithankar

>
> Masatake YAMATO
>
>>     Karel
>>
>>>
>>> Yours sincerely
>>> Prasanna Paithankar
>>>
>>
>> --
>>  Karel Zak  <kzak@redhat.com>
>>  http://karelzak.blogspot.com
>>
----------------------------------------------------------------

From 7a16f0535469dbf94d631cf40ddc539322b6d291 Mon Sep 17 00:00:00 2001
From: Prasanna Paithankar <paithankarprasanna@gmail.com>
Date: Thu, 23 Jan 2025 03:23:52 +0530
Subject: [PATCH 0/2]

The following changes since commit eba4f374fe49e3369e58acedaaed3e4581b1ce80:

  Merge branch 'column-handle-osc8-links' of
https://github.com/juarezr/util-linux (2025-01-22 11:47:04 +0100)

are available in the Git repository at:

  https://github.com/PrasannaPaithankar/util-linux.git ipc

for you to fetch changes up to 7a16f0535469dbf94d631cf40ddc539322b6d291:

  added POSIX IPC paathnames; modified sys-utils/Makemodule.am
(2025-01-23 03:18:31 +0530)

----------------------------------------------------------------

Prasanna Paithankar (2):
  added POSIX IPC support to lsipc, ipcrm, ipcmk
  added POSIX IPC paathnames; modified sys-utils/Makemodule.am

 include/pathnames.h     |  11 +-
 sys-utils/Makemodule.am |  16 +-
 sys-utils/ipcmk.1.adoc  |  15 +-
 sys-utils/ipcmk.c       |  93 ++++++++-
 sys-utils/ipcrm.1.adoc  |  21 +-
 sys-utils/ipcrm.c       | 137 +++++++++++-
 sys-utils/ipcutils.c    | 285 +++++++++++++++++++++++++
 sys-utils/ipcutils.h    |  52 +++++
 sys-utils/lsipc.1.adoc  |  22 +-
 sys-utils/lsipc.c       | 448 +++++++++++++++++++++++++++++++++++++---
 10 files changed, 1040 insertions(+), 60 deletions(-)

--
2.43.0

----------------------------------------------------------------

From c457ec945b4457418af6d5d80f4e6357b15cba9b Mon Sep 17 00:00:00 2001
From: Prasanna Paithankar <paithankarprasanna@gmail.com>
Date: Thu, 23 Jan 2025 03:08:02 +0530
Subject: [PATCH 1/2] added POSIX IPC support to lsipc, ipcrm, ipcmk

---
 sys-utils/ipcmk.1.adoc |  15 +-
 sys-utils/ipcmk.c      |  93 ++++++++-
 sys-utils/ipcrm.1.adoc |  21 +-
 sys-utils/ipcrm.c      | 137 ++++++++++++-
 sys-utils/ipcutils.c   | 285 ++++++++++++++++++++++++++
 sys-utils/ipcutils.h   |  52 +++++
 sys-utils/lsipc.1.adoc |  22 +-
 sys-utils/lsipc.c      | 448 ++++++++++++++++++++++++++++++++++++++---
 8 files changed, 1021 insertions(+), 52 deletions(-)

diff --git a/sys-utils/ipcmk.1.adoc b/sys-utils/ipcmk.1.adoc
index 605b9286c..a4871f438 100644
--- a/sys-utils/ipcmk.1.adoc
+++ b/sys-utils/ipcmk.1.adoc
@@ -20,7 +20,7 @@ ipcmk - make various IPC resources

 == DESCRIPTION

-*ipcmk* allows you to create System V inter-process communication
(IPC) objects: shared memory segments, message queues, and semaphore
arrays.
+*ipcmk* allows you to create POSIX and System V inter-process
communication (IPC) objects: shared memory segments, message queues,
and semaphore (arrays for System V).

 == OPTIONS

@@ -29,12 +29,24 @@ Resources can be specified with these options:
 *-M*, *--shmem* _size_::
 Create a shared memory segment of _size_ bytes. The _size_ argument
may be followed by the multiplicative suffixes KiB (=1024), MiB
(=1024*1024), and so on for GiB, etc. (the "iB" is optional, e.g., "K"
has the same meaning as "KiB") or the suffixes KB (=1000), MB
(=1000*1000), and so on for GB, etc.

+*-m*, *--posix-shmem* _size_::
+Create a POSIX shared memory segment of _size_ bytes. The _size_
argument may be followed by the multiplicative suffixes KiB (=1024),
MiB (=1024*1024), and so on for GiB, etc. (the "iB" is optional, e.g.,
"K" has the same meaning as "KiB") or the suffixes KB (=1000), MB
(=1000*1000), and so on for GB, etc.
+
 *-Q*, *--queue*::
 Create a message queue.

+*-q*, *--posix-mqueue*::
+Create a POSIX message queue.
+
 *-S*, *--semaphore* _number_::
 Create a semaphore array with _number_ of elements.

+*-s*, *--posix-semaphore*::
+Create a POSIX named semaphore.
+
+*-n*, *--name* _name_::
+Name of the POSIX IPC object. This option is mandatory for POSIX IPC objects.
+
 Other options are:

 *-p*, *--mode* _mode_::
@@ -50,6 +62,7 @@ mailto:hayden.james@gmail.com[Hayden A. James]

 *ipcrm*(1),
 *ipcs*(1),
+*lsipc*(1),
 *sysvipc*(7)

 include::man-common/bugreports.adoc[]
diff --git a/sys-utils/ipcmk.c b/sys-utils/ipcmk.c
index 67a7637f6..7e48b270e 100644
--- a/sys-utils/ipcmk.c
+++ b/sys-utils/ipcmk.c
@@ -26,8 +26,12 @@
 #include <stdlib.h>
 #include <sys/ipc.h>
 #include <sys/msg.h>
+#include <mqueue.h>
 #include <sys/sem.h>
+#include <semaphore.h>
 #include <sys/shm.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
 #include <sys/time.h>

 #include "c.h"
@@ -44,6 +48,23 @@ static int create_shm(size_t size, int permission)
  return shmget(key, size, permission | IPC_CREAT);
 }

+static int create_posix_shm(const char *name, size_t size, int permission)
+{
+ int shmfd;
+
+ if (-1 == (shmfd = shm_open(name, O_RDWR | O_CREAT, permission)))
+ return -1;
+
+ if (-1 == ftruncate(shmfd, size)) {
+ close(shmfd);
+ return -1;
+ }
+
+ close(shmfd);
+ printf(_("POSIX shared memory name: %s\n"), name);
+ return 0;
+}
+
 static int create_msg(int permission)
 {
  key_t key;
@@ -52,6 +73,14 @@ static int create_msg(int permission)
  return msgget(key, permission | IPC_CREAT);
 }

+static int create_posix_msg(const char *name, int permission)
+{
+ if (-1 == mq_open(name, O_RDWR | O_CREAT, permission, NULL))
+ return -1;
+ printf(_("POSIX message queue name: %s\n"), name);
+ return 0;
+}
+
 static int create_sem(int nsems, int permission)
 {
  key_t key;
@@ -60,6 +89,18 @@ static int create_sem(int nsems, int permission)
  return semget(key, nsems, permission | IPC_CREAT);
 }

+static int create_posix_sem(const char *name, int permission)
+{
+ sem_t *sem;
+
+ if (SEM_FAILED == (sem = sem_open(name, O_CREAT, permission, 0)))
+ return -1;
+
+ sem_close(sem);
+ printf(_("POSIX semaphore name: %s\n"), name);
+ return 0;
+}
+
 static void __attribute__((__noreturn__)) usage(void)
 {
  FILE *out = stdout;
@@ -71,9 +112,13 @@ static void __attribute__((__noreturn__)) usage(void)

  fputs(USAGE_OPTIONS, out);
  fputs(_(" -M, --shmem <size>       create shared memory segment of
size <size>\n"), out);
+ fputs(_(" -m, --posix-shmem <size> create POSIX shared memory
segment of size <size>\n"), out);
  fputs(_(" -S, --semaphore <number> create semaphore array with
<number> elements\n"), out);
+ fputs(_(" -s, --posix-semaphore    create POSIX semaphore\n"), out);
  fputs(_(" -Q, --queue              create message queue\n"), out);
+ fputs(_(" -q, --posix-mqueue       create POSIX message queue\n"), out);
  fputs(_(" -p, --mode <mode>        permission for the resource
(default is 0644)\n"), out);
+ fputs(_(" -n, --name <name>        name of the POSIX resource\n"), out);

  fputs(USAGE_SEPARATOR, out);
  fprintf(out, USAGE_HELP_OPTIONS(26));
@@ -81,6 +126,9 @@ static void __attribute__((__noreturn__)) usage(void)
  fputs(USAGE_ARGUMENTS, out);
  fprintf(out, USAGE_ARG_SIZE(_("<size>")));

+ fputs(USAGE_SEPARATOR, out);
+ fputs(_(" -n, --name <name> option is required for POSIX IPC\n"), out);
+
  fprintf(out, USAGE_MAN_TAIL("ipcmk(1)"));

  exit(EXIT_SUCCESS);
@@ -89,15 +137,20 @@ static void __attribute__((__noreturn__)) usage(void)
 int main(int argc, char **argv)
 {
  int permission = 0644;
+ char *name = NULL;
  int opt;
  size_t size = 0;
  int nsems = 0;
- int ask_shm = 0, ask_msg = 0, ask_sem = 0;
+ int ask_shm = 0, ask_msg = 0, ask_sem = 0, ask_pshm = 0, ask_pmsg =
0, ask_psem = 0;
  static const struct option longopts[] = {
  {"shmem", required_argument, NULL, 'M'},
+ {"posix-shmem", required_argument, NULL, 'm'},
  {"semaphore", required_argument, NULL, 'S'},
+ {"posix-semaphore", required_argument, NULL, 's'},
  {"queue", no_argument, NULL, 'Q'},
+ {"posix-mqueue", no_argument, NULL, 'q'},
  {"mode", required_argument, NULL, 'p'},
+ {"name", required_argument, NULL, 'n'},
  {"version", no_argument, NULL, 'V'},
  {"help", no_argument, NULL, 'h'},
  {NULL, 0, NULL, 0}
@@ -108,19 +161,29 @@ int main(int argc, char **argv)
  textdomain(PACKAGE);
  close_stdout_atexit();

- while((opt = getopt_long(argc, argv, "hM:QS:p:Vh", longopts, NULL)) != -1) {
+ while((opt = getopt_long(argc, argv, "hM:m:QqS:sp:n:Vh", longopts,
NULL)) != -1) {
  switch(opt) {
  case 'M':
  size = strtosize_or_err(optarg, _("failed to parse size"));
  ask_shm = 1;
  break;
+ case 'm':
+ size = strtosize_or_err(optarg, _("failed to parse size"));
+ ask_pshm = 1;
+ break;
  case 'Q':
  ask_msg = 1;
  break;
+ case 'q':
+ ask_pmsg = 1;
+ break;
  case 'S':
  nsems = strtos32_or_err(optarg, _("failed to parse elements"));
  ask_sem = 1;
  break;
+ case 's':
+ ask_psem = 1;
+ break;
  case 'p':
  {
  char *end = NULL;
@@ -130,6 +193,9 @@ int main(int argc, char **argv)
  err(EXIT_FAILURE, _("failed to parse mode"));
  break;
  }
+ case 'n':
+ name = optarg;
+ break;
  case 'h':
  usage();
  case 'V':
@@ -139,10 +205,16 @@ int main(int argc, char **argv)
  }
  }

- if(!ask_shm && !ask_msg && !ask_sem) {
+ if(!ask_shm && !ask_msg && !ask_sem && !ask_pshm && !ask_pmsg && !ask_psem) {
  warnx(_("bad usage"));
  errtryhelp(EXIT_FAILURE);
  }
+
+ if ((ask_pshm + ask_pmsg + ask_psem > 0) && name == NULL) {
+ warnx(_("name is required for POSIX IPC"));
+ errtryhelp(EXIT_FAILURE);
+ }
+
  if (ask_shm) {
  int shmid;
  if (-1 == (shmid = create_shm(size, permission)))
@@ -151,6 +223,11 @@ int main(int argc, char **argv)
  printf(_("Shared memory id: %d\n"), shmid);
  }

+ if (ask_pshm) {
+ if (-1 == create_posix_shm(name, size, permission))
+ err(EXIT_FAILURE, _("create POSIX shared memory failed"));
+ }
+
  if (ask_msg) {
  int msgid;
  if (-1 == (msgid = create_msg(permission)))
@@ -159,6 +236,11 @@ int main(int argc, char **argv)
  printf(_("Message queue id: %d\n"), msgid);
  }

+ if (ask_pmsg) {
+ if (-1 == create_posix_msg(name, permission))
+ err(EXIT_FAILURE, _("create POSIX message queue failed"));
+ }
+
  if (ask_sem) {
  int semid;
  if (-1 == (semid = create_sem(nsems, permission)))
@@ -167,5 +249,10 @@ int main(int argc, char **argv)
  printf(_("Semaphore id: %d\n"), semid);
  }

+ if (ask_psem) {
+ if (-1 == create_posix_sem(name, permission))
+ err(EXIT_FAILURE, _("create POSIX semaphore failed"));
+ }
+
  return EXIT_SUCCESS;
 }
diff --git a/sys-utils/ipcrm.1.adoc b/sys-utils/ipcrm.1.adoc
index 98e363892..f4a8b4546 100644
--- a/sys-utils/ipcrm.1.adoc
+++ b/sys-utils/ipcrm.1.adoc
@@ -23,19 +23,19 @@ ipcrm - remove certain IPC resources

 == DESCRIPTION

-*ipcrm* removes System V inter-process communication (IPC) objects
and associated data structures from the system. In order to delete
such objects, you must be superuser, or the creator or owner of the
object.
+*ipcrm* removes POSIX and System V inter-process communication (IPC)
objects and associated data structures from the system. In order to
delete such objects, you must be superuser, or the creator or owner of
the object.

-System V IPC objects are of three types: shared memory, message
queues, and semaphores. Deletion of a message queue or semaphore
object is immediate (regardless of whether any process still holds an
IPC identifier for the object). A shared memory object is only removed
after all currently attached processes have detached (*shmdt*(2)) the
object from their virtual address space.
+POSIX and System V IPC objects are of three types: shared memory,
message queues, and semaphores. Deletion of a message queue or
semaphore object is immediate (regardless of whether any process still
holds an IPC identifier for the object). A shared memory object is
only removed after all currently attached processes have detached
(*shmdt*(2)) the object from their virtual address space.

 Two syntax styles are supported. The old Linux historical syntax
specifies a three-letter keyword indicating which class of object is
to be deleted, followed by one or more IPC identifiers for objects of
this type.

 The SUS-compliant syntax allows the specification of zero or more
objects of all three types in a single command line, with objects
specified either by key or by identifier (see below). Both keys and
identifiers may be specified in decimal, hexadecimal (specified with
an initial '0x' or '0X'), or octal (specified with an initial '0').

-The details of the removes are described in *shmctl*(2), *msgctl*(2),
and *semctl*(2). The identifiers and keys can be found by using
*ipcs*(1).
+The details of the removes are described in *shmctl*(2),
*shm_unlink*(3), *msgctl*(2), *mq_unlink*(3), *semctl*(2), and
*sem_unlink*(3). The identifiers and keys can be found by using
*lsipc*(1) or *ipcs*(1).

 == OPTIONS

-*-a*, *--all* [*shm*] [*msg*] [*sem*]::
+*-a*, *--all* [*shm*] [*pshm*] [*msg*] [*pmsg*] [*sem*] [*psem*]::
 Remove all resources. When an option argument is provided, the
removal is performed only for the specified resource types.
 +
 _Warning!_ Do not use *-a* if you are unsure how the software using
the resources might react to missing objects. Some programs create
these resources at startup and may not have any code to deal with an
unexpected disappearance.
@@ -46,18 +46,27 @@ Remove the shared memory segment created with
_shmkey_ after the last detach is
 *-m*, *--shmem-id* _shmid_::
 Remove the shared memory segment identified by _shmid_ after the last
detach is performed.

+*-x*, *--posix-shmem* _name_::
+Remove the POSIX shared memory segment created with _name_.
+
 *-Q*, *--queue-key* _msgkey_::
 Remove the message queue created with _msgkey_.

 *-q*, *--queue-id* _msgid_::
 Remove the message queue identified by _msgid_.

+*-y*, *--posix-mqueue* _name_::
+Remove the POSIX message queue created with _name_.
+
 *-S*, *--semaphore-key* _semkey_::
 Remove the semaphore created with _semkey_.

 *-s*, *--semaphore-id* _semid_::
 Remove the semaphore identified by _semid_.

+*-z*, *--posix-semaphore* _name_::
+Remove the POSIX named semaphore created with _name_.
+
 include::man-common/help-version.adoc[]

 == NOTES
@@ -69,13 +78,17 @@ In its first Linux implementation, *ipcrm* used
the deprecated syntax shown in t

 *ipcmk*(1),
 *ipcs*(1),
+*lsipc*(1),
 *msgctl*(2),
+*mq_unlink*(3),
 *msgget*(2),
 *semctl*(2),
 *semget*(2),
+*sem_unlink*(3),
 *shmctl*(2),
 *shmdt*(2),
 *shmget*(2),
+*shm_unlink*(3),
 *ftok*(3),
 *sysvipc*(7)

diff --git a/sys-utils/ipcrm.c b/sys-utils/ipcrm.c
index 26255c494..2d080b007 100644
--- a/sys-utils/ipcrm.c
+++ b/sys-utils/ipcrm.c
@@ -20,6 +20,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
 #include "c.h"
 #include "nls.h"
 #include "strutils.h"
@@ -29,8 +31,11 @@

 typedef enum type_id {
  SHM,
+ PSHM,
  SEM,
+ PSEM,
  MSG,
+ PMSG,
  ALL
 } type_id;

@@ -48,14 +53,17 @@ static void __attribute__((__noreturn__)) usage(void)
  fputs(_("Remove certain IPC resources.\n"), out);

  fputs(USAGE_OPTIONS, out);
- fputs(_(" -m, --shmem-id <id>        remove shared memory segment by
id\n"), out);
- fputs(_(" -M, --shmem-key <key>      remove shared memory segment by
key\n"), out);
- fputs(_(" -q, --queue-id <id>        remove message queue by id\n"), out);
- fputs(_(" -Q, --queue-key <key>      remove message queue by key\n"), out);
- fputs(_(" -s, --semaphore-id <id>    remove semaphore by id\n"), out);
- fputs(_(" -S, --semaphore-key <key>  remove semaphore by key\n"), out);
- fputs(_(" -a, --all[=shm|msg|sem]    remove all (in the specified
category)\n"), out);
- fputs(_(" -v, --verbose              explain what is being done\n"), out);
+ fputs(_(" -m, --shmem-id <id>         remove shared memory segment
by id\n"), out);
+ fputs(_(" -M, --shmem-key <key>       remove shared memory segment
by key\n"), out);
+ fputs(_("     --posix-shmem <name>   remove POSIX shared memory
segment by name\n"), out);
+ fputs(_(" -q, --queue-id <id>         remove message queue by id\n"), out);
+ fputs(_(" -Q, --queue-key <key>       remove message queue by key\n"), out);
+ fputs(_("     --posix-mqueue <name>   remove POSIX message queue by
name\n"), out);
+ fputs(_(" -s, --semaphore-id <id>     remove semaphore by id\n"), out);
+ fputs(_(" -S, --semaphore-key <key>   remove semaphore by key\n"), out);
+ fputs(_("     --posix-semaphore <name> remove POSIX semaphore by
name\n"), out);
+ fputs(_(" -a, --all[=shm|pshm|msg|pmsg|sem|psem] remove all (in the
specified category)\n"), out);
+ fputs(_(" -v, --verbose               explain what is being done\n"), out);

  fputs(USAGE_SEPARATOR, out);
  fprintf(out, USAGE_HELP_OPTIONS(28));
@@ -229,6 +237,50 @@ static int key_to_id(type_id type, char *s)
  return id;
 }

+static int remove_name(type_id type, char *name)
+{
+ int ret;
+
+ switch (type) {
+ case PSHM:
+ if (verbose)
+ printf(_("removing POSIX shared memory `%s'\n"), name);
+ ret = shm_unlink(name);
+ break;
+ case PMSG:
+ if (verbose)
+ printf(_("removing POSIX message queue `%s'\n"), name);
+ ret = mq_unlink(name);
+ break;
+ case PSEM:
+ if (verbose)
+ printf(_("removing POSIX semaphore `%s'\n"), name);
+ ret = sem_unlink(name);
+ break;
+ default:
+ errx(EXIT_FAILURE, "impossible occurred");
+ }
+
+ if (ret < 0) {
+ switch (errno) {
+ case EACCES:
+ case EPERM:
+ warnx(_("permission denied for name `%s'"), name);
+ break;
+ case ENOENT:
+ warnx(_("name `%s' not found"), name);
+ break;
+ case ENAMETOOLONG:
+ warnx(_("name `%s' too long"), name);
+ break;
+ default:
+ err(EXIT_FAILURE, _("name failed"));
+ }
+ return 1;
+ }
+ return 0;
+}
+
 static int remove_all(type_id type)
 {
  int ret = 0;
@@ -236,13 +288,19 @@ static int remove_all(type_id type)

  struct shmid_ds shmseg;

+ struct posix_shm_data *shmds, *shmdsp;
+
  struct semid_ds semary;
  struct seminfo seminfo;
  union semun arg;

+ struct posix_sem_data *semds, *semdsp;
+
  struct msqid_ds msgque;
  struct msginfo msginfo;

+ struct posix_msg_data *msgds, *msgdsp;
+
  if (type == SHM || type == ALL) {
  maxid = shmctl(0, SHM_INFO, &shmseg);
  if (maxid < 0)
@@ -255,6 +313,16 @@ static int remove_all(type_id type)
  ret |= remove_id(SHM, 0, rm_me);
  }
  }
+ if (type == PSHM || type == ALL) {
+ if (posix_ipc_shm_get_info(NULL, &shmds) > 0) {
+ for (shmdsp = shmds; shmdsp->next != NULL; shmdsp = shmdsp->next) {
+ if (verbose)
+ printf(_("removing POSIX shared memory `%s'\n"), shmdsp->name);
+ ret |= remove_name(PSHM, shmdsp->name);
+ }
+ posix_ipc_shm_free_info(shmds);
+ }
+ }
  if (type == SEM || type == ALL) {
  arg.array = (ushort *) (void *)&seminfo;
  maxid = semctl(0, 0, SEM_INFO, arg);
@@ -269,6 +337,16 @@ static int remove_all(type_id type)
  ret |= remove_id(SEM, 0, rm_me);
  }
  }
+ if (type == PSEM || type == ALL) {
+ if (posix_ipc_sem_get_info(NULL, &semds) > 0) {
+ for (semdsp = semds; semdsp->next != NULL; semdsp = semdsp->next) {
+ if (verbose)
+ printf(_("removing POSIX semaphore `%s'\n"), semdsp->sname);
+ ret |= remove_name(PSEM, semdsp->sname);
+ }
+ posix_ipc_sem_free_info(semds);
+ }
+ }
  if (type == MSG || type == ALL) {
  maxid =
     msgctl(0, MSG_INFO, (struct msqid_ds *)(void *)&msginfo);
@@ -282,6 +360,16 @@ static int remove_all(type_id type)
  ret |= remove_id(MSG, 0, rm_me);
  }
  }
+ if (type == PMSG || type == ALL) {
+ if (posix_ipc_msg_get_info(NULL, &msgds) > 0) {
+ for (msgdsp = msgds; msgdsp->next != NULL; msgdsp = msgdsp->next) {
+ if (verbose)
+ printf(_("removing POSIX message queue `%s'\n"), msgdsp->mname);
+ ret |= remove_name(PMSG, msgdsp->mname);
+ }
+ posix_ipc_msg_free_info(msgds);
+ }
+ }
  return ret;
 }

@@ -294,13 +382,22 @@ int main(int argc, char **argv)
  int rm_all = 0;
  type_id what_all = ALL;

+ enum {
+ OPT_PSHM = CHAR_MAX + 1,
+ OPT_PMSG,
+ OPT_PSEM
+ };
+
  static const struct option longopts[] = {
  {"shmem-id", required_argument, NULL, 'm'},
  {"shmem-key", required_argument, NULL, 'M'},
+ {"posix-shmem", required_argument, NULL, OPT_PSHM},
  {"queue-id", required_argument, NULL, 'q'},
  {"queue-key", required_argument, NULL, 'Q'},
+ {"posix-mqueue", required_argument, NULL, OPT_PMSG},
  {"semaphore-id", required_argument, NULL, 's'},
  {"semaphore-key", required_argument, NULL, 'S'},
+ {"posix-semaphore", required_argument, NULL, OPT_PSEM},
  {"all", optional_argument, NULL, 'a'},
  {"verbose", no_argument, NULL, 'v'},
  {"version", no_argument, NULL, 'V'},
@@ -309,8 +406,10 @@ int main(int argc, char **argv)
  };

  /* if the command is executed without parameters, do nothing */
- if (argc == 1)
- return 0;
+ if (argc == 1) {
+ warnx(_("bad usage"));
+ errtryhelp(EXIT_FAILURE);
+ }

  setlocale(LC_ALL, "");
  bindtextdomain(PACKAGE, LOCALEDIR);
@@ -368,15 +467,33 @@ int main(int argc, char **argv)
  if (remove_id(SEM, iskey, id))
  ret++;
  break;
+ case OPT_PSHM:
+ if (remove_name(PSHM, optarg))
+ ret++;
+ break;
+ case OPT_PMSG:
+ if (remove_name(PMSG, optarg))
+ ret++;
+ break;
+ case OPT_PSEM:
+ if (remove_name(PSEM, optarg))
+ ret++;
+ break;
  case 'a':
  rm_all = 1;
  if (optarg) {
  if (!strcmp(optarg, "shm"))
  what_all = SHM;
+ else if (!strcmp(optarg, "pshm"))
+ what_all = PSHM;
  else if (!strcmp(optarg, "msg"))
  what_all = MSG;
+ else if (!strcmp(optarg, "pmsg"))
+ what_all = PMSG;
  else if (!strcmp(optarg, "sem"))
  what_all = SEM;
+ else if (!strcmp(optarg, "psem"))
+ what_all = PSEM;
  else
  errx(EXIT_FAILURE,
      _("unknown argument: %s"), optarg);
diff --git a/sys-utils/ipcutils.c b/sys-utils/ipcutils.c
index 4d4bebb74..7aeccbeca 100644
--- a/sys-utils/ipcutils.c
+++ b/sys-utils/ipcutils.c
@@ -51,6 +51,30 @@ int ipc_msg_get_limits(struct ipc_limits *lim)
  lim->msgmax = msginfo.msgmax;
  }

+ /* POSIX IPC */
+ FILE *f;
+
+ f = fopen(_PATH_PROC_POSIX_IPC_MSGMNI, "r");
+ if (f) {
+ if(fscanf(f, "%"SCNu64, &lim->msgmni_posix) != 1)
+ lim->msgmni_posix = 0;
+ fclose(f);
+ }
+
+ f = fopen(_PATH_PROC_POSIX_IPC_MSGMNB, "r");
+ if (f) {
+ if(fscanf(f, "%"SCNu64, &lim->msgmnb_posix) != 1)
+ lim->msgmnb_posix = 0;
+ fclose(f);
+ }
+
+ f = fopen(_PATH_PROC_POSIX_IPC_MSGMAX, "r");
+ if (f) {
+ if(fscanf(f, "%"SCNu64, &lim->msgmax_posix) != 1)
+ lim->msgmax_posix = 0;
+ fclose(f);
+ }
+
  return 0;
 }

@@ -227,6 +251,75 @@ void ipc_shm_free_info(struct shm_data *shmds)
  }
 }

+int posix_ipc_shm_get_info(const char *name, struct posix_shm_data **shmds)
+{
+ DIR *d;
+ int i = 0;
+ struct posix_shm_data *p;
+ struct dirent *de;
+
+ p = *shmds = xcalloc(1, sizeof(struct posix_shm_data));
+ p->next = NULL;
+
+ d = opendir(_PATH_DEV_SHM);
+ if (!d)
+ err(EXIT_FAILURE, _("cannot open %s"), _PATH_DEV_SHM);
+
+ while ((de = readdir(d)) != NULL) {
+ if ((de->d_name[0] == '.' && de->d_name[1] == '\0') ||
+    (de->d_name[0] == '.' && de->d_name[1] == '.' &&
+     de->d_name[2] == '\0'))
+ continue;
+
+ if (strncmp(de->d_name, "sem.", 4) == 0)
+ continue;
+
+ struct stat st;
+ char path[PATH_MAX];
+ snprintf(path, sizeof(path), "%s/%s", _PATH_DEV_SHM, de->d_name);
+ if (stat(path, &st) < 0)
+ continue;
+
+ memset(path, 0, sizeof(path));
+ path[0] = '/';
+ strcat(path, de->d_name);
+
+ p->name = xstrdup(path);
+ p->cuid = st.st_uid;
+ p->cgid = st.st_gid;
+ p->size = st.st_size;
+ p->mode = st.st_mode;
+ p->mtime = st.st_mtime;
+
+ if (name != NULL) {
+ if (strcmp(name, path) == 0) {
+ i = 1;
+ break;
+ }
+ continue;
+ }
+
+ p->next = xcalloc(1, sizeof(struct posix_shm_data));
+ p = p->next;
+ p->next = NULL;
+ i++;
+ }
+
+ if (i == 0)
+ free(*shmds);
+ closedir(d);
+ return i;
+}
+
+void posix_ipc_shm_free_info(struct posix_shm_data *shmds)
+{
+ while (shmds) {
+ struct posix_shm_data *next = shmds->next;
+ free(shmds);
+ shmds = next;
+ }
+}
+
 static void get_sem_elements(struct sem_data *p)
 {
  size_t i;
@@ -366,6 +459,80 @@ void ipc_sem_free_info(struct sem_data *semds)
  }
 }

+int posix_ipc_sem_get_info(const char *name, struct posix_sem_data **semds)
+{
+ DIR *d;
+ int i = 0;
+ struct posix_sem_data *p;
+ struct dirent *de;
+
+ p = *semds = xcalloc(1, sizeof(struct posix_sem_data));
+ p->next = NULL;
+
+ d = opendir(_PATH_DEV_SHM);
+ if (!d)
+ err(EXIT_FAILURE, _("cannot open %s"), _PATH_DEV_SHM);
+
+ while ((de = readdir(d)) != NULL) {
+ if ((de->d_name[0] == '.' && de->d_name[1] == '\0') ||
+    (de->d_name[0] == '.' && de->d_name[1] == '.' &&
+     de->d_name[2] == '\0'))
+ continue;
+
+ if (strncmp(de->d_name, "sem.", 4) != 0)
+ continue;
+
+ struct stat st;
+ char path[PATH_MAX];
+ snprintf(path, sizeof(path), "%s/%s", _PATH_DEV_SHM, de->d_name);
+ if (stat(path, &st) < 0)
+ continue;
+
+ sem_t *sem = sem_open(de->d_name + 4, 0);
+ if (sem == SEM_FAILED)
+ continue;
+ sem_getvalue(sem, &p->sval);
+ sem_close(sem);
+
+ memset(path, 0, sizeof(path));
+ path[0] = '/';
+ strcat(path, de->d_name + 4);
+
+ p->sname = xstrdup(path);
+ p->cuid = st.st_uid;
+ p->cgid = st.st_gid;
+ p->mode = st.st_mode;
+ p->mtime = st.st_mtime;
+
+ if (name != NULL) {
+ if (strcmp(name, path) == 0) {
+ i = 1;
+ break;
+ }
+ continue;
+ }
+
+ p->next = xcalloc(1, sizeof(struct posix_sem_data));
+ p = p->next;
+ p->next = NULL;
+ i++;
+ }
+
+ if (i == 0)
+ free(*semds);
+ closedir(d);
+ return i;
+}
+
+void posix_ipc_sem_free_info(struct posix_sem_data *semds)
+{
+ while (semds) {
+ struct posix_sem_data *next = semds->next;
+ free(semds);
+ semds = next;
+ }
+}
+
 int ipc_msg_get_info(int id, struct msg_data **msgds)
 {
  FILE *f;
@@ -477,6 +644,124 @@ void ipc_msg_free_info(struct msg_data *msgds)
  }
 }

+int posix_ipc_msg_get_info(const char *name, struct posix_msg_data **msgds)
+{
+ FILE *f;
+ DIR *d;
+ int i = 0, mounted = 0;
+ struct posix_msg_data *p;
+ struct dirent *de;
+
+ p = *msgds = xcalloc(1, sizeof(struct msg_data));
+ p->next = NULL;
+
+ d = opendir(_PATH_DEV_MQUEUE);
+ if (!d) {
+ if (errno == ENOENT) {
+ struct libmnt_context *ctx;
+
+ ctx = mnt_new_context();
+ if (!ctx)
+ err(EXIT_FAILURE, _("cannot create libmount context"));
+
+ if (mnt_context_set_source(ctx, "none") < 0)
+ err(EXIT_FAILURE, _("cannot set source"));
+
+ if (mnt_context_set_target(ctx, _PATH_DEV_MQUEUE) < 0)
+ err(EXIT_FAILURE, _("cannot set target"));
+
+ if (mnt_context_set_fstype(ctx, "mqueue") < 0)
+ err(EXIT_FAILURE, _("cannot set filesystem type"));
+
+ if (mnt_context_mount(ctx) < 0)
+ err(EXIT_FAILURE, _("cannot mount %s"), _PATH_DEV_MQUEUE);
+
+ mounted = 1;
+ } else err(EXIT_FAILURE, _("cannot open %s"), _PATH_DEV_MQUEUE);
+ }
+
+ while ((de = readdir(d)) != NULL) {
+ if ((de->d_name[0] == '.' && de->d_name[1] == '\0') ||
+    (de->d_name[0] == '.' && de->d_name[1] == '.' &&
+     de->d_name[2] == '\0'))
+ continue;
+
+ struct stat st;
+ char path[PATH_MAX];
+ snprintf(path, sizeof(path), "%s/%s", _PATH_DEV_MQUEUE, de->d_name);
+ if (stat(path, &st) < 0)
+ continue;
+
+ f = fopen(path, "r");
+ if (!f)
+ continue;
+ if (fscanf(f, "QSIZE:%"SCNu64, &p->q_cbytes) != 1) {
+ fclose(f);
+ continue;
+ }
+ fclose(f);
+
+ memset(path, 0, sizeof(path));
+ path[0] = '/';
+ strcat(path, de->d_name);
+
+ p->mname = xstrdup(path);
+
+ mqd_t mq = mq_open(path, O_RDONLY);
+ struct mq_attr attr;
+ mq_getattr(mq, &attr);
+ p->q_qnum = attr.mq_curmsgs;
+ mq_close(mq);
+
+ p->cuid = st.st_uid;
+ p->cgid = st.st_gid;
+ p->mode = st.st_mode;
+ p->mtime = st.st_mtime;
+
+ if (name != NULL) {
+ if (strcmp(name, path) == 0) {
+ i = 1;
+ break;
+ }
+ continue;
+ }
+
+ p->next = xcalloc(1, sizeof(struct posix_msg_data));
+ p = p->next;
+ p->next = NULL;
+ i++;
+ }
+
+ if (i == 0)
+ free(*msgds);
+ closedir(d);
+
+ if (mounted) {
+ struct libmnt_context *ctx;
+
+ ctx = mnt_new_context();
+ if (!ctx)
+ err(EXIT_FAILURE, _("cannot create libmount context"));
+
+ if (mnt_context_set_target(ctx, _PATH_DEV_MQUEUE) < 0)
+ err(EXIT_FAILURE, _("cannot set target"));
+
+ if (mnt_context_umount(ctx) < 0)
+ err(EXIT_FAILURE, _("cannot umount %s"), _PATH_DEV_MQUEUE);
+ }
+
+ return i;
+}
+
+void posix_ipc_msg_free_info(struct posix_msg_data *msgds)
+{
+ while (msgds) {
+ struct posix_msg_data *next = msgds->next;
+ free(msgds);
+ msgds = next;
+ }
+}
+
 void ipc_print_perms(FILE *f, struct ipc_stat *is)
 {
  struct passwd *pw;
diff --git a/sys-utils/ipcutils.h b/sys-utils/ipcutils.h
index 0234465d2..7c6963aa5 100644
--- a/sys-utils/ipcutils.h
+++ b/sys-utils/ipcutils.h
@@ -18,12 +18,15 @@
 #include <sys/msg.h>
 #include <sys/sem.h>
 #include <sys/shm.h>
+#include <mqueue.h>
+#include <semaphore.h>
 #include <sys/types.h>
 #include <time.h>
 #include <unistd.h>
 #include <grp.h>
 #include <pwd.h>
 #include <stdint.h>
+#include <libmount.h>

 /*
  * SHM_DEST and SHM_LOCKED are defined in kernel headers, but inside
@@ -99,6 +102,7 @@ enum {
 };

 struct ipc_limits {
+ /* System V IPC */
  uint64_t shmmni; /* max number of segments */
  uint64_t shmmax; /* max segment size */
  uint64_t shmall; /* max total shared memory */
@@ -113,6 +117,11 @@ struct ipc_limits {
  int msgmni; /* max queues system wide */
  uint64_t msgmax; /* max size of message */
  int msgmnb; /* default max size of queue */
+
+ /* POSIX IPC */
+ uint64_t msgmax_posix; /* max size of message */
+ uint64_t msgmni_posix; /* max queues system wide */
+ uint64_t msgmnb_posix; /* default max number of messages in a queue */
 };

 extern int ipc_msg_get_limits(struct ipc_limits *lim);
@@ -153,6 +162,20 @@ struct shm_data {
 extern int ipc_shm_get_info(int id, struct shm_data **shmds);
 extern void ipc_shm_free_info(struct shm_data *shmds);

+struct posix_shm_data {
+ char *name;
+ int64_t mtime; /* last change time */
+ uid_t cuid;
+ gid_t cgid;
+ off_t size;
+ unsigned int mode;
+
+ struct posix_shm_data *next;
+};
+
+extern int posix_ipc_shm_get_info(const char *name, struct
posix_shm_data **shmds);
+extern void posix_ipc_shm_free_info(struct posix_shm_data *shmds);
+
 /* See 'struct sem_array' in kernel sources
  */
 struct sem_elem {
@@ -175,6 +198,20 @@ struct sem_data {
 extern int ipc_sem_get_info(int id, struct sem_data **semds);
 extern void ipc_sem_free_info(struct sem_data *semds);

+struct posix_sem_data {
+ char *sname;
+ int64_t mtime; /* last change time */
+ uid_t cuid;
+ gid_t cgid;
+ unsigned int mode;
+ int sval; /* semaphore value */
+
+ struct posix_sem_data *next;
+};
+
+extern int posix_ipc_sem_get_info(const char *name, struct
posix_sem_data **semds);
+extern void posix_ipc_sem_free_info(struct posix_sem_data *semds);
+
 /* See 'struct msg_queue' in kernel sources
  */
 struct msg_data {
@@ -195,4 +232,19 @@ struct msg_data {
 extern int ipc_msg_get_info(int id, struct msg_data **msgds);
 extern void ipc_msg_free_info(struct msg_data *msgds);

+struct posix_msg_data {
+ char *mname;
+ int64_t mtime;
+ uid_t cuid;
+ gid_t cgid;
+ unsigned int mode;
+ uint64_t q_cbytes; /* current number of bytes on the queue */
+ long q_qnum; /* number of messages on the queue */
+
+ struct posix_msg_data *next;
+};
+
+extern int posix_ipc_msg_get_info(const char *name, struct
posix_msg_data **msgds);
+extern void posix_ipc_msg_free_info(struct posix_msg_data *msgds);
+
 #endif /* UTIL_LINUX_IPCUTILS_H */
diff --git a/sys-utils/lsipc.1.adoc b/sys-utils/lsipc.1.adoc
index 3ee790e21..01deaf95f 100644
--- a/sys-utils/lsipc.1.adoc
+++ b/sys-utils/lsipc.1.adoc
@@ -16,12 +16,15 @@ lsipc - show information on IPC facilities
currently employed in the system

 == DESCRIPTION

-*lsipc* shows information on the System V inter-process communication
facilities for which the calling process has read access.
+*lsipc* shows information on the POSIX and System V inter-process
communication facilities for which the calling process has read
access.

 == OPTIONS

 *-i*, *--id* _id_::
-Show full details on just the one resource element identified by
_id_. This option needs to be combined with one of the three resource
options: *-m*, *-q* or *-s*. It is possible to override the default
output format for this option with the *--list*, *--raw*, *--json* or
*--export* option.
+Show full details on just the one resource element (System V)
identified by _id_. This option needs to be combined with one of the
three resource options: *-m*, *-q* or *-s*. It is possible to override
the default output format for this option with the *--list*, *--raw*,
*--json* or *--export* option.
+
+*-N*, *--name* _name_::
+Show full details on just the one resource element (POSIX) identified
by _name_. This option needs to be combined with one of the three
resource options: *-M*, *-Q* or *-S*. It is possible to override the
default output format for this option with the *--list*, *--raw*,
*--json* or *--export* option.

 *-g*, *--global*::
 Show system-wide usage and limits of IPC resources. This option may
be combined with one of the three resource options: *-m*, *-q* or
*-s*. The default is to show information about all resources.
@@ -31,13 +34,22 @@ include::man-common/help-version.adoc[]
 === Resource options

 *-m*, *--shmems*::
-Write information about active shared memory segments.
+Write information about active System V shared memory segments.
+
+*-M*, *--posix-shmems*::
+Write information about active POSIX shared memory segments.

 *-q*, *--queues*::
-Write information about active message queues.
+Write information about active System V message queues.
+
+*-Q*, *--posix-mqueues*::
+Write information about active POSIX message queues. Mounts
/dev/mqueue if not already mounted.

 *-s*, *--semaphores*::
-Write information about active semaphore sets.
+Write information about active System V semaphore sets.
+
+*-S*, *--posix-semaphores*::
+Write information about active POSIX named semaphores.

 === Output formatting

diff --git a/sys-utils/lsipc.c b/sys-utils/lsipc.c
index 85ebcafd3..c095f315c 100644
--- a/sys-utils/lsipc.c
+++ b/sys-utils/lsipc.c
@@ -59,12 +59,17 @@ enum {
  COLDESC_IDX_GEN_FIRST = 0,
  COL_KEY = COLDESC_IDX_GEN_FIRST,
  COL_ID,
- COL_OWNER,
- COL_PERMS,
- COL_CUID,
- COL_CUSER,
- COL_CGID,
- COL_CGROUP,
+
+ /* generic and posix */
+ COLDESC_IDX_GEN_POSIX_FIRST,
+ COL_OWNER = COLDESC_IDX_GEN_POSIX_FIRST,
+ COL_PERMS,
+ COL_CUID,
+ COL_CUSER,
+ COL_CGID,
+ COL_CGROUP,
+ COLDSEC_IDX_GEN_POSIX_LAST = COL_CGROUP,
+
  COL_UID,
  COL_USER,
  COL_GID,
@@ -72,6 +77,12 @@ enum {
  COL_CTIME,
  COLDESC_IDX_GEN_LAST = COL_CTIME,

+ /* posix-specific */
+ COLDESC_IDX_POSIX_FIRST,
+ COL_NAME = COLDESC_IDX_POSIX_FIRST,
+ COL_MTIME,
+ COLDESC_IDX_POSIX_LAST = COL_MTIME,
+
  /* msgq-specific */
  COLDESC_IDX_MSG_FIRST,
  COL_USEDBYTES = COLDESC_IDX_MSG_FIRST,
@@ -107,7 +118,12 @@ enum {
  COL_LIMIT,
  COL_USED,
  COL_USEPERC,
- COLDESC_IDX_SUM_LAST = COL_USEPERC
+ COLDESC_IDX_SUM_LAST = COL_USEPERC,
+
+ /* posix-sem-specific */
+ COLDESC_IDX_POSIX_SEM_FIRST,
+ COL_SVAL = COLDESC_IDX_POSIX_SEM_FIRST,
+ COLDESC_IDX_POSIX_SEM_LAST = COL_SVAL
 };

 /* not all columns apply to all options, so we specify a legal range
for each */
@@ -161,6 +177,10 @@ static const struct lsipc_coldesc coldescs[] =
  [COL_GROUP] = { "GROUP", N_("Group name"), N_("Group name"), 1},
  [COL_CTIME] = { "CTIME", N_("Time of the last change"), N_("Last
change"), 1, SCOLS_FL_RIGHT},

+ /* posix-common */
+ [COL_NAME] = { "NAME",     N_("Resource name"), N_("Name"), 1 },
+ [COL_MTIME] = { "MTIME",   N_("Time of last action"), N_("Last
action"), 1, SCOLS_FL_RIGHT},
+
  /* msgq-specific */
  [COL_USEDBYTES] = { "USEDBYTES",N_("Bytes used"), N_("Bytes used"),
1, SCOLS_FL_RIGHT},
  [COL_MSGS] = { "MSGS", N_("Number of messages"), N_("Messages"), 1},
@@ -189,6 +209,9 @@ static const struct lsipc_coldesc coldescs[] =
  [COL_USED]      = { "USED",     N_("Currently used"), N_("Used"), 1,
SCOLS_FL_RIGHT },
  [COL_USEPERC] = { "USE%",     N_("Currently use percentage"),
N_("Use"), 1, SCOLS_FL_RIGHT },
  [COL_LIMIT]     = { "LIMIT",    N_("System-wide limit"),
N_("Limit"), 1, SCOLS_FL_RIGHT },
+
+ /* posix-sem-specific */
+ [COL_SVAL] = { "SVAL", N_("Semaphore value"), N_("Value"), 1, SCOLS_FL_RIGHT}
 };


@@ -296,11 +319,15 @@ static void __attribute__((__noreturn__)) usage(void)

  fputs(USAGE_SEPARATOR, out);
  fputs(_("Resource options:\n"), out);
- fputs(_(" -m, --shmems      shared memory segments\n"), out);
- fputs(_(" -q, --queues      message queues\n"), out);
- fputs(_(" -s, --semaphores  semaphores\n"), out);
- fputs(_(" -g, --global      info about system-wide usage (may be
used with -m, -q and -s)\n"), out);
- fputs(_(" -i, --id <id>     print details on resource identified by
<id>\n"), out);
+ fputs(_(" -m, --shmems           shared memory segments\n"), out);
+ fputs(_(" -M, --posix-shmems     POSIX shared memory segments\n"), out);
+ fputs(_(" -q, --queues         message queues\n"), out);
+ fputs(_(" -Q, --posix-mqueues POSIX message queues\n"), out);
+ fputs(_(" -s, --semaphores     semaphores\n"), out);
+ fputs(_(" -S, --posix-semaphores POSIX semaphores\n"), out);
+ fputs(_(" -g, --global       info about system-wide usage (may be
used with -m, -q and -s)\n"), out);
+ fputs(_(" -i, --id <id>          print details on resource
identified by <id>\n"), out);
+ fputs(_(" -N, --name <name>      print details on posix resource
identified by <name>\n"), out);

  fputs(USAGE_OPTIONS, out);
  fputs(_("     --noheadings         don't print headings\n"), out);
@@ -322,22 +349,32 @@ static void __attribute__((__noreturn__)) usage(void)
  fputs(USAGE_SEPARATOR, out);
  fprintf(out, USAGE_HELP_OPTIONS(26));

- fprintf(out, _("\nGeneric columns:\n"));
+ fprintf(out, _("\nGeneric System V columns:\n"));
  for (i = COLDESC_IDX_GEN_FIRST; i <= COLDESC_IDX_GEN_LAST; i++)
  fprintf(out, " %14s  %s\n", coldescs[i].name, _(coldescs[i].help));
+
+ fprintf(out, _("\nGeneric POSIX columns:\n"));
+ fprintf(out, " %14s  %s\n", coldescs[COL_NAME].name,
_(coldescs[COL_NAME].help));
+ for (i = COLDESC_IDX_GEN_POSIX_FIRST; i <= COLDSEC_IDX_GEN_POSIX_LAST; i++)
+ fprintf(out, " %14s  %s\n", coldescs[i].name, _(coldescs[i].help));
+ fprintf(out, " %14s  %s\n", coldescs[COL_MTIME].name,
_(coldescs[COL_MTIME].help));

- fprintf(out, _("\nShared-memory columns (--shmems):\n"));
+ fprintf(out, _("\nSystem V Shared-memory columns (--shmems):\n"));
  for (i = COLDESC_IDX_SHM_FIRST; i <= COLDESC_IDX_SHM_LAST; i++)
  fprintf(out, " %14s  %s\n", coldescs[i].name, _(coldescs[i].help));

- fprintf(out, _("\nMessage-queue columns (--queues):\n"));
+ fprintf(out, _("\nSystem V Message-queue columns (--queues):\n"));
  for (i = COLDESC_IDX_MSG_FIRST; i <= COLDESC_IDX_MSG_LAST; i++)
  fprintf(out, " %14s  %s\n", coldescs[i].name, _(coldescs[i].help));

- fprintf(out, _("\nSemaphore columns (--semaphores):\n"));
+ fprintf(out, _("\nSystem V Semaphore columns (--semaphores):\n"));
  for (i = COLDESC_IDX_SEM_FIRST; i <= COLDESC_IDX_SEM_LAST; i++)
  fprintf(out, " %14s  %s\n", coldescs[i].name, _(coldescs[i].help));

+ fprintf(out, _("\nPOSIX Semaphore columns (--posix-semaphores):\n"));
+ for (i = COLDESC_IDX_POSIX_SEM_FIRST; i <= COLDESC_IDX_POSIX_SEM_LAST; i++)
+ fprintf(out, " %14s  %s\n", coldescs[i].name, _(coldescs[i].help));
+
  fprintf(out, _("\nSummary columns (--global):\n"));
  for (i = COLDESC_IDX_SUM_FIRST; i <= COLDESC_IDX_SUM_LAST; i++)
  fprintf(out, " %14s  %s\n", coldescs[i].name, _(coldescs[i].help));
@@ -728,6 +765,92 @@ static void do_sem_global(struct lsipc_control
*ctl, struct libscols_table *tb)
  global_set_data(ctl, tb, "SEMVMX", _("Semaphore max value"), 0,
lim.semvmx, 0, 0);
 }

+static void do_posix_sem(const char *name, struct lsipc_control *ctl,
struct libscols_table *tb)
+{
+ struct libscols_line *ln;
+ struct passwd *pw = NULL;
+ struct group *gr = NULL;
+ struct posix_sem_data *semds, *p;
+ char *arg = NULL;
+
+ scols_table_set_name(tb, "posix-semaphores");
+ if (posix_ipc_sem_get_info(name, &semds) < 1) {
+ if (name)
+ warnx(_("name %s not found"), name);
+ return;
+ }
+ for (p = semds; p->next != NULL || name != NULL; p = p->next) {
+ size_t n;
+
+ ln = scols_table_new_line(tb, NULL);
+ if (!ln)
+ err(EXIT_FAILURE, _("failed to allocate output line"));
+
+ /* no need to call getpwuid() for the same user */
+ if (!(pw && pw->pw_uid == p->cuid))
+ pw = getpwuid(p->cuid);
+
+ /* no need to call getgrgid() for the same user */
+ if (!(gr && gr->gr_gid == p->cgid))
+ gr = getgrgid(p->cgid);
+
+ for (n = 0; n < ncolumns; n++) {
+ int rc = 0;
+ switch (get_column_id(n)) {
+ case COL_NAME:
+ rc = scols_line_set_data(ln, n, p->sname);
+ break;
+ case COL_OWNER:
+ arg = get_username(&pw, p->cuid);
+ if (!arg)
+ xasprintf(&arg, "%u", p->cuid);
+ rc = scols_line_refer_data(ln, n, arg);
+ break;
+ case COL_PERMS:
+ if (ctl->numperms)
+ xasprintf(&arg, "%#o", p->mode & 0777);
+ else {
+ arg = xmalloc(11);
+ xstrmode(p->mode & 0777, arg);
+ }
+ rc = scols_line_refer_data(ln, n, arg);
+ break;
+ case COL_MTIME:
+ if (p->mtime != 0)
+ rc = scols_line_refer_data(ln, n,
+ make_time(ctl->time_mode,
+  (time_t) p->mtime));
+ break;
+ case COL_CUID:
+ rc = scols_line_sprintf(ln, n, "%u", p->cuid);
+ break;
+ case COL_CUSER:
+ arg = get_username(&pw, p->cuid);
+ if (arg)
+ rc = scols_line_refer_data(ln, n, arg);
+ break;
+ case COL_CGID:
+ rc = scols_line_sprintf(ln, n, "%u", p->cgid);
+ break;
+ case COL_CGROUP:
+ arg = get_groupname(&gr, p->cgid);
+ if (arg)
+ rc = scols_line_refer_data(ln, n, arg);
+ break;
+ case COL_SVAL:
+ rc = scols_line_sprintf(ln, n, "%d", p->sval);
+ break;
+ }
+ if (rc != 0)
+ err(EXIT_FAILURE, _("failed to add output data"));
+ arg = NULL;
+ }
+ if (name != NULL)
+ break;
+ }
+ posix_ipc_sem_free_info(semds);
+}
+
 static void do_msg(int id, struct lsipc_control *ctl, struct
libscols_table *tb)
 {
  struct libscols_line *ln;
@@ -861,6 +984,101 @@ static void do_msg(int id, struct lsipc_control
*ctl, struct libscols_table *tb)
  ipc_msg_free_info(msgds);
 }

+static void do_posix_msg(const char *name, struct lsipc_control *ctl,
struct libscols_table *tb)
+{
+    struct libscols_line *ln;
+ struct passwd *pw = NULL;
+ struct group *gr = NULL;
+ struct posix_msg_data *msgds, *p;
+ char *arg = NULL;
+
+ if (posix_ipc_msg_get_info(name, &msgds) < 1) {
+ if (name != NULL)
+ warnx(_("mqueue %s not found"), name);
+ return;
+ }
+ scols_table_set_name(tb, "posix-messages");
+
+ for (p = msgds; p->next != NULL || name != NULL; p = p->next) {
+ size_t n;
+ ln = scols_table_new_line(tb, NULL);
+
+ if (!ln)
+ err(EXIT_FAILURE, _("failed to allocate output line"));
+
+ /* no need to call getpwuid() for the same user */
+ if (!(pw && pw->pw_uid == p->cuid))
+ pw = getpwuid(p->cuid);
+
+ /* no need to call getgrgid() for the same user */
+ if (!(gr && gr->gr_gid == p->cgid))
+ gr = getgrgid(p->cgid);
+
+ for (n = 0; n < ncolumns; n++) {
+ int rc = 0;
+
+ switch (get_column_id(n)) {
+ case COL_NAME:
+ rc = scols_line_refer_data(ln, n, p->mname);
+ break;
+ case COL_OWNER:
+ arg = get_username(&pw, p->cuid);
+ if (!arg)
+ xasprintf(&arg, "%u", p->cuid);
+ rc = scols_line_refer_data(ln, n, arg);
+ break;
+ case COL_PERMS:
+ if (ctl->numperms)
+ xasprintf(&arg, "%#o", p->mode & 0777);
+ else {
+ arg = xmalloc(11);
+ xstrmode(p->mode & 0777, arg);
+ rc = scols_line_refer_data(ln, n, arg);
+ }
+ break;
+ case COL_CUID:
+ rc = scols_line_sprintf(ln, n, "%u", p->cuid);
+ break;
+ case COL_CUSER:
+ arg = get_username(&pw, p->cuid);
+ if (arg)
+ rc = scols_line_refer_data(ln, n, arg);
+ break;
+ case COL_CGID:
+ rc = scols_line_sprintf(ln, n, "%u", p->cgid);
+ break;
+ case COL_CGROUP:
+ arg = get_groupname(&gr, p->cgid);
+ if (arg)
+ rc = scols_line_refer_data(ln, n, arg);
+ break;
+ case COL_MTIME:
+ if (p->mtime != 0)
+ rc = scols_line_refer_data(ln, n,
+ make_time(ctl->time_mode,
+  (time_t) p->mtime));
+ break;
+ case COL_USEDBYTES:
+ if (ctl->bytes)
+ xasprintf(&arg, "%ju", p->q_cbytes);
+ else
+ arg = size_to_human_string(SIZE_SUFFIX_1LETTER,
+ p->q_cbytes);
+ rc = scols_line_refer_data(ln, n, arg);
+ break;
+ case COL_MSGS:
+ rc = scols_line_sprintf(ln, n, "%ju", p->q_qnum);
+ break;
+ }
+ if (rc != 0)
+ err(EXIT_FAILURE, _("failed to set data"));
+ arg = NULL;
+ }
+ if (name != NULL)
+ break;
+ }
+ posix_ipc_msg_free_info(msgds);
+}

 static void do_msg_global(struct lsipc_control *ctl, struct libscols_table *tb)
 {
@@ -879,9 +1097,31 @@ static void do_msg_global(struct lsipc_control
*ctl, struct libscols_table *tb)
  ipc_msg_free_info(msgds);
  }

- global_set_data(ctl, tb, "MSGMNI", _("Number of message queues"),
msgqs, lim.msgmni, 1, 0);
- global_set_data(ctl, tb, "MSGMAX", _("Max size of message (bytes)"),
0, lim.msgmax, 0, 1);
- global_set_data(ctl, tb, "MSGMNB", _("Default max size of queue
(bytes)"), 0, lim.msgmnb, 0, 1);
+ global_set_data(ctl, tb, "MSGMNI", _("Number of System V message
queues"), msgqs, lim.msgmni, 1, 0);
+ global_set_data(ctl, tb, "MSGMAX", _("Max size of System V message
(bytes)"), 0, lim.msgmax, 0, 1);
+ global_set_data(ctl, tb, "MSGMNB", _("Default max size of System V
queue (bytes)"), 0, lim.msgmnb, 0, 1);
+}
+
+static void do_posix_msg_global(struct lsipc_control *ctl, struct
libscols_table *tb)
+{
+ struct posix_msg_data *pmsgds;
+ struct ipc_limits lim;
+ int pmsgqs = 0;
+
+ ipc_msg_get_limits(&lim);
+
+ /* count number of used posix queues */
+ if (posix_ipc_msg_get_info(NULL, &pmsgds) > 0) {
+ struct posix_msg_data *p;
+
+ for (p = pmsgds; p->next != NULL; p = p->next)
+ ++pmsgqs;
+ posix_ipc_msg_free_info(pmsgds);
+ }
+
+ global_set_data(ctl, tb, "MQUMNI", _("Number of POSIX message
queues"), pmsgqs, lim.msgmni_posix, 1, 0);
+ global_set_data(ctl, tb, "MQUMAX", _("Max size of POSIX message
(bytes)"), 0, lim.msgmax_posix, 0, 1);
+ global_set_data(ctl, tb, "MQUMNB", _("Number of messages in POSIX
message queue"), 0, lim.msgmnb_posix, 0, 0);
 }


@@ -1054,6 +1294,100 @@ static void do_shm(int id, struct
lsipc_control *ctl, struct libscols_table *tb)
  ipc_shm_free_info(shmds);
 }

+static void do_posix_shm(const char *name, struct lsipc_control *ctl,
struct libscols_table *tb)
+{
+ struct libscols_line *ln;
+ struct passwd *pw = NULL;
+ struct group *gr = NULL;
+ struct posix_shm_data *shmds, *p;
+ char *arg = NULL;
+
+ if (posix_ipc_shm_get_info(name, &shmds) < 1) {
+ if (name != NULL)
+ warnx(_("shm %s not found"), name);
+ return;
+ }
+
+ scols_table_set_name(tb, "posix-sharedmemory");
+
+ for (p = shmds; p->next != NULL || name != NULL ; p = p->next) {
+ size_t n;
+ ln = scols_table_new_line(tb, NULL);
+
+ if (!ln)
+ err(EXIT_FAILURE, _("failed to allocate output line"));
+
+ /* no need to call getpwuid() for the same user */
+ if (!(pw && pw->pw_uid == p->cuid))
+ pw = getpwuid(p->cuid);
+
+ /* no need to call getgrgid() for the same user */
+ if (!(gr && gr->gr_gid == p->cgid))
+ gr = getgrgid(p->cgid);
+
+ for (n = 0; n < ncolumns; n++) {
+ int rc = 0;
+
+ switch (get_column_id(n)) {
+ case COL_NAME:
+ rc = scols_line_refer_data(ln, n, p->name);
+ break;
+ case COL_OWNER:
+ arg = get_username(&pw, p->cuid);
+ if (!arg)
+ xasprintf(&arg, "%u", p->cuid);
+ rc = scols_line_refer_data(ln, n, arg);
+ break;
+ case COL_PERMS:
+ if (ctl->numperms)
+ xasprintf(&arg, "%#o", p->mode & 0777);
+ else {
+ arg = xmalloc(11);
+ xstrmode(p->mode & 0777, arg);
+ }
+ rc = scols_line_refer_data(ln, n, arg);
+ break;
+ case COL_CUID:
+ rc = scols_line_sprintf(ln, n, "%u", p->cuid);
+ break;
+ case COL_CUSER:
+ arg = get_username(&pw, p->cuid);
+ if (arg)
+ rc = scols_line_refer_data(ln, n, arg);
+ break;
+ case COL_CGID:
+ rc = scols_line_sprintf(ln, n, "%u", p->cgid);
+ break;
+ case COL_CGROUP:
+ arg = get_groupname(&gr, p->cgid);
+ if (arg)
+ rc = scols_line_refer_data(ln, n, arg);
+ break;
+ case COL_SIZE:
+ if (ctl->bytes)
+ xasprintf(&arg, "%ju", p->size);
+ else
+ arg = size_to_human_string(SIZE_SUFFIX_1LETTER,
+ p->size);
+ rc = scols_line_refer_data(ln, n, arg);
+ break;
+ case COL_MTIME:
+ if (p->mtime != 0)
+ rc = scols_line_refer_data(ln, n,
+ make_time(ctl->time_mode,
+  (time_t) p->mtime));
+ break;
+ }
+ if (rc != 0)
+ err(EXIT_FAILURE, _("failed to set data"));
+ arg = NULL;
+ }
+ if (name != NULL)
+ break;
+ }
+ posix_ipc_shm_free_info(shmds);
+}
+
 static void do_shm_global(struct lsipc_control *ctl, struct libscols_table *tb)
 {
  struct shm_data *shmds;
@@ -1081,11 +1415,13 @@ static void do_shm_global(struct lsipc_control
*ctl, struct libscols_table *tb)
 int main(int argc, char *argv[])
 {
  int opt, msg = 0, sem = 0, shm = 0, id = -1;
+ int pmsg = 0, pshm = 0, psem = 0;
  int show_time = 0, show_creat = 0, global = 0;
  size_t i;
  struct lsipc_control *ctl = xcalloc(1, sizeof(struct lsipc_control));
  static struct libscols_table *tb;
  char *outarg = NULL;
+ char *name = NULL;

  /* long only options. */
  enum {
@@ -1103,11 +1439,15 @@ int main(int argc, char *argv[])
  { "id",             required_argument, NULL, 'i' },
  { "json",           no_argument, NULL, 'J' },
  { "list",           no_argument,        NULL, 'l' },
+ { "name",           required_argument, NULL, 'N' },
  { "newline",        no_argument, NULL, 'n' },
  { "noheadings",     no_argument, NULL, OPT_NOHEAD },
  { "notruncate",     no_argument, NULL, OPT_NOTRUNC },
  { "numeric-perms",  no_argument, NULL, 'P' },
  { "output",         required_argument, NULL, 'o' },
+ { "posix-mqueues",  no_argument, NULL, 'Q' },
+ { "posix-semaphores", no_argument, NULL, 'S' },
+ { "posix-shmems",   no_argument, NULL, 'M' },
  { "queues",         no_argument, NULL, 'q' },
  { "raw",            no_argument, NULL, 'r' },
  { "semaphores",     no_argument, NULL, 's' },
@@ -1121,9 +1461,9 @@ int main(int argc, char *argv[])

  static const ul_excl_t excl[] = { /* rows and cols in ASCII order */
  { 'J', 'e', 'l', 'n', 'r' },
- { 'g', 'i' },
+ { 'N', 'g', 'i' },
  { 'c', 'o', 't' },
- { 'm', 'q', 's' },
+ { 'M', 'Q', 'S', 'm', 'q', 's' },
  { 0 }
  };
  int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
@@ -1137,7 +1477,7 @@ int main(int argc, char *argv[])

  scols_init_debug(0);

- while ((opt = getopt_long(argc, argv, "bceghi:Jlmno:PqrstVy",
longopts, NULL)) != -1) {
+ while ((opt = getopt_long(argc, argv, "bceghi:JlMmN:no:PQqrSstVy",
longopts, NULL)) != -1) {

  err_exclusive_options(opt, longopts, excl, excl_st);

@@ -1148,6 +1488,9 @@ int main(int argc, char *argv[])
  case 'i':
  id = strtos32_or_err(optarg, _("failed to parse IPC identifier"));
  break;
+ case 'N':
+ name = optarg;
+ break;
  case 'e':
  ctl->outmode = OUT_EXPORT;
  break;
@@ -1173,6 +1516,17 @@ int main(int argc, char *argv[])
  LOWER = COLDESC_IDX_MSG_FIRST;
  UPPER = COLDESC_IDX_MSG_LAST;
  break;
+ case 'Q':
+ pmsg = 1;
+ add_column(columns, ncolumns++, COL_NAME);
+ add_column(columns, ncolumns++, COL_PERMS);
+ add_column(columns, ncolumns++, COL_OWNER);
+ add_column(columns, ncolumns++, COL_MTIME);
+ add_column(columns, ncolumns++, COL_USEDBYTES);
+ add_column(columns, ncolumns++, COL_MSGS);
+ LOWER = COLDESC_IDX_POSIX_FIRST;
+ UPPER = COLDESC_IDX_POSIX_LAST;
+ break;
  case 'l':
  ctl->outmode = OUT_LIST;
  break;
@@ -1192,6 +1546,16 @@ int main(int argc, char *argv[])
  LOWER = COLDESC_IDX_SHM_FIRST;
  UPPER = COLDESC_IDX_SHM_LAST;
  break;
+ case 'M':
+ pshm = 1;
+ add_column(columns, ncolumns++, COL_NAME);
+ add_column(columns, ncolumns++, COL_PERMS);
+ add_column(columns, ncolumns++, COL_OWNER);
+ add_column(columns, ncolumns++, COL_SIZE);
+ add_column(columns, ncolumns++, COL_MTIME);
+ LOWER = COLDESC_IDX_POSIX_FIRST;
+ UPPER = COLDESC_IDX_POSIX_LAST;
+ break;
  case 'n':
  ctl->outmode = OUT_NEWLINE;
  break;
@@ -1208,6 +1572,16 @@ int main(int argc, char *argv[])
  LOWER = COLDESC_IDX_SEM_FIRST;
  UPPER = COLDESC_IDX_SEM_LAST;
  break;
+ case 'S':
+ psem = 1;
+ add_column(columns, ncolumns++, COL_NAME);
+ add_column(columns, ncolumns++, COL_PERMS);
+ add_column(columns, ncolumns++, COL_OWNER);
+ add_column(columns, ncolumns++, COL_MTIME);
+ add_column(columns, ncolumns++, COL_SVAL);
+ LOWER = COLDESC_IDX_POSIX_FIRST;
+ UPPER = COLDESC_IDX_POSIX_LAST;
+ break;
  case OPT_NOTRUNC:
  ctl->notrunc = 1;
  break;
@@ -1240,10 +1614,10 @@ int main(int argc, char *argv[])
  }

  /* default is global */
- if (msg + shm + sem == 0) {
- msg = shm = sem = global = 1;
- if (show_time || show_creat || id != -1)
- errx(EXIT_FAILURE, _("--global is mutually exclusive with --creator,
--id and --time"));
+ if (msg + shm + sem + pmsg + pshm + psem == 0) {
+ msg = shm = sem = pmsg = pshm = psem = global = 1;
+ if (show_time || show_creat || id != -1 || name != NULL)
+ errx(EXIT_FAILURE, _("--global is mutually exclusive with --creator,
--id, --name and --time"));
  }
  if (global) {
  add_column(columns, ncolumns++, COL_RESOURCE);
@@ -1256,7 +1630,7 @@ int main(int argc, char *argv[])
  }

  /* default to pretty-print if --id specified */
- if (id != -1 && !ctl->outmode)
+ if ((id != -1 || name != NULL) && !ctl->outmode)
  ctl->outmode = OUT_PRETTY;

  if (!ctl->time_mode)
@@ -1270,8 +1644,10 @@ int main(int argc, char *argv[])
  if (show_creat) {
  add_column(columns, ncolumns++, COL_CUID);
  add_column(columns, ncolumns++, COL_CGID);
- add_column(columns, ncolumns++, COL_UID);
- add_column(columns, ncolumns++, COL_GID);
+ if (!(pmsg || pshm || psem)) {
+ add_column(columns, ncolumns++, COL_UID);
+ add_column(columns, ncolumns++, COL_GID);
+ }
  }
  if (msg && show_time) {
  add_column(columns, ncolumns++, COL_SEND);
@@ -1312,18 +1688,32 @@ int main(int argc, char *argv[])
  else
  do_msg(id, ctl, tb);
  }
+ if (pmsg) {
+ if (global)
+ do_posix_msg_global(ctl, tb);
+ else
+ do_posix_msg(name, ctl, tb);
+ }
  if (shm) {
  if (global)
  do_shm_global(ctl ,tb);
  else
  do_shm(id, ctl, tb);
  }
+ if (pshm) {
+ if (!global)
+ do_posix_shm(name, ctl, tb);
+ }
  if (sem) {
  if (global)
  do_sem_global(ctl, tb);
  else
  do_sem(id, ctl, tb);
  }
+ if (psem) {
+ if (!global)
+ do_posix_sem(name, ctl, tb);
+ }

  print_table(ctl, tb);

--
2.43.0

----------------------------------------------------------------

From 7a16f0535469dbf94d631cf40ddc539322b6d291 Mon Sep 17 00:00:00 2001
From: Prasanna Paithankar <paithankarprasanna@gmail.com>
Date: Thu, 23 Jan 2025 03:18:31 +0530
Subject: [PATCH 2/2] added POSIX IPC paathnames; modified
 sys-utils/Makemodule.am

---
 include/pathnames.h     | 11 +++++++++--
 sys-utils/Makemodule.am | 16 ++++++++++------
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/include/pathnames.h b/include/pathnames.h
index a30194b10..34ba11ca3 100644
--- a/include/pathnames.h
+++ b/include/pathnames.h
@@ -187,7 +187,7 @@

 #define _PATH_PROC_KERNEL "/proc/sys/kernel"

-/* ipc paths */
+/* System V ipc paths */
 #define _PATH_PROC_SYSV_MSG "/proc/sysvipc/msg"
 #define _PATH_PROC_SYSV_SEM "/proc/sysvipc/sem"
 #define _PATH_PROC_SYSV_SHM "/proc/sysvipc/shm"
@@ -208,6 +208,13 @@
 #define _PATH_PROC_PIPE_MAX_SIZE _PATH_PROC_SYS_FS "/pipe-max-size"
 #define _PATH_PROC_BINFMT_MISC _PATH_PROC_SYS_FS "/binfmt_misc"

+/* Posix ipc paths */
+#define _PATH_DEV_MQUEUE "/dev/mqueue"
+#define _PATH_PROC_POSIX_IPC_MSGMAX _PATH_PROC_SYS_FS "/mqueue/msgsize_max"
+#define _PATH_PROC_POSIX_IPC_MSGMNB _PATH_PROC_SYS_FS "/mqueue/msg_max"
+#define _PATH_PROC_POSIX_IPC_MSGMNI _PATH_PROC_SYS_FS "/mqueue/queues_max"
+#define _PATH_DEV_SHM "/dev/shm"
+
 /* irqtop paths */
 #define _PATH_PROC_INTERRUPTS "/proc/interrupts"
 #define _PATH_PROC_SOFTIRQS "/proc/softirqs"
@@ -243,4 +250,4 @@
 # define UL_VENDORDIR_PATH      NULL
 #endif

-#endif /* PATHNAMES_H */
+#endif /* PATHNAMES_H */
\ No newline at end of file
diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index 8cc69be60..03955c85c 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -43,8 +43,11 @@ if BUILD_IPCRM
 usrbin_exec_PROGRAMS += ipcrm
 MANPAGES += sys-utils/ipcrm.1
 dist_noinst_DATA += sys-utils/ipcrm.1.adoc
-ipcrm_SOURCES = sys-utils/ipcrm.c
-ipcrm_LDADD = $(LDADD) libcommon.la
+ipcrm_SOURCES = sys-utils/ipcrm.c \
+ sys-utils/ipcutils.c \
+ sys-utils/ipcutils.h
+ipcrm_LDADD = $(LDADD) libcommon.la libmount.la
+ipcrm_CFLAGS = $(AM_CFLAGS) -I$(ul_libmount_incdir)
 endif

 if BUILD_IPCS
@@ -54,7 +57,8 @@ dist_noinst_DATA += sys-utils/ipcs.1.adoc
 ipcs_SOURCES = sys-utils/ipcs.c \
  sys-utils/ipcutils.c \
  sys-utils/ipcutils.h
-ipcs_LDADD = $(LDADD) libcommon.la
+ipcs_LDADD = $(LDADD) libcommon.la libmount.la
+ipcs_CFLAGS = $(AM_CFLAGS) -I$(ul_libmount_incdir)
 endif

 if BUILD_IRQTOP
@@ -93,8 +97,8 @@ dist_noinst_DATA += sys-utils/lsipc.1.adoc
 lsipc_SOURCES = sys-utils/lsipc.c \
  sys-utils/ipcutils.c \
  sys-utils/ipcutils.h
-lsipc_LDADD = $(LDADD) libcommon.la libsmartcols.la
-lsipc_CFLAGS = $(AM_CFLAGS) -I$(ul_libsmartcols_incdir)
+lsipc_LDADD = $(LDADD) libcommon.la libsmartcols.la libmount.la
+lsipc_CFLAGS = $(AM_CFLAGS) -I$(ul_libsmartcols_incdir) -I$(ul_libmount_incdir)
 endif

 if BUILD_RENICE
@@ -591,4 +595,4 @@ if HAVE_LINUX_LANDLOCK_H
 setpriv_SOURCES += sys-utils/setpriv-landlock.c
 endif
 setpriv_LDADD = $(LDADD) -lcap-ng libcommon.la
-endif
+endif
\ No newline at end of file
--
2.43.0
