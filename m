Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:10341 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753949Ab3CTNLp (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 20 Mar 2013 09:11:45 -0400
Date: Wed, 20 Mar 2013 14:11:39 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>, Davidlohr Bueso <dave@gnu.org>
Subject: Re: [patches] a bunch of man-page fixes, plus -V for blkid
Message-ID: <20130320131139.GE14833@x2.net.home>
References: <1363639067.25811.140661206020553.0C776E64@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363639067.25811.140661206020553.0C776E64@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 18, 2013 at 09:37:47PM +0100, Benno Schulenberg wrote:
> Attached bunch of patches mainly normalizes the formatting of the

 All applied, thanks.

> man pages in the misc-utils directory.  The second patch adds -V for
> --version to the blkid command (instead of just -v).  And the seventh
> patch makes the section AVAILABILITY always be the last one in all
> man pages.
> 
> CC'ing Davidlohr because the sixth patch touches the man page of
> his lslocks command.  This man page makes a reference to chmod(1),
> but on my machine chmod(1) does not say anything about lock files,
> nor anything about being mandatory or advisory -- only fcntl(2) does.
> So I have changed that reference, but am unsure whether this is
> okay.  The man page also referes to lockf(2), but on my machine
> there is only a lockf(3); so I've changed that one too, but again am
> unsure whether it is okay.  Davidlohr?

 Heh.. where is David, that's the question :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
