Return-Path: James.Bottomley@HansenPartnership.com
Message-ID: <1461008434.7385.27.camel@HansenPartnership.com>
Subject: Re: [PATCH] nsenter: fix ability to enter unprivileged containers
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, ebiederm@xmission.com
Date: Mon, 18 Apr 2016 15:40:34 -0400
In-Reply-To: <20160418171103.lcbrxvaldcyhemd3@ws.net.home>
References: <1460982392.2452.6.camel@HansenPartnership.com>
	 <1460993854.7385.11.camel@HansenPartnership.com>
	 <20160418171103.lcbrxvaldcyhemd3@ws.net.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

On Mon, 2016-04-18 at 19:11 +0200, Karel Zak wrote:
> On Mon, Apr 18, 2016 at 11:37:34AM -0400, James Bottomley wrote:
> > OK, so if you want me to reply properly, you're going to have to
> > keep
> > my address in the cc list.
> > 
> > > &gt; If you enter it first, you lose privilege for subsequent
> > > namespace
> > > &gt; enters,see issue
> > > &gt;
> > > &gt; https://github.com/karelzak/util-linux/issues/315
> > > &gt;
> > > &gt; The fix is to enter the user namespace last of all.
> > > 
> > > I verified that with *current*/unpatched nsenter,
> > > 
> > > $ unshare -rm sleep inf &amp;
> > > $ nsenter -t $! -U -m --preserve
> > > 
> > > works as expected (from regular user [and with unprivileged
> > > userns
> > > enabled]).
> > > 
> > > With this patch it *won't* work [verified], of course (as you'll
> > > need
> > > root privileges in userns before joining mount-ns, and you can
> > > only
> > > obtain them by entering userns first).
> > 
> > So we're using userns for different things.  I'm using it to remove
> > privilege (so on my userns implementation root in the host enters
> > but
> > on becoming root in the userns, it can do nothing other than write
> > to
> > its own files) and you're using it to enhance privilege.  It looks
> > like
> > these two things will always be mutually exclusive, so perhaps we
> > need
> > an extra flag to nsenter to say do the userns first or last?
> 
> That's what I have talked about at github -- see Eric's comment in
> the
> code, the user NS is the first in the array for a good reason. May be
> it would be really better to add --user-{first,last} options to
> specify when you want to enter user NS.

How does this look; it's just got a --user-last switch because --user
-first is current behaviour.

James

---

>From eee660d40179ed4a186f6c5a73d5596058f87473 Mon Sep 17 00:00:00 2001
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Fri, 15 Apr 2016 08:10:20 -0700
Subject: [PATCH] nsenter: add --user-last flag to enter the user namespace
 last

We have two use cases for user namespaces, one to elevate the
privilege of an unprivileged user, in which case we have to enter the
user namespace before all other namespaces (otherwise there isn't
enough permission to enter any other namespace).  And the other one is
where we're deprivileging a user and thus have to enter the user
namespace last (because that's the point at which we lose the
privileges).

This fixes

https://github.com/karelzak/util-linux/issues/315

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

diff --git a/sys-utils/nsenter.1 b/sys-utils/nsenter.1
index ea5992e..3acf8da 100644
--- a/sys-utils/nsenter.1
+++ b/sys-utils/nsenter.1
@@ -154,6 +154,10 @@ always sets UID for user namespaces, the default is 0.
 Don't modify UID and GID when enter user namespace. The default is to
 drops supplementary groups and sets GID and UID to 0.
 .TP
+\fB\-\-user\-last\fR
+Enter the user namespace last rather than first.  You need this option
+if the usernamespace deprivileges the current process.
+.TP
 \fB\-r\fR, \fB\-\-root\fR[=\fIdirectory\fR]
 Set the root directory.  If no directory is specified, set the root directory to
 the root directory of the target process.  If directory is specified, set the
diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
index d8690db..9d82621 100644
--- a/sys-utils/nsenter.c
+++ b/sys-utils/nsenter.c
@@ -48,9 +48,10 @@ static struct namespace_file {
 } namespace_files[] = {
 	/* Careful the order is significant in this array.
 	 *
-	 * The user namespace comes first, so that it is entered
-	 * first.  This gives an unprivileged user the potential to
-	 * enter the other namespaces.
+	 * The user namespace comes either first or last: first if
+	 * you're using it to increase your privilege and so enter the
+	 * other namespaces and last if you're using it to decrease
+	 * your privilege (see --user-last flag).
 	 */
 	{ .nstype = CLONE_NEWUSER,  .name = "ns/user", .fd = -1 },
 	{ .nstype = CLONE_NEWCGROUP,.name = "ns/cgroup", .fd = -1 },
@@ -88,6 +89,7 @@ static void usage(int status)
 	fputs(_(" -r, --root[=<dir>]     set the root directory\n"), out);
 	fputs(_(" -w, --wd[=<dir>]       set the working directory\n"), out);
 	fputs(_(" -F, --no-fork          do not fork before exec'ing <program>\n"), out);
+	fputs(_("     --user-last        enter the user namespace last intstead of first\n"), out);
 #ifdef HAVE_LIBSELINUX
 	fputs(_(" -Z, --follow-context   set SELinux context according to --target PID\n"), out);
 #endif
@@ -176,7 +178,8 @@ static void continue_as_child(void)
 int main(int argc, char *argv[])
 {
 	enum {
-		OPT_PRESERVE_CRED = CHAR_MAX + 1
+		OPT_PRESERVE_CRED = CHAR_MAX + 1,
+		OPT_USER_LAST,
 	};
 	static const struct option longopts[] = {
 		{ "help", no_argument, NULL, 'h' },
@@ -195,6 +198,7 @@ int main(int argc, char *argv[])
 		{ "wd", optional_argument, NULL, 'w' },
 		{ "no-fork", no_argument, NULL, 'F' },
 		{ "preserve-credentials", no_argument, NULL, OPT_PRESERVE_CRED },
+		{ "user-last", no_argument, NULL, OPT_USER_LAST },
 #ifdef HAVE_LIBSELINUX
 		{ "follow-context", no_argument, NULL, 'Z' },
 #endif
@@ -202,7 +206,7 @@ int main(int argc, char *argv[])
 	};
 
 	struct namespace_file *nsfile;
-	int c, namespaces = 0, setgroups_nerrs = 0, preserve_cred = 0;
+	int c, namespaces = 0, setgroups_nerrs = 0, preserve_cred = 0, user_last = 0;
 	bool do_rd = false, do_wd = false, force_uid = false, force_gid = false;
 	int do_fork = -1; /* unknown yet */
 	uid_t uid = 0;
@@ -297,6 +301,9 @@ int main(int argc, char *argv[])
 		case OPT_PRESERVE_CRED:
 			preserve_cred = 1;
 			break;
+		case OPT_USER_LAST:
+			user_last = 1;
+			break;
 #ifdef HAVE_LIBSELINUX
 		case 'Z':
 			selinux = 1;
@@ -321,6 +328,19 @@ int main(int argc, char *argv[])
 		freecon(scon);
 	}
 #endif
+
+	if (user_last) {
+		/*
+		 * swap the first and last entries in the namespace_files
+		 * array (so swap the user and mount entries)
+		 */
+		int user_new = ARRAY_SIZE(namespace_files) - 2;
+		struct namespace_file nsf = namespace_files[user_new];
+
+		namespace_files[user_new] = namespace_files[0];
+		namespace_files[0] = nsf;
+	}
+
 	/*
 	 * Open remaining namespace and directory descriptors.
 	 */
