Return-Path: util-linux-owner@vger.kernel.org
Received: from bombadil.infradead.org ([198.137.202.9]:47463 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbaGJObT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 10 Jul 2014 10:31:19 -0400
Date: Thu, 10 Jul 2014 07:31:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: util-linux@vger.kernel.org
Subject: Re: Supporting human parsable journal_dev specifiers
Message-ID: <20140710143119.GA13753@infradead.org>
References: <20140710142824.GA20753@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140710142824.GA20753@thunk.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jul 10, 2014 at 10:28:24AM -0400, Theodore Ts'o wrote:
> I have a user request that mount be able to interpret the device
> specifier for the journal_dev mount option, so that instead of having
> to type something like
> 
>    mount -o journal_dev=0x0803 ....
> 
> they could unstead use: "journal_dev=/dev/sda3" or even
> "journal_dev=LABEL=ext_journal".  I assume the right way to do this is
> a mount helper?  Or is this something that you would be willing to
> accept as a patch into util-linux?

At least for the device name the best is to implement it in the kernel,
take a look at what XFS is doing for the log device.  The open by dev_t
functionality currently used by extN isn't something we like to see used
anyway.

