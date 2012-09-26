Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56439 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756375Ab2IZI4s (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 26 Sep 2012 04:56:48 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 6E83F20897
	for <util-linux@vger.kernel.org>; Wed, 26 Sep 2012 04:56:47 -0400 (EDT)
Message-Id: <1348649807.24014.140661132854813.0F43545F@webmail.messagingengine.com>
From: Francesco Turco <fturco@fastmail.fm>
To: util-linux@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <CAPXgP11cuTV5+juJR54=xheDsGD9-ZqnUFuiXv43TRDvdThx1g@mail.gmail.com>
References: <1348605188.19630.140661132636721.0CD0D5D4@webmail.messagingengine.com>
 <CAPXgP11cuTV5+juJR54=xheDsGD9-ZqnUFuiXv43TRDvdThx1g@mail.gmail.com>
Subject: Re: Why fdisk wants the first partition to start at 1 MiB?
Date: Wed, 26 Sep 2012 10:56:47 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> It's a de-facto standard, which Windows does too. The first megabyte
> is reserved here for a boot loader or any other management data that
> could be needed for a disk or box to boot from.

So as far as I understood both starting at 1 MiB and having partition
boundaries at multiples of 1 MiB is for:

- Dealing with all possible situations (Windows, bootloaders, 4K
sectors, ...), both at present and in the foreseeable future
- Avoiding each person to use different partitioning rules (as I were
trying to do)

Am I right?
