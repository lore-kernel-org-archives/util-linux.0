Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34896 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727551AbeHFQw4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 6 Aug 2018 12:52:56 -0400
Date: Mon, 6 Aug 2018 16:43:28 +0200
From: Karel Zak <kzak@redhat.com>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: Martin Steigerwald <martin@lichtvoll.de>,
        util-linux@vger.kernel.org
Subject: Re: =?iso-8859-1?Q?Debian=B4?= =?iso-8859-1?Q?s?= change of "su" to
 the one in util-linux
Message-ID: <20180806144328.npyl2jq2yho3mdxj@ws.net.home>
References: <1734536.DseMWcvaqb@merkaba>
 <20180805150557.GC26138@thunk.org>
 <1642971.4ZBaquOb5i@merkaba>
 <20180806132123.GA6184@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180806132123.GA6184@thunk.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 06, 2018 at 09:21:23AM -0400, Theodore Y. Ts'o wrote:
> On Mon, Aug 06, 2018 at 10:24:43AM +0200, Martin Steigerwald wrote:
> > 
> > Thank you, Ted. This is the best explanation I saw so far. I accept it 
> > for default.
> >
> 
> An interesting question to consider is where would be the best place
> to put this kind of information.  I learned it very on in my career,
> and what is "obvious" to one person can be "obscure lore" to another.
> 
> It's probably too much tutorial information for the su man page, but

I don't see problem to add "SAFE ENVIRONMENT" to su(1), it's probably
place where the topic will be more visible than in some tutorial.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
