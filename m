Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-yb0-f178.google.com ([209.85.213.178]:34952 "EHLO
        mail-yb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932462AbcJZTih (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 26 Oct 2016 15:38:37 -0400
Received: by mail-yb0-f178.google.com with SMTP id d128so6584013ybh.2
        for <util-linux@vger.kernel.org>; Wed, 26 Oct 2016 12:38:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <580FC961.8060502@tlinx.org>
References: <1477427661-19788-1-git-send-email-halfline@gmail.com> <580FC961.8060502@tlinx.org>
From: Ray Strode <halfline@gmail.com>
Date: Wed, 26 Oct 2016 15:38:16 -0400
Message-ID: <CAA_UwzKqEsXDOrayqMHsLOXzB72YfNMyuWa4b0ODcbrqnGgDmw@mail.gmail.com>
Subject: Re: [PATCH] login-utils: import environment from user manager on
 systemd systems
To: Linda Walsh <lkml@tlinx.org>
Cc: util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,
>    Isn't pam_env supposed to allow setting vars in setting up
> a user's first login session?
It can, but it has a few problems

1) the file format is kind of weird
2) not all distros set user_readenv=1 so users cant set the
environment variables they want
3) pam_env doesn't provide a facility for 3rd party applications to
adjust the environment
4) PAM modules run in the context of a user but as root. Having a
bunch of independent plugins all running as root, and not necessarily
integrating with each other is a recipe for security problems,
especially if you throw environment variables into the mix.
(if pam_env is erroneously in the session stack before a pam_exec
call, the user could easily get root access)


This topic was discussed a bit in the cited systemd pull request, I think.

--Ray
