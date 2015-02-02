Return-Path: util-linux-owner@vger.kernel.org
Received: from mout3.wup.tal.de ([195.8.224.251]:60743 "EHLO mout3.wup.tal.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933206AbbBBM5N (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 2 Feb 2015 07:57:13 -0500
Received: from point.localnet (mue-88-130-75-006.dsl.tropolys.de [88.130.75.6])
	(Authenticated sender: ib@wtal.de)
	by smtp.tal.de (Postfix) with ESMTPA id AE610860D487
	for <util-linux@vger.kernel.org>; Mon,  2 Feb 2015 13:47:31 +0100 (CET)
Received: from ib by point.localnet with local (masqmail 0.2.21) id
 1YIGPb-0ct-00 for <util-linux@vger.kernel.org>; Mon, 02 Feb 2015
 13:47:31 +0100
Message-ID: <54cf71c2.3100869e.bm000@wupperonline.de>
From: =?ISO-8859-1?Q?Ingo=20Br=FCckl?= <ib@wupperonline.de>
To: util-linux@vger.kernel.org
Subject: Re: cfdisk's input fields behave awkwardly (in utf8 locale)
Date: Mon, 02 Feb 2015 13:46:57 +0100
In-Reply-To: <20150202123736.GN16162@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote on Mon, 2 Feb 2015 13:37:36 +0100:

> On Mon, Feb 02, 2015 at 08:29:23AM -0400, Peter Cordes wrote:
>> On Mon, Feb 02, 2015 at 01:11:26PM +0100, Karel Zak wrote:
>> > On Sun, Feb 01, 2015 at 03:02:06PM +0100, Benno Schulenberg wrote:
>> > > [...cfdisk...]
>> > > prompted for a partition size, would put the cursor at the start
>> > > of the suggested value, and hitting any other key than Enter
>> > > would erase this value. That is nice and desirable behaviour.
>> > > Could that be restored?
>> >
>> >  It would be better to implement full one line editor with support for
>> >  all basic keys and with ability to insert and erase chars on
>> >  arbitrary position with in the string... v2.27 :-)
>>
>>  Maybe link with GNU readline, to avoid reinventing the wheel.

> yep, and maybe for all fdisks, but it would be probably nice to have
> it optional (--with-readline), [...]

Absolutely!

Ingo
