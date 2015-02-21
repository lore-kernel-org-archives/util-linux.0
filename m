Return-Path: util-linux-owner@vger.kernel.org
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:53124 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750793AbbBULhs (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sat, 21 Feb 2015 06:37:48 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id C0FC420E9D
	for <util-linux@vger.kernel.org>; Sat, 21 Feb 2015 06:37:44 -0500 (EST)
Message-Id: <1424518665.2638628.230488493.69A940D7@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: kerolasa@gmail.com
Cc: "util-linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <CAG27Bk0UnAhjfyw+EoXZmXXLG+egVFJrDY0cvkGmhFKezY78dQ@mail.gmail.com>
References: <20150220100647.GA2624@jue.netz> <20150220104106.GB19430@ws.net.home>
 <20150220124436.GA18236@jue.netz>
 <CAG27Bk0UnAhjfyw+EoXZmXXLG+egVFJrDY0cvkGmhFKezY78dQ@mail.gmail.com>
Subject: Re: [bug] logger 2.26: regression,
 option -i not combinable with other options
Date: Sat, 21 Feb 2015 12:37:45 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Fri, Feb 20, 2015, at 21:12, Sami Kerola wrote:
> Clearly the 'logger -is' should keep on working the same way it always
> has. Here's my proposal how regression could be fixed.
> 
> https://github.com/kerolasa/lelux-utiliteetit/commit/bfe6c5d2381b510a4a0330c1c809a63e49b26840

The fix looks fine, of course.  Just about the commit message:

s/loggerit's/logger it's/
s/options such as:/options, such as -s.  But currently:/

Also, to make the fix complete the -i and -id options have
to be separated in the usage text and the man page.

Benno

-- 
http://www.fastmail.com - Does exactly what it says on the tin

