Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756464AbdCUMPE (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 21 Mar 2017 08:15:04 -0400
Date: Tue, 21 Mar 2017 13:14:26 +0100
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: sysfsutils, aka systool, candidate for inclusion in util-linux-ng
Message-ID: <20170321111156.i6kjcbmktj34lsvq@ws.net.home>
References: <6affdcde-0ec0-87ee-45f8-7da32ae1d1a5@gmail.com>
 <CAG27Bk3uXbmBs9cY8gK34YJuUVEY11CdGB0-ibiTQ9feXg_9og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk3uXbmBs9cY8gK34YJuUVEY11CdGB0-ibiTQ9feXg_9og@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Mar 18, 2017 at 07:41:53PM +0000, Sami Kerola wrote:
> On 17 March 2017 at 17:47, Xose Vazquez Perez <xose.vazquez@gmail.com> wrote:
> > Description: utilities for interfacing with sysfs.
> >
> > Background: unmaintained since ten years, included in
> > enterprise distributions and widely used with plenty of
> > downloads: https://sourceforge.net/projects/linux-diag/files/sysfsutils/stats/timeline?dates=2003-07-01++to+2017-03-17
> >
> >
> > $HOME: https://linux-diag.sf.net/Sysfsutils.html
> > Source code: https://sf.net/projects/linux-diag/files/sysfsutils/
> 
> Good proposal, and after quick test to migrate sysfsutils to
> util-linux this seems
> do-able. But before proceeding any further I want to hear from Karel and old
> sysfsutils maintainer if the project merge what is wanted.

The question is if maintain it again is the right reaction to the
current agony. Maybe death is better solution.

I don't think it's widely used and IMHO it's probably used for trivial
things like write/read from sysfs.

For example we have for work with /sys/block a file lib/sysfs.c in
utils-linux. Not sure if for something like this is necessary to have
shared library.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
