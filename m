Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:42606 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941957AbcJYVlL (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 25 Oct 2016 17:41:11 -0400
Message-ID: <580FC961.8060502@tlinx.org>
Date: Tue, 25 Oct 2016 14:06:41 -0700
From: Linda Walsh <lkml@tlinx.org>
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
> This allows administrators to initialize the environment of the sessions
> via systemd configuration.
>   
---
    Isn't pam_env supposed to allow setting vars in setting up
a user's first login session?

(from /etc/security/pam_env.conf)
# This is the configuration file for pam_env, a PAM module to load in
# a configurable list of environment variables for an _authorized_ session.
#
# The original idea for this came from Andrew G. Morgan ...
#<quote>
#   Mmm. Perhaps you might like to write a pam_env module that reads a
#   default environment from a file? I can see that as REALLY
#   useful... Note it would be an "auth" module that returns PAM_IGNORE
#   for the auth part and sets the environment returning PAM_SUCCESS in
#   the setcred function...
#</quote>
#
# What I wanted was the REMOTEHOST variable set...

As an aside, I use that to set my DISPLAY to the remote host on 1st login.

It's only available when a user is establishing a session from a
remote system.   Calling it at other times won't have remotehost set.
(basically values of REMOTEHOST & DISPLAY should be kept intact much like
the TERM or LANG settigns.





