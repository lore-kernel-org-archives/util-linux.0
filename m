Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vb0-f48.google.com ([209.85.212.48]:38135 "EHLO
	mail-vb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436Ab3JGLj3 (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Mon, 7 Oct 2013 07:39:29 -0400
Received: by mail-vb0-f48.google.com with SMTP id w16so3298214vbf.21
        for <util-linux-ng@vger.kernel.org>; Mon, 07 Oct 2013 04:39:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <52522615.4010304@draigBrady.com>
References: <CAO2cUkTj+f+6xrgr6+WzY9D+TwwZHWYhMfuMKKYF=39vJ8wU6w@mail.gmail.com>
	<CAG27Bk3APFUnaWq+TzK9p3snpAzZ2v4SBoikB+8HWHaPojZVMQ@mail.gmail.com>
	<CAO2cUkRXsUrK=kZsx=yHAKR+Ht2baA5bLiTwU4J9UD4sEbBepg@mail.gmail.com>
	<52522615.4010304@draigBrady.com>
Date: Mon, 7 Oct 2013 14:39:27 +0300
Message-ID: <CAO2cUkQuNiHwdmxACq1i1W8ix1teVvtUi9McPtksRrFC-M7F3g@mail.gmail.com>
Subject: Re: [RFC/PATCH] week numbers for cal
From: Tommi Kyntola <tommi.kyntola@gmail.com>
To: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigbrady.com>
Cc: Sami Kerola <kerolasa@gmail.com>, util-linux-ng@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Why not. I wasn't sure what exactly should be done with 52 when many
years have days belonging to two different 52 weeks, but I came up
with a spec that says it points to the week that starts during the
relevant year.

A patch in guthub:
https://github.com/Kynde/util-linux/commit/3a53abddc14f46eccb4264668b24875054f5ba62

cheers,
Tommi Kyntola
---
commit 3a53abddc14f46eccb4264668b24875054f5ba62
Author: Tommi Kyntola <kynde@iki.fi>
Date:   Mon Oct 7 14:32:23 2013 +0300

    cal: added argument option for -w|--week to display that week

    Because many years have two sections of week 52 or 53, the week that
    this argument points to is the one that starts during that year (when availa
    The week number in argument is also highlighted in addition to possibly visi
    current/defined date highlighting.

    Signed-off-by: Tommi Kyntola <kynde@iki.fi>

 misc-utils/cal.1           |   2 +-
 misc-utils/cal.c           | 115 +++++++++++++++++++++++++++++++++------
 tests/expected/cal/weekarg | 127 +++++++++++++++++++++++++++++++++++++++++++
 tests/ts/cal/weekarg       | 131 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 358 insertions(+), 17 deletions(-)
