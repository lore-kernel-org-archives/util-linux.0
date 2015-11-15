Return-Path: util-linux-owner@vger.kernel.org
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:55790 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751817AbbKOPHh (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 15 Nov 2015 10:07:37 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 3253F201E0
	for <util-linux@vger.kernel.org>; Sun, 15 Nov 2015 10:07:34 -0500 (EST)
Message-Id: <1447600053.449482.440244641.57DFABF2@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Barry Vos <barryvos@gmail.com>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <CACZ46+5V8coLvm=9VnfM2aDRXZB_Hv4idSTsESLC6Ee9zGeBdw@mail.gmail.com>
References: <CACZ46+5V8coLvm=9VnfM2aDRXZB_Hv4idSTsESLC6Ee9zGeBdw@mail.gmail.com>
Subject: Re: Typo man-page mkfs(8)
Date: Sun, 15 Nov 2015 16:07:33 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Fri, Nov 13, 2015, at 23:24, Barry Vos wrote:
> The man-page mkfs(8) mentions that the option -V equates to --verbose.
> I think this should be -v instead.

Well, no.  A leading -V gets consumed by the mkfs program itself;
a -v gets passed on to the filesystem-specific helper program.

Try it:

mkfs -V  somefile
mkfs -V -v  somefile
mkfs -v  somefile
mkfs -v -V  somefile

Benno

-- 
http://www.fastmail.com - The professional email service

