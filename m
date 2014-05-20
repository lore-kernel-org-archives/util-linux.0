Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:8601 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752425AbaETKCu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 20 May 2014 06:02:50 -0400
Date: Tue, 20 May 2014 12:02:38 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: kerolasa@gmail.com, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 00/17] pull: almost complete setterm refactoring
Message-ID: <20140520100238.GO26357@x2.net.home>
References: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
 <CAG27Bk2qzzF2BNp=ec+x4zn8WOc40CNn8qKyG9_H5+mdWHb5ew@mail.gmail.com>
 <1400573509.16753.119372357.3CE7F060@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1400573509.16753.119372357.3CE7F060@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 20, 2014 at 10:11:49AM +0200, Benno Schulenberg wrote:
> 
> Some day Karel Zak wrote:
> > >     _(" -hbcolor <bright> <color>\n")
> > >
> > > and describe below in usage():
> > >
> > >    _(" <color> means black, blue, ...")
> 
> But but but... the word "bright" is not a placeholder, it must not
> be replaced by something else, as <color> by blue, for example.
> It is a literal argument, so should not take <>, and it is optional,
> so it should take [].  No

 Yep, fixed. Thanks!

 BTW, setterm still need our love:
 
  * usage() contains only options, but no any description

  * it would be nice to have long options (--term rather than -term)
    in the man page

  * nowhere (in man page) is info that --long options are supported
    since v2.25 (and for backward compatibility is better to use
    "-foo" rather than "--foo")


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
