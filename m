Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43372 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751221AbbCPLNh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Mar 2015 07:13:37 -0400
Date: Mon, 16 Mar 2015 12:13:35 +0100
From: Karel Zak <kzak@redhat.com>
To: Rainer Gerhards <rgerhards@hq.adiscon.com>
Cc: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org,
        Rainer Gerhards <rgerhards@adiscon.com>
Subject: Re: [PATCH 5/8] logger: fix rfc5424 format crash
Message-ID: <20150316111335.GJ28925@ws.net.home>
References: <1426424094-25451-1-git-send-email-kerolasa@iki.fi>
 <1426424094-25451-6-git-send-email-kerolasa@iki.fi>
 <20150316104954.GE28925@ws.net.home>
 <CADk+mPA+R1PGGpA6=Aj0JB6RZSzS4NG-s9oSKEN35ff4SFZChA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CADk+mPA+R1PGGpA6=Aj0JB6RZSzS4NG-s9oSKEN35ff4SFZChA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 16, 2015 at 11:55:36AM +0100, Rainer Gerhards wrote:
> The best thing to do is use
> 
> = xstrdup(NILVALUE)

Yeah,
https://github.com/karelzak/util-linux/commit/773df0fa2f6c12581cc8649a08b9d825456a247c

> 
> I defined NILVALUE exactly for those cases (see rest of code).
> 
> Rainer
> 
> PS: I've been silent for a couple of days because my main projects demand
> attention. Will soon post more again here.

No problem.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
