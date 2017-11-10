Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35268 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751455AbdKJNPD (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 10 Nov 2017 08:15:03 -0500
Date: Fri, 10 Nov 2017 14:14:58 +0100
From: Karel Zak <kzak@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Ximin Luo <infinity0@pwned.gg>, util-linux@vger.kernel.org
Subject: Re: Bug: for mount namespaces inside a chroot, unshare works but
 nsenter doesn't
Message-ID: <20171110131458.7xlnbf7ayvtk7r2r@ws.net.home>
References: <7b168fc6-957c-3c98-d7f2-673842ee550c@pwned.gg>
 <20171103133348.p4coyse7eoibcpsn@ws.net.home>
 <877euzaws1.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <877euzaws1.fsf@xmission.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Nov 09, 2017 at 04:54:06PM -0600, Eric W. Biederman wrote:
> Karel Zak <kzak@redhat.com> writes:
> 
> > Unfortunately, I'm not sure if this is the right way in all cases.
> 
> I believe this will break all except the case mentioned.

I have expected something like this...

> My personal recommendation is not to use chroot with persistent mount
> namespaces.  That just seems to keep unnecessary mounts around.  Those
> extra mounts will almost certainly be a problem later when you discover
> you want to unmount one of those mounted filesystems you don't care
> about but are chrooting over.
> 
> I think it would be quite reasonable to have an additional option to
> open things in the new mount namespace, just before exec.  I just don't
> see how useful it would be.

It would be solution for this use-case, but it will increase
complexity and I'm not sure this use-case is important enough.

Especially if the all you need is to use chroot command before nsenter.
I don't think nsenter has to be all-in-one command. It's very basic
tool.

> A second possibility is to issue a warning if root and is not a member
> of the target mount namespace.  That might even allow doing the right
> thing automatically.  It looks like the mnt_id is available from
> /proc/<pid>/fdinfo/<fd#>.  So it looks like it is possible with the
> existing kernel interfaces (at least in theory).

I'll think about it.

> Ugh.  It looks like you commited your change below to sys-utils by
> accident.

OMG...<censored>... fixed. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
