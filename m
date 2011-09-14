Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcbbj.dreamhost.com ([208.97.132.119]:53332 "EHLO
	homiemail-a4.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932406Ab1INNWE (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 14 Sep 2011 09:22:04 -0400
Subject: Re: [pull] some sys-utils improvements
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
In-Reply-To: <CAG27Bk342RY_dMN5BFW9G+9z-KmmasX0XOA4UVSrn+tSsvmVRA@mail.gmail.com>
References: <CAG27Bk342RY_dMN5BFW9G+9z-KmmasX0XOA4UVSrn+tSsvmVRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 14 Sep 2011 10:21:53 -0300
Message-ID: <1316006513.2467.2.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, 2011-09-13 at 23:13 +0200, Sami Kerola wrote:
> Hello,
> 

Hi Sami,

> I started to look sys-utils directory, and got obsessed by getting ipc
> stuff to behave like a tool from this millennium. The whole directory
> is not done, but I feel this is already big enough patch set.
> 
> I must admit that there is a lurking bug. When ipcrm tries to delete
> everything, new --all switch without options, it prints fail rubbish
> when there are only message queues resources. Bellow is an example how
> I could see the issue.
> 
> $ ./ipcs
> 
> ------ Shared Memory Segments --------
> key        shmid      owner      perms      bytes      nattch     status
> 
> ------ Semaphore Arrays --------
> key        semid      owner      perms      nsems
> 
> ------ Message Queues --------
> key        msqid      owner      perms      used-bytes   messages
> 
> $ ./ipcmk -Q
> Message queue id: 14581760
> $ ./ipcrm --all -v
> removing message queue id `14581760'
> ipcrm: invalid id (14581760)
> 
> Strange enough the `invalid id' is not reported if I comment out
> either shared memory or semaphore if blocks from remove all function.
> And same happens when remove all explicitly specifies message queue
> resource.
> 
> $ ./ipcmk -Q
> Message queue id: 14614528
> $ ./ipcrm --all=msg -v
> removing message queue id `14614528'
> 
> I am 99.9% certainty my code is wrong, I just don't see how and advice
> is very welcome. Other than this the patch set should be fairly OKish.

Please try the following patch, it fixed it for me. In the case when the
errors were shown, the msgctl(2) was returning 0 (success), so errno
shouldn't be checked. Remember, this isn't reseted afterwards, so we are
running into bogus messages (the msgid's are being correctly deleted).

Thanks,
Davidlohr

>From 952d6100c28505005c0a335e3e64f384bd941859 Mon Sep 17 00:00:00 2001
From: Davidlohr Bueso <dave@gnu.org>
Date: Wed, 14 Sep 2011 10:17:15 -0300
Subject: [PATCH] ipcrm: check IPC syscalls

It's not enough to check errno for errors as the variable is not reset, we also need to check the last syscall return value to verify a problem.
This addresses bogus msgqueue errors when deleting keys.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 sys-utils/ipcrm.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/sys-utils/ipcrm.c b/sys-utils/ipcrm.c
index a8d6623..c794cbe 100644
--- a/sys-utils/ipcrm.c
+++ b/sys-utils/ipcrm.c
@@ -65,6 +65,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 
 int remove_id(int type, int iskey, int id)
 {
+	int ret;
 	char *errmsg;
 	/* needed to delete semaphores */
 	union semun arg;
@@ -75,24 +76,24 @@ int remove_id(int type, int iskey, int id)
 	case SHM:
 		if (verbose)
 			printf(_("removing shared memory segment id `%d'\n"), id);
-		shmctl(id, IPC_RMID, NULL);
+		ret = shmctl(id, IPC_RMID, NULL);
 		break;
 	case MSG:
 		if (verbose)
 			printf(_("removing message queue id `%d'\n"), id);
-		msgctl(id, IPC_RMID, NULL);
+		ret = msgctl(id, IPC_RMID, NULL);
 		break;
 	case SEM:
 		if (verbose)
 			printf(_("removing semaphore id `%d'\n"), id);
-		semctl(id, 0, IPC_RMID, arg);
+		ret = semctl(id, 0, IPC_RMID, arg);
 		break;
 	default:
 		errx(EXIT_FAILURE, "impossible occurred");
 	}
 
 	/* how did the removal go? */
-	switch (errno) {
+	switch (errno && ret) {
 	case 0:
 		return 0;
 	case EACCES:
-- 
1.7.4.1



