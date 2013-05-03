Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-da0-f43.google.com ([209.85.210.43]:53296 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934031Ab3ECUTF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 3 May 2013 16:19:05 -0400
Received: by mail-da0-f43.google.com with SMTP id u7so960741dae.30
        for <util-linux@vger.kernel.org>; Fri, 03 May 2013 13:19:04 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1367520701-14962-17-git-send-email-kerolasa@iki.fi>
References: <1367520701-14962-1-git-send-email-kerolasa@iki.fi>
	<1367520701-14962-17-git-send-email-kerolasa@iki.fi>
Date: Fri, 3 May 2013 21:19:03 +0100
Message-ID: <CAG27Bk1KXxQ_G-5RjS=3cYAn35fLwCArU4rv7LS_EPMMuf=0Yw@mail.gmail.com>
Subject: Re: [PATCH 16/16] cal: simplify day_in_week()
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 2 May 2013 19:51, Sami Kerola <kerolasa@iki.fi> wrote:
> The day_in_week() does not need to perform fullfledged September 1752
> calculations, that month is dealt as static assignment.

Hi Karel, and others,

Please drop this patch. Having abort() at the end of the function is
bad choice, if something like weekday name highlighting is
implemented[1]. When I reconsider that bit the function it should
return for the eleven days at September 1752 a day out of bounds,
which basically some sort of NaN equivalent.

[1] http://www.spinics.net/lists/util-linux-ng/msg07904.html

--
   Sami Kerola
   http://www.iki.fi/kerolasa/
