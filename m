Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50566 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751508AbdLSKwT (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 19 Dec 2017 05:52:19 -0500
Date: Tue, 19 Dec 2017 11:52:14 +0100
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?R=FCdiger?= Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: v2.31.1 plan
Message-ID: <20171219105214.epp3rzheakptbf57@ws.net.home>
References: <20171214150026.7lk3mtwng5jbfcnf@ws.net.home>
 <113c13c9-4bbe-28b2-ed4e-59c0b8f3f32c@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <113c13c9-4bbe-28b2-ed4e-59c0b8f3f32c@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 15, 2017 at 01:01:23PM +0100, Rüdiger Meier wrote:
> On 12/14/2017 04:00 PM, Karel Zak wrote:
> > 
> >   I'd like to release stable maintenance v2.31.1 tomorrow or on Monday.
> > 
> >   All is already in stable/v2.31 branch:
> >   https://github.com/karelzak/util-linux/tree/stable/v2.31
> > 
> >   See log below, comments & objections?
> 
> I have one, probably minor issue which I was too lazy to investigate
> so far.
> 
> Test mount/fslists-type-pattern fails if you have /sbin/mount.exfat installed.

It sounds strange and I cannot reproduce this problem.

# ls -la /sbin/mount.exfat
lrwxrwxrwx 1 root root 16 Jun 21 16:27 /sbin/mount.exfat -> mount.exfat-fuse

# ./tests/ts/mount/fslists
        mount: fs lists                       ...
                : one-type                    ... OK
                : more-types                  ... OK
                : more-types-fstab            ... OK
                : type-pattern                ... OK
                : type-pattern-neg            ... OK
           ... OK (all 5 sub-tests PASSED)


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
