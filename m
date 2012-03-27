Return-Path: util-linux-owner@vger.kernel.org
Received: from li9-11.members.linode.com ([67.18.176.11]:59935 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751862Ab2C0Rbw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 27 Mar 2012 13:31:52 -0400
Date: Tue, 27 Mar 2012 10:31:49 -0700
From: "Ted Ts'o" <tytso@mit.edu>
To: Michael Conrad <mconrad@intellitree.com>
Cc: util-linux@vger.kernel.org
Subject: Re: blkid -o value
Message-ID: <20120327173149.GC10142@thunk.org>
References: <4F71F836.4000103@intellitree.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F71F836.4000103@intellitree.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 27, 2012 at 01:26:14PM -0400, Michael Conrad wrote:
> 
> I would request that either the order of fields become stable by
> printing empty lines for missing fields (and documented), or the "-o
> value" be done away with, since I can't see any reason anyone would
> want random output in a script-friendly format, and the fact that it
> exists is likely to lead people astray.

Try using this way, which was its intended usage:

blkid -o value -s TYPE -t UUID=a3dc6f56-da22-4079-bf75-1fa2ce1aa4b0

(replace part following -t with the search criteria you want; for
example, "-t LABEL=backup").

It was intended to be used a script-friendly way, and I believe there
are shell scripts using in this fashion.  So please don't change blkid
-o value.

Best regards,

						- Ted
