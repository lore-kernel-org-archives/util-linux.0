Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43346 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752277AbcFCNDL (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 3 Jun 2016 09:03:11 -0400
Date: Fri, 3 Jun 2016 15:03:09 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Don't allow widechar with plain ncurses
Message-ID: <20160603130309.6ntkxydp7hlrxg6r@ws.net.home>
References: <34855db6-f82e-d9df-6bb9-022be6d06523@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <34855db6-f82e-d9df-6bb9-022be6d06523@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 31, 2016 at 10:47:25PM +0200, Stanislav Brabec wrote:
> Standard ncurses library does not pass UTF-8 characters properly.
> 
> As widechar-enabled libsmartcols directly uses UTF-8 characters in
> table.c, it is unusable in applications using ncurses (e. g. cfdisk).

It's possible to force libsmartcols to use pure ascii rather than
UTF8.

The library checks for UTF8, but of course it has no clue about ncurses, 
so it's necessary to explicitly call scols_table_enable_ascii().

Fixed.

> Fail if widechar support is detected, ncurses is supported but
> libncursesw is not found.

This seems like overkill, ncurses is necessary only for small subset
of our utils. It would be better to disable ncurses at all (if
widechar expected but ncursesw not available) -- then only a few utils
will be disabled. I'll fix it next week.

Note that I have add --disable-widechar to make it easy to test (and I
found some bugs).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
