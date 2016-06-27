Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34790 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbcF0Tsm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 27 Jun 2016 15:48:42 -0400
Received: by mail-oi0-f45.google.com with SMTP id s66so215073738oif.1
        for <util-linux@vger.kernel.org>; Mon, 27 Jun 2016 12:48:42 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20160624093143.wgmytikwnybb7dp3@ws.net.home>
References: <20160620204037.3292-1-kerolasa@iki.fi> <20160620204037.3292-6-kerolasa@iki.fi>
 <20160624093143.wgmytikwnybb7dp3@ws.net.home>
From: Sami Kerola <kerolasa@iki.fi>
Date: Mon, 27 Jun 2016 20:48:41 +0100
Message-ID: <CAG27Bk3=qqwgmU9+bivm3H91yELuZ0tFjwi+hTu5P7qU1egZ5Q@mail.gmail.com>
Subject: Re: [PATCH 5/6] tests: remove utmpdump localization go-around
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 24 June 2016 at 10:31, Karel Zak <kzak@redhat.com> wrote:
> On Mon, Jun 20, 2016 at 09:40:36PM +0100, Sami Kerola wrote:
>> The utmpdump timestamps are unambiguous, so forcing locale environment is
>> never needed.
>
> and what about strptime()?
>
> I think it's fine to keep tests robust and in well know environment.

strptime(3) is no longer expected to make timestamp to be localized.
Perhaps it would
be best to give strptime(3) wrong ideas about timezone, so that one can observe
gmtime(3) to do the right thing. To express same in form of change, here we go:

https://github.com/kerolasa/lelux-utiliteetit/commit/73f46aedc316efbb8e2a719c1c6c3aef364a5553

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
