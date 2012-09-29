Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:60976 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552Ab2I2MtM convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 29 Sep 2012 08:49:12 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so888175wib.1
        for <util-linux@vger.kernel.org>; Sat, 29 Sep 2012 05:49:10 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <5066CC39.20408@draigBrady.com>
References: <50636D1D.3080007@draigBrady.com>
	<1348910519-10684-1-git-send-email-kerolasa@iki.fi>
	<5066CC39.20408@draigBrady.com>
Date: Sat, 29 Sep 2012 13:49:10 +0100
Message-ID: <CAG27Bk3LL6_9oNY9-R8wzKjPd+QZs6TxEgob8fVhAs+TXTU1YQ@mail.gmail.com>
Subject: Re: [PATCH] docs: column.1 describe change of separator behavior in
 bugs section
From: Sami Kerola <kerolasa@iki.fi>
To: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigbrady.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Sep 29, 2012 at 11:23 AM, Pádraig Brady <P@draigbrady.com> wrote:
> On 09/29/2012 10:21 AM, Sami Kerola wrote:
>> Add to manual page how to achieve old behavior, just in case someone
>> relies on buggy behavior of the command.
>
> Too much info for a man page IMHO.

Hi Pádraig,

You might be right. Karel, feel free to drop the patch if you want to
keep the man page short. If you choose to merge maybe adding a FIXME
comment 'remove column version < 2.23 compatibility note after
29.09.2017' is good idea.

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
