Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f45.google.com ([74.125.82.45]:63652 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753993AbaIPUur (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 16 Sep 2014 16:50:47 -0400
Received: by mail-wg0-f45.google.com with SMTP id z12so427081wgg.4
        for <util-linux@vger.kernel.org>; Tue, 16 Sep 2014 13:50:46 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
Date: Tue, 16 Sep 2014 21:50:43 +0100 (BST)
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 17/17] setarch: remove unreachable code
In-Reply-To: <20140912095038.GW21325@x2.net.home>
Message-ID: <alpine.LNX.2.03.1409162139520.3712@kerolasa-home>
References: <1410093785-17537-1-git-send-email-kerolasa@iki.fi> <1410093785-17537-18-git-send-email-kerolasa@iki.fi> <20140912095038.GW21325@x2.net.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, 12 Sep 2014, Karel Zak wrote:

> On Sun, Sep 07, 2014 at 01:43:05PM +0100, Sami Kerola wrote:
>> Architectures are protected using '#if defined' clauses, making the code
>> in this removal to be impossible to reach.
>
> Hmmm.. I guess the code tries to verify that the result architecture
> after personality() matches with uname.machine (except to
> i{486,586,...}), to be sure that our request has been correctly
> interpreted by kernel.
>
> IMHO it's correct.

I removed the change from incoming pull request, and try to improve the 
'Unrecognized architecture' message this week. Since the condition looks 
impossible reach maybe the message should encourage to report to 
util-linux maillist with which transitions[i].result_arch and un.machine 
values one was able to see it.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
