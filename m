Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vk0-f48.google.com ([209.85.213.48]:33482 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752508AbcLHSjp (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 8 Dec 2016 13:39:45 -0500
Received: by mail-vk0-f48.google.com with SMTP id 137so233889527vkl.0
        for <util-linux@vger.kernel.org>; Thu, 08 Dec 2016 10:39:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAA_UwzLaHYUx6po+TJFN7HyHRkBRwBGCeLjO70aoFAPtMS4_iQ@mail.gmail.com>
References: <1477427661-19788-1-git-send-email-halfline@gmail.com>
 <CAA_Uwz+od5AwWosSzb_j59v2LvdZ=ipmHe2s+_kZiccC6v-FnQ@mail.gmail.com>
 <201612072104.37323.sweet_f_a@gmx.de> <20161208112441.5kckrt7cofh2opbz@ws.net.home>
 <CAA_UwzLaHYUx6po+TJFN7HyHRkBRwBGCeLjO70aoFAPtMS4_iQ@mail.gmail.com>
From: Ray Strode <halfline@gmail.com>
Date: Thu, 8 Dec 2016 13:39:24 -0500
Message-ID: <CAA_UwzJn_OyX=w4uvfjvTGmx528FPzB0++u_9eYEqFix6J99ZA@mail.gmail.com>
Subject: Fwd: [PATCH] login-utils: import environment from user manager on
 systemd systems
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

(resending because gmail.com sent it as html email first time around)

Hi,

On Thu, Dec 8, 2016 at 6:24 AM Karel Zak <kzak@redhat.com> wrote:
>
> We had positive feedback about it from Red Hat PAM maintainer, but it
> would be probably better to discuss it with PAM upstream. This change
> will require a new stuff in PAM API.

Pretty sure Tomas is one of the upstream maintainers, but you're right,
discussion should take place upstream.

> Although I'm not sure why we need systemd as mediator, would be
> possible to read the environment setting directly by login(1)? Or it's
> expected that something (e.g. script) will be executed to get the session
> initialized?

The point is, the environment of systemd --user services and processes started
inside a logind registered session should get the same environment.  It doesn't
really make sense for them to get out of sync. login(1) could try to
read all the
same environment configuration files as systemd, but systemd gets its
environment
from a variety of places (user.conf / systemd service files /
/etc/environment.d), so
I think getting the environment from the user manager is the best way to go.

--Ray
