Return-Path: lkml@tlinx.org
Message-ID: <58127756.7070409@tlinx.org>
Date: Thu, 27 Oct 2016 14:53:26 -0700
From: "L. Walsh" <lkml@tlinx.org>
MIME-Version: 1.0
To: Ray Strode <halfline@gmail.com>
CC: util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Lennart Poettering <lennart@poettering.net>
Subject: Re: [PATCH] login-utils: import environment from user manager on
 systemd systems
References: <1477427661-19788-1-git-send-email-halfline@gmail.com> <580FC961.8060502@tlinx.org> <CAA_UwzKqEsXDOrayqMHsLOXzB72YfNMyuWa4b0ODcbrqnGgDmw@mail.gmail.com>
In-Reply-To: <CAA_UwzKqEsXDOrayqMHsLOXzB72YfNMyuWa4b0ODcbrqnGgDmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <util-linux.vger.kernel.org>

Ray Strode wrote:
> Hi,
>   
>>    Isn't pam_env supposed to allow setting vars in setting up
>> a user's first login session?
>>     
> It can, but it has a few problems
>
> 1) the file format is kind of weird
>   
---
    People looking at systemd's config files have said similar.

> 2) not all distros set user_readenv=1 so users cant set the
> environment variables they want
>   
----
    pam_env wasn't designed for reading user-set environment variables.
Can users modify systemd config files at will?  Can't users put their
envvars in their profiles? 

> 3) pam_env doesn't provide a facility for 3rd party applications to
> adjust the environment
>   
---
    I wasn't aware systemd could read users' profiles.  I've seen
many 3rd party apps add their needed env vars to the system "profile.d"
directory (for system wide changes) and some to a user's shell if they
were user-specific changes.
> 4) PAM modules run in the context of a user but as root.
----
    Most login related and system security processes do.  They are not
part of the kernel.  Systemd runs in a user-context as root, as well.
Are you saying that is insecure?

`   Pam_env is designed to be run before the user's first session has
been setup and not again.  Some environment variables are meant to have
the same lifetime as the login-(or audit) UID.  Just like TERM, any X
programs rely on DISPLAY and those things don't change unless a
new first-contact session is created when a user first accesses a
secure network from an outside location. 

> Having a
> bunch of independent plugins all running as root, and not necessarily
> integrating with each other is a recipe for security problems,
> especially if you throw environment variables into the mix.
>   
----
    True.  The pam modules have been vetted for about 10+ years and have 
good
security record, yet you seem quite willing to jump to a new solution
without such a track record. 
> (if pam_env is erroneously in the session stack before a pam_exec
> call, the user could easily get root access).
>   
If an administrator  misconfigures ANY system security and 
authentication modules a user could gain root access.  Pam_env was 
designed for a
first-contact to the system, as that's the only time 'REMOTEHOST' is set 
(presuming the user came from another system).  Does systemd set REMOTEHOST
and allow for a users DISPLAY variable to be defaulted to a dependent 
setting?
> This topic was discussed a bit in the cited systemd pull request, I think.
>   
----
    how is that relevant to a util-linux list?
-l
