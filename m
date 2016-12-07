Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:62564 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752193AbcLGO7P (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 7 Dec 2016 09:59:15 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: [PATCH 0/2] docs: renice(1) patches
Date: Wed, 7 Dec 2016 15:52:37 +0100
Cc: util-linux@vger.kernel.org
References: <a107f552-049d-0600-3893-fdb2a5c11f29@gmail.com>
In-Reply-To: <a107f552-049d-0600-3893-fdb2a5c11f29@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201612071552.38043.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wednesday 07 December 2016, Michael Kerrisk (man-pages) wrote:
> Karel,
>
> The two following patches contain nontrivial content
> changes to the renice(1) page. They depend on changes
> sent in my just-sent git pull request that includes
> trivial changes to the renice(1) page.


BTW you could use git instead Thunderbird to send your patches. Should 
be easier and better. (Maybe that's why you've asked about pull-request 
vs. mailinglist in the other thread.)


For example like this:

$ rm -rf /tmp/patches
$ git format-patch --cover-letter o /tmp/patches  master..HEAD
$ git send-email --to=util-linux@vger.kernel.org /tmp/patches/*


Your ~/.gitconfig would probably need such smtp/email setup:

[sendemail]
        smtpencryption = tls
        smtpserver = smtp.yourdomain.com
        smtpuser = xyzuser
        smtppass = xyzpwd
        smtpserverport = 25
        from=Your Name <bla@.yourdomain.com>
        suppresscc = self
        suppresscc = author
        suppresscc = sob
[format]
        signoff = true
