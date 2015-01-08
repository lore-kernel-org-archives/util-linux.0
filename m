Return-Path: util-linux-owner@vger.kernel.org
Received: from out01.mta.xmission.com ([166.70.13.231]:44385 "EHLO
	out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753877AbbAHPoU (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 8 Jan 2015 10:44:20 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
References: <87zjalkhb8.fsf@x220.int.ebiederm.org>
	<87sigdkglg.fsf@x220.int.ebiederm.org>
	<20141219100749.GJ19904@x2.net.home>
	<87a92j4yde.fsf@x220.int.ebiederm.org>
	<20150108115915.GK15715@x2.net.home>
Date: Thu, 08 Jan 2015 09:41:36 -0600
In-Reply-To: <20150108115915.GK15715@x2.net.home> (Karel Zak's message of
	"Thu, 8 Jan 2015 12:59:15 +0100")
Message-ID: <87siflz3db.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [RFC][PATCH] unshare: Fix --map-root-user to work on new kernels
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak <kzak@redhat.com> writes:

> On Fri, Dec 19, 2014 at 06:28:45AM -0600, Eric W. Biederman wrote:
>> >> This may also have some affect on the setgroups(0, NULL) case of
>> >> nsenter as well.
> ... 
>> The best would be to call setgroups(0, NULL) before entering the user
>> namespace (so root can always clear their groups), and call setgroups(0,
>> NULL) after entering the user namespace (as currently happens).  If both
>> setgroups(0, NULL) calls fail then complain.
>> 
>> nsenter as currently constructed can not enter a user namespaces that
>> does not map uid 0 and gid 0.   So not handling setgroups=deny for
>> non-root users in seems reasonable.
>> 
>> What looks compelling to me is a --preserve-credentials option to
>> nsenter that would not touch uids or gids.  A --preserve-credentials
>> option will allow nsenter to enter all manner of user namespaces
>> irrespective of they are configured.
>
>  Implemented. Please, review.


Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reading it through that looks reasonable.

>     Karel
>
>
> From 6e38747286e958e5c0f6060e803ea916bb6be756 Mon Sep 17 00:00:00 2001
> From: Karel Zak <kzak@redhat.com>
> Date: Thu, 8 Jan 2015 12:52:43 +0100
> Subject: [PATCH] nsenter: add --preserve-credentials and cleanup setgroups()
>  usage
>
> The new option --preserve-credentials completely disables all
> operations related to UIGs and GIDs.
>
> The patch also calls setgroups() before we enter user namespace (so
> root can always clear their groups) and after we enter user namespace
> (to detect /proc/self/setgroups "deny"). If both fail then nsenter
> complains.
>
> CC: "Eric W. Biederman" <ebiederm@xmission.com>
> Signed-off-by: Karel Zak <kzak@redhat.com>
> ---
>  sys-utils/nsenter.1 |  4 ++++
>  sys-utils/nsenter.c | 27 +++++++++++++++++++++------
>  2 files changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/sys-utils/nsenter.1 b/sys-utils/nsenter.1
> index 487f731..0b1fceb 100644
> --- a/sys-utils/nsenter.1
> +++ b/sys-utils/nsenter.1
> @@ -136,6 +136,10 @@ Set the user ID which will be used in the entered namespace.
>  .BR nsenter (1)
>  always sets UID for user namespaces, the default is 0.
>  .TP
> +\fB\-\-preserve-credentials\fR
> +Don't modify UID and GID when enter user namespace. The default is to
> +drops supplementary groups and sets GID and UID to 0.
> +.TP
>  \fB\-r\fR, \fB\-\-root\fR[=\fIdirectory\fR]
>  Set the root directory.  If no directory is specified, set the root directory to
>  the root directory of the target process.  If directory is specified, set the
> diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
> index 50f77f3..b029f80 100644
> --- a/sys-utils/nsenter.c
> +++ b/sys-utils/nsenter.c
> @@ -78,6 +78,7 @@ static void usage(int status)
>  	fputs(_(" -U, --user[=<file>]    enter user namespace\n"), out);
>  	fputs(_(" -S, --setuid <uid>     set uid in entered namespace\n"), out);
>  	fputs(_(" -G, --setgid <gid>     set gid in entered namespace\n"), out);
> +	fputs(_("     --preserve-credentials do not touch uids or gids\n"), out);
>  	fputs(_(" -r, --root[=<dir>]     set the root directory\n"), out);
>  	fputs(_(" -w, --wd[=<dir>]       set the working directory\n"), out);
>  	fputs(_(" -F, --no-fork          do not fork before exec'ing <program>\n"), out);
> @@ -165,6 +166,9 @@ static void continue_as_child(void)
>  
>  int main(int argc, char *argv[])
>  {
> +	enum {
> +		OPT_PRESERVE_CRED = CHAR_MAX + 1
> +	};
>  	static const struct option longopts[] = {
>  		{ "help", no_argument, NULL, 'h' },
>  		{ "version", no_argument, NULL, 'V'},
> @@ -180,11 +184,12 @@ int main(int argc, char *argv[])
>  		{ "root", optional_argument, NULL, 'r' },
>  		{ "wd", optional_argument, NULL, 'w' },
>  		{ "no-fork", no_argument, NULL, 'F' },
> +		{ "preserve-credentials", no_argument, NULL, OPT_PRESERVE_CRED },
>  		{ NULL, 0, NULL, 0 }
>  	};
>  
>  	struct namespace_file *nsfile;
> -	int c, namespaces = 0;
> +	int c, namespaces = 0, setgroups_nerrs = 0, preserve_cred = 0;
>  	bool do_rd = false, do_wd = false, force_uid = false, force_gid = false;
>  	int do_fork = -1; /* unknown yet */
>  	uid_t uid = 0;
> @@ -267,6 +272,9 @@ int main(int argc, char *argv[])
>  			else
>  				do_wd = true;
>  			break;
> +		case OPT_PRESERVE_CRED:
> +			preserve_cred = 1;
> +			break;
>  		default:
>  			usage(EXIT_FAILURE);
>  		}
> @@ -292,6 +300,17 @@ int main(int argc, char *argv[])
>  		namespaces |= nsfile->nstype;
>  	}
>  
> +	/* for user namespaces we always set UID and GID (default is 0)
> +	 * and clear root's groups if --preserve-credentials is no specified */
> +	if ((namespaces & CLONE_NEWUSER) && !preserve_cred) {
> +		force_uid = true, force_gid = true;
> +
> +		/* We call setgroups() before and after we enter user namespace,
> +		 * let's complain only if both fail */
> +		if (setgroups(0, NULL) != 0)
> +			setgroups_nerrs++;
> +	}
> +
>  	/*
>  	 * Now that we know which namespaces we want to enter, enter them.
>  	 */
> @@ -342,12 +361,8 @@ int main(int argc, char *argv[])
>  	if (do_fork == 1)
>  		continue_as_child();
>  
> -	/* for user namespaces we always set UID and GID (default is 0) */
> -	if (namespaces & CLONE_NEWUSER)
> -		force_uid = true, force_gid = true;
> -
>  	if (force_uid || force_gid) {
> -		if (force_gid && setgroups(0, NULL))		/* drop supplementary groups */
> +		if (force_gid && setgroups(0, NULL) != 0 && setgroups_nerrs)	/* drop supplementary groups */
>  			err(EXIT_FAILURE, _("setgroups failed"));
>  		if (force_gid && setgid(gid) < 0)		/* change GID */
>  			err(EXIT_FAILURE, _("setgid failed"));
> -- 
> 1.9.3
