Return-Path: util-linux-owner@vger.kernel.org
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40589 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752905AbbAEUmx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 Jan 2015 15:42:53 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id A649E20A43
	for <util-linux@vger.kernel.org>; Mon,  5 Jan 2015 15:37:48 -0500 (EST)
Message-Id: <1420490268.1408121.209893057.48A620D9@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Antonio Ceballos <aceballos@gmail.com>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <CAO7R9g8opv3Z3aW73xJ-d3ZBwi5_f4td9Xeqk=QBUCqz13fGhw@mail.gmail.com>
References: <CAO7R9g8opv3Z3aW73xJ-d3ZBwi5_f4td9Xeqk=QBUCqz13fGhw@mail.gmail.com>
Subject: Re: questions on util-linux translation
Date: Mon, 05 Jan 2015 21:37:48 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Hi Antonio,  :)

On Mon, Jan 5, 2015, at 11:11, Antonio Ceballos wrote:
> msgid ""
> " -V, --verbose      explain what is being done;\n"
> "                      specifying -V more than once will cause a dry-run\n"
> 
> msgid ""
> " -V, --version      display version information and exit;\n"
> "                      -V as --version must be the only option\n"
> 
> You can see '-V' (uppercase) for both --verbose and --version. Is that correct?

It is.  As the second line for --version tries to explain, -V *only* means
--version when no other option is specified.  -V together with other options
means --verbose.

> 2. Could the English wording be improved in the following sentence?
> msgid "%s: partition #%d already doesn't exist\n"

Hmm, yes, it should.  In Dutch I have translated it to the equivalent
of "partition #%d doesn't even exist" -- which sounds a tiny bit like:
"you're stupid".  So I'd better change that.  :|

> I would suggest something like:
> msgid "%s: partition #%d doesn't exist\n"
> msgid "%s: partition #%d no longer exists\n"

The latter one does not seem correct -- maybe the partition never
existed at all.  The verbose message was introduced with commit
ab025087f91b66ee8e23a16bc49eb0d9bd421d65 -- when a range of
partitions is specified for removal, say 5 to 9, and partition 7
does not exist, then, when --verbose is specified, partx would
mention that "partition #7 already doesn't exist".  Probably it is
better so say something like "skipping nonexistent partition #7"?
What do you think?

Benno

-- 
http://www.fastmail.com - Faster than the air-speed velocity of an
                          unladen european swallow

