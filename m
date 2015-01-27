Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f175.google.com ([74.125.82.175]:48681 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754503AbbA0J4G (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 27 Jan 2015 04:56:06 -0500
Received: by mail-we0-f175.google.com with SMTP id p10so13895747wes.6
        for <util-linux@vger.kernel.org>; Tue, 27 Jan 2015 01:56:05 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <CAJm42388wcQx0TgFEVxNXJCjKQPywO+65osLagn9_Wm=+5FB8g@mail.gmail.com>
References: <CAJm42388wcQx0TgFEVxNXJCjKQPywO+65osLagn9_Wm=+5FB8g@mail.gmail.com>
Date: Tue, 27 Jan 2015 09:56:04 +0000
Message-ID: <CAG27Bk07WVef-+xq3QdA6UeQgKkKzv-Oz9R-kqQdT34m996uag@mail.gmail.com>
Subject: Re: whereis search path
From: Sami Kerola <kerolasa@iki.fi>
To: Brandon Vincent <Brandon.Vincent@asu.edu>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 27 January 2015 at 06:33, Brandon Vincent <Brandon.Vincent@asu.edu> wrote:
> Out of curiosity, it looks like the search path for whereis is hard coded.

Hi Brandon,

The whereis(1) default paths are indeed hard coded.

https://github.com/karelzak/util-linux/blob/master/misc-utils/whereis.c#L96

With -B, -M, and -S option arguments additional paths can be
specified, but that is not what you are asking.

> Was the inclusion of /usr/share/info ever considered?

As far I can tell inclusion of the info directory has not been
considered. I recon the /usr/share/info is closest to manuals category
from the three options, and it feels like reasonable addition.

Any other opinions? And should this change be done before or after
release v2.25?

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
