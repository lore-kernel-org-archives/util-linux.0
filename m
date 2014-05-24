Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f48.google.com ([74.125.82.48]:34120 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbaEXLIV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 24 May 2014 07:08:21 -0400
Received: by mail-wg0-f48.google.com with SMTP id k14so1651435wgh.19
        for <util-linux@vger.kernel.org>; Sat, 24 May 2014 04:08:20 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 0/4] setterm: documentation updates
Date: Sat, 24 May 2014 12:08:12 +0100
Message-Id: <1400929696-12548-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 20 May 2014 11:02, Karel Zak <kzak@redhat.com> wrote:
>  BTW, setterm still need our love:

Hi Karel and others,

Here is the remaining setterm(1) love before release 2.25. 

>   * usage() contains only options, but no any description

In this patch set, see 0001.

>   * it would be nice to have long options (--term rather than -term)
>     in the man page

Hold on, do you mean what I did in commit
fb27f91cac9702ad1858d782dd840d5868547423

>   * nowhere (in man page) is info that --long options are supported
>     since v2.25 (and for backward compatibility is better to use
>     "-foo" rather than "--foo")

In this patch set, see 0003.


Sami Kerola (4):
  setterm: add usage() descriptions
  docs: setterm.1 add missing options to manual page and remove
    duplicate
  docs: setterm.1 add options compatibility note
  docs: setterm.1 clean up manual page groff style

 term-utils/setterm.1 | 291 +++++++++++++++++++++++++++++++++------------------
 term-utils/setterm.c |  69 ++++++------
 2 files changed, 222 insertions(+), 138 deletions(-)

-- 
1.9.3

