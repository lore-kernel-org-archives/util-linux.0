Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58317 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753842AbbCPMGn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Mar 2015 08:06:43 -0400
Date: Mon, 16 Mar 2015 13:06:31 +0100
From: Karel Zak <kzak@redhat.com>
To: Rainer Gerhards <rgerhards@gmail.com>
Cc: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
Subject: Re: [PATCH 0/8] pull: logger: add tests and fix couple issues
Message-ID: <20150316120631.GL28925@ws.net.home>
References: <1426424094-25451-1-git-send-email-kerolasa@iki.fi>
 <CAP-up9AJwjQU8Mq5fT0wYZgv2noqz845EtVt-CiYjN=F0J8R5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAP-up9AJwjQU8Mq5fT0wYZgv2noqz845EtVt-CiYjN=F0J8R5A@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 16, 2015 at 12:28:19PM +0100, Rainer Gerhards wrote:
> On Sun, Mar 15, 2015 at 1:54 PM, Sami Kerola <kerolasa@iki.fi> wrote:
> > Hello,
> >
> > Coverage of these tests is not magnificent.  None of the communications
> > to external systems using tcp, udp, or to journald are tested, but at
> > least some aspects of the logger(1) functionality gets to be checked -
> > that is message formats and input validation.
> 
> 
> ah! excellent. I'll also have a look to understand the nature of how
> tests work for util-linux. Regarding tcp and udp: I guess a simple way
> would be to use netcat? Or is that considered bad practice for
> util-linux (as versions may differ and may interfere with test
> results?

 We have no any strict policy for tests, it's fine to check all
 necessary environment and versions and skip (ts_skip function) all
 the test if necessary. 
 
 We have two basic modes:
 
 * "non-root" (make check) - this is usually for simple tests where you
   don't need root permissions and where is it safe to call the test
   on arbitrary machine (to make it usable for example from spec
   files on build machines, etc.)

 * "root" - this is for dangerous tests you never want to call on
   production system, it's never executed by build system and you
   have to manually "cd tests; ./run.sh". This is for example for
   mount(8), some fdisk tests etc. These tests are for developers
   only.



 Note I have just committed a new --no-act logger command line option
 to make it possible to check messages formatting without spam in
 system logs, for example:

   $ logger --no-act --stderr --rfc5424 "This is message"

 I guess we can use it for messages formatting tests (as the tests
 suggested by Sami).

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
