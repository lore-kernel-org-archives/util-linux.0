Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:5768 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754953Ab3EFPlC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 6 May 2013 11:41:02 -0400
Date: Mon, 6 May 2013 17:39:53 +0200
From: Karel Zak <kzak@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Richard Weinberger <richard@nod.at>, util-linux@vger.kernel.org,
        davidlohr.bueso@hp.com
Subject: Re: [PATCH] nsenter: Allow selecting the uid and gid to be used in
 the entered userns
Message-ID: <20130506153953.GA9740@x2.net.home>
References: <1366917100-10581-1-git-send-email-richard@nod.at>
 <871u9yqf5d.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <871u9yqf5d.fsf@xmission.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 25, 2013 at 06:01:02PM -0700, Eric W. Biederman wrote:
> Richard Weinberger <richard@nod.at> writes:
> 
> > Using -S (--setuid) and -G (--setgid) one can select
> > the uid/gid which will be used in the entered user namespace.
> 
> There is definitely utility here.  I don't have a strong preference but
> I am inclined to suggest that you remove the set_uid and set_gid
> variables, and unconditionally call setuid and setgid when entering
> a user namespace.

 I agree.

> > --- a/sys-utils/nsenter.c
> > +++ b/sys-utils/nsenter.c
> > @@ -72,6 +72,8 @@ static void usage(int status)
> >  	fputs(_(" -n, --net   [=<file>]  enter network namespace\n"), out);
> >  	fputs(_(" -p, --pid   [=<file>]  enter pid namespace\n"), out);
> >  	fputs(_(" -U, --user  [=<file>]  enter user namespace\n"), out);
> > +	fputs(_(" -S, --setuid <uid>     set uid in user namespace\n"), out);
> > +	fputs(_(" -G, --setgid <gid>     set gid in user namespace\n"), out);

 Richard, update man page too. Please.

> > @@ -319,5 +335,15 @@ int main(int argc, char *argv[])
> >  		execvp(argv[optind], argv + optind);
> >  		err(EXIT_FAILURE, _("failed to execute %s"), argv[optind]);
> >  	}
> > +
> > +	if (namespaces & CLONE_NEWUSER) {
> > +		if (set_uid)
> > +			if (setuid(uid) < 0)
> > +				err(EXIT_FAILURE, _("setuid failed"));
> > +		if (set_gid)
> > +			if (setgid(gid) < 0)
> > +				err(EXIT_FAILURE, _("setgid failed"));
> > +	}
> > +
> >  	exec_shell();

 Why do call setuid/gid() only for shell? Would be better to move all
 this code before the block with execvp() to call setuid/gid() for
 all execvp() as well as for exec_shell()?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
