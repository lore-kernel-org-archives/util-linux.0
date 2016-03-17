Return-Path: util-linux-owner@vger.kernel.org
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:49176 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030555AbcCQQtr (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 17 Mar 2016 12:49:47 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 23E4C206A6
	for <util-linux@vger.kernel.org>; Thu, 17 Mar 2016 12:49:47 -0400 (EDT)
Message-Id: <1458233386.879328.552147938.0BC34E2C@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: cancelling the tests says that they all passed
Date: Thu, 17 Mar 2016 17:49:46 +0100
In-Reply-To: <201603171350.44094.sweet_f_a@gmx.de>
References: <1458207847.751745.551787010.6EE6554F@webmail.messagingengine.com>
 <201603171135.19679.sweet_f_a@gmx.de>
 <1458215622.795504.551872786.40E5990C@webmail.messagingengine.com>
 <201603171350.44094.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Thu, Mar 17, 2016, at 13:50, Ruediger Meier wrote:
> I have some guesses about "ipcs" and "fallocate" but some more 
> questions:
> 
> 1. Which kernel version?

2.6.32

> 2. Which file system? (findmnt -n -o FSTYPE -T tests/output)

ext3

> 3. Is /proc mounted?

$ ./findmnt -n -t proc
/proc  none   proc   rw,nosuid,nodev,noexec,relatime

> 4  grep "FALL" config.h

#define HAVE_FALLOCATE 1
#define HAVE_LINUX_FALLOC_H 1

Benno

-- 
http://www.fastmail.com - A fast, anti-spam email service.

