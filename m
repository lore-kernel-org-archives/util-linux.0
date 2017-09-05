Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39272 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750755AbdIELAK (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 5 Sep 2017 07:00:10 -0400
Date: Tue, 5 Sep 2017 13:00:05 +0200
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/1] Two changes before we go to rc
Message-ID: <20170905110005.jjcfq3rvch7jtqhi@ws>
References: <e5219e08-60f7-d35d-c81c-64cb598c7e84@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e5219e08-60f7-d35d-c81c-64cb598c7e84@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Sep 03, 2017 at 09:14:25PM -0400, J William Piggott wrote:
> 
> With the recent comment regarding the pending rc, I'd like to make
> two small string changes before we send them off for translation.
> 
> During this cycle all of hwclock usage strings have been changed, but
> I still do not like the debug description.
> 
> I looked at what the other utils are using; there are only two others
> with a debug option and their strings are no better for hwclock, IMO.
> So I looked at usage strings for the verbose option. In 27
> occurrences there are 15 different descriptions. The most recent one,
> written by Karel, I think is good for both debug (except uuidd) and
> verbose (it could be made a usage constant to reduce 17 strings to
> 1). It is: "display more details"

OK, merged.

Frankly, I don't like --debug option. It's better to use --verbose for
this purpose for new tools.

>From my point of view debugging is something extremely talkative with
many additional information and should be implemented with some
instrument to control what and how to debug. This is reason why I
prefer *_DEBUG= env. variables. For example LIBMOUNT_DEBUG=<what>.

Anyway, already supported command line options should be supported
"forever" (if possible); hwclock --debug is nice example. It's used by
many many users.

> 
> The second change was the subject of a long discussion which ended
> without a consensus. My last volley went unanswered:
> https://marc.info/?l=util-linux-ng&m=150124890123757&w=2
> 
> So this patch also makes the usage constants for help and version use
> the same verb; which Karel originally said was an improvement:
> https://marc.info/?l=util-linux-ng&m=149794873321562&w=2

I have merged the change. It's fine to have "display" there, and we
should go away from topic :-)


Note that the missing thing for the next release is Rudi's
coreutils-like options arguments:

 https://www.spinics.net/lists/util-linux-ng/msg14396.html

We have 14 days (to 19th) to implement it, the original plan is:

   - Sep 12 -- feature freeze, no invasive changes allowed (aka rc1)
   - Sep 19 -- strings freeze, translations (aka rc2)
   - Sep 26 -- v2.31


but I'm going to sailing in France next week, so rc1 will be later.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
