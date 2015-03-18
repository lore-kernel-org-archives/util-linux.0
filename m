Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43266 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933178AbbCRJ4J (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 18 Mar 2015 05:56:09 -0400
Date: Wed, 18 Mar 2015 10:55:57 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: Benno Schulenberg <bensberg@justemail.net>, util-linux@vger.kernel.org
Subject: Re: [PATCH 2/3] hwclock: remove unneeded stuff from the man-page
 header
Message-ID: <20150318095557.GA28925@ws.net.home>
References: <1426624493-2464-1-git-send-email-bensberg@justemail.net>
 <1426624493-2464-2-git-send-email-bensberg@justemail.net>
 <5508C836.1070702@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5508C836.1070702@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 17, 2015 at 08:35:02PM -0400, J William Piggott wrote: 
> First, you have no right to assign my name to anything, let alone a
> legal notice.

This is valid point, but it would be also nice if you guys will be able
to keep our discussions in friendly climate. This is not lkml, right? ;-)

> Second, we've already been through this. The decision was left to Karel
> and he accepted it as is. There is nothing wrong with a man-page having
> some top comments.

Well, I miss the header. It's fine (and it's recommended) to add your
copyright to header. I personally prefer git to record history than
use file header for this purpose, but I have no strong opinion for
this. More important is to have nice man pages with usable content.

Note that in code I sometimes add my name and date to the comment
before some important code block. Maybe you can use the same in man
pages.  For example add a comment before man page section rather than
use man page header for this purpose.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
