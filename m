Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34030 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbbA3QF5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 30 Jan 2015 11:05:57 -0500
Received: by mail-wi0-f170.google.com with SMTP id bs8so3861097wib.1
        for <util-linux@vger.kernel.org>; Fri, 30 Jan 2015 08:05:56 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1422608050-28600-1-git-send-email-kerolasa@iki.fi>
References: <1422608050-28600-1-git-send-email-kerolasa@iki.fi>
Date: Fri, 30 Jan 2015 17:05:55 +0100
Message-ID: <CAG27Bk08wUXz=s4dRBcYiwZ+KO=3oT3csQH6g3aAoTAk_+0G0Q@mail.gmail.com>
Subject: Re: [PATCH] more: fix control character display bug
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Cc: Sami Kerola <kerolasa@iki.fi>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 30 January 2015 at 09:54, Sami Kerola <kerolasa@iki.fi> wrote:
> This removes isprint(c) column++ from get_line() that made underlining,
> bold, and other control characters to cause more display to wrap lines
> incorrectly.  Easiest way to see the difference is to run following
> before and after compiling this change.
>
> PAGER=./more man man

Hold on. The change also alter press \n that earlier made more(1) to
more forward one line, but after the change only new line appears. I
will try to write better change sometime soon.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
