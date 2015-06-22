Return-Path: util-linux-owner@vger.kernel.org
Received: from c-83-233-174-181.cust.bredband2.com ([83.233.174.181]:48228
	"EHLO pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbbFVR33 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 22 Jun 2015 13:29:29 -0400
Date: Mon, 22 Jun 2015 19:29:28 +0200
From: Andreas Henriksson <andreas@fatal.se>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] rename: allow full-path renames
Message-ID: <20150622172928.GA20786@fatal.se>
References: <1434990185-19883-1-git-send-email-andreas@fatal.se>
 <CAG27Bk353ASGr0hyDe4oQvAZ3Swf_HbgonENtkOPFE_qcjE7MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk353ASGr0hyDe4oQvAZ3Swf_HbgonENtkOPFE_qcjE7MQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello Sami Kerola.

On Mon, Jun 22, 2015 at 06:08:53PM +0100, Sami Kerola wrote:
> Hi Andreas,
> 
> Change looks good, but I would add a test to avoid same regression
> happening in future.  The same change with test can be found from
> my git.

Thanks for your quick review. I was just about to send out the tests
I was writing which should now be in your inbox with hopefully a bit
more coverage...

Also submitted patch v2 with your Reviewed-by added.

Regards,
Andreas Henriksson
--
To unsubscribe from this list: send the line "unsubscribe util-linux" in
