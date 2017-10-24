Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751921AbdJXJhc (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 24 Oct 2017 05:37:32 -0400
Date: Tue, 24 Oct 2017 11:37:28 +0200
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 4/4] lib/timeutils: add common ISO timestamp masks
Message-ID: <20171024093728.cwri5elvpqxk6tl7@ws.net.home>
References: <ac1afb00-aed1-4eed-aabe-89d26e29ca0d@gmx.com>
 <661c0a48-59bb-8263-9fd7-c1ef80b160f2@gmx.com>
 <20171023094959.dxlot6uqj5pvymwk@ws.net.home>
 <54ed1151-d782-815c-c986-1ae6ea9d20fe@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54ed1151-d782-815c-c986-1ae6ea9d20fe@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 23, 2017 at 03:54:19PM -0400, J William Piggott wrote:
> > Would be possible to use ISO_8601_* to compose ISO_TIMESTAMP_*
> > macros? Your hardcoded magic 0x constants make the header file
> > less readable. I mean
> > 
> >   ISO_TIMESTAMP = ISO_8601_DATE | ISO_8601_TIME | ISO_8601_TIMEZONE
> 
> We could eliminate wrapping by dropping the unnecessary 8601. Using the
> longest example:
> 
> 	ISO_TIMESTAMP_COMMA_GT = ISO_TIMESTAMP_COMMA | ISO_GMTIME | ISO_T
 
OK, although ISO_T seems pretty generic :-)

> > and it would be also nice to add somehow info about "usec" to the
> > macro name (see ISO_TIMESTAMP vs. ISO_TIMESTAMP_COMMA).
> 
> 8601 only uses comma or dot for the radix character; so 'COMMA/DOT'
> imply the presence of a fractional part.
> 
> > What about:
> > 
> >     - use "U" prefix for usec times
> >     - use "GM_" prefix for GMTIME
> > 
> > for example:
> > 
> >    ISO_TIMESTAMP           = ISO_8601_DATE | ISO_8601_TIME | ISO_8601_TIMEZONE,
> >    ISO_UTIMESTAMP_DOT      = ISO_TIMESTAMP | ISO_8601_DOTUSEC,
> >    ISO_UTIMESTAMP_COMMA    = ISO_TIMESTAMP | ISO_8601_ISO_8601_COMMAUSEC,
> >    ISO_GM_UTIMESTAMP_COMMA = ISO_UTIMESTAMP_COMMA | ISO_8601_GMTIME
> > 
> > and so on.
> 
> IMO the macros are easier to remember, write, and read, if they all
> begin the same and the optional parts are suffixes. All of the masks are
> basic ISO Timestamps (date time timezone), the rest are minor variations.

I have a problem if I have to use more suffixes, the order of the
suffixes is not obvious. The idea behind ISO_8601_* with in code has
been to keep it readable:

    strtime_iso(ISO_8601_DATE | ISO_8601_TIME | ISO_8601_TIMEZONE)

is so easy to read...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
