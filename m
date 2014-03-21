Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:36370 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488AbaCUPDC (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 21 Mar 2014 11:03:02 -0400
Message-ID: <532C54A3.3030903@ubuntu.com>
Date: Fri, 21 Mar 2014 11:02:59 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>,
        Janani Venkataraman <jananive@linux.vnet.ibm.com>
CC: linux-kernel@vger.kernel.org, util-linux@vger.kernel.org
Subject: Re: [PATCH 00/33] [RFC] Non disruptive application core dump infrastructure
References: <20140320093040.14878.903.stgit@localhost.localdomain> <20140321080855.GE26374@x2.net.home>
In-Reply-To: <20140321080855.GE26374@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 3/21/2014 4:17 AM, Karel Zak wrote:
> The gencore command looks like a good idea, but why we need the 
> client-server infrastructure? At least at first glance it seems 
> like overkill.

Yes, the server seems pointless.

>> We would like to push this to one of the following packages: a)
>> util-linux b) coreutils c) procps-ng
> 
> d) somewhere near to gdb :-)

gdb already has such a thing; it's called gcore.  Kind of makes this
work seem redundant?


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJTLFSjAAoJEI5FoCIzSKrwuTIH/jGtc3dB1WKgtDSE2wtXXHO0
0WxhWDbVkpJ0Q+tkG/tjw4wudYtEJ+XAHsCIK3vH7OMX7i4PMOLDgjT/FyxTPrWl
W+eUCazi4vRPNGscii5mRFlsthgEd2pofotlx5UB7Br9D05/QZqErtEMJMqD935V
94wlvJSvJI0n3hfAUgcM8apxTgxYr/TIPEQPfqLem3xTZIw3lTRic613Qji2Kwif
l+kqs0WLy/AHEwBLRrXDQahnv5n2IhOVUn3KDwm9Su56rbrmAF7LAvK0+uxRyoQk
IVC5h8BdBQ4QMYl7KYYEPy+n+0Qbe1EQ4tLmYvaEBwXP5c0QDGX0M5VUkko+eGI=
=zFoW
-----END PGP SIGNATURE-----
