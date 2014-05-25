Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f52.google.com ([209.85.160.52]:35748 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbaEYK5q (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 25 May 2014 06:57:46 -0400
Received: by mail-pb0-f52.google.com with SMTP id rr13so6316495pbb.11
        for <util-linux@vger.kernel.org>; Sun, 25 May 2014 03:57:45 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1400934810.16438.121084941.30D576D1@webmail.messagingengine.com>
References: <1400929696-12548-1-git-send-email-kerolasa@iki.fi>
	<1400929696-12548-3-git-send-email-kerolasa@iki.fi>
	<1400934810.16438.121084941.30D576D1@webmail.messagingengine.com>
Date: Sun, 25 May 2014 11:57:45 +0100
Message-ID: <CAG27Bk2kgLjYBc5Wx36X5kpSQ-+-jQGUYVy7Z8ArRZVDFMYLUQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] docs: setterm.1 add missing options to manual page
 and remove duplicate
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 24 May 2014 13:33, Benno Schulenberg <bensberg@justemail.net> wrote:
> On Sat, May 24, 2014, at 13:08, Sami Kerola wrote:
>> +.TP
>> +.BR \-\-inversescreen " [" on | off "]"
>
> Previously it had the string "(virtual consoles only)" appended.

Commit 78dd23c changed that. Point taken, I should double check the
"(virtual consoles only)" in manual page being aligned with the code.

>> +Invert foreground and background color.
>
> Swap foreground and background colors for the whole screen?

That is better.

New version:
https://github.com/kerolasa/lelux-utiliteetit/commit/b660237b7bd2e72e0a6d9c765b286ac6a6a405e2

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
