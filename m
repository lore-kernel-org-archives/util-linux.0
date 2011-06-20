Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33949 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758Ab1FTKpy (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 20 Jun 2011 06:45:54 -0400
Date: Mon, 20 Jun 2011 12:45:48 +0200
From: Karel Zak <kzak@redhat.com>
To: "Ted Ts'o" <tytso@mit.edu>
Cc: Ludwig Nussel <ludwig.nussel@suse.de>, util-linux@vger.kernel.org
Subject: Re: [PATCH 1/4] uuidgen: fail if uuidd isn't running
Message-ID: <20110620104548.GC17967@nb.net.home>
References: <1308232779-21018-1-git-send-email-ludwig.nussel@suse.de> <20110617020756.GB29725@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110617020756.GB29725@thunk.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 16, 2011 at 10:07:56PM -0400, Ted Ts'o wrote:
> On Thu, Jun 16, 2011 at 03:59:36PM +0200, Ludwig Nussel wrote:
> > time bases uuids are not safe if uuidd is not running.
> > Add option --force to generate a uuid in this case nevertheless.
>
> I really wouldn't worry about time-based uuid if you're grabbing them
> from uuidgen.  Yes, if you're generating thousands of uuid's in
> parallel via the C interface, it's possible that you potentially force
> a collision.  But via the command-line interface of uuidgen?

 I agree with Ted. 

 Let's go one step back (sorry Ludwig). It would be really better to
 add --safe rather than --force. We can use the --safe option to test
 the new *_safe functions or for really paranoid environments, but we
 should not force people use the new functionality.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
