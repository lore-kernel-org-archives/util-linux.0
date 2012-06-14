Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:9881 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752975Ab2FNTnN (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Thu, 14 Jun 2012 15:43:13 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q5EJhCoC015203
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux-ng@vger.kernel.org>; Thu, 14 Jun 2012 15:43:13 -0400
Received: from [10.36.4.198] (vpn1-4-198.ams2.redhat.com [10.36.4.198])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id q5EJhBk9007344
	for <util-linux-ng@vger.kernel.org>; Thu, 14 Jun 2012 15:43:12 -0400
Message-ID: <4FDA3ECF.9060607@redhat.com>
Date: Thu, 14 Jun 2012 21:43:11 +0200
From: Milan Broz <mbroz@redhat.com>
MIME-Version: 1.0
To: util-linux-ng <util-linux-ng@vger.kernel.org>
Subject: Re: remove encryption options from mount and losetup?
References: <4FD8A950.5000906@suse.de> <20120613150144.GE10561@x2.net.home> <4FD9CF44.8090800@suse.de>
In-Reply-To: <4FD9CF44.8090800@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 06/14/2012 01:47 PM, Ludwig Nussel wrote:
> Karel Zak wrote:

> Well, someone could come up with another tool to support cryptoloop, or
> rather 'transfer functions'.

cryptsetup can map all compatible mappings with cryptoloop using dmcrypt
(and it can automatically alloc loop device as well) so providing something
compatible is just question of simple wrapper.

IMHO cryptoloop should be removed from kernel... The only usable (and secure)
solution using this interface is out-of-mainline-tree loop-aes extension.

Milan



