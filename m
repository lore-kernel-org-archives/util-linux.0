Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:38850 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754281Ab2CBMUF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 2 Mar 2012 07:20:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1S3RSu-0006RF-6z
	for util-linux@vger.kernel.org; Fri, 02 Mar 2012 13:20:04 +0100
Received: from 72-014.eduroam.rwth-aachen.de ([134.61.72.14])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Fri, 02 Mar 2012 13:20:03 +0100
Received: from thomas by 72-014.eduroam.rwth-aachen.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Fri, 02 Mar 2012 13:20:03 +0100
To: util-linux@vger.kernel.org
From: =?ISO-8859-15?Q?Thomas_B=E4chler?= <thomas@archlinux.org>
Subject: Re: unclear udev format output of blkid
Date: Fri, 02 Mar 2012 13:16:15 +0100
Message-ID: <jiqdmf$cbi$1@dough.gmane.org>
References: <5f2c4b72-cda0-4618-ae7c-b89333c1d2b9@zmail01.collab.prod.int.phx2.redhat.com> <249be96a-803a-4d00-b5b1-ff3f18722a36@zmail01.collab.prod.int.phx2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
In-Reply-To: <249be96a-803a-4d00-b5b1-ff3f18722a36@zmail01.collab.prod.int.phx2.redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Am 02.03.2012 12:18, schrieb Balamurugan Arumugam:
> We are trying to parse blkid output in python for all devices and their attributes.

This sounds like a bad idea. Instead, you should write a python
extension using the Python C API that uses libblkid directly (unless you
plan to support other implementations than CPython).

> I found two strange things.
> 1. udev format output is grouped by empty newline, but I see an extra newline in between.

'udev' output format is deprecated and will be removed in a future
version of util-linux. Starting to support it now is a clear waste of time.

> 2. In udev format output for all devices, there is no devname displayed.  Without devname, its unclear grouping.  Is there a plan to add devname in udev format output?

For above reasons, unlikely.

