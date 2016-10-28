Return-Path: halfline@gmail.com
MIME-Version: 1.0
In-Reply-To: <5812BFD6.3050006@tlinx.org>
References: <1477427661-19788-1-git-send-email-halfline@gmail.com> <5812BFD6.3050006@tlinx.org>
From: Ray Strode <halfline@gmail.com>
Date: Fri, 28 Oct 2016 11:14:22 -0400
Message-ID: <CAA_UwzLvPNz5B568Qhpx-E0ToxadKPowtcLS3MKa1FuBRhosxA@mail.gmail.com>
Subject: Re: [PATCH] login-utils: import environment from user manager on
 systemd systems
To: "L. Walsh" <lkml@tlinx.org>
Cc: util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

Hi,

>    The other issue you don't really touch on, is why should this be hard-
> coded in various programs when this is seems exactly like why PAM was
> invented.
Oh this was touched on, thoroughly, in the URL cited in the patch.

>    One of the issues with systemd is that it is doesn't re-use
> existing interfaces, but tends to force programs to make changes to work
> with sysd
There is no existing interface that meets the needs here. The closest you
can get is a pam session stack module, but as stated before, that idea has
been rejected (and I've already covered why on this thread and on the
systemd pull request).

>    Minimizing code changes in existing, working code seems like a
> safer design decision.
Safer than needlessly running code as root that doesn't need to be? We're
just going to have to agree to disagree I guess.

> It is especially true that the more code paths
> that are added to programs, the more test paths and opportunities for
> failure are added.
This I totally agree with!

--Ray
