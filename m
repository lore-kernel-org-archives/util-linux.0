Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55124 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751974AbaLSNU0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 19 Dec 2014 08:20:26 -0500
Date: Fri, 19 Dec 2014 14:20:21 +0100
From: Karel Zak <kzak@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: util-linux@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [RFC][PATCH] unshare: Fix --map-root-user to work on new kernels
Message-ID: <20141219132021.GK19904@x2.net.home>
References: <87zjalkhb8.fsf@x220.int.ebiederm.org>
 <87sigdkglg.fsf@x220.int.ebiederm.org>
 <20141219100749.GJ19904@x2.net.home>
 <87a92j4yde.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87a92j4yde.fsf@x220.int.ebiederm.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 19, 2014 at 06:28:45AM -0600, Eric W. Biederman wrote:
> Karel Zak <kzak@redhat.com> writes:
> >  What does it mean "allow" in /proc/self/setgroups? 
> >  
> >  If I good understand than /proc/self/gid_map is unwritable until the
> >  setgroups file is set to "deny", and "allow" means that gid_map is
> >  disabled at all, but setgroup() syscall is possible to use in the
> >  user namespace. Right?
> 
> No.
> 
> The current state is backwards compatible for root, and is a little
> weird but not that weird.
> 
> setgroups(2) is only callable with CAP_SETGID.
> CAP_SETGID in a user namespace (now) does not give you permission to
> call setgroups(2) (or any other system call) until after gid_map has
> been set.
> 
> /proc/self/setgroups controls the setgroups system call.
> "allow" means setgroups(2) is callable (permission checks permitting).
> "allow" is the default state of /proc/self/setgroups.
> "deny" means setgroups(2) is permanently disabled in the user namespace.
> "deny" is only settable while setgroups(2) is disabled (aka "deny" is
>        only settable before the gid_map is programmed)
> 
> gid_map is writable by root when setgroups(2) is enabled.
> gid_map becomes writable by "unprivileged" processes when setgroups(2)
> is permamently disabled.

Thanks, this is more obvious description.

[...]

> Fair enough.  A general control is reasonable, and not hard to support.
> Call it --setgroups=[allow|deny].

OK.

> I was wondering if we should have such a control and require it with
> --map-root-user to tell users their shell scripts fork login will break.

I think it's better to make --map-root-user usable without any another
command line option (as suggested by our unshare patch). In man page
we can describe all the relation between --map-root-user and new
--setgroups.

> For the prupose of breaking setups that will break a little later when
> setgroups(2) is called I don't think the option is worth it.
> 
> Just as a general knob I can see value in having a
> --setgroups=[allow|deny] knob.

Yes.

[...]

> The best would be to call setgroups(0, NULL) before entering the user
> namespace (so root can always clear their groups), and call setgroups(0,
> NULL) after entering the user namespace (as currently happens).  If both
> setgroups(0, NULL) calls fail then complain.
> 
> nsenter as currently constructed can not enter a user namespaces that
> does not map uid 0 and gid 0.   So not handling setgroups=deny for
> non-root users in seems reasonable.
> 
> What looks compelling to me is a --preserve-credentials option to
> nsenter that would not touch uids or gids.  A --preserve-credentials
> option will allow nsenter to enter all manner of user namespaces
> irrespective of they are configured.
> 
> Does that clear up the confusion?

Good question, we will see :-) ... I'm going to prepare some unshare
and nsenter patches next week.

Thanks Eric.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
