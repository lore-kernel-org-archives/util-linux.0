Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33633 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753125AbbFYKGU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 25 Jun 2015 06:06:20 -0400
Date: Thu, 25 Jun 2015 12:06:18 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Andreas Henriksson <andreas@fatal.se>,
        util-linux <util-linux@vger.kernel.org>,
        Andreas Henriksson <andreas.henriksson@endian.se>
Subject: Re: [PATCH] rename: allow full-path renames
Message-ID: <20150625100618.GQ1992@ws.net.home>
References: <1434990185-19883-1-git-send-email-andreas@fatal.se>
 <CAG27Bk353ASGr0hyDe4oQvAZ3Swf_HbgonENtkOPFE_qcjE7MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk353ASGr0hyDe4oQvAZ3Swf_HbgonENtkOPFE_qcjE7MQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 22, 2015 at 06:08:53PM +0100, Sami Kerola wrote:
> Change looks good, but I would add a test to avoid same regression
> happening in future.  The same change with test can be found from
> my git.
> 
> https://github.com/kerolasa/lelux-utiliteetit/commit/19ef4954935c65559e7561b4b3becbe462848127

 I have applied Andreas' test (but if you want to submit more tests
 then go ahead :-)

 Please, keep tests in the independent commits.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
