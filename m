Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52994 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934609AbaEFKSi (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 6 May 2014 06:18:38 -0400
Date: Tue, 6 May 2014 12:18:29 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>,
        Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 20/21] login-utils/last.1: Improve the typesetting of the
 manual
Message-ID: <20140506101829.GK5962@x2.net.home>
References: <1399084359-28425-1-git-send-email-bjarniig@rhi.hi.is>
 <1399084359-28425-4-git-send-email-bjarniig@rhi.hi.is>
 <1399121099.30443.113236621.44458DE1@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399121099.30443.113236621.44458DE1@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, May 03, 2014 at 02:44:59PM +0200, Benno Schulenberg wrote:
> 
> Hello Bjarni,
> 
> On Sat, May 3, 2014, at 4:32, Bjarni Ingi Gislason wrote:
> >   Add a space character in front of an ellipsis
> 
> Hmm.  I find it clearer when the ellipsis is glued to the thing
> that it applies to.  But, as a space before it seems to be the
> accepted convention, okay.

 But it would be nice to be consistent. Few minutes ago I merged your
 patch with

     - <device> [...]
     + <device>...\

 I don't have any strong opinion about it, but I'd like to avoid 
 situation when we every week change it.

> However, it would be nice if you could make thematic patches:
> one patch for each type of change.  For example, one big patch
> for *all* man pages (in util-linux) that makes this space-before-
> ellipsis change, then one big patch for no-minus-within-options,
> and so on.

 Yep, it would be really nice.

> (A strange effect of this ellipsis is that between the following pair
> of "] [" brackets there will be a double space instead of a single one.
> Do you see this too?  An if so, would this be a bug or intentional?)
> 
> >   A minus is not used in words.  People using UTF-8 and copy-and-paste
> > can(?) (may?) use "info", "man --ascii"

Bjarni, this is really ugly recommendation -- especially when UTF8 and
copy & past from man pages is pretty common.

> No, you cannot require/suggest that people (if they want to copy and
> paste from the man-page output) use 'info' instead of 'man', or use an
> extra option.  Commands in the output of plain 'man' should be copy-
> and-pastable.  People who want to actually print a manual page may
> be required to use extra options to get the typesetting right.

Exactly.

> But for me, on a terminal in a UTF-8 locale, it makes no difference
> whether a man page contains \-\-long-option or --long-option, all
> those dashes render to  0x2d.  So copy-and-paste will work fine.

 Yep, me too :-)

> > -.RI [ username ...]
> > -.RI [ tty ...]
> > +.RI [ username " ...]
> > +.RI [ tty " ...]
> 
> Hm.  An unpaired quotation mark I find ugly.
> Better do "username " or " ...]" instead.

 Yep, we're SW developers. All strings have to be terminated :-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
