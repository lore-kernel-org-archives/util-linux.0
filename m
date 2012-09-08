Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:45650 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753264Ab2IHUT6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 8 Sep 2012 16:19:58 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1TARVT-0006El-HX
	for util-linux@vger.kernel.org; Sat, 08 Sep 2012 22:19:55 +0200
Received: from cpe-76-171-221-18.socal.res.rr.com ([76.171.221.18])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Sat, 08 Sep 2012 22:19:55 +0200
Received: from amit.uttam by cpe-76-171-221-18.socal.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Sat, 08 Sep 2012 22:19:55 +0200
To: util-linux@vger.kernel.org
From: Amit <amit.uttam@gmail.com>
Subject: Re: Can't figure out how to use =?utf-8?b?bW50X3RhYmxlX2dldF9yb290X2Zz?= from libmount
Date: Sat, 8 Sep 2012 20:19:40 +0000 (UTC)
Message-ID: <loom.20120908T221718-348@post.gmane.org>
References: <loom.20120908T195804-890@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Amit <amit.uttam@...> writes:

> 
> Hello,
> 
> I have a simple program using libmount that simply gets the path of the
> root filesystem. I can't seem to get it to work. I always get a
> segmentation fault. There is probably something basic that I am missing
> but can't figure it out.

[snip]

Using the following function works better.

fs = mnt_table_find_target(tab, "/", MNT_ITER_BACKWARD);

This is on until-linux 2.20.1 on debian wheezy.

