Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59534 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751156AbdDDNLb (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 4 Apr 2017 09:11:31 -0400
Date: Tue, 4 Apr 2017 15:11:25 +0200
From: Karel Zak <kzak@redhat.com>
To: kalle <kalle@projektwerkstatt.de>
Cc: util-linux@vger.kernel.org
Subject: Re: not responding
Message-ID: <20170404131125.vbq2ziezq3ekucyt@ws.net.home>
References: <58CAA79B.4010108@projektwerkstatt.de>
 <95b803a1-8288-25d6-4bbe-738348016813@projektwerkstatt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <95b803a1-8288-25d6-4bbe-738348016813@projektwerkstatt.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Apr 02, 2017 at 08:56:07PM +0200, kalle wrote:
> i have util-linux version 2.20.1 , the "more"-manpage says version 5.19

Well, the current version is v2.29.2 ...

> of more, and found the following problems in "more":
> I start with more FILE.
> then "=" to get the line "57". It is to say here, that the first line of
> the screen, will not be shown again, even if typing "b".
> Then z ;then = again. Gives line 115.
> b;= :line 58
> s;= :line 116
> b;= :line 59
> f;= :line 173
> b;= :line 116
> b;= :line 59
> 
> This result seems to contradict to man more's definitions of
> -"s" :"skip forward k lines of text. Defaults to 1."
> -"f" :"skip forward k screenfuls of text. Defaults to 1."

Hmm... it's mess, like everything around more(1).
Sami any comment? :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
