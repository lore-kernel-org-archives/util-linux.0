Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42707 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752339AbbHaIxk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 31 Aug 2015 04:53:40 -0400
Date: Mon, 31 Aug 2015 10:53:38 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/4] pull: cal: --sunday --week numbering correction
Message-ID: <20150831085338.GB2726@ws.net.home>
References: <1440681689-2708-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1440681689-2708-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Aug 27, 2015 at 02:21:25PM +0100, Sami Kerola wrote:
> I do not think cal(1) should implement all of the possible week numbering
> alternatives.

Yes, it seems the current US mess is enough.

> Sami Kerola (4):
>   cal: correct gregorian week numbering
>   tests: cal: update Gregorian week numbers
    ^^^^^^^^^^^^
 not sent

>   cal: replace magic constants with symbolical values
>   cal: check biggest week number correctly when highlighting
> 
>  misc-utils/cal.c            | 102 +++---
>  tests/expected/cal/bigyearw | 156 ++++-----
>  tests/expected/cal/colorw   |  48 +--
>  tests/expected/cal/jan1753  |  12 +-
>  tests/expected/cal/sep1752w | 148 ++++----
>  tests/expected/cal/weekarg  |  60 ++--
>  tests/expected/cal/weeknum  | 816 ++++++++++++++++++++++----------------------
>  tests/ts/cal/weekarg        |  26 ++

this diffstat does not match with patches you send to the list. It
seems you forgot to send updated tests. I have updated the tests
manually. Please, git-pull & review.  Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
