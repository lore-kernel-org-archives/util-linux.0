Return-Path: util-linux-owner@vger.kernel.org
Received: from li9-11.members.linode.com ([67.18.176.11]:47759 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752175Ab1FQCPU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 16 Jun 2011 22:15:20 -0400
Date: Thu, 16 Jun 2011 22:07:56 -0400
From: "Ted Ts'o" <tytso@mit.edu>
To: Ludwig Nussel <ludwig.nussel@suse.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/4] uuidgen: fail if uuidd isn't running
Message-ID: <20110617020756.GB29725@thunk.org>
References: <1308232779-21018-1-git-send-email-ludwig.nussel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308232779-21018-1-git-send-email-ludwig.nussel@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 16, 2011 at 03:59:36PM +0200, Ludwig Nussel wrote:
> time bases uuids are not safe if uuidd is not running.
> Add option --force to generate a uuid in this case nevertheless.

I really wouldn't worry about time-based uuid if you're grabbing them
from uuidgen.  Yes, if you're generating thousands of uuid's in
parallel via the C interface, it's possible that you potentially force
a collision.  But via the command-line interface of uuidgen?

There are plenty of other things to worry about.

							- Ted
