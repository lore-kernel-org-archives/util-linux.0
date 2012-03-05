Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63436 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757696Ab2CEUr2 convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 Mar 2012 15:47:28 -0500
Received: by yhmm54 with SMTP id m54so1913263yhm.19
        for <util-linux@vger.kernel.org>; Mon, 05 Mar 2012 12:47:28 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20120305195228.GD838@rampage>
References: <20120305123847.GD486@x2.net.home>
	<1330976334-10751-1-git-send-email-kerolasa@iki.fi>
	<1330976334-10751-16-git-send-email-kerolasa@iki.fi>
	<20120305195228.GD838@rampage>
Date: Mon, 5 Mar 2012 21:47:27 +0100
Message-ID: <CAG27Bk3eTjR_gpN6N3TVeV9sonj6FOMxa8jR4aGRH-gUjfrDRA@mail.gmail.com>
Subject: Re: [PATCH 15/17] include: add asprintf wrapper
From: Sami Kerola <kerolasa@iki.fi>
To: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 5, 2012 at 20:52, Dave Reisner <d@falconindy.com> wrote:
> On Mon, Mar 05, 2012 at 08:38:52PM +0100, Sami Kerola wrote:
>> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
>> ---
>>  include/xalloc.h |   11 +++++++++++
>>  1 file changed, 11 insertions(+)
>
> maybe add xasprintf to tools/checkxalloc.sh as well?

Hi Dave,

Great idea.

https://github.com/kerolasa/lelux-utiliteetit/commit/7a63067e36c67f70a6b4cc4394295d72e22c0b5b

And immediately useful.

https://github.com/kerolasa/lelux-utiliteetit/commit/a516dbf53363865f27589bf72e85c91ca0e24094

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
