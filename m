Return-Path: util-linux-owner@vger.kernel.org
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:53632 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751441AbcDRU4o (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 18 Apr 2016 16:56:44 -0400
Message-ID: <1461013000.7385.28.camel@HansenPartnership.com>
Subject: Re: [PATCH] nsenter: fix ability to enter unprivileged containers
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Date: Mon, 18 Apr 2016 16:56:40 -0400
In-Reply-To: <87k2juu61i.fsf@x220.int.ebiederm.org>
References: <1460982392.2452.6.camel@HansenPartnership.com>
	 <1460993854.7385.11.camel@HansenPartnership.com>
	 <20160418171103.lcbrxvaldcyhemd3@ws.net.home>
	 <1461000495.7385.18.camel@HansenPartnership.com>
	 <87k2juu61i.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, 2016-04-18 at 13:26 -0500, Eric W. Biederman wrote:
> James Bottomley <James.Bottomley@HansenPartnership.com> writes:
> 
> > On Mon, 2016-04-18 at 19:11 +0200, Karel Zak wrote:
> > > On Mon, Apr 18, 2016 at 11:37:34AM -0400, James Bottomley wrote:
> > > > OK, so if you want me to reply properly, you're going to have
> > > > to keep
> > > > my address in the cc list.
> > > > 
> > > > > > If you enter it first, you lose privilege for subsequent
> > > > > namespace
> > > > > > enters,see issue
> > > > > > 
> > > > > > https://github.com/karelzak/util-linux/issues/315
> > > > > > 
> > > > > > The fix is to enter the user namespace last of all.
> > > > > 
> > > > > I verified that with *current*/unpatched nsenter,
> > > > > 
> > > > > $ unshare -rm sleep inf &
> > > > > $ nsenter -t $! -U -m --preserve
> > > > > 
> > > > > works as expected (from regular user [and with unprivileged
> > > > > userns
> > > > > enabled]).
> > > > > 
> > > > > With this patch it *won't* work [verified], of course (as
> > > > > you'll need
> > > > > root privileges in userns before joining mount-ns, and you
> > > > > can only
> > > > > obtain them by entering userns first).
> > > > 
> > > > So we're using userns for different things.  I'm using it to
> > > > remove
> > > > privilege (so on my userns implementation root in the host
> > > > enters but
> > > > on becoming root in the userns, it can do nothing other than
> > > > write to
> > > > its own files) and you're using it to enhance privilege.  It
> > > > looks like
> > > > these two things will always be mutually exclusive, so perhaps
> > > > we need
> > > > an extra flag to nsenter to say do the userns first or last?
> > > 
> > > That's what I have talked about at github -- see Eric's comment
> > > in the
> > > code, the user NS is the first in the array for a good reason.
> > > May be
> > > it would be really better to add --user-{first,last} options to
> > > specify when you want to enter user NS.
> > 
> > OK, I'll code this up; hang on.
> 
> I think we can do this even better with two passes to setns.
> 
> A first pass before the user namespace is set (that ignores
> failures),
> and a second pass that sets the user namespace first as happens
> today.
> 
> That should satisfy both cases without flags, and would remove the
> need
> to remember/guess which kind of container people are using.

Makes sense, so like this?

James

---
>From 39cecc604a6c997c328affea52e65d6f67898bf5 Mon Sep 17 00:00:00 2001
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Fri, 15 Apr 2016 08:10:20 -0700
Subject: [PATCH] nsenter: enter namespaces in two passes

We have two use cases for user namespaces, one to elevate the
privilege of an unprivileged user, in which case we have to enter the
user namespace before all other namespaces (otherwise there isn't
enough permission to enter any other namespace).  And the other one is
where we're deprivileging a user and thus have to enter the user
namespace last (because that's the point at which we lose the
privileges).  On the first pass, we start at the position one after
the user namespace clearing the file descriptors as we close them
after calling setns().  If setns() fails on the first pass, ignore the
failure assuming that it will succeed after we enter the user
namespace.

This fixes

https://github.com/karelzak/util-linux/issues/315

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
index d8690db..8dbd22b 100644
--- a/sys-utils/nsenter.c
+++ b/sys-utils/nsenter.c
@@ -48,9 +48,11 @@ static struct namespace_file {
 } namespace_files[] = {
 	/* Careful the order is significant in this array.
 	 *
-	 * The user namespace comes first, so that it is entered
-	 * first.  This gives an unprivileged user the potential to
-	 * enter the other namespaces.
+	 * The user namespace comes either first or last: first if
+	 * you're using it to increase your privilege and last if
+	 * you're using it to decrease.  We enter the namespaces in
+	 * two passes starting initially from offset 1 and then offset
+	 * 0 if that fails.
 	 */
 	{ .nstype = CLONE_NEWUSER,  .name = "ns/user", .fd = -1 },
 	{ .nstype = CLONE_NEWCGROUP,.name = "ns/cgroup", .fd = -1 },
@@ -202,7 +204,7 @@ int main(int argc, char *argv[])
 	};
 
 	struct namespace_file *nsfile;
-	int c, namespaces = 0, setgroups_nerrs = 0, preserve_cred = 0;
+	int c, pass, namespaces = 0, setgroups_nerrs = 0, preserve_cred = 0;
 	bool do_rd = false, do_wd = false, force_uid = false, force_gid = false;
 	int do_fork = -1; /* unknown yet */
 	uid_t uid = 0;
@@ -353,19 +355,31 @@ int main(int argc, char *argv[])
 	}
 
 	/*
-	 * Now that we know which namespaces we want to enter, enter them.
+	 * Now that we know which namespaces we want to enter, enter
+	 * them.  Do this in two passes, not entering the user
+	 * namespace on the first pass.  So if we're deprivileging the
+	 * container we'll enter the user namespace last and if we're
+	 * privileging it then we enter the usernamespace first
+	 * (because the initial setns will fail).
 	 */
-	for (nsfile = namespace_files; nsfile->nstype; nsfile++) {
-		if (nsfile->fd < 0)
-			continue;
-		if (nsfile->nstype == CLONE_NEWPID && do_fork == -1)
-			do_fork = 1;
-		if (setns(nsfile->fd, nsfile->nstype))
-			err(EXIT_FAILURE,
-			    _("reassociate to namespace '%s' failed"),
-			    nsfile->name);
-		close(nsfile->fd);
-		nsfile->fd = -1;
+	for (pass = 0; pass < 2; pass ++) {
+		for (nsfile = namespace_files + 1 - pass; nsfile->nstype; nsfile++) {
+			if (nsfile->fd < 0)
+				continue;
+			if (nsfile->nstype == CLONE_NEWPID && do_fork == -1)
+				do_fork = 1;
+			if (setns(nsfile->fd, nsfile->nstype)) {
+				if (pass != 0)
+					err(EXIT_FAILURE,
+					    _("reassociate to namespace '%s' failed"),
+					    nsfile->name);
+				else
+					continue;
+			}
+
+			close(nsfile->fd);
+			nsfile->fd = -1;
+		}
 	}
 
 	/* Remember the current working directory if I'm not changing it */
