Return-Path: halfline@gmail.com
MIME-Version: 1.0
In-Reply-To: <58127756.7070409@tlinx.org>
References: <1477427661-19788-1-git-send-email-halfline@gmail.com>
 <580FC961.8060502@tlinx.org> <CAA_UwzKqEsXDOrayqMHsLOXzB72YfNMyuWa4b0ODcbrqnGgDmw@mail.gmail.com>
 <58127756.7070409@tlinx.org>
From: Ray Strode <halfline@gmail.com>
Date: Fri, 28 Oct 2016 11:06:32 -0400
Message-ID: <CAA_Uwz+GuBjZL1zjCXGDTSoAp8Qfe351-od=8neJr1EYM_MiZg@mail.gmail.com>
Subject: Re: [PATCH] login-utils: import environment from user manager on
 systemd systems
To: "L. Walsh" <lkml@tlinx.org>
Cc: util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

Hi,

> ----
>    Most login related and system security processes do.  They are not
> part of the kernel.  Systemd runs in a user-context as root, as well.
> Are you saying that is insecure?
I'm not sure why you're bringing up the kernel, that's a weird segue, but
no I'm not saying it's necessarily insecure to run user session code as root,
I'm just saying if you minimize the code running as root, you minimize risk.
Environment variables in particular are a large surface area for problems.

> Pam_env is designed to be run before the user's first session has
> been setup and not again.
That's not correct. Most distributions that use pam_env, run it for
any login session. But what does that have to do with my patch?

> Some environment variables are meant to have
> the same lifetime as the login-(or audit) UID.  Just like TERM, any X
> programs rely on DISPLAY and those things don't change unless a
> new first-contact session is created when a user first accesses a
> secure network from an outside location.
You lost me.  I think you're trying to explain to me what the scope
of DISPLAY and TERM are, but I'm not sure, and I don't know why you
would be doing that.  Can you reiterate your point more clearly?

>    True.  The pam modules have been vetted for about 10+ years and have good
> security record,
An okay track record, sure, but that doesn't somehow invalidate my point.
pam_env, in particular, has had a couple of CVEs, but either way it misses
the point.  This is about preemptive mitigation, we can choose where to put the
code, and one spot is inherently less risky than the other.

> yet you seem quite willing to jump to a new solution without such a track record.
This was all discussed on the systemd pull request that you for some reason
 won't read
(why? it's just a link with background information).

Originally, there was a patch to put the code in pam_systemd, but that idea was
ultimately rejected, because environment variables are an easy way to perturb a
system in unexpected ways.  Could it be done there? sure. Is it
riskier? yes!  why
incur the risk?

> Pam_env was designed for a
> first-contact to the system, as that's the only time 'REMOTEHOST' is set
> (presuming the user came from another system).
what? I think you have some side point, but you're not articulating it well.
pam_env can be configured to set REMOTEHOST from PAM_RHOST.
If so configured it will happen from any remotely initiated connection, not
just the first.

And indeed, REMOTEHOST is a commented out example provided in the
default pam_env conf file.  It's not used by default, but I really don't see
how this has anything to do with my patch.

> Does systemd set REMOTEHOST
> and allow for a users DISPLAY variable to be defaulted to a dependent
> setting?
No of course not.  The patch is about importing non-session-specific,
user environment variables into new sessions.  systemd --user runs
outside of a typical user session, and this makes sure environment
variables configured for systemd --user get picked up by new login
sessions.

If you want REMOTEHOST set to PAM_RHOST fine, but that's nothing
to do with this. Anyway, ssh already sets DISPLAY for you.  If you're
using rsh or telnet, well...I don't know what to say other than this patch
isn't getting in your way.

>> This topic was discussed a bit in the cited systemd pull request, I think.
>    how is that relevant to a util-linux list?
It's extremely relevant to the patch, since the patch is motivated by the
discussion there. How is that relevance not clear?

Do you just have mental block because "systemd" != "util-linux" ?  util-linux
already integrates with systemd.  It's not like this is the first
 #ifdef HAVE_LIBSYSTEMD added to the code.

Anyway, I talked with Karel about this approach before I started, and he's
tentatively onboard with the concept (again, see the cited url!)

I'd appreciate patch review, if you want to jump in, but I don't want to get
bogged down in a rehash of a discussion that's already been had elsewhere.

--Ray
