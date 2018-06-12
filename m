Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49752 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932970AbeFLKYM (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 12 Jun 2018 06:24:12 -0400
Date: Tue, 12 Jun 2018 12:24:08 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Dominik Heidler <dheidler@suse.de>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: Bug: "blkid -o list" output formating is broken
Message-ID: <20180612102408.we6iwp4iugl3ywyx@ws.net.home>
References: <9d6d94f3-cb99-45e6-4170-2bb744f5878b@suse.de>
 <CAG27Bk3dTjXhcsoBpWTORRsdJk8A7ZiO=jF0B8BkdJd-YwAWag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk3dTjXhcsoBpWTORRsdJk8A7ZiO=jF0B8BkdJd-YwAWag@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 07, 2018 at 10:35:52AM +0100, Sami Kerola wrote:
> On 6 June 2018 at 15:50, Dominik Heidler <dheidler@suse.de> wrote:
> > when I run "blkid -o list" on a terminal with width >= 178 chars
> > the output will be broken:
> > https://paste.opensuse.org/view/raw/84899108
> >
> > It will shift the table output and create longer lines than the
> > terminal width generating linebreaks and breaking the readability of
> > the table.
> >
> > I was able to reproduce this issue with util-linux-2.32.
> 
> Hi Dominik,
> 
> From bklid(8) manual page:
> 
>   It is recommended to use lsblk(8) command to get information about block
>   devices, or lsblk --fs to get an overview of filesystems, or findmnt(8) to
>   search in already mounted filesystems.
> 
>   lsblk(8) provides more information, better control on output formatting,
>   easy to use in scripts and it does not require root permissions to get
>   actual information. <and so on>
> 
> Notice that the manual page also has marked --output=list deprecated
> in favour of the lsblk(8) command. So it is _very_ unlikely changes to
> that output format are accepted by Karel who maintains the project.
> That basically means bugs in that format are now features.

Yes, it seems bad idea to invest time to --output=list if we have
libsmartcols based solutions.

"lsblk --fs" is better solution. blkid(8) is there for backward
compatibility and to have a way how to test libblkid probing code
(-p).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
