Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:34588 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935217AbcJ1DOQ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 27 Oct 2016 23:14:16 -0400
Message-ID: <5812BFD6.3050006@tlinx.org>
Date: Thu, 27 Oct 2016 20:02:46 -0700
From: "L. Walsh" <lkml@tlinx.org>
MIME-Version: 1.0
To: Ray Strode <halfline@gmail.com>
CC: util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        Ray Strode <rstrode@redhat.com>
Subject: Re: [PATCH] login-utils: import environment from user manager on
 systemd systems
References: <1477427661-19788-1-git-send-email-halfline@gmail.com>
In-Reply-To: <1477427661-19788-1-git-send-email-halfline@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Ray Strode wrote:
> From: Ray Strode <rstrode@redhat.com>
>
> If the user is using a systemd system, then its useful to grab the
> environment from the systemd user manager process.
>   
----
    The other issue you don't really touch on, is why should this be hard-
coded in various programs when this is seems exactly like why PAM was
invented. 

    I.e. why not have a PAM module, say "pam_sysd_env", that gets the
env from the systemd user module(s), so any programs using
PAM can include in their security/authentication stack, the same
way pam_env might be used now (not that they are necessarily mutually
exclusive).

    One of the issues with systemd is that it is doesn't re-use
existing interfaces, but tends to force programs to make changes to work
with sysd, where if it used the existing interfaces, no program-specific
changes might be required and no explicit dependencies are built in
tools so that the same tools can be used on sysd systems, vs. non-sysd
systems. 

    Minimizing code changes in existing, working code seems like a
safer design decision.  It is especially true that the more code paths
that are added to programs, the more test paths and opportunities for 
failure
are added.


