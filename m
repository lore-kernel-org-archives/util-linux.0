Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59400 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751864AbaAOI1i (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 15 Jan 2014 03:27:38 -0500
Date: Wed, 15 Jan 2014 09:27:08 +0100
From: Karel Zak <kzak@redhat.com>
To: Felix Miata <mrmazda@earthlink.net>
Cc: util-linux@vger.kernel.org,
        =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Subject: Re: global fdisk colors disable
Message-ID: <20140115082708.GH12700@x2.net.home>
References: <52D62F0C.9060308@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52D62F0C.9060308@earthlink.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 15, 2014 at 01:47:40AM -0500, Felix Miata wrote:
> Is there a way to do $SUBJECT? One really shouldn't have to resort to using
> -L on every invocation to be able to see fdisk output. 

 Does it mean that fdisk output is broken or you just don't like
 colors? You can use:

   alias fdisk=fdisk -L=never

 in your shell profile or rc file.

> I see nothing in the
> man page about any kind of config file. I don't think there's ever been a
> reason to configure it before.

 Well, I guess that more people prefer colorized output so this
 feature is enabled by default.


 I have already thought about it and it would be probably nice to have
 a way how to globally configure colors for all command line utils
 (e.g.  util-linux, coreutils, ...).
 
 It seems we have no standard and package  independent solution now,
 so distributions use things like "alias" in shell profile files (for
 example for ls(1), grep(1), ...). It would be nice to have at least
 global variable (something like COLOR_MODE={auto,never,always}) to
 avoid aliases with --color= option. (CC: Padraig ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
