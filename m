Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55226 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750931AbeAQLGj (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 17 Jan 2018 06:06:39 -0500
Date: Wed, 17 Jan 2018 12:06:33 +0100
From: Karel Zak <kzak@redhat.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        "Eric W. Biederman" <ebiederm@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        util-linux@vger.kernel.org,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: User-visible context-mount API
Message-ID: <20180117110633.zneqvnjzgxkv4yc2@ws.net.home>
References: <28167.1516032442@warthog.procyon.org.uk>
 <CAOssrKdgudK7kKbhQBAnV9EwzHBq=4+9M26JGfmhNDGrGXmnFg@mail.gmail.com>
 <1643.1516117204@warthog.procyon.org.uk>
 <CAOssrKdn-ZhOB9V28uL-JK9zgNGJzF4cFBeyoqLLj4pADqNFVQ@mail.gmail.com>
 <20180117041727.GS13338@ZenIV.linux.org.uk>
 <CAOssrKfN_ZT5yJC1mxkhUf6FG=_eMD4nzQtETfu_4X3vOf1kHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOssrKfN_ZT5yJC1mxkhUf6FG=_eMD4nzQtETfu_4X3vOf1kHw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 17, 2018 at 10:53:36AM +0100, Miklos Szeredi wrote:
> [Adding util-linux@vger and Michael Kerrisk]
> 
> On Wed, Jan 17, 2018 at 5:17 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > On Tue, Jan 16, 2018 at 05:41:46PM +0100, Miklos Szeredi wrote:
> >
> >> Right.
> >>
> >> Still, those two (propagation and flags) are properties of the mount.
> >> No fundamental difference in how to handle them, that I see.  Okay, we
> >> have MS_REC handling in the propagation and not in the flags, but
> >> that's something that might make sense for flags as well.
> >>
> >> What's more interesting is how MS_PRIVATE + MS_REC semantics are
> >> complete failure in the real world: the logical thing would be to mark
> >> a mount private on the supplied mount AND propagate an umount event to
> >> everywhere else.
> >
> > This is utter nonsense.  Most of the time it's "Fedora, in its infinite
> > bogo^Wwisdom has made everything shared; I don't fucking need that
> > idiocy, so please unshare this, this and that".  You really don't want
> > (or have permissions for) unmounting e.g. /mnt in namespace of init
> > when you do that.
> >
> > Sure, we get tons of bug reports.  Due to idiotic Fedora setup, with
> > everything shared.  The same setup that would go up in flames on the
> > semantics change you propose.

I guess "all shared" is systemd requirement, so I guess it's not
Fedora specific, right?

> I wouldn't propose to change existing --make-private, as this would
> not be backward compatible. The new semantics would mean a new op,
> obviously.

Definitely.

> Documenting  --make-private thing properly would also help.  To me the
> wording "make private" strongly implies "I want to make submounts
> private to this instance".  See for example rhbz#1432211.

All propagation stuff is poorly documented in mount.8. It would be
nice to add section about it to the man page. Volunteer? (My skills to
explain this topic to end-users is pretty limited...)
 
> > If anything, "private bind on itself" would be a useful operation.
> > Turning given location into a mountpoint, and having everything
> > under it looking as it used to, but with no propagation at all.
> > Without bothering anybody else, even if location currently happens
> > to be on a shared/master mount.

Good idea.

> > I can slap that together for mount(2), but I'm not sure what a sane
> > combination of flags for that would look like ;-)

What about new flag (for the API) rather than try to be smart with the
current flags? But I have doubts that invest time to new mount(2)
features is a good idea.

> For fsmount I think it would be very useful thing to have.

Yes.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
