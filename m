Return-Path: dave@gnu.org
Subject: Re: [pull] some sys-utils improvements
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: kerolasa@gmail.com, util-linux <util-linux@vger.kernel.org>
In-Reply-To: <20110914163506.GC1829@nb.net.home>
References: 
	 <CAG27Bk342RY_dMN5BFW9G+9z-KmmasX0XOA4UVSrn+tSsvmVRA@mail.gmail.com>
	 <1316006513.2467.2.camel@offbook>  <20110914163506.GC1829@nb.net.home>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 14 Sep 2011 14:04:45 -0300
Message-ID: <1316019885.2605.1.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

On Wed, 2011-09-14 at 18:35 +0200, Karel Zak wrote:
> On Wed, Sep 14, 2011 at 10:21:53AM -0300, Davidlohr Bueso wrote:
> > On Tue, 2011-09-13 at 23:13 +0200, Sami Kerola wrote:
> > Please try the following patch, it fixed it for me. In the case when the
> > errors were shown, the msgctl(2) was returning 0 (success), so errno
> > shouldn't be checked. Remember, this isn't reseted afterwards, so we are
> > running into bogus messages (the msgid's are being correctly deleted).
> > 
> > Thanks,
> > Davidlohr
> > 
> > From 952d6100c28505005c0a335e3e64f384bd941859 Mon Sep 17 00:00:00 2001
> > From: Davidlohr Bueso <dave@gnu.org>
> > Date: Wed, 14 Sep 2011 10:17:15 -0300
> > Subject: [PATCH] ipcrm: check IPC syscalls
> > 
> > It's not enough to check errno for errors as the variable is not reset, we also need to check the last syscall return value to verify a problem.
> > This addresses bogus msgqueue errors when deleting keys.
> > 
> > Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> > ---
> >  sys-utils/ipcrm.c |    9 +++++----
> >  1 files changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/sys-utils/ipcrm.c b/sys-utils/ipcrm.c
> > index a8d6623..c794cbe 100644
> > --- a/sys-utils/ipcrm.c
> > +++ b/sys-utils/ipcrm.c
> > @@ -65,6 +65,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
> >  
> >  int remove_id(int type, int iskey, int id)
> >  {
> > +	int ret;
> >  	char *errmsg;
> >  	/* needed to delete semaphores */
> >  	union semun arg;
> > @@ -75,24 +76,24 @@ int remove_id(int type, int iskey, int id)
> >  	case SHM:
> >  		if (verbose)
> >  			printf(_("removing shared memory segment id `%d'\n"), id);
> > -		shmctl(id, IPC_RMID, NULL);
> > +		ret = shmctl(id, IPC_RMID, NULL);
> >  		break;
> >  	case MSG:
> >  		if (verbose)
> >  			printf(_("removing message queue id `%d'\n"), id);
> > -		msgctl(id, IPC_RMID, NULL);
> > +		ret = msgctl(id, IPC_RMID, NULL);
> >  		break;
> >  	case SEM:
> >  		if (verbose)
> >  			printf(_("removing semaphore id `%d'\n"), id);
> > -		semctl(id, 0, IPC_RMID, arg);
> > +		ret = semctl(id, 0, IPC_RMID, arg);
> >  		break;
> >  	default:
> >  		errx(EXIT_FAILURE, "impossible occurred");
> >  	}
> >  
> >  	/* how did the removal go? */
> > -	switch (errno) {
> > +	switch (errno && ret) {
> 
>  so true/false only ... why we need the "case EACCES" (etc.)?
> 
> >  	case 0:
> >  		return 0;
> >  	case EACCES:
> 
>  why we cannot use:
> 
>   if (ret < 0) 
>     switch(errno) {
>       case EACCES:
>          ...
>          break;
> 
>       ....
>   }

Well, yes, the case 0 didn't make much sense, otherwise I don't really
care how we evaluate ret/errno. Is the below patch ok with you?

From: Davidlohr Bueso <dave@gnu.org>
Date: Wed, 14 Sep 2011 14:02:15 -0300
Subject: [PATCH] ipcrm: check IPC syscalls

It's not enough to check errno for errors as the variable is not reset, we also need to check the last syscall return value to verify a problem.
This addresses bogus msgqueue errors when deleting keys.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 sys-utils/ipcrm.c |   51 ++++++++++++++++++++++++++-------------------------
 1 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/sys-utils/ipcrm.c b/sys-utils/ipcrm.c
index a8d6623..a176fc7 100644
--- a/sys-utils/ipcrm.c
+++ b/sys-utils/ipcrm.c
@@ -65,6 +65,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 
 int remove_id(int type, int iskey, int id)
 {
+	int ret;
 	char *errmsg;
 	/* needed to delete semaphores */
 	union semun arg;
@@ -75,46 +76,46 @@ int remove_id(int type, int iskey, int id)
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
-	case 0:
-		return 0;
-	case EACCES:
-	case EPERM:
-		errmsg = iskey ? _("permission denied for key")
-		    : _("permission denied for id");
-		break;
-	case EINVAL:
-		errmsg = iskey ? _("invalid key")
-		    : _("invalid id");
-		break;
-	case EIDRM:
-		errmsg = iskey ? _("already removed key")
-		    : _("already removed id");
-		break;
-	default:
-		if (iskey)
-			err(EXIT_FAILURE, _("key failed"));
-		else
-			err(EXIT_FAILURE, _("id failed"));
+	if (ret < 0) {
+		switch (errno) {
+		case EACCES:
+		case EPERM:
+			errmsg = iskey ? _("permission denied for key")
+				: _("permission denied for id");
+			break;
+		case EINVAL:
+			errmsg = iskey ? _("invalid key")
+				: _("invalid id");
+			break;
+		case EIDRM:
+			errmsg = iskey ? _("already removed key")
+				: _("already removed id");
+			break;
+		default:
+			if (iskey)
+				err(EXIT_FAILURE, _("key failed"));
+			else
+				err(EXIT_FAILURE, _("id failed"));
+		}
+		warnx("%s (%d)", errmsg, id);
 	}
-	warnx("%s (%d)", errmsg, id);
 	return 1;
 }
 
-- 
1.7.4.1
